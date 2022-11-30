import psycopg2
from rich.table import Table
from rich.console import Console

con = psycopg2.connect(database="template1", user="postgres", password="0123456789", host="localhost", port="5432")
console = Console()
print("Database opened successfully")
nam = "mathias"
cur = con.cursor()
#cur.execute("insert into client(nom) values ('Messie')")
cur.execute("select * from Client")
console.print("[bold magenta]CLIENT[/bold magenta]!", "💻","👤")

table = Table(show_header=True, header_style="bold blue")
table.add_column("id", style="dim", width=6)
table.add_column("num", style="dim", width=6)
table.add_column("client_id", min_width=20)
table.add_column("nom", min_width=12, justify="right")
con.commit()

data = cur.fetchall()

k = 0
for row in data:
    table.add_row(str(row[0]),str(k),str(row[1]),str(row[2]))
    k = k+1


print("Record inserted successfully")
con.close()
console.print(table)
        