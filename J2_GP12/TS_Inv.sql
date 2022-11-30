/*
-- =========================================================================== A
-- TS_Inv.sql
-- ---------------------------------------------------------------------------
Activit� : IFT187_2022-2 PROJET BASE DE DONNEES
Encodage : UTF-8 sans BOM, fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.6 � 14.1
Responsables : LORINCE TAWAMBA, LUC LAVOIE
Version : V0.1
Statut : en d�veloppement
R�sum� : Cr�ation des invariants du sch�ma Centaures (boutique d'achat en ligne)
-- =========================================================================== A
*/


--Fonction qui renvoit un code form� d'un caract�re et d'un num�ro'

create or replace function formId (_k int, _c varchar(6))
returns varchar(15)
language plpgsql as $$
declare lk varchar(6);
resultat varchar(10);
begin
	lk = cast(_k as varchar);
	if char_length(lk) = 1 then resultat = _c ||'00' || lk;
	elsif char_length(lk) = 2 then resultat =  _c ||'0' || lk;
	elsif char_length(lk) = 3 then resultat = _c || lk;
	end if;
	return resultat;
end;
$$;

--Fonction qui renvoit une regex du tel camerounais

create or replace function cmTelBox ()
returns varchar(30)
language plpgsql as $$
declare
resultat varchar(30);
begin
resultat = '\+237 6[0-9]{8}';
	return resultat;
end;
$$;

/* registerClient   permet d'enregistrer un client'*/
create or replace procedure registerClient(_nom varchar(50), _mail varchar(255),_num varchar(30), _adresse varchar(255))
language plpgsql as 
$$
declare _k int;
declare lk varchar(50);
begin
_k = (select count(id_client) from Client) +1;
lk = formId(_k, 'CL');
insert into Client (id_client, nom_client, mail_client,num_client, adresse_client) values (lk,_nom, _mail,_num, _adresse);
end;
$$;

/* clientIdback permet de récupérer l'ID d'un client*/
create or replace function clientIdback(_nom varchar(50), _mail varchar(255),_num varchar(30), _adresse varchar(255))
returns varchar(50)
language plpgsql as
$$
declare _id varchar(25);
begin
_id = (select id_client from client where nom_client = _nom and num_client = _num and adresse_client = _adresse and mail_client = _mail);
return _id;
end;
$$;

/* registerTranspo  permet d'enregistrer un transporteur'*/
create or replace procedure registerTranspo(_nom varchar(50), _mail varchar(255), _adresse varchar(255))
language plpgsql as 
$$
declare _k int;
declare lk varchar(50);
begin
_k = (select count(id_transporteur) from Transporteur) +1;
lk = formId(_k, 'T');
insert into Transporteur (id_transporteur, nom_transporteur, mail_transporteur, adresse)
values (lk, _nom, _mail, _adresse);
end;
$$;

/* addProduct   permet d'ajouter un produit'*/
create or replace procedure addProduct(_idC text, _nom varchar(255), _pu float, _masse float, _volume float, _descrip text)
language plpgsql as 
$$
declare _k int;
declare lk varchar(50);
begin
_k = (select count(produit_id) from produit) +1;
lk = formId(_k, 'P');
insert into Produit (produit_id, id_categorie, nom_produit, pu, masse_g, volume_l, description)
values (lk, _idC, _nom, _pu, _masse, _volume, _descrip);
end;
$$;


/* addCat   permet d'ajouter une categorie'*/
create or replace procedure addCat(_idC text, _nom varchar(255))
language plpgsql as 
$$
declare _k int;
declare lk varchar(50);
begin
_k = (select count(id_categorie) from categorie) +1;
lk = formId(_k, 'CA');
insert into Categorie (id_categorie, nom_categorie) values (_idC, _nom);
end;
$$;

/* addMode  permet d'ajouter un mode de paiement'*/
create or replace procedure addMode(_idM text, _nom varchar(255))
language plpgsql as 
$$
declare _k int;
declare lk varchar(50);
begin
_k = (select count(id_categorie) from categorie) +1;
lk = formId(_k, 'M');
insert into Mode_Paiement (id_mode, nom_mode) values (_idM, _nom);
end;
$$;

/* OrderP    permet de commander un produit pr�cis*/

create or replace procedure orderP(idP varchar(50))
language plpgsql as 
$$
begin
	if not exists(select * from commande where produit_id = idP) then
	insert into Commande (produit_id, nom_produit, pu, volume_l, masse_g) select produit.produit_id, produit.nom_produit, 
				produit.pu, produit.volume_l, produit.masse_g from produit where produit.produit_id = idP;
	else update commande set qte = qte + 1 where produit_id = idP;
end if;
end;
$$;

/* Pu_lim   v�rifie si les limites logique de fixation d'un prix sont respect�es(pu strictement sup�rieur � z�ro)'*/
create or replace function Pu_lim()
returns trigger
language plpgsql as $$
    BEGIN
    if exists (select * from Produit where pu <= 0) then
         raise exception 'Vous ne pouvez  fixer un PU nul ou n�gatif';
        else
       return null;
    end if;
end;
$$;

/* Pu_dec_lim   appele la pr�c�dente apr�s une insertion ou une mis � jour dans Produits*/
create trigger Pu_dec_lim
    after insert or update on Produit
    execute procedure Pu_lim();
    /*Produit
les clients doivent voir les produits et leur prix et etre en mesure 
de les selectionner pour une commande 
le propri�taire doit voir les produits,le code des produits,le prix ,le stok,
*/


CREATE VIEW ProCli (nom_produit,PU) AS
SELECT 
nom_produit,
PU
FROM produit;

CREATE VIEW ProGes (produit_id,nom_produit,PU,qte_commande) AS
WITH SER AS (
    SELECT * 
	FROM commande
 )
SELECT produit_id,nom_produit,PU,qte_commande
FROM produit NATURAL JOIN SER
ORDER BY produit_id ASC;

/*Bon de commande
les memes elements que dans la commande 
avec un patch valid� pour indiqu� que la commande a bien �t� effectuer
*/
INSERT INTO Bon commande
SELECT *
FROM commande;


/*Bon livraison
-code du colis
-id du transporteur 
-adresse de livraison
-date de livraison
*/

SELECT produit_id,id_transpo,adresse,(date_envoie+ INTERVAL '15 day') AS date_livraison
FROM colis NATURAL JOIN bon_livraison
ORDER BY code_colis ASC;

 /*commande
ici nous avons besoins de fournir au client 
-le nom du produit
-le prix unitaire
-la quantit�
-le prix total 
-le cout total de la commande
-id des produits*/
INSERT INTO commande ( produit_id, nom_commande,pu_produit,volume_tcommande,masse_tcommande)
SELECT produit_id, nom_produit,PU,volume,masse
FROM produit;






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
-- TS_Inv.sql
-- =========================================================================== Z
*/
