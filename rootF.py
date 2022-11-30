import psycopg2
from models import Client
from rich.align import Align
from rich.console import Console, Group
from rich.panel import Panel
from rich.table import Table
from rich.prompt import Prompt
import os
from rich.columns import Columns
import datetime
from time import sleep
from makers import make_header, main,testCatId,testProdId,make_bar,dataClientData,verify_num,verify_mail,Villes
import uuid

console = Console()

