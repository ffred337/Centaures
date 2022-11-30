#Veuillez installez les modules suivants: Rich, Psycopg2

from makers import main
import uuid
from models import Client
from clientF import make_main_client
import psycopg2
import tabulate
from rich.console import Console
from rich.panel import Panel
import datetime
if __name__ == "__main__":
    main()
    dbCon = psycopg2.connect(database="Centaures", user="postgres", password="0123456789", host="localhost", port="5433")
    c = dbCon.cursor()
    c.execute("delete from Commande;")
    dbCon.commit()
    dbCon.close()
    c.close()
    make_main_client()

