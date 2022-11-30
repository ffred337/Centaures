--Function qui renvoit un code formé d'un caractère et du serial

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

--function qui renvoit une regex du tel camerounais

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

/* registerClient*/
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

/* registerTranspo*/
create or replace procedure registerTranspo(_nom varchar(50), _mail varchar(255), _adresse varchar(255))
language plpgsql as 
$$
declare _k int;
declare lk varchar(50);
begin
_k = (select count(id_transporteur) from Transporteur) +1;
lk = formId(_k, 'T');
insert into Transporteur (id_transporteur, nom_transporteur, mail_transporteur, adresse_transporteur)
values (lk, _nom, _mail, _adresse);
$$;


/* addProduct*/
create or replace procedure addProduct(_idP Produit_id, _idC Categorie_id, _nom varchar(255), _pu float, _masse float, _volume float, _descrip text)
language sql as 
$$
insert into Produits (id_produit, id_categorie, nom_produit, pu_produit, masse_produit, volume_produit, description)
values (_idP, _idC, _nom, _pu, _masse, _volume, _descrip);
$$;


/* addCat*/
create or replace procedure addCat(_idC Categorie_id, _nom varchar(255))
language sql as 
$$
insert into Categorie (id_categorie, nom_categorie) values (_idC, _nom);
$$;

/* addMode*/
create or replace procedure addMode(_idM Mode_id, _nom varchar(255))
language sql as 
$$
insert into Mode_Paiement (id_mode, nom_mode) values (_idM, _nom);
$$;

/* Order*/
create or replace procedure Order(_idP Produit_id)
language sql as
$$
insert into Commande select id_produit, nom_produit, pu_produit from Produits where id_produit = _idP;
update Commande set qte = 1 where id_produit = _idP;
update Commande set masse_T = masse_produit.Produits * qte where id_produit = _idP;
update Commande set volume_T = volume_produit.Produits * qte where id_produit = _idP;
$$;

/* Norder*/
create or replace procedure Order(_idP Produit_id)
language sql as
$$
delete from Commande where exists (select id_produit from Commande where id_produit = _idP);
$$;

/* SetPrice*/
create or replace procedure SetPrice(_idP Produit_id, price float)
language sql as
$$
update Produits set pu_produit = price where id_produit = _idP;
$$;

/* rmProduct*/
create or replace procedure rmProduct(_idP Produit_id)
language sql as 
$$
delete from Produits where id_produit = _idP);
$$;


/* rmCat*/
create or replace procedure rmCat(_idC Categorie_id)
language sql as 
$$
delete from Produits where id_produit = _idP);
$$;


/* SetQte*/
create or replace procedure SetQte(_idP Produit_id, _qte int)
language sql as
$$
update Commande set qte = _qte  where id_produit = _idP;
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

