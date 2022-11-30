
-- categorie_id plus grand que 3
INSERT INTO Categorie(id_categorie, nom_categorie) VALUES 
    ('ca000', 'Huile'),
    ('CA01', 'Farine');


/**
 * produit
 */
-- produit_id plus grand que 3
INSERT INTO Produit(produit_id , categorie_id, PU, masse, volume) VALUES
       ('p000', 'CA000', '2.3' , '3.2', '4.1'),
       ('P01' , 'CA001', '2.4' , '3.4', '4.5');

-- transporteur_id plus grand que 3
INSERT INTO Transporteur(id_transporteur, mail_transporteur, Adresse_transporteur) VALUES 
         ('t000', '12u__3@','village'),
         ('T01', 't_1___45x_@gma_.cm', 'village');

-- Mode_paiement_code plus grand que 3
INSERT INTO Mode_paiement(id_mode, nom_mode) VALUES 
       ('MAE', 'Paypal'),
       ('Maez','Paypal');