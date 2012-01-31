#! /usr/bin/env python
#
#   Author: 	Kris Beazley
#   Copyright  2012 Kris Beazley

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
import heyu

# For now we define some static variables.
# In the future this should be controlled in the control panel
# Restart_sleep_interval allows heyu to restart gracefully
# HC = housecode
x10config = "./x10config"
x10sched = "./x10.sched"
x10report = "./report.txt"
heyu_path = "/usr/local/bin/heyu"

restart_sleep_interval = "5"
heyu_web_interface_version = "11.56_beta"
expires = "expires=01-Jan-2036 12:00:00 GMT" 
HC = heyu.housecode(heyu_path, x10config)



heyu.engine(heyu_path, x10config)

if heyu.cookies() is None:
    print "Set-Cookie: Interface_version=", heyu_web_interface_version, ";", expires
    print "Set-Cookie: auto_refresh=False;", expires
    auto_refresh = "False"
    print "Set-Cookie: heyu_show_all_modules=False;", expires
    heyu_show_all_modules = "False"
    print "Set-Cookie: heyu_theme=default;", expires
    heyu_theme = "default"
    print "Set-Cookie: sub0b_0cookie="";", expires
    print "Set-Cookie: sub1b_1cookie="";", expires
    print "Set-Cookie: sub_3cookie=@{sub_heigth}=600@{sub_width}=650@{sub_css}=heyu_style.css@{sub_refresh}=10;", expires
    
       
   
if heyu.cookies() is not None:
    cookies = heyu.cookies()
    if 'auto_refresh=True' in cookies:
        auto_refresh = "True"
    if 'auto_refresh=False' in cookies:
        auto_refresh = "False"
    if 'heyu_show_all_modules=True' in cookies:
        heyu_show_all_modules = "True"
    if 'heyu_show_all_modules=False' in cookies:
        heyu_show_all_modules = "False"
    if 'heyu_theme=compact' in cookies:
        heyu_theme = "compact"
    if 'heyu_theme=default' in cookies:
        heyu_theme = "default"
        
    
    
    # Double redundancy         
    # Test if values are missing and declare values
    if 'heyu_theme' not in cookies:
        print "Set-Cookie: heyu_theme=default;", expires
        heyu_theme = "default"
    if 'auto_refresh' not in cookies:
        print "Set-Cookie: auto_refresh=False;", expires
        auto_refresh = "False"
    if 'heyu_show_all_modules' not in cookies:
        print "Set-Cookie: heyu_show_all_modules=False;", expires
        heyu_show_all_modules = "False"
    if 'sub' not in cookies:    
        print "Set-Cookie: sub0b_0cookie="";", expires
        print "Set-Cookie: sub1b_1cookie="";", expires
        print "Set-Cookie: sub_3cookie=@{sub_heigth}=600@{sub_width}=650@{sub_css}=heyu_style.css@{sub_refresh}=10;", expires
        
  
### Read stdin ### 
   
try:
    for data in sys.stdin:
        data = urllib2.unquote(data) 
        
          
        #Sub 0                        
        if '@{crontab}@{cmd' in data:
            data = urllib2.unquote(data)
            q = data
            q = q.replace("control_panel_@","")
            q = q.replace("@","|")
             
            if '@{crontab}@{cmd' in data:
                c = q.replace("{crontab}|{","")
                c = c.replace("}","")                
                subcmd0 = c  
            if heyu.getsub_b_0() is None:
                print "Set-Cookie: sub0b_0cookie=" + q + ";", expires
            for x in heyu.getsub_b_0():
                if q not in x:
                    print "Set-Cookie: sub0b_0cookie=" + q + x + ";", expires
                elif q in x:
                    x = x.replace(q,"")
                    print "Set-Cookie: sub0b_0cookie=" + x + ";", expires
        # Sub 1

        if '@{config}@' in data:
            #heyu.debug()
            data = urllib2.unquote(data)
            q = data
            q = q.replace("control_panel_@","")

            if '@{config}@{sub_' in data:               
               
                q = q.replace("{config}","")
                   
                if heyu.getsub_3() is None:
                    print "Set-Cookie: sub_3cookie=" + q + ";", expires
                for x in heyu.getsub_3():
                    for c in heyu.getsub_3():
                        c = c
                    h = "@{sub_heigth}=" + heyu.scrheigth()
                    w = "@{sub_width}=" + heyu.scrwidth()
                    css = "@{sub_css}=" + heyu.sub_css()
                    refresh = "@{sub_refresh}=" + heyu.sub_refresh()
                    
                    if '@{sub_heigth}' in q:   
                        c = c.replace(c,w)
                        print "Set-Cookie: sub_3cookie=" + c + ";", expires                                        
                        print "Set-Cookie: sub_3cookie=" + q + w + css + refresh + ";", expires
                        scrheigth = q
                    if '@{sub_width}' in q:   
                        c = c.replace(c,h)
                        print "Set-Cookie: sub_3cookie=" + c + ";", expires                                        
                        print "Set-Cookie: sub_3cookie=" + q + h + css + refresh + ";", expires
                    if '@{sub_css}' in q:   
                        c = c.replace(c,css)
                        print "Set-Cookie: sub_3cookie=" + c + ";", expires                                        
                        print "Set-Cookie: sub_3cookie=" + q + h + w + refresh + ";", expires
                    if '@{sub_refresh}' in q:   
                        c = c.replace(c,refresh)
                        print "Set-Cookie: sub_3cookie=" + c + ";", expires                                        
                        print "Set-Cookie: sub_3cookie=" + q + h + w + css + ";", expires
                
            if '@{config}@{cmd' in data:
                q = q.replace("@","|")
                c = q.replace("{config}|{","")
                c = c.replace("}","")                
                subcmd1 = c            
                if heyu.getsub_b_1() is None:
                    print "Set-Cookie: sub1b_1cookie=" + q + ";", expires
                for x in heyu.getsub_b_1():
                    if q not in x:
                        print "Set-Cookie: sub1b_1cookie=" + q + x + ";", expires
                    elif q in x:
                        x = x.replace(q,"")
                        print "Set-Cookie: sub1b_1cookie=" + x + ";", expires
            
             
                    
     
        if 'heyu_do_cmd' in data:
            cmd = data.replace("heyu_do_cmd",heyu_path + " -c " + x10config)
            cmd = cmd.split()           
            ## For debugging uncomment out the two lines                    
            #heyu.debug()
            #print cmd 
            
            if 'rheo' not in cmd:
                subprocess.call(cmd) 
                
                            
            ### Dimming Controls ###
            # First test of str rheo is in QUERY_STRING
            # if so assign cx, cy to the values we want to dim
            # if cx and cy are equal ignore it because we don't want it to try to dim
            # test greater and lesser and set level to give us the right integer to dim
            # replace cmd[5] with the right str(level) and lastly call the subprocess.            
            
            if 'rheo' in cmd:
                cx = int(cmd[5])
                cy = int(cmd[6])                
                 
                if cx == cy:                                     
                    del cmd
                  
                if cx > cy:                                     
                    for x in cmd:
                        cmd[3] = 'bright'
                        level = int(cmd[5]) - int(cmd[6])                                          
                        
                if cx < cy:                    
                    for x in cmd:
                        cmd[3] = 'dim'
                        level = int(cmd[6]) - int(cmd[5])
            
            cmd[5] = str(level)         
            cmd = cmd[:6]
            subprocess.call(cmd)           

         
        else:
            if 'auto_refresh' in data or 'show_all_modules' in data or 'heyu_theme' in data:  
                try:
                    cookies = heyu.cookies()
                    for x in cookies:
                        for i in data:
                            if 'auto_refresh' in data and 'auto_refresh=True' not in cookies:
                                print "Set-Cookie: auto_refresh=True;", expires
                                auto_refresh = "True"
                                del x                                
                            if 'auto_refresh' in data and 'auto_refresh=False' not in cookies:
                                print "Set-Cookie: auto_refresh=False;", expires
                                auto_refresh = "False"
                                del x                                
                            if  'show_all_modules' in data and 'heyu_show_all_modules=True' not in cookies:
                                print "Set-Cookie: heyu_show_all_modules=True;", expires
                                heyu_show_all_modules = "True"
                                del x
                            if  'show_all_modules' in data and 'heyu_show_all_modules=False' not in cookies:
                                print "Set-Cookie: heyu_show_all_modules=False;", expires
                                heyu_show_all_modules = "False"  
                                del x                     
                            if 'heyu_theme' in data and 'heyu_theme=default' not in cookies:
                                print "Set-Cookie: heyu_theme=default;", expires
                                heyu_theme = "default"
                                del x
                            if 'heyu_theme' in data and 'heyu_theme=compact' not in cookies:
                                print "Set-Cookie: heyu_theme=compact;", expires
                                heyu_theme = "compact"
                                del x
                except:
                    pass


except:
    pass
    
    
     

# If data is empty assign it to query_string for compact theme
try:
    if data:
        pass
except:
    if heyu_theme == 'compact':
        data = urllib2.unquote(heyu.QUERY_STRING())
        cmd = data.replace("heyu_do_cmd",heyu_path + " -c " + x10config)
        cmd = cmd.split()
        try:
            subprocess.call(cmd)
        except:
            pass
    else:
        data = ""
    

heyu.html(heyu_web_interface_version)

try:
    if subcmd0:
        pass
except:
    subcmd0 = ""   
try:
    if subcmd1:
        pass
except:
    subcmd1 = ""     
try:
    if auto_refresh:
        pass
except:
    auto_refresh = "False"

heyu.control_panel(data, x10config, x10sched, x10report, 
                   heyu_path, HC, heyu_web_interface_version, 
                   restart_sleep_interval, subcmd0, subcmd1)
                   
if 'control_panel_@' not in urllib2.unquote(data):
     if heyu_theme == 'compact':
         from heyu_themes import compact_theme1
         compact_theme1(x10config, x10sched, heyu_path, HC)
     else:
        from heyu_themes import theme_default
        theme_default(data, x10config, x10sched, x10report, heyu_path, HC, 
        auto_refresh)    
