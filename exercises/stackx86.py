import random
from enum import Enum
import tkinter as tk
from tkinter import font


GROWTH = {"dec":1, "inc":-1}

MINIMUM_ADDRESS = 0x0fffff05
MAXIMUM_ADDRESS = 0x0ffffffa
MINIMUM_VALUE = 0x10000000
MAXIMUM_VALUE = 0x1fffffff



class Simulator:
    def __init__(self, root):
        self.root = root
        self.root.title("Stacksim")
        self.root.geometry("400x400")
        self.root.configure(bg="light gray")
        self.growth = random.choice(list(GROWTH.keys()))
        custom_font = font.Font(family="Helvetica", size=16)
        self.adress_labels = []
        self.values_labels = []
        self.refresh_cells()
        self.refresh_values()


        for index, value in enumerate(self.cells):
            address_label = tk.Label(root, text=f"{value}:".upper(), padx=10, font=custom_font, width=8)
            address_label.grid(row=index, column=0)
            self.adress_labels.append(address_label)

        for index, value in enumerate(self.values):
            value_label = tk.Label(root, text=f"{value}".upper(), padx=10, font=custom_font, width=5)
            value_label.grid(row=index, column=1)
            self.values_labels.append(value_label)

        self.update_button = tk.Button(root, text="Next", command=self.update)
        self.update_button.grid(row=8, columnspan=2, pady=10)

        self.stack_pointer_label = tk.Label(root, text=f"{hex(self.stack_pointer)}".upper(), padx=10, font=custom_font)
        self.stack_pointer_label.grid(row=9, columnspan=1, pady=10)

        self.pointer_label = tk.Label(root, text=f"<-", font=custom_font)
        self.pointer_label.grid(row=9, column=1)

        self.entry = tk.Entry(root, width=20,)
        self.entry.grid(row=8, column=3, pady=10)

        self.button = tk.Button(root, text="Submit", command=self.check)
        self.button.grid(row=9, column=3)

    def check(self):
        user_input = self.entry.get().upper()
        resulting_string = "".join(self.answer).upper()
        if user_input == resulting_string:
            self.entry.config(bg="green")
        else:
            self.entry.config(bg="red")
        

    def update(self):
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




def main():
    root = tk.Tk()
    app = Simulator(root)
    root.mainloop()

if __name__ == "__main__":
    main()
