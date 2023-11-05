import random
import requests
import tkinter as tk
from tkinter import font

BASE_URL = "http://127.0.0.1:8080/"
GROWTH = {"dec": 1, "inc": -1}
REGISTER = {"EAX": 4, "AX": 2}
EAX = 4  # bytes
AX = 2  # bytes
MINIMUM_ADDRESS = 0x0fffff05
MAXIMUM_ADDRESS = 0x0ffffffa
MINIMUM_VALUE = 0x10000000
MAXIMUM_VALUE = 0x1fffffff

class Simulator(tk.Tk):
    def __init__(self, token):
        super().__init__()
        self.TOKEN = token
        self.title("Stacksim")
        self.geometry("640x480")
        self.configure(bg="light gray")
        self.growth = random.choice(list(GROWTH.keys()))
        custom_font = font.Font(family="Helvetica", size=16)
        self.register = "EAX"
        self.adress_labels = []
        self.values_labels = []
        self.refresh_cells()
        self.refresh_values()



        for index, value in enumerate(self.cells):
            address_label = tk.Label(self, text=f"{value}:".upper(), padx=10, font=custom_font, width=8)
            address_label.grid(row=index+1, column=0)
            self.adress_labels.append(address_label)

        for index, value in enumerate(self.values):
            value_label = tk.Label(self, text=f"{value}".upper(), padx=10, font=custom_font, width=5)
            value_label.grid(row=index+1, column=1)
            self.values_labels.append(value_label)

        self.update_button = tk.Button(self, text="Next", command=self.update)
        self.update_button.grid(row=8, columnspan=2, pady=10)

        self.stack_pointer_label = tk.Label(self, text=f"{hex(self.stack_pointer)}".upper(), padx=10, font=custom_font)
        self.stack_pointer_label.grid(row=9, columnspan=1, pady=10)

        self.pointer_label = tk.Label(self, text=f"<-", font=custom_font)
        self.pointer_label.grid(row=9, column=1)

        self.entry = tk.Entry(self, width=20,)
        self.entry.grid(row=8, column=3, pady=10)

        self.submit_button = tk.Button(self, text="Submit", command=self.check)
        self.submit_button.grid(row=9, column=3)

        self.exercise_test_label = tk.Label(self, text=f"Stan bezposrednio po push EAX, \n jaka wartosc bedzie w EAX po wykonaniu pop EAX", padx=10, font=custom_font)
        self.exercise_test_label.grid(row=10, column=0, columnspan=5)

    def check(self):
        headers = {'Content-Type': 'application/json',
                   'Authorization': f'Token {self.TOKEN}'
                   }
        data = {}

        user_input = self.entry.get().upper()
        resulting_string = "".join(self.answer).upper()
        self.submit_button.config(state=tk.DISABLED, relief=tk.SUNKEN, background='gray')
        
        if user_input == resulting_string:
            self.entry.config(bg="green")
            data = {"wins": 1, "losses": 0}
        else:
            self.entry.config(bg="red")
            data = {"wins": 0, "losses": 1}

        response = requests.get(f"{BASE_URL}validate_token", headers=headers, json=data)

    def update(self):
        self.submit_button.config(state=tk.NORMAL, relief=tk.RAISED, background='SystemButtonFace')

        self.register = random.choice(list(REGISTER.keys()))
        if REGISTER[self.register] == EAX:
            self.exercise_test_label.config(text=f"Stan bezposrednio po push EAX, \n jaka wartosc bedzie w EAX po wykonaniu pop EAX")
        else:
            self.exercise_test_label.config(text=f"Stan bezposrednio po push AX, \n jaka wartosc bedzie w AX po wykonaniu pop AX")

        self.refresh_cells()
        for index, value in enumerate(self.cells):
            self.adress_labels[index].config(text=f"{value}".upper())

        self.refresh_values()
        for index, value in enumerate(self.values):
            self.values_labels[index].config(text=f"{value}".upper())

        self.stack_pointer_label.config(text=f"{hex(self.stack_pointer)}".upper())
        
        self.entry.delete(0, "end")
        self.entry.config(bg="white")

    def refresh_cells(self):
        self.stack_pointer : int =  random.randint(MINIMUM_ADDRESS,MAXIMUM_ADDRESS)
        self.growth = random.choice(list(GROWTH.keys()))
        self.cells = [
            hex(self.stack_pointer - (3*GROWTH[self.growth]))[2:],
            hex(self.stack_pointer - (2*GROWTH[self.growth]))[2:],
            hex(self.stack_pointer - (1*GROWTH[self.growth]))[2:],
            hex(self.stack_pointer)[2:],
            hex(self.stack_pointer + (1*GROWTH[self.growth]))[2:],
            hex(self.stack_pointer + (2*GROWTH[self.growth]))[2:],
            hex(self.stack_pointer + (3*GROWTH[self.growth]))[2:]
        ]

    def refresh_values(self):
        self.answer : str = str(hex(random.randint(MINIMUM_VALUE,MAXIMUM_VALUE)))[2:]
        splitted_answer = [self.answer[i:i+2] for i in range(0, len(self.answer), 2)]

        self.answer = splitted_answer

        hex_integers = [random.randint(0, 255) for _ in range(3)]
        hex_strings = [hex(num)[2:].zfill(2) for num in hex_integers]

        if GROWTH[self.growth] == -1:
            self.values =  self.answer  + hex_strings
        else:
            self.values =  hex_strings + self.answer[::-1]

        if REGISTER[self.register] == AX:
            self.answer = self.answer[-2::]

