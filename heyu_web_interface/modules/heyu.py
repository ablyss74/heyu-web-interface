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


import cgitb, sys, re, subprocess, urllib2
sys.path.append('./modules')
cgitb.enable()
import heyu

def QUERY_STRING():
    i = subprocess.Popen(['env'], stdout=subprocess.PIPE)
    i = i.communicate()
    i = i[0]
    i = cookies.split('\n')
    for x in i:
        if 'QUERY_STRING' in x:
            x = x.replace("QUERY_STRING=","")
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
            
def housecode(heyu_path, x10config):
    i = subprocess.Popen([heyu_path, '-c', x10config, 'webhook', 'config_dump'], stdout=subprocess.PIPE)
    i = i.communicate()
    i = i[0]
    i = i.split('\n')
    for x in i:
        if 'housecode' in x:
            x = x.replace("housecode ","")
            return x
                           
def engine(heyu_path, x10config):
    # Is the heyu engine running ?
    engine = subprocess.Popen([heyu_path, '-c', x10config, 'enginestate'], stdout=subprocess.PIPE)
    engine = engine.communicate()
    if 'starting heyu_relay\n0\n' in engine or '0\n' in engine:
        subprocess.call([heyu_path, '-c', x10config, 'engine'])
   
def html(heyu_web_interface_version, auto_refresh_rate):
    print('Content-type:text/html')
    print('')    
    # Start HTML, Javascript 
    print("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/1998/REC-html40-19980424/loose.dtd\">")
    print("<html><head><title>Heyu Web Interface v." + heyu_web_interface_version + "</title>")
    print( """
    <style type=text/css>
    @import url(heyu_style.css);
    @import url(tinyboxstyle.css);
    textarea {
    	width: 660px;
    	height: 650px;
    }
    </style>""")
    print "<script type=text/javascript>refreshInterval=setInterval('ajax_update()',", auto_refresh_rate + "000);</script>"
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
                        restart_sleep_interval):
    decoded_data = urllib2.unquote(data)
    # Debug data
    # print decoded_data
    if 'control_panel_@{save}' in decoded_data:
    
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
                crontab(data)
            except:
                print "<table><tr><td>Error loading crontab</table>"
 
 
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
        
        # We dont need textarea in updates or top         
        if 'control_panel_@{updates}' not in decoded_data and 'control_panel_@{top}' not in decoded_data and 'control_panel_@{crontab}' not in decoded_data:        
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
                    <button class=userconfigbutton type=button onclick=\"Status(); show('#')\"> Exit</button>
                                        </td>
                                   </tr>
                           </table>
                    </form>
            </table>
        </div>
    </body>
</html>""")
        

def crontab(data):
    decoded_data = urllib2.unquote(data)
    print("""
            <table><tr><td><table class=control_panel><tr>
		    <tr>
		    <td><button type=button class=userconfigbutton onclick=\"Status(); show('control_panel_@{crontab}@{cmd1}')\">cmd 1</button>
		    <td><button type=button class=userconfigbutton onclick=\"Status(); show('control_panel_@{crontab}@{cmd2}')\">cmd 2</button>
		    <td><button type=button class=userconfigbutton onclick=\"Status(); show('control_panel_@{crontab}@{cmd3}')\">cmd 3</button>
		    <td><button type=button class=userconfigbutton onclick=\"Status(); show('control_panel_@{crontab}@{cmd4}')\">cmd 4</button>
	        <td><button type=button class=userconfigbutton onclick=\"Status(); show('control_panel_@{crontab}@{cmd5}')\">cmd 5</button>
		    </table>
            """)
    if 'cmd' in decoded_data:
        print "This is", decoded_data, "outside the textarea"
   
    print("""<table><tr><td><br>
            <textarea name=control_panel_@{save}>""")
    if 'cmd' in decoded_data:
        print "This is", decoded_data, "inside the textarea"
        
    print "</textarea></table></form>"


