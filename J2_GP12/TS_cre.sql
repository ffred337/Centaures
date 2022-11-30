/*
-- =========================================================================== A
-- TS_cre.sql
-- ---------------------------------------------------------------------------
Activit� : IFT187_2022-2 PROJET BASE DE DONNEES
Encodage : UTF-8 sans BOM, fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.6 � 14.1
Responsables : LORINCE TAWAMBA, LUC LAVOIE
Version : V0.1
Statut : en d�veloppement
R�sum� : Cr�ation script pour les tables de Centaures (boutique d'achat en ligne)
-- =========================================================================== A
*/

/* Table CATEGORIES
  Une categorie est identifie par son id et son nom
*/
CREATE DOMAIN ID_Cat
TEXT
CHECK (VALUE SIMILAR TO 'CA[0-9]{3}');

CREATE TABLE Categorie
(
  ID_Categorie  ID_Cat NOT NULL,
  Nom_Categorie VARCHAR(20) NOT NULL,
 CONSTRAINT Categorie_cc00  PRIMARY KEY  (ID_Categorie),
 CONSTRAINT Categorie_cc01 unique (nom_categorie)
);

/* Table PRODUIT
  Un produit est identifie par
    Son produit_id
    Son id_categorie provenant de la table Categorie
    Son nom_produit
    Son PU
    Son Volume
    Sa Masse
    Sa Description
*/
CREATE DOMAIN Produit_id
TEXT
CHECK (VALUE SIMILAR TO 'P[0-9]{3}');

CREATE TABLE produit
(
  produit_id         Produit_id       NOT NULL,
  id_categorie       ID_Cat           NOT NULL,
  nom_produit        VARCHAR(30)      NOT NULL,
  PU                 FLOAT            NOT NULL,
  Volume_l             FLOAT            NOT NULL,
  Masse_g              FLOAT            NOT NULL,
  Description        TEXT             NOT NULL,
 CONSTRAINT produit_cc00  PRIMARY KEY (produit_id),
 CONSTRAINT produit_cc01 UNIQUE (nom_produit),
 constraint produit_cc02 foreign key (id_categorie) references Categorie (ID_categorie)
 );

/*il ya quelques colones a inserer dans ces tables */

CREATE DOMAIN Localisation
TEXT
CHECK (VALUE SIMILAR TO '[A-Z]{3}');

/* Table CLIENT
  Un client est identifie par
  Son id_client qui est le code genere a partir de _idc pour l'identifie
  Son nom_client
  Son adresse_client
  Son mail_client
*/

-- Modif
/* TABLE VILLE
  Une ville est identifiee par
    Son id_ville
    Son nom_ville
    Son tarif_ville
*/

create table Ville(
  id_ville Localisation not null,
  nom_ville varchar(25) not null,
  tarif_ville float not null,
  constraint Ville_cc00 primary key (id_ville),
  constraint Ville_cc01 UNIQUE (nom_ville)
); 
-- Modif

create table Client(
  id_client varchar(50) not null,
  nom_client varchar(50) not null,
  num_client varchar(50) not null,
  adresse_client text not null,
  mail_client varchar(255) not null,
  constraint client_c00 primary key(id_client),
  constraint client_c01 check ( num_client similar to '\+237 6[0-9]{8}' )
);



/* Table TRANSPORTEUR
  Un transporteur est identifie par
  Son id_transporteur
  Son Adresse (Localisation)
  Son mail_transporteur
*/
CREATE DOMAIN  Transporteur_id
TEXT
CHECK (VALUE SIMILAR TO 'T[0-9]{3}'); --Modif
CREATE TABLE Transporteur
(
  id_transporteur    Transporteur_id    NOT NULL,
  Nom_Transporteur   VARCHAR(50)        NOT NULL,
  Adresse            Localisation            NOT NULL,
  mail_transporteur     VARCHAR(50)         NOT NULL,
 CONSTRAINT transporteur_cc00  PRIMARY KEY (id_transporteur),
 CONSTRAINT transporteur_cc01 UNIQUE (mail_transporteur),
 CONSTRAINT transporteur_cc02 FOREIGN KEY (Adresse) REFERENCES Ville(id_ville)
);

/* Table Commande
  La table Commande est identifie
    Son id_commande
    Son nom_commande qui provient de la table produit
    Son pu_produit qui provient de la table produit
    Sa masse_Tcommande
    Sa volume_Tcommande
    Sa qte_commande
    Son cout_produit
*/
create table Commande(
  id_commande serial not null,
  produit_id Produit_id not null,
  nom_produit varchar(50) not null,
  pu float not null,
  volume_l float not null,
  masse_g float not null,
--  qte_commande integer not null set default 1,
  --cout_produit float not null set (qte_commande * pu),
  constraint Commande_cc00 primary key(id_Commande),
  constraint Commande_cc01 unique (nom_produit),
  constraint Commande_cc02 FOREIGN KEY (produit_id) REFERENCES Produit(produit_id)
);

ALTER TABLE Commande
ADD cout_produit float not null
CONSTRAINT value_commande DEFAULT pu;
ALTER TABLE Commande
ADD qte float not null
CONSTRAINT value_qte DEFAULT 1;


/* Table MODE_PAIEMENT
  Le mode de paiement est identifie par
    Son ID_Mode
    Son Nom_Mode
*/
CREATE DOMAIN ID_MP
TEXT
CHECK (VALUE SIMILAR TO 'M[0-9]{3}');
CREATE TABLE Mode_Paiement
(
  ID_Mode        ID_MP          NOT NULL,
  Nom_Mode       VARCHAR(30)    NOT NULL,
 CONSTRAINT mode_paiement_cc00  PRIMARY KEY (ID_Mode),
 CONSTRAINT mode_paiement_cc01    UNIQUE    (Nom_Mode)
);


/* Table BON DE COMMANDE
  Un bon de commande est idenfie par
    Son num_bon_c qui est son identifiant unique
    Son nom_commande qui provient des differentes commandes
    Sa date_c
    Son pu_produit qui provient de la table produit
    Sa masse_Tcommande
    Son volume_Tcommande
    Sa qte_commande
    Son cout_produit
*/
create table Bon_Commande(
  num_bon_c serial not null,
  id_commande serial not null,
  Mode_Paie   ID_MP  not null,
  nom_commande varchar(50) not null,
  date_c date not null,
  pu_produit float not null,
  masse_Tcommande float not null,
  volume_Tcommande float not null,
  qte_commande integer not null,
  cout_produit float not null,
  constraint Bon_Commande_cc00 primary key (num_bon_c),
  constraint Bon_Commande_cc01 FOREIGN KEY (id_commande) references Commande(id_commande),
  constraint Bon_Commande_cc02 FOREIGN KEY (Mode_Paie) references Mode_Paiement(ID_Mode)
);

/* Table COLIS
  Un Colis est identifie par
    Son code_colis
    Sa date_envoie
    Son adresse qui est l'adresse du client
    Sa masse_colis
    Son volume_colis
    Son num_bon_c qui provient de la table bon Commande
    Son id_transpo qui provient de la table Transporteur
    Son id_client qui provient de la table Client
    Son nom_client qui provient de la table Client
*/
CREATE DOMAIN Colis_id
TEXT
CHECK (VALUE SIMILAR TO 'Co[0-9]{3}');

create table colis (
  code_colis Colis_id NOT NULL,
  date_envoie date not null,
  adresse Localisation not null,
  masse_colis float not  null,
  volume_colis float not null,
  num_bon_c int not null,
  id_transpo Transporteur_id not null,
  id_client varchar(50) NOT NULL,
  nom_client varchar(50) NOT NULL,
  CONSTRAINT colis_cc00 PRIMARY KEY (code_colis),
  CONSTRAINT colis_cc01 FOREIGN KEY (id_client) references Client(id_client),
  CONSTRAINT colis_cc03 FOREIGN KEY (id_transpo) references transporteur(id_transporteur),
  CONSTRAINT colis_cc05 FOREIGN KEY (num_bon_c) references Bon_Commande(num_bon_c)

);

/*  Table FACTURE
  La facture est identifiee par
    Son id_facture
    Sa date_paiement
*/
CREATE DOMAIN  facture_id
TEXT
CHECK (VALUE SIMILAR TO 'F[0-9]{3}');
CREATE TABLE facture
(
  facture_id          facture_id      NOT NULL,
  date_paiement       DATE            NOT NULL,
  num_bon_com serial not null,
  nom_commande varchar(50) not null,
  date_c date not null,
  pu_produit float not null,
  masse_Tcommande float not null,
  volume_Tcommande float not null,
  qte_commande integer not null,
  cout_produit float not null,
 CONSTRAINT facture_cc00  PRIMARY KEY (facture_id),
 CONSTRAINT facture_cc01 FOREIGN KEY (num_bon_com) REFERENCES Bon_Commande(num_bon_c)
);



/* TABLE Bon_Livraison
    Un bon de livraison est identifie par
    Son Num_Bon_Livraison qui est son identifiant unique
    Sa Date_Livraison

*/

/*CREATE DOMAIN NumBonLiv
TEXT
CHECK (VALUE SIMILAR TO 'NL[0-9]{3}');
*/
CREATE TABLE Bon_Livraison
(
  Num_Bon_Livraison INTEGER   NOT NULL,
  Date_Livraison    DATE      NOT NULL,
  id_bon_com         serial    NOT NULL,
  facture_id       facture_id NOT NULL,
  Mode_Paie         ID_MP     NOT NULL,
  CONSTRAINT Bon_Livraison_cc00 PRIMARY KEY (Num_Bon_Livraison),
  CONSTRAINT Bon_Livraison_cc01 FOREIGN KEY (id_bon_com) REFERENCES Bon_Commande(num_bon_c),
  CONSTRAINT Bon_Livraison_cc02 FOREIGN KEY (facture_id) REFERENCES Facture(facture_id),
  CONSTRAINT Bon_Livraison_cc03 FOREIGN KEY (Mode_Paie) REFERENCES Mode_Paiement(ID_Mode)
);