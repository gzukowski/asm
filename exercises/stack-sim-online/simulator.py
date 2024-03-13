import random
from tkinter import messagebox
import requests
import tkinter as tk
from tkinter import font
import sys



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
        custom_font = font.Font(family="Helvetica", size=16)

        self.register = "EAX"
        self.adress_labels = []
        self.values_labels = []
        self.task_id = 0


        success = self.get_new_task()

        if not success:
            messagebox.showerror("Error", "Failed to load, check internet.")
            return

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

        self.pointer_label = tk.Label(self, text="<-", font=custom_font)
        self.pointer_label.grid(row=9, column=1)

        self.entry = tk.Entry(self, width=20,)
        self.entry.grid(row=8, column=3, pady=10)

        self.submit_button = tk.Button(self, text="Submit", command=self.check)
        self.submit_button.grid(row=9, column=3)

        self.exercise_test_label = tk.Label(self, text="State directly after push EAX, \n what will be the value of EAX after pop EAX", padx=10, font=custom_font)
        self.exercise_test_label.grid(row=10, column=0, columnspan=5)



    def check(self):
        headers = {'Content-Type': 'application/json',
                   'Authorization': f'Token {self.TOKEN}'
                   }
        data = {
            "answer" : self.entry.get().upper(),
            "task_id" : self.task_id
        }
    
        self.submit_button.config(state=tk.DISABLED, relief=tk.SUNKEN, background='gray')
    
        response = requests.get(f"{BASE_URL}validate_answer", headers=headers, json=data)

        if response.status_code != 200:
            



    def update(self):
        self.submit_button.config(state=tk.NORMAL, relief=tk.RAISED, background='SystemButtonFace')

        self.register = random.choice(list(REGISTER.keys()))
        if REGISTER[self.register] == EAX:
            self.exercise_test_label.config(text="State directly after push EAX, \n what will be the value of EAX after pop EAX")
        
        success = self.get_new_task()

        if not success:
            messagebox.showerror("Error", "Failed to load, check internet.")
            return

        for index, value in enumerate(self.cells):
            self.adress_labels[index].config(text=f"{value}".upper())

        for index, value in enumerate(self.values):
            self.values_labels[index].config(text=f"{value}".upper())

        self.stack_pointer_label.config(text=f"{hex(self.stack_pointer)}".upper())
        
        self.entry.delete(0, "end")
        self.entry.config(bg="white")


    def get_new_task(self):
        try:
            response = requests.get(url=BASE_URL+"generate_task")

        except Exception:
            return False
        
        if response.status_code != 200:
            return False
        
        data = response.json()

        self.cells = data["cells"]
        self.values = data["values"]
        self.stack_pointer = data["esp"]
        self.register = data["register"]
        self.task_id = data["task_id"]

        return True
    
    def terminate_program(self):
        sys.exit()

