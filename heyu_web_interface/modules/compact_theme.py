#! /usr/bin/env python
# Author: 	Kris Beazley
# Apache License, Version 2.0 http://www.apache.org/licenses/LICENSE-2.0


import cgitb, sys, os, re, subprocess, urllib2
cgitb.enable()

def theme(x10config, x10sched, heyu, HC):

    print("""
            <form method=post><select name=states onChange=\"goPage(this.options[this.selectedIndex].value)\" size=1>
            <option>Heyu
            <optgroup label=SCENES>""")
    file = open(x10config)
    print("""
            <!-- Begin Form For Scenes and Aliases -->
            <form method=post>
            <h4 style=\"font-family:Tahoma\">SCENES</h4>""")
            
    for scene in file:
        if re.match('SCENE', scene.upper()) and re.search('(EXCLUDE)', scene.upper()) is None:
            a = re.search("SCENE", scene.upper())        
            if a:
                scene = scene[:a.start()] + scene[a.end():]
            scene = scene.rstrip()
            scene = scene.lstrip()
            scene = scene.replace("  "," ")
            cmds = scene
            name = scene.split(' ')
            name = name[0]
            cmds = cmds.replace(name,"")
            cmds = cmds.replace(";","; heyu ")
            cmds = cmds.lstrip()
            name = name.replace("_"," ")
            print "<option value=\"?heyu_do_cmd " + cmds + "\"> " + name
    file.closed     
       
    print "</optgroup><optgroup label=ALIASES>"
    

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
            addr = line[1]
            addr = addr.lstrip()
            

            # Call heyu and get on/off status and slice strings
            process = subprocess.Popen(heyu + " -c " + x10config + " onstate " + addr, shell=True, stdout=subprocess.PIPE)
            status = process.communicate()
            status = status[0]        
            xstatus = status.replace("1","off")
            xstatus = xstatus.replace("0","on")
            xstatus = xstatus.rstrip() 
            status = status.replace("1","- On")
            status = status.replace("0","- Off")
            print "<option value=\"?heyu_do_cmd " + xstatus, addr + "\">" + unit, status

            
    file.closed
    
    
    print(""" </optgroup>
			<optgroup label=CONFIG>
			<option value=?control_panel_@{x10_config}>Control Panel""")

    print "<option value=?heyu_do_cmd%20allon%20" + HC + ">All Units On"
    print "<option value=?heyu_do_cmd%20alloff%20" + HC + ">All Units Off"
    print "<option value=?heyu_do_cmd%20kill_all_hc>All Units Off A-P"
    print "</optgroup></select></form>"
    print "<form method=post><button class=userconfigbutton type=button onclick=\"Status(); show('heyu_theme')\"> Change Theme</button></form>"
