#! /usr/bin/env python
# Author: 	Kris Beazley
# Apache License, Version 2.0 http://www.apache.org/licenses/LICENSE-2.0

# For now we define the location of x10config and heyu here
x10config = "./x10config"
heyu = "/usr/local/bin/heyu"
auto_refresh_rate = "10"

# The version of this script
Heyu_web_interface_version = "11.56_beta_python"

import cgitb, cgi, os, re, subprocess


cgitb.enable()
stdin = cgi.FieldStorage()


expires = "expires=01-Jan-2036 12:00:00 GMT"

 
if 'HTTP_COOKIE' not in os.environ.keys():
    print "Set-Cookie: Interface_version=", Heyu_web_interface_version, ";", expires
    
try:
    if 'heyu_status_change' in stdin.keys():
        #print "<pre>Input: " + name + " value: " + stdin[name].value + "</pre><BR>"
        subprocess.call(["echo", "Content-type:text/html"], shell=False)
        subprocess.call(["echo"], shell=False)
        for name in stdin.keys():
            subprocess.call(stdin[name].value, shell=True,)
    else:
        for name in stdin.keys():
            if stdin[name].value == 'auto_refresh' or stdin[name].value == 'show_all_modules' or stdin[name].value == 'heyu_theme':             
                try:
                    cookies = [os.environ['HTTP_COOKIE']]  
                    for x in cookies:	     
                        for i in stdin.keys():            
                            if stdin[i].value == 'auto_refresh' and re.search('(auto_refresh=True)', x) is None:
                                print "Set-Cookie: auto_refresh=True;", expires
                                auto_refresh = "True"
                            if stdin[i].value == 'auto_refresh' and re.search('(auto_refresh=False)', x) is None:
                                print "Set-Cookie: auto_refresh=False;", expires
                                auto_refresh = "False"   
                            
                            if stdin[i].value == 'show_all_modules' and re.search('(heyu_show_all_modules=True)', x) is None:
                                print "Set-Cookie: heyu_show_all_modules=True;", expires
                                heyu_show_all_modules = "True"
                            if stdin[i].value == 'show_all_modules' and re.search('(heyu_show_all_modules=False)', x) is None:
                                print "Set-Cookie: heyu_show_all_modules=False;", expires
                                heyu_show_all_modules = "False"  
                                                     
                            if stdin[i].value == 'heyu_theme' and re.search('(heyu_theme=default)', x) is None:
                                print "Set-Cookie: heyu_theme=default;", expires
                                heyu_theme = "default"
                            if stdin[i].value == 'heyu_theme' and re.search('(heyu_theme=compact)', x) is None:
                                print "Set-Cookie: heyu_theme=compact;", expires
                                heyu_theme = "compact"
                except:
                    pass

        print('Content-type:text/html')
        print('')
    
except:
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
<button type=submit name=Button1 value=BasicUserConfig=css class=scene_button onclick=\"Status(); show('')\">
<table class=scene_button><tr><td class=scene_button>
<img src=\"imgs/tool.png\" alt=none class=icons>
Control Panel</table></button>

<button type=submit name=Button2 value=show_all_modules class=scene_button onclick=\"Status(); show('This_is_Foobar')\">
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
<br>

<h4 style=\"font-family:Tahoma\">ALIASES</h4>
"""
)

# Open x10config file for reading
# Use upper() to sanitize the content
# Rm alias, STDLM, and STDAM strings.  Yes other strings will show for now.
# Create list array by using replace() and split() ... Tricky!
# Slice the list array

file = open(x10config)

# Set z for formating HTML rows/columns
z = 0
print "<form method=\"post\">"
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
        
        # Call heyu and get on/off status and slice strings
        process = subprocess.Popen(heyu + " -c " + x10config + " onstate " + addr, shell=True, stdout=subprocess.PIPE)
        status = process.communicate()
        status = status[0]
        
        on_icon = status.replace("1","<img src=\"imgs/on2.png\" class=icons>")
        on_icon = on_icon.replace("0","")
        
        xstatus = status.replace("1","off")
        xstatus = xstatus.replace("0","on")
        
        status = status.replace("1","On")
        status = status.replace("0","Off")
        
        # Call heyu and get time stamp and slice strings. ** To do **
        timestamp = subprocess.Popen(heyu + " -c " + x10config + " show tstamp " + addr, shell=True, stdout=subprocess.PIPE)
        timestamp = timestamp.communicate()
        timestamp = timestamp[0]
                
        print "<button type=submit name=\"heyu_status_change\" value=\"heyu turn", addr, xstatus +  "\"class=scene_button onclick=\"Status(); show('')\"><table class=button><tr><td class=button>" + on_icon + unit
        print "<td class=info>", status, addr, "<br><br></table></button>"
        
        # For html formating rows/columns
        z = z+1
        if z == 3:
            print "<tr>"

 
    else:
        pass
        
file.closed
print("</form></table></div></body></html>")

