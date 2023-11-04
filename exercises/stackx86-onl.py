import random
import requests
from enum import Enum
import tkinter as tk
from tkinter import font


BASE_URL = "http://127.0.0.1:8080/"

GROWTH = {"dec":1, "inc":-1}
REGISTER = {"EAX":4, "AX":2}

EAX = 4 #bytes
AX = 2 #bytes

MINIMUM_ADDRESS = 0x0fffff05
MAXIMUM_ADDRESS = 0x0ffffffa
MINIMUM_VALUE = 0x10000000
MAXIMUM_VALUE = 0x1fffffff


TOKEN =""


class Simulator(tk.Tk):
    def __init__(self):
        super().__init__()
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
        user_input = self.entry.get().upper()
        resulting_string = "".join(self.answer).upper()
        self.submit_button.config(state=tk.DISABLED, relief=tk.SUNKEN, background='gray')
        if user_input == resulting_string:
            self.entry.config(bg="green")
        else:
            self.entry.config(bg="red")
        

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


class StartWindow(tk.Tk):
    def __init__(self):
        super().__init__()
        self.start_window_closed = False
        self.title("Stacksim")
        self.geometry("640x480")
        self.protocol("WM_DELETE_WINDOW", self.on_closing)
        self.configure(bg="light gray")
        custom_font = font.Font(family="Helvetica", size=16)
        self.start()
    
    def start(self):
        self.username_label = tk.Label(self, text="Username:")
        self.username_label.pack()
        self.username_entry = tk.Entry(self)
        self.username_entry.pack()

        self.password_label = tk.Label(self, text="Password:")
        self.password_label.pack()
        self.password_entry = tk.Entry(self, show="*")
        self.password_entry.pack()


        self.login_button = tk.Button(self, text="Login", command=self.login)
        self.login_button.pack()

        self.signup_button = tk.Button(self, text="Signup", command=self.signup)
        self.signup_button.pack()

        self.message_label = tk.Label(self, text="", bg="light gray", fg="red")
        self.message_label.pack()


    def login(self):
        username = self.username_entry.get()
        password = self.password_entry.get()
        if not username or not password:
            self.message_label.config(text="Username and password are required.")
            return

        data = {
            "username": username,
            "password": password
        }

        response = requests.post(f"{BASE_URL}login", json=data)

        if response.status_code == 200:  # Successful login
            self.message_label.config(text="Login successful.")

            response_data = response.json()
            TOKEN = response_data["token"]

            self.switch_to_simulator()
        else:
            self.message_label.config(text="Login failed. Please check your credentials.")

    def signup(self):
        username = self.username_entry.get()
        password = self.password_entry.get()
        
        if not username or not password:
            self.message_label.config(text="Username and password are required.")
            return

        data = {
            "username": username,
            "password": password
        }

        response = requests.post(f"{BASE_URL}signup", json=data)

        if response.status_code == 200:  # Successful registration
            self.message_label.config(text="Registration successful.")

            response_data = response.json()
            TOKEN = response_data["token"]
            
            self.switch_to_simulator()
        elif response.status_code == 400:    
            self.message_label.config(text="Username already taken.")
        else:
            self.message_label.config(text="Registration failed. Please try again.")
        
    
    def on_closing(self):
        self.destroy()

    def switch_to_simulator(self):
        # Close the StartWindow
        self.destroy()

        # Open the Simulator window
        simulator_window = Simulator()
        simulator_window.mainloop()

def main():
    app = StartWindow()
    app.mainloop()

if __name__ == "__main__":
    main()
