from rich.console import Console
from rich.text import Text
from rich.theme import Theme
import os
os.system('cls')
'''PRINTS IN RICH
from rich.console import print
print(f"Let do some math: 5 + 7 = {5+7}")
print({"a": [1, 2, 3], "b": {"c": 5}})'''
'''

console = Console()
console.print("This is somme text.")
console.print("This is somme text.", style= "bold")
console.print("This is somme text.", style= "bold underline")
console.print("This is somme text.", style= "bold underline green")
console.print("This is somme text.", style= "bold underline red on white")
console.print("[bold]This [cyan]is[/] some text.[/]")'''

"""
TEXT
console = Console()
console.print("This is somme text.", style= "bold underline green")
console.print("[bold]This [cyan]is[/] some text.[/]")
text = Text("Hello,4 World!")
text.stylize("bold magenta", 0, 6)
console.print(text)"""
console = Console()

console.print("Operation successful!", style="success")
console.print("Operation failed!", style="error")
console.print("Operation [error]failed![/error]")

#Emoji
console.print(":thumbs_up: File downloaded!")
console.print(":apple: :bug: :wolf: :cake: :bus:")
