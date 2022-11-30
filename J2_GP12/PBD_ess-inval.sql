/**
 * Categories
 */
-- categorie_id plus grand que 3
INSERT INTO Categorie(id_categorie, nom_categorie) VALUES 
    ('ca000', 'Huile'),
    ('CA01', 'Farine');
/*

/**
 * produit
 */
-- produit_id plus grand que 3
INSERT INTO Produit(produit_id , categorie_id, PU, masse, volume) VALUES
       ('p000', 'CA000', '2.3' , '3.2', '4.1'),
       ('P01' , 'CA001', '2.4' , '3.4', '4.5');
/*


/**
 * Transporteur
 */
-- transporteur_id plus grand que 3
INSERT INTO Transporteur(id_transporteur, mail_transporteur, Adresse_transporteur) VALUES 
         ('t000', 'IEFT.mailbox()','village'),
         ('T01', 'IEFT.mailbox()', 'village');

/*


/**
 * Mode_paiement
 */
-- Mode_paiement_code plus grand que 3
INSERT INTO Mode_paiement(id_mode, nom_mode) VALUES 
       ('MAE', 'Paypal'),
       ('Maez','Paypal');
/*

/**
 * Bon de livraison
 */
-- Bon_livraison_code plus grand que 3
INSERT INTO Bon_livraison(Num_bon_livraison, Date_livraison) VALUES 
  ('nl000', '08 mai'),
  ('NL00' , '08 mai');  
/*

/**
 * Localisation
 */
-- localisation_code plus grand que 3
INSERT INTO localisation(id_ville, nom_ville, tarif_ville) VALUES 
  ('', ''),
  ( '' , '');
/*

/**
 * mail
 */
-- mail_code plus grand que 3
INSERT INTO mail(mail_client, id_client, nom_client, Adresse_client) VALUES 
  ('', ''),
  ('' , '');
/*