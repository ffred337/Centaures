#Veuillez installez les modules suivants: Rich, Psycopg2
class Categorie:
    def __init__(self, id, nom, position = None):
        self.id = id
        self.nom = nom
        self.position = position if position is not None else None
    
    def __repr__(self) -> str:
        return f"({self.id}, {self.nom},{self.position})"

class Mode_Paiement:
    def __init__(self, id, nom, position = None):
        self.id = id
        self.nom = nom
        self.position = position if position is not None else None
    
    def __repr__(self) -> str:
        return f"({self.id}, {self.nom},{self.position})"

class Client:
    def __init__(self, id="", nom="", tel="", mail="", adresse=""):
        self.id = id
        self.nom = nom
        self.tel = tel
        self.adresse = adresse
        self.mail = mail
    def update(self, id="", nom="", tel="", mail="", adresse=""):
        self.id = id
        self.nom = nom
        self.tel = tel
        self.adresse = adresse
        self.mail = mail
    def ret(self):
        return self.id,self.nom,self.tel,self.adresse,self.mail

class Transporteur:
    def __init__(self, id, nom, adresse, mail, position = None):
        self.id = id
        self.nom = nom
        self.adresse = adresse
        self.mail = mail
        self.position = position if position is not None else None
    
    def __repr__(self) -> str:
        return f"({self.id}, {self.nom},{self.adresse},{self.mail},{self.position})"

class Produit:
    def __init__(self, id, nom, pu, masse,volume,description, position = None):
        self.id = id
        self.nom = nom
        self.pu = pu
        self.masse = masse
        self.volume = volume
        self.description = description
        self.position = position if position is not None else None
    
    def __repr__(self) -> str:
        return f"({self.id}, {self.nom},{self.pu},{self.masse},{self.volume},{self.description},{self.position})"

class Commande:
    def __init__(self, id, nom, pu, masse,volume,qte, position = None):
        self.id = id
        self.nom = nom
        self.pu = pu
        self.masse = masse
        self.volume = volume
        self.qte = qte
        self.position = position if position is not None else None
    
    def __repr__(self) -> str:
        return f"({self.id}, {self.nom},{self.pu},{self.masse},{self.volume},{self.qte},{self.position})"

class bonCommande:
    def __init__(self, num, nom, pu, masse,volume,qte, position = None):
        self.num = num
        self.nom = nom
        self.pu = pu
        self.masse = masse
        self.volume = volume
        self.qte = qte
        self.position = position if position is not None else None
    
    def __repr__(self) -> str:
        return f"({self.num}, {self.nom},{self.pu},{self.masse},{self.volume},{self.qte},{self.position})"







