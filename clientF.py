#Veuillez installez les modules suivants: Rich, Psycopg2
import psycopg2
from models import Client
from rich.align import Align
from rich.console import Console, Group
from rich.panel import Panel
from rich.table import Table
from rich.prompt import Prompt
import os
import datetime
from time import sleep
from makers import make_header, main,testCatId,testProdId,make_bar,dataClientData,verify_mail,verify_num,Villes
import uuid
console = Console(record=True)
dbCon = psycopg2.connect(database="Centaures", user="postgres", password="0123456789", host="localhost", port="5433")
c = dbCon.cursor()

a = Align(Panel(" CATEGORIES  ", expand=False, height=3, width= 15, title="1", title_align="left"), align= "center", style= "cyan", vertical= "middle")
b = Align(Panel("  PRODUITS  ", expand=False, height=3, width= 15, title="2", title_align="left"), align= "center", style= "green")
d = Align(Panel(" COMMANDE  ", expand=False, height=3, width= 15, title="3", title_align="left"), align= "center", style= "orange1")
e = Align(Panel("   BACK   ", expand=False, height=3, width= 15, title="4", title_align="left"), align= "center", style= "red3")

def make_main_client():
    make_header()
    console.print("\n\n\n")
    console.print(a)
    console.print("\n\n\n")
    console.print(b)
    console.print("\n\n\n")
    console.print(d)
    console.print("\n\n\n")
    console.print(e)
    console.print("\n\n\n")
    choice = Prompt.ask("Choississez une option 🤖", choices = ["1","2","3","4"])
    actions = {1: displayCat, 2: displayProd, 3: displayCmd, 4: main}
    k = int(choice)
    action = actions.get(k)
    action()
    os.system('cls')

def decide(text1, text2):
    C = Align(Panel(text1, expand=False, height=3, width= 15, title="1", title_align="left"), align= "center", style= "cyan", vertical= "middle")
    B = Align(Panel(text2, expand=False, height=3, width= 15, title="2", title_align="left"), align= "center", style= "red3", vertical= "middle")
    console.print("\n\n\n")
    console.print(C)
    console.print(B)

def displayCat():
    make_header()
    c.execute("select * from Categorie")
    data = c.fetchall()
    os.system('cls')
    make_header()
    console.print("\n\n\n")
    console.print(Align("[bold magenta]CATEGORIES[/bold magenta]! 📦", align="center"))

    categorie = Table(show_header=True, header_style="bold blue")
    categorie.add_column("ID CAT", style="dim", width=6, justify="center")
    categorie.add_column("NOM", min_width=20, justify="right")
    for row in data:
        categorie.add_row(row[0], row[1])
    console.print(Align(categorie,align="center"))

    decide(" CHOISIR ","   BACK  ")
    choice = Prompt.ask("Choississez une option 🤖", choices = ["1","2"])
    actions = {1: chooseCat, 2: make_main_client}
    k = int(choice)
    action = actions.get(k)
    action()
    os.system('cls')
    dbCon.commit()

def chooseCat():
    cat_id = console.input("Entrer l'ID de la catégorie que vous voulez explorer:   ")
    while (testCatId(cat_id) == False):
        cat_id = console.input("[red][b]Entrez une ID existante parmi celles plus-haut: [/b][/red] ")
    c.execute(f"select produit_id, nom_produit, pu, volume_l, masse_g, description from produit where id_categorie = '{cat_id}';")
    os.system('cls')
    make_header()
    console.print("\n\n\n")

    console.print(Align("[bold orange1]PRODUITS[/bold orange1]! 🛍️", align="center"))
    cat_Prod = Table(show_header=True, header_style="bold blue")
    cat_Prod.add_column("id_produit", style="dim", min_width=10, justify="center")
    cat_Prod.add_column("nom", min_width=20, justify="center")
    cat_Prod.add_column("P.U", min_width=12, justify="center")
    cat_Prod.add_column("Volume(l)", min_width=12, justify="center")
    cat_Prod.add_column("Masse(g)", min_width=12, justify="center")
    cat_Prod.add_column("description", min_width=30, justify="center")
    data = c.fetchall()
    for row in data:
        cat_Prod.add_row(row[0], row[1],str(row[2])+" XAF",str(row[3])+" L",str(row[4])+" g",row[5])
    dbCon.commit()
    console.print(Align(cat_Prod,align="center"))
    decide(" COMMANDER ","   BACK  ")
    choice = Prompt.ask("Choississez une option 🤖", choices = ["1","2"])
    actions = {1: chooseProd, 2: displayCat}#Change le 1------------
    k = int(choice)
    action = actions.get(k)
    action()

def displayProd():
    make_header()
    c.execute("select * from produit")
    data = c.fetchall()
    os.system('cls')
    make_header()
    console.print("\n\n\n")
    console.print(Align("[bold orange1]PRODUITS[/bold orange1]! 🛍️", align="center"))

    Prod = Table(show_header=True, header_style="bold blue")
    Prod.add_column("id_produit", style="dim", min_width=8, justify="center")
    Prod.add_column("id_categorie", style="dim", min_width=8, justify="center")
    Prod.add_column("nom", min_width=20, justify="center")
    Prod.add_column("P.U", min_width=12, justify="right")
    Prod.add_column("Volume(l)", min_width=12, justify="right")
    Prod.add_column("Masse(g)", min_width=12, justify="right")
    Prod.add_column("description", min_width=30, justify="center")
    for row in data:
        Prod.add_row(row[0], row[1],row[2],str(row[3])+" XAF",str(row[4])+" L",str(row[5])+" g",row[6])
    dbCon.commit()
    console.print(Align(Prod,align="center"))

    decide(" COMMANDER ","   BACK  ")
    choice = Prompt.ask("Choississez une option 🤖", choices = ["1","2"])
    actions = {1: chooseProd, 2: make_main_client}
    k = int(choice)
    action = actions.get(k)
    action()
    os.system('cls')

def chooseProd():
    prod_id = console.input("Entrer l'ID du produit à commander:   ")
    while (testProdId(prod_id) == False):
        prod_id = console.input("[red][b]Entrez une ID existante parmi celles plus-haut: [/b][/red] ")
    c.execute(f"call orderP('{prod_id}');")
    dbCon.commit()
    console.print("Votre produit à été ajouter à votre panier")
    sleep(2)
    make_main_client()


def displayCmd():
    os.system('cls')
    make_header()
    c.execute("select * from commande")
    data = c.fetchall()
    console.print("\n")
    console.print(Align("[bold orange1]VOTRE PANIER !!![/bold orange1]! 🛍️", align="center"))

    Prod = Table(show_header=True, header_style="bold blue")
    Prod.add_column("id_produit", style="dim", min_width=8, justify="center")
    #Prod.add_column("id_categorie", style="dim", min_width=8, justify="center")
    Prod.add_column("nom ", min_width=20, justify="center")
    Prod.add_column("P.U (XAF)", min_width=12, justify="right")
    Prod.add_column("Volume_T", min_width=12, justify="right")
    Prod.add_column("Masse_T", min_width=12, justify="right")
    Prod.add_column("Qte", min_width=30, justify="center")
    Prod.add_column("Cout_T", min_width=30, justify="center")

    for row in data:
        Prod.add_row(row[1], row[2],str(row[3]),str(row[4]*row[6])+" L",str(row[5]*row[6])+" g",str(row[6]),str(row[3]*row[6])+" XAF")
    dbCon.commit()
    console.print(Align(Prod,align="center"))
    console.print(Align(Panel(f"[dark_orange][b]NET A PAYER : [/b][/dark_orange][green][b]{Summ(data)} XAF[/b][/green] "),align="center"))
    console.print("\n")
    console.print("\n")

    x = Align(Panel(" VALIDER  ", expand=False, height=3, width= 15, title="1", title_align="left"), align= "center", style= "cyan")
    y = Align(Panel("   QTE    ", expand=False, height=3, width= 15, title="2", title_align="left"), align= "center", style= "green")
    z = Align(Panel(" RETIRER  ", expand=False, height=3, width= 15, title="3", title_align="left"), align= "center", style= "orange1")
    s = Align(Panel("   BACK   ", expand=False, height=3, width= 15, title="4", title_align="left"), align= "center", style= "red3")

    #decide(" COMMANDER ","   BACK  ")
    console.print(x)
    console.print(y)
    console.print(z)
    console.print(s)
    choice = Prompt.ask("Choississez une option 🤖", choices = ["1","2","3","4"])
    actions = {1: generate, 2: SetQte, 3: NorderP, 4: make_main_client}
    k = int(choice)
    action = actions.get(k)
    action()
    os.system('cls')


def Summ(data):
    sum = 0
    for row in data:
        sum += row[3]*row[6]
    return sum

def generate():
    num_commande = uuid.uuid1()
    g_console = Console(record=True)
    os.system('cls')
    make_header()
    c.execute("select * from commande")
    data = c.fetchall()
    g_console.print("\n")
    g_console.print(Align(f"[bold orange1]VOTRE COMMANDE : {num_commande}!!![/bold orange1]! 🛍️", align="center"))

    Prod = Table(show_header=True, header_style="bold blue")
    Prod.add_column("id_produit", style="dim", min_width=8, justify="center")
    #Prod.add_column("id_categorie", style="dim", min_width=8, justify="center")
    Prod.add_column("nom ", min_width=20, justify="center")
    Prod.add_column("P.U (XAF)", min_width=12, justify="right")
    Prod.add_column("Volume_T", min_width=12, justify="right")
    Prod.add_column("Masse_T", min_width=12, justify="right")
    Prod.add_column("Qte", min_width=30, justify="center")
    Prod.add_column("Cout_T", min_width=30, justify="center")

    for row in data:
        Prod.add_row(row[1], row[2],str(row[3]),str(row[4]*row[6])+" L",str(row[5]*row[6])+" g",str(row[6]),str(row[3]*row[6])+" XAF")
    dbCon.commit()
    g_console.print(Align(Prod,align="center"))
    g_console.print(Align(Panel(f"[dark_orange][b]NET A PAYER : [/b][/dark_orange][green][b]{Summ(data)} XAF[/b][/green] "),align="center"))
    g_console.print("\n")
    g_console.print("\n")
    idC, nomC, numC, mailC, adresseC = dataClientData()
    g_console.print(f"NUMERO COMMANDE:    {num_commande}")
    g_console.print(f"ID CLIENT: {idC}")
    g_console.print(f"NOM CLIENT: {nomC}")
    g_console.print(f"TEL CLIENT: {numC}")
    g_console.print(f"MAIL CLIENT: {mailC}")
    g_console.print(f"ADRESSE CLIENT: {adresseC}")
    g_console.print(f"DATE DE COMMANDE: {datetime.datetime.now().isoformat()}")
    g_console.print("\n\n\n : MONSIEUR/MADAME A CE STADE DE CONCEPTION CE DOCUMENT FERA OFFICE DE BON DE COMMANDE - LIVRAISON - FACTURE")
    g_console.save_text(f"{idC}-{nomC}.txt")

    sleep(1)
    c.execute("delete from commande;")
    dbCon.commit()
    os.system('cls')
    make_main_client()



def SetQte():
    prod_id = console.input("Entrer l'ID du produit à modifier:   ")
    while (testProdId(prod_id) == False):
        prod_id = console.input("[red][b]Entrez une ID existante parmi celles plus-haut: [/b][/red] ")
    _qte = console.input("Entrer la nouvelle quantité à commander:   ")
    while (not _qte.isnumeric()):
        _qte = console.input("[red][b]Cette quantité est un entier(produit retiré si nul): [/b][/red] ")
    qte = int(_qte)
    c.execute(f"call SetQte('{prod_id}', {qte});")
    dbCon.commit()
    console.print("Votre panier va etre mis à jour")
    make_bar("UPDATING ...",2)
    displayCmd()

def NorderP():
    prod_id = console.input("Entrer l'ID du produit à modifier:   ")
    while (testProdId(prod_id) == False):
        prod_id = console.input("[red][b]Entrez une ID existante parmi celles plus-haut: [/b][/red] ")
    c.execute(f"call NorderP('{prod_id}');")
    dbCon.commit()
    console.print("Votre panier va etre mis à jour")
    make_bar("UPDATING ...",2)
    displayCmd()





