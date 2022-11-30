/*
-- =========================================================================== A
-- TS_ini-pos.sql
-- ---------------------------------------------------------------------------
Activit� : IFT187_2022-2 PROJET BASE DE DONNEES
Encodage : UTF-8 sans BOM, fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.6 � 14.1
Responsables : LORINCE TAWAMBA, LUC LAVOIE
Version : V0.1
Statut : en d�veloppement
R�sum� : Cr�ation script pour insertion valeurs valides de Centaures (boutique d'achat en ligne)
-- =========================================================================== A
*/


 INSERT INTO Categorie(ID_Categorie, Nom_Categorie) VALUES
	('CA000', 'Biscuit'),
	('CA001', 'Chocolat'),
	('CA002', 'Riz'),
	('CA003', 'Pates'),
	('CA004', 'Huile'),
	('CA005', 'Sucre'),
	('CA006', 'Confiseries'),
	('CA007', 'Eau'),
	('CA008', 'Lait'),
	('CA009', 'Jus'),
	('CA010', 'Yaourt');


INSERT INTO Produit(Produit_Id, Id_Categorie, Nom_Produit, PU, volume_l, Masse_g, Description) VALUES
	('P000', 'CA000', 'Biscuit Au Chocolat Supercao', '25' , '1', '1000', 'biscuit Supercoa. 4 Biscuits chocolates dans un sachet de 25XAF'),
	('P001', 'CA000', 'Biscuit Naya Citron', '50', '1', '1020', 'Biscuit Naya. 4 Biscuits foires au citron dans un paquet de 50XAF'),
	('P002', 'CA001', 'Mambo au Lait', '150', '1', '1025', 'Decouvrez le plaisir du gout intense du cacao et la saveur inoubliable du lait dans une barre de mambo'),
	('P003', 'CA001', 'Grand Mambo au Lait', '660', '1000', '20', 'Decouvrez le plaisir du gout intense du cacao et la saveur inoubliable du lait dans une barre de mambo'),
	('P004', 'CA002', 'Riz Parfume Le bon Cuisinier', '5700', '1', '5000', 'Le riz Le bon cuisinier parfumé 5kg est idéal pour toutes cuissons.'),
	('P005', 'CA002', 'Riz Royal Mekong', '3575', '1', '5000', 'Riz Royal Mekong 5KG'),
	('P006', 'CA003', 'Spaghetti Salaka', '500','1', '500', 'Decouvrez le plaisir du gout intense des Spaghetti Salaka'),
	('P007', 'CA003', 'Spaghetti Spaghetto', '500', '1', '500', 'Decouvrez le plaisir du gout intense des Spaghetti Spaghetto'),
	('P008', 'CA004', 'Huile Mayor', '1150', '1', '790', 'L`huile Mayor est utilisée pour les fritures, la cuisson, les pâtisseries et bien d`autres.'),
	('P009', 'CA004', 'Huile D`olive Puget', '5250', '0.5', '395', 'l’huile d’olive contribue à la prévention des maladies'),
	('P010', 'CA005', 'Sucre Roux Tatie En poudre', '800', '1', '1000', 'Dosettes subtiles de sucre pour vos matins'),
	('P011', 'CA005', 'Sucre Sumocam', '800', '1', '1000', 'Sucre Sumocam pour vos matins heureux'),
	('P012', 'CA006', 'Bonbon Maxi Pop', '1100', '1', '1000', 'Bonbon Maxi Pop avec un gout mentholé'),
	('P013', 'CA006', 'Bonbon Youpi', '1700', '1', '1000', 'Le lait et la fraise font partie des ingredients qui rendent ce bonbon magique'),
	('P014', 'CA007', 'Eau Mineral O`pur', '2000', '20', '15800', 'Eau minérale O’pur'),
	('P015', 'CA007', 'Eau Mineral Vitale', '1100', '10', '7900', 'Supermontest une eau minerale'),
	('P016', 'CA008', 'Peak en Poudre', '5000', '1', '900', 'Lait Peak en poudre.'),
	('P017', 'CA008', 'Nido en Poudre', '2200', '1', '365', 'Nido lait concentré en poudre'),
	('P018', 'CA009', 'Jus Coca Cola', '600', '1', '790', 'Le jus Coca-Cola est sans conservateurs'),
	('P019', 'CA009', 'Fanta', '450', '1', '790', 'Goutez une nouvelle sensation a travers un jus'),
	('P020', 'CA010', 'Camlait Yaourt', '300', '1', '150', 'Yaourt sucré'),
	('P021', 'CA010', 'Yaourt Dolait', '900', '1', '500', 'Yaourt Dolait Nature');


INSERT INTO Mode_Paiement(ID_Mode, Nom_Mode) VALUES
	('M001', 'Orange Money'),
	('M002', 'Mobile Money'),
	('M003', 'Paiement_Bancaire');

INSERT INTO Ville(id_ville, nom_ville, tarif_ville) VALUES
	('YDE', 'Yaounde', '10000'),
	('DLA', 'Douala', '5000'),
	('MAR', 'Maroua', '20000'),
	('GAR', 'Garoua', '15000'),
	('EBL', 'Ebolowa', '10000'),
	('NGA', 'Ngaoundere', '25000'),
	('BMD', 'Bamenda', '30000'),
	('BAF', 'Bafoussam', '15000'),
	('BER', 'Bertoua', '20000'),
	('BUE', 'Buéa', '25000'),
    ('MBA', 'MBANGA', '20000');

	
INSERT INTO Transporteur(id_transporteur, Nom_Transporteur, Adresse, mail_transporteur) VALUES
	('T000', 'Paul','YDE', 'PaulYDE@gmail.com'),
	('T001', 'François','DLA', 'fracoisDla@gmail.com'),
	('T002', 'Elvis','NGA', 'ElvisNga@gmail.com'),
	('T003', 'Marc','MAR', 'Marcmar@gmail.com'),
	('T004', 'Jean','BUE', 'JeanBue@gmail.com'),
	('T005', 'Chris','EBL', 'ChrisEbl@gmail.com'),
	('T006', 'Antoine','GAR', 'AntoineGar@gmail.com'),
	('T007', 'Yves','BMD', 'Yves@gmail.com'),
	('T008', 'James','BAF' ,'JamesBaf@gmail.com'),
	('T009', 'Victor','BER','Victorber@gmail.com'),
	('T010', 'Adam', 'MBA','adammba@gmail.com');

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
  2022-06-15 (XX) : Insertion



-- ---------------------------------------------------------------------------
-- TS_ini-pos.sql
-- =========================================================================== Z
*/