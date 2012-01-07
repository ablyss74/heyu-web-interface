#! /usr/bin/env python
# Author: 	Kris Beazley
# Apache License, Version 2.0 http://www.apache.org/licenses/LICENSE-2.0

import cgitb, sys, os, re, subprocess, urllib2
sys.path.append('./modules')
cgitb.enable()
import heyu_py

# For now we define some static variables.
# In the future this should be controlled in the control panel
# Restart_sleep_interval allow heyu to restart gracefully
# HC = housecode
x10config = "./x10config"
x10sched = "./x10.sched"
x10report = "./report.txt"
heyu = "/usr/local/bin/heyu"
auto_refresh_rate = "10"
restart_sleep_interval = "5"
Heyu_web_interface_version = "11.56_beta"
file = open(x10config)
for H in file:
    if re.match('HOUSECODE', H.upper()):
        HC = H.replace("HOUSECODE ","")
file.closed 


heyu_py.engine(heyu, x10config)


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
        if re.search('(auto_refresh=False)', x) is not None:
            auto_refresh = "False"
        if re.search('(heyu_show_all_modules=True)', x) is not None:
            heyu_show_all_modules = "True"
        if re.search('(heyu_theme=compact)', x) is not None:
            heyu_theme = "compact"
    
   
try:
    for data in sys.stdin:    

        if 'heyu_do_cmd' in data:
            cmd = data.replace("heyu_do_cmd",heyu + " -c " + x10config)
            subprocess.call(cmd, shell=True,)
            #For debugging 
            #print('Content-type:text/html')
            #print('')
            #print cmd
            
            
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
                            if 'heyu_theme' in data and re.search('(heyu_theme=compact)', x) is None:
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
    data = urllib2.unquote(os.environ['QUERY_STRING'])
    cmd = data.replace("heyu_do_cmd",heyu + " -c " + x10config)
    subprocess.call(cmd, shell=True,)
    

heyu_py.html(Heyu_web_interface_version, auto_refresh_rate)


def _main_():
    heyu_py.main(data, x10config, x10sched, x10report, heyu, HC, 
    auto_refresh, auto_refresh_rate)


heyu_py.control_panel(data, x10config, x10sched, x10report, 
                   heyu, HC, Heyu_web_interface_version, 
                   restart_sleep_interval)
try:
    if 'control_panel' not in data:
        try:
            if heyu_theme == 'compact':
                from compact_theme import theme
                theme(x10config, x10sched, heyu, HC)
            else:
                _main_()     
        except:
            _main_()
except:
    _main_()

