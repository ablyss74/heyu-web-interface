#! /usr/bin/env python
#   Author: 	Kris Beazley
#   Copyright 2012 Kris Beazley

#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at

#       http://www.apache.org/licenses/LICENSE-2.0

#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#   Apache License, Version 2.0 http://www.apache.org/licenses/LICENSE-2.0


import cgitb, sys, subprocess, urllib2
sys.path.append('./modules')
cgitb.enable()
	
       
def debug():
    print('Content-type:text/html')
    print('')         
        
def QUERY_STRING():
    i = subprocess.Popen(['env'], stdout=subprocess.PIPE)
    i = i.communicate()
    i = i[0]
    i = i.split('\n')
    for x in i:
        if 'QUERY_STRING' in x:
            x = x.replace("QUERY_STRING=","")
            return x
            
def user_agent():
    i = subprocess.Popen(['env'], stdout=subprocess.PIPE)
    i = i.communicate()
    i = i[0]
    i = i.split('\n')
    for x in i:
        if 'HTTP_USER_AGENT' in x:
            x = x.replace("HTTP_USER_AGENT=","")
            return x            
                
def cookies():
    i = subprocess.Popen(['env'], stdout=subprocess.PIPE)
    i = i.communicate()
    i = i[0]
    i = i.split('\n')
    for x in i:
        if 'HTTP_COOKIE' in x:
            x = x.replace("HTTP_COOKIE=","")
            return x
            
def getsub_b_0():
    i = subprocess.Popen(['env'], stdout=subprocess.PIPE)
    i = i.communicate()
    i = i[0]
    i = i.split('\n')
    for x in i:
        if 'HTTP_COOKIE' in x:
            x = x.replace("HTTP_COOKIE=","")
            x = x.split()
            for y in x:
                if 'sub_0cookie' in y:
                    y = y.replace("sub_0cookie=","")
                    y = y.replace(";","")
                    y = y.split(" ")
                    return y                  
def getsub_b_1():
    i = subprocess.Popen(['env'], stdout=subprocess.PIPE)
    i = i.communicate()
    i = i[0]
    i = i.split('\n')
    for x in i:
        if 'HTTP_COOKIE' in x:
            x = x.replace("HTTP_COOKIE=","")
            x = x.split()
            for y in x:
                if 'sub_1cookie' in y:
                    y = y.replace("sub_1cookie=","")
                    y = y.replace(";","")
                    y = y.split(" ")
                    return y                      
def getsub_3():
    i = subprocess.Popen(['env'], stdout=subprocess.PIPE)
    i = i.communicate()
    i = i[0]
    i = i.split('\n')
    for x in i:
        if 'HTTP_COOKIE' in x:
            x = x.replace("HTTP_COOKIE=","")
            x = x.split()
            for y in x:
                if 'sub_3cookie' in y:
                    y = y.replace("sub_3cookie=","")
                    y = y.replace(";","")
                    y = y.split(" ")
                    return y                      
def scrheigth():
    for x in getsub_3():
        x = x.replace("@"," ")
        x = x.split()
        for y in x:
            if 'sub_heigth' in y:
                y = y.replace("="," ")
                y = y.split()
                return y[1]                 
            
def scrwidth():
    for x in getsub_3():
        x = x.replace("@"," ")
        x = x.split()
        for y in x:
            if 'sub_width' in y:
                y = y.replace("="," ")
                y = y.split()
                return y[1]  
                         
def sub_css():
    for x in getsub_3():
        x = x.replace("@"," ")
        x = x.split()
        for y in x:
            if 'sub_css' in y:
                y = y.replace("="," ")
                y = y.split()
                return y[1]    
                       
def sub_refresh():
    for x in getsub_3():
        x = x.replace("@"," ")
        x = x.split()
        for y in x:
            if 'sub_refresh' in y:
                y = y.replace("="," ")
                y = y.split()
                return y[1]   
                                      
def env():
    i = subprocess.Popen(['env'], stdout=subprocess.PIPE)
    i = i.communicate()
    i = i[0]
    i = i.split('\n')
    for x in i:
        print "<pre>" + x + "<pre>"
            
def housecode(heyu_path, x10config):
    i = subprocess.Popen([heyu_path, '-c', x10config, 'webhook', 'config_dump'], stdout=subprocess.PIPE)
    i = i.communicate()
    i = i[0]
    i = i.split('\n')
    for x in i:
        if 'housecode' in x:
            x = x.replace("housecode ","")
            return x
            
def tty(heyu_path, x10config):
    i = subprocess.Popen([heyu_path, '-c', x10config, 'webhook', 'config_dump'], stdout=subprocess.PIPE)
    i = i.communicate()
    i = i[0]
    i = i.split('\n')
    for x in i:
        if 'tty' in x:
            x = x.replace("tty ","")
            return x
            
def spooldir(heyu_path, x10config):
    i = subprocess.Popen([heyu_path, '-c', x10config, 'list'], stdout=subprocess.PIPE)
    i = i.communicate()
    i = i[0]
    i = i.split('\n')
    for x in i:
        if 'SPOOLDIR' in x:
            x = x.replace("SPOOLDIR=","")
            return x
            
def lockdir(heyu_path, x10config):
    i = subprocess.Popen([heyu_path, '-c', x10config, 'list'], stdout=subprocess.PIPE)
    i = i.communicate()
    i = i[0]
    i = i.split('\n')
    for x in i:
        if 'LOCKDIR' in x:
            x = x.replace("LOCKDIR=","")
            return x
            
def sysbasedir(heyu_path, x10config):
    i = subprocess.Popen([heyu_path, '-c', x10config, 'list'], stdout=subprocess.PIPE)
    i = i.communicate()
    i = i[0]
    i = i.split('\n')
    for x in i:
        if 'SYSBASEDIR' in x:
            x = x.replace("SYSBASEDIR=","")
            return x
   
                           
def engine(heyu_path, x10config):
    # Is the heyu engine running ?
    engine = subprocess.Popen([heyu_path, '-c', x10config, 'enginestate'], stdout=subprocess.PIPE)
    engine = engine.communicate()
    if 'starting heyu_relay\n0\n' in engine or '0\n' in engine:
        subprocess.call([heyu_path, '-c', x10config, 'engine'])
   
def html(heyu_web_interface_version):

    def _scrheigth_():
        try:
            if scrheigth():
                return scrheigth()
        except:
            return "500"
            
    def _scrwidth_():
        try:
            if scrwidth():
                return scrwidth()
        except:
            return "650"
            
    def _css_():
        try:
            if sub_css():
                return sub_css()
        except:
            return "heyu_style.css"
            
    def _refresh_():
        try:
            if sub_refresh():
                return sub_refresh()
        except:
            return "10"
                    
    print('Content-type:text/html')
    print('')    
    # Start HTML, Javascript 
    print("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/1998/REC-html40-19980424/loose.dtd\">")
    print("<html><head><title>Heyu Web Interface v." + heyu_web_interface_version + "</title>")
    print"<style type=text/css>"
    print "@import url(" + _css_() + ");"
    print "@import url(tinyboxstyle.css);"
    
    
    print "textarea {"
    print "width:", _scrwidth_() + ";"
    print "height:", _scrheigth_() +";"
    print "}"
    

    
    print "</style>"    
    print("""
        <script type=text/javascript>
        var testrange=document.createElement("input")
        testrange.setAttribute("type", "range")
        if (testrange.type=="range"){ 
        document.cookie = "html_range=True; expires=01-Jan-2036 12:00:00 GMT";}
         </script>
         """)

    print "<script type=text/javascript>refreshInterval=setInterval('ajax_update()',", _refresh_() + "000);</script>"
    print("""<script type=text/javascript src=javascript/ajax.js></script>
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
        <!-- Begin Div -->
            <div id=content>""")
    

def control_panel(data, x10config, x10sched, x10report,
                        heyu_path, HC, heyu_web_interface_version, 
                        restart_sleep_interval, subcmd0, subcmd1):
    decoded_data = urllib2.unquote(data)
    # Debug data
    # print decoded_data
    if 'control_panel_@{save}' in decoded_data and 'heyu_cmd' not in decoded_data:
    
        out = urllib2.unquote(data)        
        out = out.replace("+"," ")
        out = out.replace("control_panel_@{save}=","")
        out = out.replace("control_panel_","")
        out = out.replace("@{config}","")  
        out = out.replace("@{x10_config}","")
        out = out.replace("@{schedule_config}","")
        out = out.replace("@{updates}","")
        out = out.replace("@{crontab}","")
        out = out.replace("@{top}","")
        out = out.replace("@{theme}","")
        out = out.replace("@{info}","")    
        out = out.replace("@{manpage=heyu}","")  
        out = out.replace("@{heyu=enter_cmd}","")  
        out = out.replace("@{kill_all_hc}","")  
        out = out.replace("@{heyu_restart}","")  
        out = out.strip()

        f = open(x10config, 'w')
        f.write(out)
        f.closed
        
        
    if 'control_panel' in decoded_data:
        print("""
            <!-- Begin Form Post For Control Panel -->
            
            
            <table class=control_panel align=center border=0 cellspacing=0 cellpadding=15>
            <tr><td class=control_panel valign=top align=center style=\"background:#CCC\">
            """)
        if 'manpage' in decoded_data:
            print("""
           
            <button class=control_panel_buttons type=button onclick=\"Status();show('control_panel_@{x10_config}@{manpage=heyu}')\">
		    <table><tr><td width=20 height=25><td><span class=control_panel>Heyu</table></button><br>

		    <button class=control_panel_buttons type=button onclick=\"Status();show('control_panel_@{x10_config}@{manpage=x10config}')\">
		    <table><tr><td width=20 height=25><td><span class=control_panel>Config</table></button><br>

		    <button class=control_panel_buttons type=button onclick=\"Status();show('control_panel_@{x10_config}@{manpage=x10sched}')\">
		    <table><tr><td width=20 height=25><td><span class=control_panel>Schedule</table></button><br>

		    <button class=control_panel_buttons type=button onclick=\"Status();show('control_panel_@{x10_config}@{manpage=x10scripts}')\">
		    <table><tr><td width=20 height=25><td><span class=control_panel>Scripts</table></button><br>

		    <button class=control_panel_buttons type=button onclick=\"Status();show('control_panel_@{x10_config}@{manpage=x10cm17a}')\">
		    <table><tr><td width=20 height=25><td><span class=control_panel>CM17A</table></button><br>

		    <button class=control_panel_buttons type=button onclick=\"Status();show('control_panel_@{x10_config}@{manpage=x10aux}')\">
		    <table><tr><td width=20 height=25><td><span class=control_panel>Aux</table></button><br>

		    <button class=control_panel_buttons type=button onclick=\"Status();show('control_panel_@{x10_config}@{manpage=x10rfxsensors}')\">
		    <table><tr><td width=20 height=25><td><span class=control_panel>RFXSensors</table></button><br>

		    <button class=control_panel_buttons type=button onclick=\"Status();show('control_panel_@{x10_config}@{manpage=x10rfxmeters}')\">
		    <table><tr><td width=20 height=25><td><span class=control_panel>RFXMeters</table></button><br>

		    <button class=control_panel_buttons type=button onclick=\"Status();show('control_panel_@{x10_config}@{manpage=x10digimax}')\">
		    <table><tr><td width=20 height=25><td><span class=control_panel>Digimax</table></button><br>

		    <button class=control_panel_buttons type=button onclick=\"Status();show('control_panel_@{x10_config}@{manpage=x10oregon}')\">
		    <table><tr><td width=20 height=25><td><span class=control_panel>Oregon</table></button><br>

		    <button class=control_panel_buttons type=button onclick=\"Status();show('control_panel_@{x10_config}@{manpage=x10kaku}')\">
		    <table><tr><td width=20 height=25><td><span class=control_panel>Kaku</table></button><br>		    
		                          
            <button class=control_panel_buttons type=button onclick=\"Status();show('control_panel_@{x10_config}')\">
		    <table><tr><td width=20 height=25><img src=./imgs/alloff.png width=25 height=25><td><span class=control_panel>Exit</table></button><br>
            
            """)
             
        else:
            print("""
            <button class=control_panel_buttons type=button onclick=\"Status(); show('control_panel_@{x10_config}')\">
		    <table><tr><td width=20><img src=./imgs/OnLamp-icon.png width=25 height=25> 
		    <td><span class=control_panel>Heyu Config</table></button><br>
	
		    <button class=control_panel_buttons type=button onclick=\"Status(); show('control_panel_@{config}')\">
		    <table><tr><td width=20><img src=./imgs/edit_user.png width=25 height=25> 
		    <td><span class=control_panel>Interface Config</table></button><br>
		
		    <button class=control_panel_buttons type=button onclick=\"Status(); show('control_panel_@{schedule_config}')\">
		    <table><tr><td width=20><img src=./imgs/macro.png width=25 height=25> 
		    <td><span class=control_panel>Heyu Schedule</table></button><br>
		
		    <button class=control_panel_buttons type=button onclick=\"Status(); show('control_panel_@{updates}')\">
		    <table><tr><td width=20><img src=./imgs/update3.png width=25 height=25> 
		    <td><span class=control_panel>Updates</table></button><br>
		
		    <button class=control_panel_buttons type=button onclick=\"Status(); show('control_panel_@{crontab}')\">
		    <table><tr><td width=20><img src=./imgs/cron.png width=25 height=25> 
		    <td><span class=control_panel>Crontab</table></button><br>
		
		    <button class=control_panel_buttons type=button onclick=\"Status(); show('control_panel_@{top}')\">
		    <table><tr><td width=20><img src=./imgs/top.png width=25 height=25> 
		    <td><span class=control_panel>Top</table></button><br>	
		
		    <button class=control_panel_buttons type=button onclick=\"Status(); show('heyu_theme')\">
		    <table><tr><td width=20><img src=./imgs/compact3.png width=25 height=25> 
		    <td><span class=control_panel>Theme Compact</table></button><br>
		    
		    <button class=control_panel_buttons type=button onclick=\"Status(); show('#')\">
		    <table><tr><td width=20><img src=./imgs/alloff.png width=25 height=25> 
		    <td><span class=control_panel>Exit</table></button><br>		
        """)
        print("""
                <td class=control_panel valign=top align=center style=\"background:#CCC\">""")
        if 'control_panel_@{schedule_' in decoded_data:
            # Schedule View
            print("""
            <table><tr><td><table class=control_panel><tr>
		    <tr>
		    <td><button type=button class=userconfigbutton onclick=\"Status(); show('control_panel_@{schedule_config}@{status}')\">Status</button>
		    <td><button type=button class=userconfigbutton onclick=\"Status(); show('control_panel_@{schedule_config}@{examples}')\">Examples</button>
		    <td><button type=button class=userconfigbutton onclick=\"Status(); show('control_panel_@{schedule_config}@{report}')\">Report</button>
		    <td><button type=button class=userconfigbutton onclick=\"Status(); show('control_panel_@{schedule_config}@{upload}')\">Upload</button>
	        <td><button type=button class=userconfigbutton onclick=\"Status(); show('control_panel_@{schedule_config}@{erase}')\">Erase</button>
		    </table>""")
		    
        elif 'control_panel_@{crontab}' in decoded_data:
            pass
        elif 'control_panel_@{config}' in decoded_data:
            pass
            
        else:
            # Heyu Config View
            print("""
            <table><tr><td><table class=control_panel><tr>
		    <tr>
		    <td><button type=button class=userconfigbutton onclick=\"Status(); show('control_panel_@{x10_config}@{info}')\">Heyu Info</button>
		    <td><button type=button class=userconfigbutton onclick=\"Status(); show('control_panel_@{x10_config}@{manpage=heyu}')\">Heyu Manual</button>
		    <td><button type=button class=userconfigbutton onclick=\"Status(); show('control_panel_@{x10_config}@{heyu_cmd=}')\">Heyu Cmd...</button>
		    <td><button type=button class=userconfigbutton onclick=\"Status(); show('control_panel_@{x10_config}@{kill_all_hc}')\">All Off A-P</button>
	        <td><button type=button class=userconfigbutton onclick=\"Status(); show('control_panel_@{x10_config}@{heyu_restart}')\">Heyu Restart</button>
		    </table>
            """)
            
            # Crontab
        if 'control_panel_@{crontab}' in decoded_data:
            try:                
                crontab(data, subcmd0)
            except:
                print "<table><tr><td>Error loading crontab</table>"
                
            # Config    
        if 'control_panel_@{config}' in decoded_data:
            try:                
                config(data, subcmd1)
            except:
                print "<table><tr><td>Error loading Config</table>"
 
 
        if 'control_panel_@{x10_config}@{heyu_cmd=' in decoded_data:
            print("""<form method=POST>
                <br><table class=control_panel><tr>
			    <td>Enter Command:<input type=text value=\"webhook config_dump\" name=\"control_panel_@{x10_config}@{heyu_cmd\" onsubmit=\"Status(); show('')\">
			    <td><button type=sumbit value=\"webhook config_dump\" >Enter</button>
			    <!-- <input type=submit value=Enter> -->
			    <td><button type=button onclick=\"Status(); show('control_panel_@{x10_config}@{heyu_cmd=help}')\">Help</button></form>
		        </table></form>
            """)
            
        if 'control_panel_@{updates}' in decoded_data:
            print "</textarea><table valign=top><tr><td valign=top align=center bgcolor=#ffffff >"
            print "<iframe align=center src=http://heyu.epluribusunix.net/?heyu_web_interface_version=" + heyu_web_interface_version + " border=0 height=600 width=650 scrolling=yes></iframe></table>"
        
        # We dont want textarea in updates, top, crontab or config        
        if 'control_panel_@{updates}' not in decoded_data and 'control_panel_@{top}' not in decoded_data and 'control_panel_@{crontab}' not in decoded_data and 'control_panel_@{config}' not in decoded_data:        
            print("""<form method=post>
                    <textarea name=control_panel_@{save}>""")
                    
                
                
        # Everything else belows gets put in textarea            
        
        if 'control_panel_@{x10_config}@{info}' in decoded_data:
            info = subprocess.Popen([heyu_path, '-c', x10config, 'info'], stdout=subprocess.PIPE)
            info = info.communicate()
            info = info[0]
            print info
            

        elif 'control_panel_@{schedule_config}@{erase}' in decoded_data:
            info = subprocess.Popen([heyu_path, '-c', x10config, '-s', x10sched, 'erase'], stderr=subprocess.STDOUT, stdout=subprocess.PIPE)
            info = info.communicate()
            info = info[0]
            print info
            
            
        elif 'control_panel_@{schedule_config}@{upload}' in decoded_data:
            info = subprocess.Popen([heyu_path, '-c', x10config, '-s', x10sched, 'upload'], stderr=subprocess.STDOUT, stdout=subprocess.PIPE)
            info = info.communicate()
            info = info[0]
            print info
            
        elif 'control_panel_@{schedule_config}@{report}' in decoded_data:
            try:
                file = open(x10report)
                for line in file:
                    line = line.strip()
                    print line
                file.closed
            except:
                print "Error reading x10report file. Are you sure you spelled it correctly?"
            
        elif 'control_panel_@{schedule_config}@{examples}' in decoded_data:
            info = subprocess.Popen(['man', '-E', 'UTF-8', 'X10SCHED'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            info = info.communicate()
            info = info[0]
            print info         

        elif 'control_panel_@{schedule_config}@{status}' in decoded_data:
            info = subprocess.Popen([heyu_path, '-c', x10config, '-s', x10sched, 'upload', 'status'], stderr=subprocess.STDOUT, stdout=subprocess.PIPE)
            info = info.communicate()
            info = info[0]
            print info
            
        elif 'control_panel_@{schedule_config}' in decoded_data:
            try:
                file = open(x10sched)
                for line in file:
                    line = line.strip()
                    print line
                file.closed
            except:
                print "Error reading x10sched file. Are you sure you spelled it correctly?"

           
        elif 'control_panel_@{top}' in decoded_data:
            print("""
                    </textarea><table valign=top><tr><td valign=top align=center bgcolor=#ffffff ><iframe align=center 
		        	src=./CGI/top.cgi border=0 height=600 width=650 scrolling=yes></iframe></table>""")
            
            
        elif 'control_panel_@{x10_config}@{kill_all_hc}' in decoded_data:
            info = subprocess.Popen([heyu_path, '-c', x10config, 'kill_all_hc'], stdout=subprocess.PIPE)
            info = info.communicate()
            info = info[0]
            print info

        elif 'control_panel_@{x10_config}@{manpage' in decoded_data:
            out = decoded_data.replace("control_panel_@{x10_config}@{manpage=","")
            out = out[:-1]
            info = subprocess.Popen(['man', '-E', 'UTF-8', out], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            info = info.communicate()
            info = info[0]
            print info
     
        elif 'control_panel_@{x10_config}@{heyu_restart}' in decoded_data:
            info = subprocess.Popen([heyu_path, '-c', x10config, 'stop'], stdout=subprocess.PIPE)
            info = subprocess.Popen(['sleep', restart_sleep_interval], stdout=subprocess.PIPE)
            info = subprocess.Popen([heyu_path, '-c', x10config, 'start'], stdout=subprocess.PIPE)
            info = info.communicate()
            info = info[0]
            info = info.replace("starting heyu_relay","",1)
            info = info.replace("starting heyu_engine","",1)
            info = info.replace("starting","Restarted the")
            info = info.strip()
            print info
            
        elif 'control_panel_@{x10_config}@{heyu_cmd=monitor' in decoded_data:
            print "Monitor command disabled."         

        elif 'control_panel_@{x10_config}@{heyu_cmd=' in decoded_data:
            out = urllib2.unquote(data)
            out = out.replace("+",",")
            out = out.replace("monitor","")
            out = out.replace("control_panel_@{x10_config}@{heyu_cmd=","")                 
            out = out.replace("@{heyu_cmd=","")
            out = out.replace("}","")
            out = heyu_path + ',-c,' + x10config + ',' + out
            out = out.split(",")            
            info = subprocess.Popen(out, stderr=subprocess.STDOUT, stdout=subprocess.PIPE)
            info = info.communicate()
            info = info[0]
            print info
             
        
        elif 'control_panel_@{x10_config}' in decoded_data or 'control_panel_@{save}' in decoded_data and '@{updates}' not in decoded_data:
            
            file = open(x10config)
            for line in file:
                line = line.strip()
                print line
            file.closed
        
            out = urllib2.unquote(data)
            out = out.replace("+"," ")
            out = out.replace("control_panel_@{save}=","")
            out = out.replace("control_panel_","")
            out = out.replace("@{config}","")  
            out = out.replace("@{x10_config}","")
            out = out.replace("@{schedule_config}","")
            out = out.replace("@{updates}","")
            out = out.replace("@{crontab}","")
            out = out.replace("@{top}","")
            out = out.replace("@{theme}","")
            out = out.replace("@{info}","")    
            out = out.replace("@{manpage=heyu}","")  
            out = out.replace("@{heyu=enter_cmd}","")  
            out = out.replace("@{kill_all_hc}","")  
            out = out.replace("@{heyu_restart}","")  
            out = out.strip()
        
            print out
            
            def save_exit_buttons():
                print("""
                    <button class=userconfigbutton type=submit onclick=\"Status(); "show('control_panel')\"> Save</button>""")  
        print("""
                    </textarea>
                    <br>
                        <br>
                            <table>
                                    <tr>
                                        <td>""")
        
        try:
            save_exit_buttons()
        except:
            pass      
        print("""
                    
                                        </td>
                                   </tr>
                           </table>
                    </form>
            </table>
        </div>
    </body>
</html>""")

# Begin Crontab 
def crontab(data, subcmd0):
    def c0subs1(data, subcmd0):
        s = 'cmd1'
        for x in getsub_b_0():
            if subcmd0 == s and subcmd0 in x:
                return "Off"
            if subcmd0 == s and subcmd0 not in x:
                return "On"
            if s in x:
                return  "On"
            else:
                return "Off"
        
    def c0subs2(data, subcmd0):
        s = 'cmd2'
        for x in getsub_b_0():
            if subcmd0 == s and subcmd0 in x:
                return "Off"
            if subcmd0 == s and subcmd0 not in x:
                return "On"
            if s in x:
                return  "On"
            else:
                return "Off"

    def c0subs3(data, subcmd0):
        s = 'cmd3'
        for x in getsub_b_0():
            if subcmd0 == s and subcmd0 in x:
                return "Off"
            if subcmd0 == s and subcmd0 not in x:
                return "On"
            if s in x:
                return  "On"
            else:
                return "Off"

    def c0subs4(data, subcmd0):
        s = 'cmd4'
        for x in getsub_b_0():
            if subcmd0 == s and subcmd0 in x:
                return "Off"
            if subcmd0 == s and subcmd0 not in x:
                return "On"
            if s in x:
                return  "On"
            else:
                return "Off"
        
    def c0subs5(data, subcmd0):
        s = 'cmd5'
        for x in getsub_b_0():
            if subcmd0 == s and subcmd0 in x:
                return "Off"
            if subcmd0 == s and subcmd0 not in x:
                return "On"
            if s in x:
                return  "On"
            else:
                return "Off"
    
    decoded_data = urllib2.unquote(data)
    
    print "<table><tr><td><table class=control_panel><tr><tr>"
    print "<td><button type=button class=userconfigbutton onclick=\"Status(); show('control_panel_@{crontab}@{cmd1}')\">Cmd 1", c0subs1(data, subcmd0), "</button>"
    print "<td><button type=button class=userconfigbutton onclick=\"Status(); show('control_panel_@{crontab}@{cmd2}')\">Cmd 2", c0subs2(data, subcmd0), "</button>"
    print "<td><button type=button class=userconfigbutton onclick=\"Status(); show('control_panel_@{crontab}@{cmd3}')\">Cmd 3", c0subs3(data, subcmd0), "</button>"
    print "<td><button type=button class=userconfigbutton onclick=\"Status(); show('control_panel_@{crontab}@{cmd4}')\">Cmd 4", c0subs4(data, subcmd0), "</button>"
    print "<td><button type=button class=userconfigbutton onclick=\"Status(); show('control_panel_@{crontab}@{cmd5}')\">Cmd 5", c0subs5(data, subcmd0), "</button>"
    print "</table>"
    
   
    print("""<table><tr><td><br>
            <textarea style=\"height: 400px;\" name=control_panel_@{save}>""")
    if len(subcmd0) < 1:
        print "Select a command from above."
    if len(subcmd0) > 1:
        if 'cmd1' in subcmd0:
            print "You choose", subcmd0 + ".", "Status is", c0subs1(data, subcmd0)
        if 'cmd2' in subcmd0:
            print "You choose", subcmd0 + ".", "Status is", c0subs2(data, subcmd0)
        if 'cmd3' in subcmd0:
            print "You choose", subcmd0 + ".", "Status is", c0subs3(data, subcmd0)
        if 'cmd4' in subcmd0:
            print "You choose", subcmd0 + ".", "Status is", c0subs4(data, subcmd0)                         
        if 'cmd5' in subcmd0:
            print "You choose", subcmd0 + ".", "Status is", c0subs5(data, subcmd0) 
                                  
    print "</textarea></table></form>"
    

# Begine Config 
def config(data, subcmd1):
    def c1subs1(data, subcmd1):
        s = 'cmd1'
        for x in getsub_b_1():
            if subcmd1 == s and subcmd1 in x:
                return "Off"
            if subcmd1 == s and subcmd1 not in x:
                return "On"
            if s in x:
                return  "On"
            else:
                return "Off"
        
    def c1subs2(data, subcmd1):
        s = 'cmd2'
        for x in getsub_b_1():
            if subcmd1 == s and subcmd1 in x:
                return "Off"
            if subcmd1 == s and subcmd1 not in x:
                return "On"
            if s in x:
                return  "On"
            else:
                return "Off"

    def c1subs3(data, subcmd1):
        s = 'cmd3'
        for x in getsub_b_1():
            if subcmd1 == s and subcmd1 in x:
                return "Off"
            if subcmd1 == s and subcmd1 not in x:
                return "On"
            if s in x:
                return  "On"
            else:
                return "Off"

    def c1subs4(data, subcmd1):
        s = 'cmd4'
        for x in getsub_b_1():
            if subcmd1 == s and subcmd1 in x:
                return "Off"
            if subcmd1 == s and subcmd1 not in x:
                return "On"
            if s in x:
                return  "On"
            else:
                return "Off"
        
    def c1subs5(data, subcmd1):
        s = 'cmd5'
        for x in getsub_b_1():
            if subcmd1 == s and subcmd1 in x:
                return "Off"
            if subcmd1 == s and subcmd1 not in x:
                return "On"
            if s in x:
                return  "On"
            else:
                return "Off"
               
            
            
    data = urllib2.unquote(data)
    
    def _scrheigth_():
        if '@{config}@{sub_heigth' in data:
            s = data
            s = s.replace("control_panel_@{config}@{sub_heigth}=","")
            return s
        else:
            return scrheigth() 
            
    def _scrwidth_():
        if '@{config}@{sub_width' in data:
            s = data
            s = s.replace("control_panel_@{config}@{sub_width}=","")
            return s
        else:
            return scrwidth()
            
    def _css_():
        if '@{config}@{sub_css' in data:
            s = data
            s = s.replace("control_panel_@{config}@{sub_css}=","")
            return s
        else:
            return sub_css() 
            
    def _refresh_():
        if '@{config}@{sub_refresh' in data:
            s = data
            s = s.replace("control_panel_@{config}@{sub_refresh}=","")
            return s
        else:
            return sub_refresh() 
        
        
    print "<table class=userconfig2 width=" + _scrwidth_() + "><tr>"
    
    print "<table class=userconfig2 name=config>"
    
    print "<tr><td class=userconfig2>Screen Width:<td class=userconfig2><form method=post><input class=userconfig2 value=" + _scrwidth_() + " size=6 type=text name=\"control_panel_@{config}@{sub_width}\"><input class=configb1 value=OK type=submit></form>"
    
    print "<tr><td class=userconfig2>Screen Height:<td class=userconfig2><form method=post><input class=userconfig2 value=" + _scrheigth_() + " size=6 type=text name=\"control_panel_@{config}@{sub_heigth}\"><input class=configb1 value=OK type=submit></form>" 
    
    print "<tr><td class=userconfig2>CSS Location:<td class=userconfig2><form method=post><input class=userconfig2 value=" + _css_() + " size=16 type=text name=\"control_panel_@{config}@{sub_css}\"><input class=configb1 value=OK type=submit></form>"
    
    print "<tr><td class=userconfig2>Auto Refresh Rate:<td class=userconfig2><form method=post><input class=userconfig2 value=" + _refresh_() + " size=16 type=text name=\"control_panel_@{config}@{sub_refresh}\"><input class=configb1 value=OK type=submit></form>" 
    
    print "<tr><td>Option 1:<button type=button class=userconfigbutton2 onclick=\"Status(); show('control_panel_@{config}@{cmd1}')\">", c1subs1(data, subcmd1), "</button>"
    print "<tr><td>Option 2:<button type=button class=userconfigbutton2 onclick=\"Status(); show('control_panel_@{config}@{cmd2}')\">", c1subs2(data, subcmd1), "</button>"
    print "<tr><td>Option 3:<button type=button class=userconfigbutton2 onclick=\"Status(); show('control_panel_@{config}@{cmd3}')\">", c1subs3(data, subcmd1), "</button>"
    print "<tr><td>Option 4:<button type=button class=userconfigbutton2 onclick=\"Status(); show('control_panel_@{config}@{cmd4}')\">", c1subs4(data, subcmd1), "</button>"
    print "<tr><td>Option 5:<button type=button class=userconfigbutton2 onclick=\"Status(); show('control_panel_@{config}@{cmd5}')\">", c1subs5(data, subcmd1), "</button>"
    print "</table>"
    #print "<br>"
 

    print "</textarea></table></form>"

