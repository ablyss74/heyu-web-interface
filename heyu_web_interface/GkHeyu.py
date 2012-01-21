#! /usr/bin/env python

from gi.repository import Gtk
import re, subprocess

class ToggleButtonWindow(Gtk.Window):
        
    def __init__(self):
        Gtk.Window.__init__(self, title="Heyu")
        self.set_border_width(10)
        self.set_default_size(200, 200)
        vbox = Gtk.Box(spacing=6, orientation=Gtk.Orientation.VERTICAL)
        self.add(vbox)
       

        
        x10config = "/var/www/heyu-web-interface/heyu_web_interface/x10config"
        heyu_path = "/usr/local/bin/heyu"

        file = open(x10config)     
        for line in file:
            if re.match('ALIAS', line.upper()) and re.search('(EXCLUDE)', line.upper()) is None:
                a = re.search("ALIAS", line.upper())        
                if a:
                    line = line[:a.start()] + line[a.end():]
                b = re.search("STDLM", line.upper())        
                if b:
                    line = line[:b.start()] + line[b.end():]
                c = re.search("STDAM", line.upper())        
                if c:
                    line = line[:c.start()] + line[c.end():]
                        
                line = line.replace("#","")
                line = line.lstrip()
                line = line.rstrip()
                line = line.replace(" "," =",1)
                line = line.split('=')
                unit = line[0]
                unit = unit.replace("_"," ")
                unit = unit.strip()
                addr = line[1]
                addr = addr.lstrip()
                addr = addr.split()
                addr = addr[0]
     
                if ',' in addr:
                    addr = addr[:2]
                       
                process = subprocess.Popen([heyu_path, '-c', x10config, 'onstate', addr], stdout=subprocess.PIPE)
                status = process.communicate()
                status = status[0]
                
                button = Gtk.ToggleButton(unit)    
                            
                if '1' in status:                    
                    button.set_active(True)       
                                                
                button.connect("toggled", self.on_button_toggled, unit, status, heyu_path, x10config, addr)
                vbox.pack_start(button, 1, 1, 1)
                
            
        file.closed

    def on_button_toggled(self, button, unit, status, heyu_path, x10config, addr):
        if button.get_active():
            state = "on"
        else:
            state = "off"
        print "Unit", addr, '"' + unit + '"',"was turned", state + "."
        subprocess.call([heyu_path, '-c', x10config, state, addr], stdout=subprocess.PIPE)

        

win = ToggleButtonWindow()
win.connect("delete-event", Gtk.main_quit)
win.show_all()
Gtk.main()
