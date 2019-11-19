import serial
from tkinter import *

try: 
    port = serial.Serial("/dev/tty.RNBT-EA6F-RNI-SPP", 9600)
except:
    print("Cannot open port")

def IncreaseTempo():
    try:
        port.write('+'.encode())
    except:
        print("Couldn't increase tempo")

def DecreaseTempo():
    try:   
        port.write('-'.encode())
    except:
        print("Couldn't decrease tempo")   

# Create Root TkInter 
root = Tk() 
root.title("Tempo Controller")
root.geometry("400x300")

increase = Button(root, text = "Increase Tempo", command = IncreaseTempo, height = 9, width = 45)
increase.config(font = "bold")
increase.place(x = 0, y = 0)

decrease = Button(root, text = "Decrease Tempo", command = DecreaseTempo, height = 9, width = 45)
decrease.config(font = "bold")
decrease.place(x = 0, y = 150)

root.mainloop()


