create table Client(
	_idc serial not null
	id_client varchar(50) not null,
	nom_client varchar(50) not null,
	adresse_client varchar(25) not null,
	mail_client IETF.mailbox() not null,
	constraint client_c00 primary key(_idc)
);
create table Transporteur(
	id_transpo serial not null,
	nom_transpo varchar(50) not null,
	adresse_transpo varchar(25) not null,
	mail_transpo IETF.mailbox() not null,
	constraint transpo_c00 primary key(id_transpo)
);

create domain Categorie_id
  text 
  check(value similar to 'CA[0-9]{2}');
create table Categorie(
	id_categorie Categorie_id not null,
	nom_categorie varchar(50) not null,
	constraint categorie_c00 primary key(id_categorie)
);

create table Produit(
	id_produit serial not null,
	id_categorie Categorie not null,
	nom_produit varchar(50) not null,
	pu_produit
	masse_produit float not null,
	volume_produit float not null,
	description_produit text not null,
	constraint produit_c00 primary key(id_produit),
	constraint produit_c01 unique (nom_produit),
	constraint produit_c02 foreign key (id_categorie) references Categorie (id_categorie)
);
create table Commande(
	id_commande serial not null,
	nom_commande varchar(50) not null,
	pu_produit float not null
	masse_Tcommande float not null,
	volume_Tcommande float not null,
	qte_commande integer not null,
	cout_produit float not null,
	constraint Commande_c00 primary key(id_Commande),
	constraint Commande_c01 unique (nom_Commande),
	constraint Commande_c02 foreign key (nom_commande) references Produit (nom_produit)
	constraint Commande_c03 foreign key (pu_produit) references Produit (pu_produit)
);

create domain Mode_id
  text 
  check(value similar to 'M[0-9]{2}');
create table Mode_Paiement(
	id_mode Mode_id not null,
	nom_mode varchar(50) not null,
	constraint Mode_Paiement_c00 primary key(id_mode)
);

create table Ville(
	id_ville serial not null,
	nom_ville varchar(25) not null,
	tarif_ville float not null,
	constraint Ville_c00 primary key (nom_ville)
);

create table Bon_Commande(
	num_bon_c serial not null,
	nom_commande varchar(50) not null,
	date_c date not null,
	nom_commande varchar(50) not null,
	pu_produit float not null,
	masse_Tcommande float not null,
	volume_Tcommande float not null,
	qte_commande integer not null,
	cout_produit float not null,
	constraint Bon_Commande_c00 primary key (num_bon_c)
	constraint Bon_Commande_c02 foreign key (nom_commande) references Commande (nom_commande)
	constraint Bon_Commande_c03 foreign key (pu_produit) references Commande (pu_produit)
	constraint Bon_Commande_c04 foreign key (description) references Commande (description_produit)
);

create table colis (
	date_envoie date not null,
	adresse varchar(50) not null,
	masse_colis float not  null,
	volume_colis float not null,
	num_bon_c int not null,
	id_transpo int not null,
	/*pending*/
	
)

