try:
    from Tkinter import Tk, Frame, BOTH, Label, PhotoImage, OptionMenu, StringVar, Button, Text, Entry, Toplevel
except ImportError:
    from tkinter import Tk, Frame, BOTH, Label, PhotoImage, OptionMenu, StringVar, Button, Text, Entry, Toplevel, filedialog
from tkinter.filedialog import askopenfilename
import os

OptionList = [
'Semiquaver',
'Quaver',
'Crotchet',
'Minim',
'Dotted Minim',
'Semibreve'
] 

KEYS_TO_NOTES = {
    'a': 'C4',
    'b': 'C#4',
    'c': 'D4',
    'd': 'D#4',
    'e': 'E4',
    'f': 'F4',
    'g': 'F#4',
    'h': 'G4',
    'i': 'G#4',
    'j': 'A4',
    'k': 'A#4',
    'l': 'B4',
    'm': 'C5',
    'n': 'C#5',
    'o': 'D5',
    'p': 'D#5',
    'q': 'E5',
    'r': 'F5',
    's': 'F#5',
    't': 'G5',
    'u': 'G#5',
    'v': 'A5',
    'w': 'A#5',
    'x': 'B5',
    'y': 'C6',
    'z': 'Silence'
    }

KEYS_TO_BEATS = {
    '1': 'Semiquaver',
    '2': 'Quaver',
    '3': 'Crotchet',
    '4': 'Minim',
    '5': 'Dotted Minim',
    '6': 'Semibreve'
    }

class Piano(Frame):

    def __init__(self, parent):

        Frame.__init__(self, parent, background='SkyBlue3')

        self.parent = parent

        self.init_user_interface()
        self.music = {'note': [], 'beat': []}

    def clear_music(self):
        self.music['note'].clear()
        self.music['beat'].clear()

    def add_note(self, note, beat=None):
        if beat == None:
            beat = self.beat.get()
        self.music['note'].append(note)
        self.music['beat'].append(beat)
        self.display_music()

    def remove_last_note(self):
        try:
            note = self.music['note'].pop()
            beat = self.music['beat'].pop()
            self.display_music()
            print(note, beat)
            return note, beat
        except:
            self.display_music('Add music first')
            return None, None


    def key_pressed(self, event):
        note = KEYS_TO_NOTES.get(event.char, None)
        if note:
            self.add_note(note)
            print(self.music)


    def button_pressed(self, event):
        self.add_note(event.widget.name)
        print(self.music)


    def display_music(self, message=None):
        if message == None:
            notes = self.music.get('note')
            beats = self.music.get('beat')
            new = [f'{notes[i]}:{beats[i]}' for i in range(len(notes))]
            message = '  '.join(new)
        self.textbox.configure(state='normal')
        self.textbox.delete('1.0', 'end')
        self.textbox.insert(0.0, message)
        self.textbox.configure(state='disabled')

    def read_file(self):
        filename = askopenfilename()
        f = open(filename, 'r')
        music = f.readline()
        f.close()
        return music

    def extract_music(self):
        music_string = self.read_file()
        self.tempo = ord(music_string[0])
        self.show_tempo()
        music_string = music_string[1:-1]
        self.clear_music()
        for (note, beat) in zip(music_string[0::2], music_string[1::2]):
            self.add_note(KEYS_TO_NOTES.get(note), KEYS_TO_BEATS.get(beat))


    def save_to_file(self):
        [('all files', '.*'), ('text files', '.txt')]
        filename = filedialog.asksaveasfilename(initialdir = '/',title = 'Select file')

        music_string = self.music_to_string()
        with open(filename, 'w') as text_file:
            print(music_string, file=text_file)
        print(music_string)
        print(filename)

    def music_to_string(self):
        inv_map_beats = {v: k for k, v in KEYS_TO_BEATS.items()}
        inv_map_notes = {v: k for k, v in KEYS_TO_NOTES.items()}
        music_string = str(chr(self.tempo))
        for note, beat in zip(self.music['note'], self.music['beat']):
            music_string += f'{inv_map_notes.get(note)}{inv_map_beats.get(beat)}'
        music_string += '@'
        return music_string

    def decrease_tempo(self):
        self.tempo -= 1
        self.show_tempo()

    def increase_tempo(self):
        self.tempo += 1
        self.show_tempo()

    def show_tempo(self):
        self.tempo_box.configure(state='normal')
        self.tempo_box.delete('1.0', 'end')
        self.tempo_box.insert(0.0, str(self.tempo))
        self.textbox.configure(state='disabled')

    def send_to_fpga(self):
        music_string = self.music_to_string()
        cwd = os.getcwd()
        filename = cwd.replace('GUI', 'loaders/output.txt')
        with open(filename, 'w+') as text_file:
            print(music_string, file=text_file)
        filename.replace('output.txt', 'console.exe')
        os.system(filename)


    def implement_me(self):
        print('Implement me')

    def init_user_interface(self):

        keys = [
            [0, 'C4'],
            [35, 'C#4'],
            [50, 'D4'],
            [85, 'D#4'],
            [100, 'E4'],
            [150, 'F4'],
            [185, 'F#4'],
            [200, 'G4'],
            [235, 'G#4'],
            [250, 'A4'],
            [285, 'A#4'],
            [300, 'B4'],
            [350, 'C5'],
            [385, 'C#5'],
            [400, 'D5'],
            [435, 'D#5'],
            [450, 'E5'],
            [500, 'F5'],
            [535, 'F#5'],
            [550, 'G5'],
            [585, 'G#5'],
            [600, 'A5'],
            [635, 'A#5'],
            [650, 'B5'],
            [700, 'C6'],
        ]

        for key in keys:
            if len(key[1]) == 2:
                img = 'pictures/white_key.gif'
                key.append(self.create_key(img, key))

        for key in keys:
            if len(key[1]) > 2:
                img = 'pictures/black_key.gif'
                key.append(self.create_key(img, key))

        load_button = Button(self, text='Load', command=self.extract_music, font=('Helvetica', 22))
        load_button.place(x=750, y=40, width=90, height=40)

        save_button = Button(self, text='Save', command=self.save_to_file, font=('Helvetica', 22))
        save_button.place(x=750, y=80, width=90, height=40)

        play_button = Button(self, text='Play', command=self.send_to_fpga, font=('Helvetica', 22))
        play_button.place(x=750, y=120, width=90, height=40)

        undo_button = Button(self, text='Undo', command=self.remove_last_note, font=('Helvetica', 22))
        undo_button.place(x=750, y=160, width=90, height=40) 

        increase_button = Button(self, text='+', command=self.increase_tempo, font=('Helvetica', 22))
        increase_button.place(x=750, y=200, width=45, height=40) 

        decrease_button = Button(self, text='-', command=self.decrease_tempo, font=('Helvetica', 22))
        decrease_button.place(x=795, y=200, width=45, height=40) 

        self.beat = StringVar(self)
        self.beat.set(OptionList[0])
        opt = OptionMenu(self, self.beat, *OptionList)
        opt.config(font=('Helvetica', 12))
        opt.place(x=750, y=0, height=40, width=90)

        self.textbox = Text(self, bg='aqua')
        self.textbox.place(y=200, width=750)
        self.textbox.insert(0.0, 'La La Laaa!')
        self.textbox.configure(state='disabled')


        self.tempo = 60

        self.tempo_box = Text(self, bg='aqua')
        self.tempo_box.place(x=750, y=240, width=90)
        self.show_tempo()

        self.parent.title('Key Selector')

        w = 840
        h = 270
        sw = self.parent.winfo_screenwidth()
        sh = self.parent.winfo_screenheight()
        x = (sw - w) / 2
        y = (sh - h) / 2
        self.parent.geometry('%dx%d+%d+%d' % (w, h, x, y))

        self.parent.keys = keys
        self.parent.bind('<KeyPress>', self.key_pressed)

        self.pack(fill=BOTH, expand=1)

    def create_key(self, img, key):
        key_image = PhotoImage(file=img)
        label = Label(self, image=key_image, bd=0)
        label.image = key_image
        label.place(x=key[0], y=0)
        label.name = key[1]
        label.bind('<Button-1>', self.button_pressed)
        return label


def main():
    root = Tk()
    app = Piano(root)
    app.mainloop()

if __name__ == '__main__':
    main()
