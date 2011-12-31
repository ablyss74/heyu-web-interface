#! /usr/bin/env python
# Author: 	Kris Beazley
# Apache License, Version 2.0 http://www.apache.org/licenses/LICENSE-2.0

# For now we define some static variables.
# In the future this should be controlled in the control panel
x10config = "./x10config"
heyu = "/usr/local/bin/heyu"
auto_refresh_rate = "10"


# The version of this script
Heyu_web_interface_version = "11.56_beta_python"

import cgitb, sys, os, re, subprocess
sys.path.append('./modules')

cgitb.enable()
expires = "expires=01-Jan-2036 12:00:00 GMT"

 
if 'HTTP_COOKIE' not in os.environ.keys():
    print "Set-Cookie: Interface_version=", Heyu_web_interface_version, ";", expires
    print "Set-Cookie: auto_refresh=False;", expires
    print "Set-Cookie: heyu_show_all_modules=False;", expires
    print "Set-Cookie: heyu_theme=default;", expires
   
   
if 'HTTP_COOKIE' in os.environ.keys():
    cookies = [os.environ['HTTP_COOKIE']]  
    for x in cookies:
        if re.search('(auto_refresh=True)', x) is not None:
            auto_refresh = "True"
        if re.search('(heyu_show_all_modules=True)', x) is not None:
            heyu_show_all_modules = "True"
        if re.search('(heyu_theme=compactt)', x) is not None:
            heyu_theme = "compact"
    
   
try:
    for data in sys.stdin:

        if 'heyu_do_cmd' in data:
            cmd = data.replace("heyu_do_cmd",heyu + " -c " + x10config)
            subprocess.call(cmd, shell=True,)
            #print('Content-type:text/html')
            #print('')
            #print cmd
            #urllib2.unquote("")
            
        else:
            if 'auto_refresh' in data or 'show_all_modules' in data or 'heyu_theme' in data:  
                try:
                    cookies = [os.environ['HTTP_COOKIE']] 
                    for x in cookies:
                        for i in data:
                            if 'auto_refresh' in data and re.search('(auto_refresh=True)', x) is None:
                                print "Set-Cookie: auto_refresh=True;", expires
                                auto_refresh = "True"
                            if 'auto_refresh' in data and re.search('(auto_refresh=False)', x) is None:
                                print "Set-Cookie: auto_refresh=False;", expires
                                auto_refresh = "False"
                                
                            if  'show_all_modules' in data and re.search('(heyu_show_all_modules=True)', x) is None:
                                print "Set-Cookie: heyu_show_all_modules=True;", expires
                                heyu_show_all_modules = "True"
                            if  'show_all_modules' in data and re.search('(heyu_show_all_modules=False)', x) is None:
                                print "Set-Cookie: heyu_show_all_modules=False;", expires
                                heyu_show_all_modules = "False"  
                                                     
                            if 'heyu_theme' in data and re.search('(heyu_theme=default)', x) is None:
                                print "Set-Cookie: heyu_theme=default;", expires
                                heyu_theme = "default"
                            if 'heyu_theme'in data and re.search('(heyu_theme=compact)', x) is None:
                                print "Set-Cookie: heyu_theme=compact;", expires
                                heyu_theme = "compact"
                except:
                    pass

except:
    pass
    
print('Content-type:text/html')
print('')
    
# Start HTML, Javascript 
print("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/1998/REC-html40-19980424/loose.dtd\">")

print("<html><head><title>Heyu Web Interface v." + Heyu_web_interface_version + "</title>")

print( """
<style type=text/css>
@import url(heyu_style.css);
@import url(tinyboxstyle.css);
textarea {
	width: 400px;
	height: 650px;
}
</style>""")

print "<script type=text/javascript>refreshInterval=setInterval('ajax_update()',", auto_refresh_rate + "000);</script>"

print("""
<script type=text/javascript src=javascript/ajax.js></script>
<script type=text/javascript src=javascript/phone.js></script>
<script type=text/javascript src=javascript/progressbar.js></script>
<script type=text/javascript src=javascript/compact_theme.js></script>
<script type=text/javascript src=javascript/packed.js></script>
<meta name=\"viewport\" content=\"width=device-width\">
<META HTTP-EQUIV=\"Content-Type\" content=\"text/html;charset=utf-8\">
<META HTTP-EQUIV=\"CACHE-CONTROL\" CONTENT=\"NO-CACHE\">
<META HTTP-EQUIV=\"Pragma\" CONTENT=\"no-cache\">
<META HTTP-EQUIV=\"Expires\" CONTENT=\"-1\">

<div id=progress class=hide><img src=imgs/loading2.gif alt=none>  Please Wait</div>
<div id=content>

<table><tr><td>
<h4 style=\"font-family:Tahoma\">HEYU WEB INTERFACE </h4>

<form method="post">
<button type=submit name=Button1 value=control_panel class=scene_button onclick=\"Status(); show('')\">
<table class=scene_button><tr><td class=scene_button>
<img src=\"imgs/tool.png\" alt=none class=icons>
Control Panel</table></button>

<button type=submit name=Button2 value=show_all_modules class=scene_button onclick=\"Status(); show('')\">
<table class=scene_button><tr><td class=scene_button>
<img src=\"imgs/horizon.png\" alt=none class=icons>
Show All Modules</table></button>

<button id=refresh type=submit name=Button3 value=auto_refresh class=scene_button onclick=\"Status(); show('')\">
<table class=scene_button><tr><td class=scene_button>
<img src=\"imgs/reload.png\" alt=none class=icons>
Auto Refresh""")
try:
    auto_refresh = auto_refresh.replace("False","")
    print(auto_refresh.replace("True", auto_refresh_rate + "s"))
except:
    pass
print("""</table></button>
</table></button></form></table>
<br>""")

# Open x10config file for reading
# Use upper() to sanitize the content
# Rm alias, STDLM, and STDAM strings.  Yes other strings will show for now.
# Create list array by using replace() and split() ... Tricky!
# Slice the list array

file = open(x10config)
print "<form method=\"post\">"
print("<h4 style=\"font-family:Tahoma\">Scenes</h4>")
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
        print "<button type=button class=scene_button onclick=\"Status(); show('heyu_do_cmd " + cmds + "')\">"
        print "<table class=scene_button><tr><td class=scene_button><img src=\"imgs/scenes.png\" alt=none class=icons>"
        print name, "<br></table></button>"
file.closed



print("<br><h4 style=\"font-family:Tahoma\">ALIASES</h4>")

file = open(x10config)
# Set z for formating HTML rows/columns
z = 0
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
        on_icon = status.replace("1","<img src=\"imgs/on2.png\" class=icons>")
        on_icon = on_icon.replace("0","")        
        xstatus = status.replace("1","off")
        xstatus = xstatus.replace("0","on")
        xstatus = xstatus.rstrip() 
        status = status.replace("1","<font class=info_on_color>On,</font>")
        status = status.replace("0","<font class=info_off_color>Off</font>")
        
        # Call heyu and get dimlevel.
        dimlevel = subprocess.Popen(heyu + " -c " + x10config + " dimlevel " + addr, shell=True, stdout=subprocess.PIPE)
        dimlevel = dimlevel.communicate()
        dimlevel = dimlevel[0]
        dimlevel = dimlevel.rstrip()
        
        # Call heyu and get time stamp and slice strings.
        timestamp = subprocess.Popen(heyu + " -c " + x10config + " show tstamp " + addr, shell=True, stdout=subprocess.PIPE)
        timestamp = timestamp.communicate()
        try:
            timestamp = timestamp[0]
            timestamp = timestamp.split(' ')
            day = timestamp[1]
            time = timestamp[3]
            month = timestamp[5]
            mday = timestamp[6]
            year = timestamp[7]
                
            print "<button type=button class=scene_button onclick=\"Status(); show('heyu_do_cmd " + xstatus, addr + "')\">"
            print "<table class=button><tr><td class=button>" + on_icon + unit
        
            # Info part of the button
            print "<td class=info>", addr, status, dimlevel + "&#37; Power", "<br>", month, mday + ",", time, "<br></table></button>"
        
            # For html formatting rows/columns
            z = z+1
            if z == 3:
                print "<tr>"
        except:
            z = "error"
if 'error' == z:
    print "<pre>Warning: Heyu not started or owned by the interface."
    print "Trying to start heyu now..."
    start_heyu = subprocess.Popen(heyu + " -c " + x10config + " start ", shell=True, stdout=subprocess.PIPE)
    start_heyu = start_heyu.communicate()
    start_heyu = start_heyu[0]
    start_heyu = start_heyu.replace("starting","",1)
    start_heyu = start_heyu.replace("heyu_engine","",1)
    start_heyu = start_heyu.replace("Starting","")
    print start_heyu.replace("heyu_engine","the heyu engine",1)
    print "<form action=/ method=POST><input type=submit value=Reload>"
         
file.closed
print("</form></table></div></body></html>")

