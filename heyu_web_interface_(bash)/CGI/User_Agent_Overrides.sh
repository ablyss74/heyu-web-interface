#!/usr/bin/env bash
set -f

# Author: 	Kris Beazley
# Copyright     2013 
# Online: 	http://heyu.epluribusunix.net/
# Online email: http://heyu.epluribusunix.net/?contactus
# Licensed under the Apache License, Version 2.0 http://www.apache.org/licenses/LICENSE-2.0


if [[ -n $user_agent_override && ${HTTP_USER_AGENT,,} == *$user_agent_override* ]];then
echo 
# Note: hrr = auto refresh rate

#heyu=/usr/local/bin/heyu
#x10config=./x10config
#x10sched=./x10.sched
#sched_report=./report.txt
#hrr=10
#Disable_HTML5=False
#Debug_Script=True
#Hide_Scenes=False
#Show_All_Modules_Width=70px
#Show_All_Modules_Height=70px
#Show_Power_Percentage=True
#Show_On_Off_Status=True
#Show_Time_Stamp=True
#Show_Module_Type=False    
#heyu_css=heyu_style.css
#heyu_show_all_modules=False
#heyu_theme=default
#auto_refresh=False
#Screen_Height=400px
#Screen_Width=650px

# The remaining overrides are for mobile devices.

#mobile_css=mobile.css
#Mobile_User_Active=False
#Show_Aliases=True
#Show_Menu=True
#Show_Scenes=True
#Hide_Status_Popup=False

fi
