#Veuillez installez les modules suivants: Rich, Psycopg2

import psycopg2
from models import Client
from rich.markdown import Markdown
from rich import box
from rich.align import Align
from rich.console import Console, Group
from rich.layout import Layout
from rich.panel import Panel
from rich.progress import Progress, SpinnerColumn, BarColumn, TextColumn, track
from rich.syntax import Syntax
from rich.table import Table
from rich.text import Text
from rich.prompt import Prompt
from rich.columns import Columns
import os
#__init.py__
from time import sleep

#LOGIN DE OWNER
own_id = "GROUPE12"
own_psd = "groupe12.iui"
console = Console()

#PLATEFORME TITLES
t_main = Align("[blue]Connectez-vous à la plateforme[/blue]",align= "center", style= "cyan", vertical= "top")
cc ="[green][bold]V0.1[/bold][/green] [red][bold]G12[/bold][/red]"
t_owner = Align(f"[blue]Bienvenue à l'espace [bold]Propriétaire[/bold][/blue] -- Utilisez vos codes d'accès   {cc}",align= "center", style= "cyan", vertical= "top")
t_client = Align(f"[blue]Bienvenue à l'espace [bold]Client[/bold][/blue] -- Veuillez entrer vos information   {cc}",align= "center", style= "cyan", vertical= "top")

#VILLES DE LIVRAISON DISPONIBLES
Villes = ['Ex-Nord', 'Nord', 'Adamaoua', 'Centre', 'Est', 'Nord-Ouest', 'Sud-Ouest', 'Ouest', 'Littoral', 'Sud']

#DATABASE NAME'S
dbname = "Centaures"

currentClient = Client()

_client = Client()
#MAIN VOID
def main():
    make_header()
    console.print("\n")
    console.print(t_main)
    console.print("\n")
    make_mainMenu()

#PAGES HEADER
def make_header():
    fixed_title = '''# CENTAURES ET FRERES'''
    md = Markdown(fixed_title, style="blue")
    os.system('cls')
    console.print(md)

#MAIN MENU
def make_mainMenu():
    a = Align(Panel(" ROOT ", expand=False, height=3, width= 10, title="1", title_align="left"), align= "center", style= "cyan", vertical= "middle")
    b = Align(Panel("CLIENT", expand=False, height=3, width= 10, title="2", title_align="left"), align= "center", style= "green")
    c = Align(Panel(" EXIT ", expand=False, height=3, width= 15, title="3", title_align="left"), align= "center", style= "red")
    console.print(a)
    console.print("\n\n\n")
    console.print(b)
    console.print("\n\n\n")
    console.print(c)
    console.print("\n\n\n")
    choice = Prompt.ask("Choississez une option 🤖", choices = ["1","2","3"])
    actions = {1: make_ownerMenu, 2: make_clientMenu, 3: make_Exit}
    k = int(choice)
    action = actions.get(k)
    action()

#OWNER MENU
def make_ownerMenu():
    make_header()
    console.print("\n")
    console.print(t_owner)
    console.print("\n\n")
    console.print(Align(Panel(" ROOT ", expand=False, height=3, width= 10), align= "center", style= "cyan", vertical= "middle"))
    console.print("\n\n\n")
    make_ownerConnection()

 #CLIENT MENU   
def make_clientMenu():
    make_header()
    console.print("\n")
    console.print(t_client)
    console.print("\n\n")
    console.print(Align(Panel("CLIENT", expand=False, height=3, width= 10), align= "center", style= "green", vertical= "middle"))
    console.print("\n\n\n")
    make_clientRegistration()  

#REGISTER CLIENT
def make_clientRegistration():
    console.rule("[green]NOMS[/green]",characters="_")
    console.print("\n")
    nomC = console.input("Veuillez entrer votre nom : ")
    while(not nomC.isalpha()):
        nomC = console.input("[red][b]Veuillez entrer un nom correcte SVP ! :[/b][/red] ")
    console.rule("[green]NUMERO DE TEL CM[/green]",characters="_")
    console.print("\n")
    numC = console.input("Veuillez entrer votre numéro téléphonique : ")
    while(verify_num(numC) == False):
        numC = console.input("[red][b]Veuillez entrer un numéro(CM) correcte SVP !(+237 6[0-9]*8) :[/b][/red] ")
    console.rule("[green]ADRESSE_COURRIEL[/green]",characters="_")
    console.print("\n")
    mailC = console.input("Veuillez entrer votre mail : ")
    while(verify_mail(mailC) == False):
        mailC = console.input("[red][b]Veuillez entrer un mail correcte SVP ! :[/b][/red] ")
    console.rule("[green]ADRESSE[/green]",characters="_")
    console.print("\n")
    villes_render = [Align(Panel(ville, expand = True), style="cyan",align = "center", vertical="middle") for ville in  Villes]
    console.print(Columns(villes_render))
    adresseC= console.input("Veuillez choisir votre adresse (Respectez la syntaxe ci-dessus) : ")
    while adresseC not in Villes:
        adresseC = console.input("[red][b]Veuillez Respecter la syntaxe comme ci-dessus : [/b][/red] ")
    try:
        dbCon = psycopg2.connect(database=dbname, user="postgres", password="0123456789", host="localhost", port="5433")
        c = dbCon.cursor()
        c.execute(f"call registerClient('{nomC}', '{mailC}', '{numC}', '{adresseC}');")
        dbCon.commit()
        dbCon.close()
    except Exception:
        print("Problème depuis la base de données °!°")
    try:
        dbCon = psycopg2.connect(database=dbname, user="postgres", password="0123456789", host="localhost", port="5433")
        c = dbCon.cursor()
        c.execute(f"select clientIdback('{nomC}', '{mailC}', '{numC}', '{adresseC}');")
        data = c.fetchone()
        for row in data:
            idC = row
        dbCon.commit()
        dbCon.close()
    except Exception:
        print("Problème depuis la base de données °!°")
    
    global currentClient
    currentClient.update(idC, nomC, numC, mailC, adresseC)
    


#OWNER LOGIN
def make_ownerConnection():
    console.print("\n")
    o_id = Prompt.ask("Veuillez entrer votre OWNER_ID 🤖",)
    o_psd = Prompt.ask("Veuillez entrer votre Code d'accès 👾", password= True)
    while(o_id != own_id or o_psd != own_psd):
        console.print("[red][b]Mauvais identifiant et/ou Password[/b][/red] ")
        o_id = Prompt.ask("Veuillez entrer votre OWNER_ID 🤖")
        o_psd = Prompt.ask("Veuillez entrer votre Code d'accès 👾", password= True)
    console.print("[green][b]BIENVENUE MESSIEURS/DAMES[/b][/green] ")
    make_bar("ROOT Connection Loading ...", 5)
    os.system('cls')
    make_main_root()

#EXIT BUTTON
def make_Exit():
    make_bar("Exiting...", 10)
    os.system('cls')

#PROGRESS BAR CREATION
def make_bar(text, r: int):
    console.print("\n\n\n")
    for _ in track(range(r), description = text):
        sleep(0.5)


#VERIFY -----

#VERIFY MAIL ADRESS
def verify_mail(_mail):
    dbCon = psycopg2.connect(database="Centaures", user="postgres", password="0123456789", host="localhost", port="5433")
    c = dbCon.cursor()
    c.execute(f"select '{_mail}' similar to IETF.mailbox () ;")
    dbCon.commit()
    data = c.fetchall()
    for row in data:
        toVerify = row[0]
    return toVerify

#VERIFY CM NUMBER '+237 6********'
def verify_num(_num):
    dbCon = psycopg2.connect(database="Centaures", user="postgres", password="0123456789", host="localhost", port="5433")
    c = dbCon.cursor()
    c.execute(f"select '{_num}' similar to cmTelbox () ;")
    dbCon.commit()
    data = c.fetchall()
    for row in data:
        toVerify = row[0]
    return toVerify
def testCatId(cat_id):
    dbCon = psycopg2.connect(database="Centaures", user="postgres", password="0123456789", host="localhost", port="5433")
    c = dbCon.cursor()
    c.execute(f"select testCatId('{cat_id}');")
    dbCon.commit()
    data = c.fetchall()
    for row in data:
        toVerify = row[0]
    return toVerify

def testProdId(prod_id):
    dbCon = psycopg2.connect(database="Centaures", user="postgres", password="0123456789", host="localhost", port="5433")
    c = dbCon.cursor()
    c.execute(f"select testProdId('{prod_id}');")
    dbCon.commit()
    data = c.fetchall()
    for row in data:
        toVerify = row[0]
    return toVerify

def testTranspId(trans_id):
    dbCon = psycopg2.connect(database="Centaures", user="postgres", password="0123456789", host="localhost", port="5433")
    c = dbCon.cursor()
    c.execute(f"select testTranspId('{trans_id}');")
    dbCon.commit()
    data = c.fetchall()
    for row in data:
        toVerify = row[0]
    return toVerify


def dataClientData():
    global currentClient
    return currentClient.ret()


def make_main_root():
    os.system('cls')
    make_header()
    a = Align(Panel(" ADD  ", expand=False, height=3, width= 15, title="1", title_align="left"), align= "center", style= "cyan", vertical= "middle")
    b = Align(Panel("  DELETE  ", expand=False, height=3, width= 15, title="2", title_align="left"), align= "center", style= "red")
    d = Align(Panel(" ENABLE  ", expand=False, height=3, width= 15, title="3", title_align="left"), align= "center", style= "orange1")
    e = Align(Panel("  DISABLE   ", expand=False, height=3, width= 15, title="4", title_align="left"), align= "center", style= "orange1")
    f = Align(Panel("   SETTINGS   ", expand=False, height=3, width= 15, title="5", title_align="left"), align= "center", style= "green")
    l = Align(Panel("   EXIT   ", expand=False, height=3, width= 15, title="6", title_align="left"), align= "center", style= "red3")
    console.print("\n\n\n")
    console.print(a)
    console.print("\n\n\n")
    console.print(b)
    console.print("\n\n\n")
    console.print(d)
    console.print("\n\n\n")
    console.print(e)
    console.print("\n\n\n")
    console.print(f)
    console.print("\n\n\n")
    console.print(l)
    console.print("\n\n\n")
    choice = Prompt.ask("Choississez une option 🤖", choices = ["1","2","3","4","5","6"])
    actions = {1: add, 2: delete, 3: enable, 4: disable, 5: setting, 6: main}
    k = int(choice)
    action = actions.get(k)
    action()
    os.system('cls')


def add():
    os.system('cls')
    make_header()
    display()
    choice = Prompt.ask("Choississez une option 🤖", choices = ["1","2","3","4","5"])
    k = int(choice)
    if(k == 1):
        console.rule("[green]NOMS[/green]",characters="_")
        console.print("\n")
        nomC = console.input("Veuillez entrer votre nom : ")
        while(not nomC.isalpha()):
            nomC = console.input("[red][b]Veuillez entrer un nom correcte SVP ! :[/b][/red] ")
        console.rule("[green]NUMERO DE TEL CM[/green]",characters="_")
        console.print("\n")
        numC = console.input("Veuillez entrer votre numéro téléphonique : ")
        while(verify_num(numC) == False):
            numC = console.input("[red][b]Veuillez entrer un numéro(CM) correcte SVP !(+237 6[0-9]*8) :[/b][/red] ")
        console.rule("[green]ADRESSE_COURRIEL[/green]",characters="_")
        console.print("\n")
        mailC = console.input("Veuillez entrer votre mail : ")
        while(verify_mail(mailC) == False):
            mailC = console.input("[red][b]Veuillez entrer un mail correcte SVP ! :[/b][/red] ")
        console.rule("[green]ADRESSE[/green]",characters="_")
        console.print("\n")
        villes_render = [Align(Panel(ville, expand = True), style="cyan",align = "center", vertical="middle") for ville in  Villes]
        console.print(Columns(villes_render))
        adresseC= console.input("Veuillez choisir votre adresse (Respectez la syntaxe ci-dessus) : ")
        while adresseC not in Villes:
            adresseC = console.input("[red][b]Veuillez Respecter la syntaxe comme ci-dessus : [/b][/red] ")
        try:
            dbCon = psycopg2.connect(database="Centaures", user="postgres", password="0123456789", host="localhost", port="5433")
            c = dbCon.cursor()
            c.execute(f"call registerClient('{nomC}', '{mailC}', '{numC}', '{adresseC}');")
            dbCon.commit()
            dbCon.close()
        except Exception:
            print("Problème depuis la base de données °!°")
        console.print("CLIENT ENREGISTRE AVEC SUCCES")
        os.system('cls')
        make_main_root()
    
    elif(k == 2):
        os.system('cls')
        make_header()
        console.rule("[green]NOMS[/green]",characters="_")
        console.print("\n")
        nomT = console.input("Veuillez entrer son nom : ")
        while(not nomT.isalpha()):
            nomT = console.input("[red][b]Veuillez entrer un nom correcte SVP ! :[/b][/red] ")
        console.rule("[green]ADRESSE_COURRIEL[/green]",characters="_")
        console.print("\n")
        mailT = console.input("Veuillez entrer son mail : ")
        while(verify_mail(mailT) == False):
            mailT = console.input("[red][b]Veuillez entrer un mail correcte SVP ! :[/b][/red] ")
        console.rule("[green]ADRESSE[/green]",characters="_")
        console.print("\n")
        villes_render = [Align(Panel(ville, expand = True), style="cyan",align = "center", vertical="middle") for ville in  Villes]
        console.print(Columns(villes_render))
        adresseT= console.input("Veuillez choisir votre adresse (Respectez la syntaxe ci-dessus) : ")
        while len(adresseT) != 3:
            adresseT = console.input("[red][b]Veuillez Respecter la syntaxe [A-Z]3 : [/b][/red] ")
        try:
            dbCon = psycopg2.connect(database="Centaures", user="postgres", password="0123456789", host="localhost", port="5433")
            c = dbCon.cursor()
            c.execute(f"call registerTranspo('{nomT}', '{mailT}', '{adresseC}');")
            dbCon.commit()
            dbCon.close()
        except Exception:
            print("Problème depuis la base de données °!°")
        console.print("NOUVEAUX TRANSPORTEUR ENREGISTRE AVEC SUCCES")
        os.system('cls')
        make_main_root()

    elif(k ==3):
        print()





def delete():
    os.system('cls')
    make_header()
    display()
    

def enable():
    os.system('cls')
    make_header()
    display()

def disable():
    os.system('cls')
    make_header()
    display()

def setting():
    os.system('cls')
    make_header()
    display()


def display():
    x = Align(Panel(" CLIENT  ", expand=False, height=3, width= 15, title="1", title_align="left"), align= "center", style= "cyan", vertical= "middle")
    y = Align(Panel("  TRANSPO  ", expand=False, height=3, width= 15, title="2", title_align="left"), align= "center", style= "green")
    z = Align(Panel(" CATEGORIE  ", expand=False, height=3, width= 15, title="3", title_align="left"), align= "center", style= "orange1")
    f = Align(Panel("   PRODUIT   ", expand=False, height=3, width= 15, title="4", title_align="left"), align= "center", style= "orange1")
    g = Align(Panel("   BACK   ", expand=False, height=3, width= 15, title="5", title_align="left"), align= "center", style= "red3")
    console.print("\n\n\n")
    console.print(x)
    console.print("\n\n\n")
    console.print(y)
    console.print("\n\n\n")
    console.print(z)
    console.print("\n\n\n")
    console.print(f)
    console.print("\n\n\n")
    console.print(g)