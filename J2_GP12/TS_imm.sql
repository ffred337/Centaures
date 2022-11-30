/*
-- =========================================================================== A
-- TS_imm.sql
-- ---------------------------------------------------------------------------
Activit� : IFT187_2022-2 PROJET BASE DE DONNEES
Encodage : UTF-8 sans BOM, fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.6 � 14.1
Responsables : LORINCE TAWAMBA, LUC LAVOIE
Version : V0.1
Statut : en d�veloppement
R�sum� : Cr�ation script pour IMM de Centaures (boutique d'achat en ligne)
-- =========================================================================== A
*/

/* NorderP*/
create or replace procedure NorderP(idP varchar(50))
language plpgsql as 
$$
begin
	if exists(select * from commande where produit_id = idP) then delete from commande where produit_id = idP;
end if;
end;
$$;

/* SetPrice*/
create or replace procedure SetPrice(_idP Produit_id, price float)
language sql as
$$
update Produit set pu_produit = price where id_produit = _idP;
$$;

/* rmProduct*/
create or replace procedure rmProduct(_idP Produit_id)
language sql as 
$$
delete from Produit where id_produit = _idP);
$$;


/* rmCat*/
create or replace procedure rmCat(_idC Categorie_id)
language sql as 
$$
delete from Produit where id_produit = _idP);
$$;


/* SetQte*/
create or replace procedure SetQte(_idP varchar(50), _qte int)
language plpgsql as
$$
begin
if _qte = 0 then call NorderP(_idp);
else update Commande set qte = _qte  where produit_id = _idP;
end if;
end;
$$;


/* SetNum*/
create or replace procedure SetNum(_num)
language sql as
$$
update Commande set num_commande = _num;
$$;

/* SetTranspo*/
create or replace procedure SetTranspo(_idT Transporteur_id, idCol Colis_id)
language sql as
$$
update Colis set id_transpo = _idT where id_colis = idCol;
$$;

/* Qte_lim   v�rifie si les limites logique de fixation de quantit� d'un produit command� sont prix sont respect�es(qte strictement sup�rieur � z�ro)'*/
create or replace function Qte_lim()
returns trigger
language plpgsql as $$
    BEGIN
    if exists (select * from commande where qte <= 0) then
         raise exception 'Vous ne pouvez  commander un produit de qte nulle ou n�gative';
        else
       return null;
    end if;
end;
$$;

/* Qte_dec_lim   appele la pr�c�dente apr�s une insertion ou une mis � jour dans Commande*/
create trigger Qte_dec_lim
    after insert or update on commande
    execute procedure Qte_lim();

/*Colis
-le transporteur doit avoir l'adresse de livraison ,le code du colis,la destination
-le propri�taire doit voir le nom du destinataire,le contenu de la commande et le prix total
l'adresse du destintaire,l'id du transporteur,son nom,la date de livraison et l'heure

*/
CREATE VIEW TransCo (adresse,produit_id)
AS SELECT adresse ,produit_id
FROM colis;

CREATE VIEW ProCo (nom_client ,nom_produit,PU,produit_id,adresse,id_transpo,date_livraison)
AS SELECT nom_client ,nom_produit,PU,produit_id,adresse,id_transpo,date_livraison
FROM colis NATURAL JOIN bon_commande NATURAL JOIN bon_livraison;

/*Facture
-id du produit
-nom du produit
-la quantit�
-le prix total 
-le cout total de la commande
-cout de la livraison 
-mode de payement*/

SELECT produit_id,nom_commande,qte_commande,tarif_ville
FROM colis NATURAL JOIN ville NATURAL JOIN bon_commande ;


create or replace function testClientId(_idc varchar(50))
returns boolean
language plpgsql as
$$
declare _result bool;
begin
if exists (select id_client from client where id_client = _idc ) then _result = True;
else 
_result = False;
end if;
return _result;
end;
$$;


create or replace function testCatId(_idc varchar(50))
returns boolean
language plpgsql as
$$
declare _result bool;
begin
if exists (select id_categorie from Categorie where id_categorie = _idc ) then _result = True;
else 
_result = False;
end if;
return _result;
end;
$$;

create or replace function testProdId(_idc varchar(50))
returns boolean
language plpgsql as
$$
declare _result bool;
begin
if exists (select produit_id from produit where produit_id = _idc ) then _result = True;
else 
_result = False;
end if;
return _result;
end;
$$;

create or replace function testTranspId(_idc varchar(50))
returns boolean
language plpgsql as
$$
declare _result bool;
begin
if exists (select id_transporteur from transporteur where id_transporteur = _idc ) then _result = True;
else 
_result = False;
end if;
return _result;
end;
$$;

create or replace procedure SetStatusC(_idc varchar(50), _status bool)
language plpgsql as
$$
begin
if exists (select * from Client where id_client = _idc) then update Client set status = _status where id_client = _idc;
end if;
end;
$$;

create or replace procedure SetStatusT(_idc varchar(50), _status bool)
language plpgsql as
$$
begin
if exists (select * from transporteur where id_client = _idc) then update transporteur set status = _status where id_tranporteur = _idc;
end if;
end;
$$;

create or replace procedure SetStatusCat(_idc varchar(50), _status bool)
language plpgsql as
$$
begin
if exists (select * from categorie where id_categorie = _idc) then update categorie set status = _status where id_categorie = _idc;
end if;
end;
$$;

create or replace procedure SetStatusP(_idc varchar(50), _status bool)
language plpgsql as
$$
begin
if exists (select * from produit where produit_id = _idc) then update produit set status = _status where produit_id = _idc;
end if;
end;
$$;


/*
-- =========================================================================== Z
Contributeurs :

  (NV) VICTOIRE NTCHUINGWA 
  (SW) SERGINE WELLAN 
  (BM) BORISKA MBILONGO
  (FT) FRED TCHIADEU  

Adresse, droits d'auteur et copyright :
  INSTITUT UCAC-ICAM X2026

T�ches projet�es :
  NIL

T�ches r�alis�es :
  2022-06-15 (XX) : Cr�ation



-- ---------------------------------------------------------------------------
-- TS_imm.sql
-- =========================================================================== Z
*/