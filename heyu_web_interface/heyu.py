#! /usr/bin/env python
# Author: 	Kris Beazley

x10config = "./x10config"

Heyu_web_interface_version = "11.56_beta_python"

import cgitb, cgi, os, re, subprocess

cgitb.enable()
stdin = cgi.FieldStorage()


expires = "expires=01-Jan-2036 12:00:00 GMT"
     
if 'HTTP_COOKIE' not in os.environ.keys():
    print "Set-Cookie: Interface_version=", Heyu_web_interface_version, ";", expires
    print('Content-type:text/html')
    print('')



if 'HTTP_COOKIE' in os.environ:
    subprocess.call("echo Content-type:text/html", shell=True)
    subprocess.call("echo", shell=True)
    try:
        for name in stdin.keys():
            if name == 'heyu_status_change':
                #print "<pre>Input: " + name + " value: " + stdin[name].value + "</pre><BR>"
                try:
                    subprocess.call(stdin[name].value, shell=True)
                except:
                    pass
    except:
        pass




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
</style>
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
"""
)
             
print( """
<table><tr><td>
<h4 style=\"font-family:Tahoma\">HEYU WEB INTERFACE </h4>

<form method="post">
<button type=submit name=Button1 value=BasicUserConfig=css class=scene_button onclick=\"Status(); show('')\">
<table class=scene_button><tr><td class=scene_button>
<img src=\"imgs/tool.png\" alt=none class=icons>
Control Panel</table></button>

<button type=submit name=Button2 value=show_all_modules class=scene_button onclick=\"Status(); show('')\">
<table class=scene_button><tr><td class=scene_button>
<img src=\"imgs/horizon.png\" alt=none class=icons>
Show All Modules</table></button>

<button type=submit name=Button3 value=auto_refresh class=scene_button onclick=\"Status(); show('')\">
<table class=scene_button><tr><td class=scene_button>
<img src=\"imgs/reload.png\" alt=none class=icons>
Auto Refresh</table></button>


</table></button></form></table>
<br>
<h4 style=\"font-family:Tahoma\">ALIASES</h4>



"""
)


file = open(x10config)
z = 1

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
        
        # call heyu and get on/off status
        process = subprocess.Popen("heyu -c /var/www/heyu_web_interface/x10config onstate " + addr, shell=True, stdout=subprocess.PIPE)
        status = process.communicate()
        status = status[0]
        
        on_icon = status.replace("1","<img src=\"imgs/on2.png\" class=icons>")
        on_icon = on_icon.replace("0","")
        
        xstatus = status.replace("1","off")
        xstatus = xstatus.replace("0","on")
        
        status = status.replace("1","On")
        status = status.replace("0","Off")
        
        # call heyu and get time stamp 
        timestamp = subprocess.Popen("heyu -c /var/www/heyu_web_interface/x10config show tstamp " + addr, shell=True, stdout=subprocess.PIPE)
        timestamp = timestamp.communicate()
        timestamp = timestamp[0]
                
        print "<form method=\"post\"><button type=submit name=\"heyu_status_change\" value=\"heyu turn", addr, xstatus +  "\"class=scene_button onclick=\"Status(); show('')\"><table class=button><tr><td class=button>" + on_icon + unit
        print "<td class=info>", status, addr, "<br><br></table></button>"
        z = z+1
        if z == 3:
            print "<tr>"
 
    else:
        pass
file.closed
print("</table>")






