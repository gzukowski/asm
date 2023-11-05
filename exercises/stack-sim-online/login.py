import requests
import tkinter as tk
from tkinter import font
from simulator import Simulator

BASE_URL = "http://34.17.58.255:8080/"

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

            self.switch_to_simulator(response_data["token"])
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
            
            self.switch_to_simulator(response_data["token"])
        elif response.status_code == 400:    
            self.message_label.config(text="Username already taken.")
        else:
            self.message_label.config(text="Registration failed. Please try again.")
        
    
    def on_closing(self):
        self.destroy()

    def switch_to_simulator(self, token):
        # Close the StartWindow
        self.destroy()

        # Open the Simulator window
        simulator_window = Simulator(token)
        simulator_window.mainloop()

