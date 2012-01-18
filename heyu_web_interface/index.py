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

import cgitb, sys, re, subprocess, urllib2
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
auto_refresh_rate = "10"
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
   
   
if heyu.cookies() is not None:
    cookies = heyu.cookies()
    if 'auto_refresh=True' in cookies:
        auto_refresh = "True"
    if 'auto_refresh=False' not in cookies:
        auto_refresh = "False"
    if 'heyu_show_all_modules=True' in cookies:
        heyu_show_all_modules = "True"
    if 'heyu_show_all_modules=False' not in cookies:
        heyu_show_all_modules = "False"
    if 'heyu_theme=compact' in cookies:
        heyu_theme = "compact"
    if 'heyu_theme=default' in cookies:
        heyu_theme = "default"
            
    # Test is values are missing and declare values
    if 'heyu_theme' not in cookies:
        print "Set-Cookie: heyu_theme=default;", expires
        heyu_theme = "default"
    if 'auto_refresh' not in cookies:
        print "Set-Cookie: auto_refresh=False;", expires
        auto_refresh = "False"
    if 'heyu_show_all_modules' not in cookies:
        print "Set-Cookie: heyu_show_all_modules=False;", expires
        heyu_show_all_modules = "False"
            
    
   
try:
    for data in sys.stdin:            
        if 'heyu_do_cmd' in data:
            cmd = data.replace("heyu_do_cmd",heyu_path + " -c " + x10config)
            cmd = cmd.split()
            subprocess.call(cmd)
            ###  For debugging  ###
            #print('Content-type:text/html')
            #print('')
            #print cmd
            
            
            
        else:
            if 'auto_refresh' in data or 'show_all_modules' in data or 'heyu_theme' in data:  
                try:
                    cookies = heyu.cookies()
                    for x in cookies:
                        for i in data:
                            if 'auto_refresh' in data and 'auto_refresh=True' not in cookies:
                                print "Set-Cookie: auto_refresh=True;", expires
                                auto_refresh = "True"
                            if 'auto_refresh' in data and 'auto_refresh=False' not in cookies:
                                print "Set-Cookie: auto_refresh=False;", expires
                                auto_refresh = "False"
                                
                            if  'show_all_modules' in data and 'heyu_show_all_modules=True' not in cookies:
                                print "Set-Cookie: heyu_show_all_modules=True;", expires
                                heyu_show_all_modules = "True"
                            if  'show_all_modules' in data and 'heyu_show_all_modules=False' not in cookies:
                                print "Set-Cookie: heyu_show_all_modules=False;", expires
                                heyu_show_all_modules = "False"  
                                                     
                            if 'heyu_theme' in data and 'heyu_theme=default' not in cookies:
                                print "Set-Cookie: heyu_theme=default;", expires
                                heyu_theme = "default"
                            if 'heyu_theme' in data and 'heyu_theme=compact' not in cookies:
                                print "Set-Cookie: heyu_theme=compact;", expires
                                heyu_theme = "compact"
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
    

heyu.html(heyu_web_interface_version, auto_refresh_rate)

try:
    if auto_refresh:
        pass
except:
    auto_refresh = "False"

heyu.control_panel(data, x10config, x10sched, x10report, 
                   heyu_path, HC, heyu_web_interface_version, 
                   restart_sleep_interval)
                   
if 'control_panel_@' not in urllib2.unquote(data):
     if heyu_theme == 'compact':
         from heyu_themes import compact_theme1
         compact_theme1(x10config, x10sched, heyu_path, HC)
     else:
        from heyu_themes import theme_default
        theme_default(data, x10config, x10sched, x10report, heyu_path, HC, 
        auto_refresh, auto_refresh_rate)    
