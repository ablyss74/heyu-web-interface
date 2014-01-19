#!/usr/bin/env bash
set -f

# Author: 	Kris Beazley
# Copyright     2013 
# Online: 	http://heyu.epluribusunix.net/
# Online email: http://heyu.epluribusunix.net/?contactus
# Licensed under the Apache License, Version 2.0 http://www.apache.org/licenses/LICENSE-2.0


## Begin Control Panel

example()
{
	
	[[ ${Show_On_Off_Status^^} == TRUE 	]] && echo "<font color=red>On</font>"
	[[ ${Show_Power_Percentage^^} == TRUE 	]] && echo "				65&#37; Power"
	[[ ${Show_Time_Stamp^^} == TRUE 	]] && echo "				<br>Feb 10 14:10:01"
	[[ ${Show_Module_Type^^} == TRUE	]] && echo "				<br>StdAM"
	echo "			</table></button><br>"
	
    if [[ $HTTP_COOKIE == *html_range=True* ]] && [[ ${Disable_HTML5,,} != true ]];then
        echo "<input type=range min=0 max=21 class=sliderfx value=11 step=1>" 
                        
    else
        r1=$(($rawlevel - 3))
        r2=$(($rawlevel + 3))
        echo "<img src=./imgs/down.png class=pbi max=21><progress class=pb value=16 max=21></progress><img src=./imgs/up.png class=pbi>"
	
    fi
	#[[ ${HTML5_Slider,,} == true  ]] && 
	#echo "<input type=range min=0 max=21 class=sliderfx value=11 step=1>"


	if [[ ${Basic_Buttons,,} == true  ]];then
	echo "<table align=center><tr><td>
	      <button type=button style=\"width:130px;height:32px;background-color:#ccc;border-width: 0px;border-style: groove;border-color: #ccc;\">
	      <table style=\"width:130px;height:32px;background-color:#ccc;border-width: 0px;border-style: groove;border-color: #ccc;\">
	      <tr><td align=center><img src=./imgs/down.png class=icons></table></button>
	      <button type=button style=\"width:130px;height:32px;background-color:#ccc;border-width: 0px;border-style: groove;border-color: #ccc;\">
	      <table style=\"width:130px;height:32px;background-color:#ccc;border-width: 0px;border-style: groove;border-color: #ccc;\">
	      <tr><td align=center><img src=./imgs/up.png class=icons></table></button></table>" 
	fi

	
}


smenu()
{
		echo "<table width=$ctaw height=$ctah><tr><td><table class=control_panel><tr>
		<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('x10config_=Info')\">Heyu Info</button>
		<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('manpage=heyu')\">Heyu Manual</button>
		<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('heyu=enter_cmd')\">Heyu Cmd...</button>
		<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('kill_all_hc')\">All Off A-P</button>
	        <td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('heyu_restart')\">Heyu Restart</button>
	        <td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('heyu_insteon')\">Insteon Help</button>
		"
}

	if [[ -z $HTTP_COOKIE ]];then
	show() {
	echo "<table width=600 height=600><tr><td><table class=control_panel><tr>
	<td><h2 class=heading2> Welcome
	<tr><td><h3 class=heading3>Heyu Web Interface Version: $Heyu_web_interface_version 
	<br><br>You can begin using heyu web interface immediately by clicking the exit button.
	<br>	
	<br>You can customize heyu settings with the \"Heyu Config\" button.
	<br>
	<br>You can customize the interface with the \"Interface Config\" Menu.
	"
	
	
	
	
	
	}
	
	
	
	
	fi

	
	if [[ ${HTTP_COOKIE,,} == *groupstatus\|on* ]];then
	show() {
		echo "<table width=$ctaw height=$ctah><tr><td><table class=control_panel><tr>"
		echo "<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('heyugroup=*')\">Modules</button>"
		echo "<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('heyugroup=SCENE')\">Scenes</button>"

	sub3cookie() {
	
	do_subs() {
		 	
	   
	[[ ${name,,} == *group1* && ${value,,} != "null"  && $value != "" ]] && echo "<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('heyugroup=$value')\">$value</button>"
	[[ ${name,,} == *group2* && ${value,,} != "null"  && $value != "" ]] && echo "<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('heyugroup=$value')\">$value</button>"
	[[ ${name,,} == *group3* && ${value,,} != "null"  && $value != "" ]] && echo "<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('heyugroup=$value')\">$value</button>"
	[[ ${name,,} == *group4* && ${value,,} != "null"  && $value != "" ]] && echo "<tr><td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('heyugroup=$value')\">$value</button>"
	[[ ${name,,} == *group5* && ${value,,} != "null"  && $value != "" ]] && echo "<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('heyugroup=$value')\">$value</button>"
	[[ ${name,,} == *group6* && ${value,,} != "null"  && $value != "" ]] && echo "<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('heyugroup=$value')\">$value</button>"
	[[ ${name,,} == *group7* && ${value,,} != "null"  && $value != "" ]] && echo "<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('heyugroup=$value')\">$value</button>"
	[[ ${name,,} == *group8* && ${value,,} != "null"  && $value != "" ]] && echo "<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('heyugroup=$value')\">$value</button>"
	[[ ${name,,} == *group9* && ${value,,} != "null"  && $value != "" ]] && echo "<tr><td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('heyugroup=$value')\">$value</button>"
	[[ ${name,,} == *group0* && ${value,,} != "null"  && $value != "" ]] && echo "<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('heyugroup=$value')\">$value</button>"
	}
	
	
	if [[ $name == sub3cookie* ]];then
		name=${name//sub3cookie_}
		if [[ $value == *\|* ]];then	
		subarr=(${value//^/ })
		while [[ $subi -lt ${#subarr[*]} ]]
			do
			subvar=${subarr[$subi]}
			name=${subvar%|*}
			value=${subvar#*|}
			do_subs
			((subi++))
			done
		else
			do_subs
		fi	
		
	fi
	
	}
	# Show cookies current values
	arr=($HTTP_COOKIE)

	while [[ $i -lt ${#arr[*]} ]]
		do
		cookies=${arr[$i]}
		cookies=${cookies//&/;}
		cookies=${cookies/=/ }
		cookies=${cookies//;/}
		cookies=(${cookies})
		name=${cookies[0]}
		value=${cookies[1]}

		sub3cookie
		((i++))

			done		
		unset i	

	  		var=heyu_group
	      
	  }	  
	  
       
fi



#		
        [[ $QUERY_STRING == *sched* ]] && var=sched || var=config

	if [[ $QUERY_STRING == *heyu_web_interface_version* ]];then
	
	  show() {
		 smenu && echo "</table>"
		 echo "</textarea><table valign=top><tr><td valign=top align=center bgcolor=#ffffff ><iframe align=center 
			src=http://heyu.epluribusunix.net/?heyu_web_interface_version=${Heyu_web_interface_version/%=/} border=0 
			height=$ctah width=$ctaw scrolling=yes></iframe></table>
			"
		 }

	fi



	if [[ $QUERY_STRING == *heyu_camera1* ]];then
	  
          var=heyu_camera1
	  show() {
		
			echo "</textarea>
			      <table valign=top><tr><td valign=top align=center bgcolor=#ffffff>
			      <img src=$camera1_location alt=\"\" height=340 width=420>
			      <td valign=top align=center bgcolor=#ffffff>
			       <img src=$camera2_location alt=\"\" height=340 width=420>
			      <tr><td valign=top align=center bgcolor=#ffffff >
			      <img src=$camera3_location alt=\"\" height=340 width=420>
			      <td valign=top align=center bgcolor=#ffffff>
			       <img src=$camera4_location alt=\"\" height=340 width=420>
			      </table>"
		 }

	fi
	


	if [[ $QUERY_STRING == *heyu_top* ]];then
	  
          var=heyu_top
	  show() {
		
			 echo "</textarea><table valign=top><tr><td valign=top align=center bgcolor=#ffffff ><iframe align=center 
		        	src=./CGI/top.sh border=0 height=$ctah width=$ctaw scrolling=yes></iframe></table>"		
		
		 }

	fi 
   
   if [[ $QUERY_STRING == *heyu_insteon* ]];then
	  
          var=heyu_insteon
	  show() {
			 Q=${QUERY_STRING/heyu_insteon_}
			 Q=${Q/&heyu_insteon_set_pri=/}
			 Q=${Q/&heyu_insteon_rem_pri=/}
			 if [[ $Q == *set_pri=* ]];then
			 Q=${Q/set_pri=} && heyu on $Q ; heyu address $Q ; heyu on $Q ; heyu address $Q ; heyu on $Q
			 fi
			 if [[ $Q == *rem_pri=* ]];then
			 Q=${Q/rem_pri=} && heyu on $Q ; heyu address $Q ; heyu on $Q ; heyu address $Q ; heyu on $Q
			 fi
			 smenu
			 echo "</table><table valign=top width=600 class=control_panel><tr><td>
			 <form method=post><b>Set X10 Primary Address:</b><td>
			 <select name=heyu_insteon_set_pri><option value=\"A\">A
			 $(for i in {B..P}; do echo "<option value=\"$i\">$i"; done)
			 </select>
			 <select name=heyu_insteon_set_pri><option>1<option value=\"1\">2
			 $(var=3;while [[ $var -le 16 ]]; do echo "<option value=\"$var\">$((var++))"; done)
			 </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=submit value=OK></form> 			 
			 <tr><td><font size=1><i>1. Press & hold the Set button <br>(enter linking mode) LED will blink<br>
			 <br>2. Enter desired X10 Address and press OK.<br> The device will exit unlinking mode and<br> its LED will stop blinking.</i></font><br><br>
			 <tr><td>
			 
			 <form method=post><b>Remove X10 Primary Address:</b><td>
			 <select name=heyu_insteon_rem_pri><option value=\"A\">A
			 $(for i in {B..P}; do echo "<option value=\"$i\">$i"; done)
			 </select>
			 <select name=heyu_insteon_rem_pri><option>1<option value=\"1\">2
			 $(var=3;while [[ $var -le 16 ]]; do echo "<option value=\"$var\">$((var++))"; done)
			 </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=submit value=OK></form> 
			 
			 <tr><td><font size=1><i>
			 1. Press & hold the Set button <br>(enter linking mode) LED will blink.<br>
			 2. Press & hold the Set button again<br>
			 (enter unlinking mode) LED will blink<br> 
			 3. Enter desired X10 Address and press OK.
			 <br>The device will exit unlinking mode and<br> its LED will stop blinking.</i></font><br><br>
			 
			 <tr><td>
			 <form method=post><b>Set On-Level:</b><td>
			 <select name=heyu_insteon_onlevel><option value=\"A\">A
			 $(for i in {B..P}; do echo "<option value=\"$i\">$i"; done)
			 </select>
			 <select name=heyu_insteon_onlevel><option>1<option value=\"1\">2
			 $(var=3;while [[ $var -le 16 ]]; do echo "<option value=\"$var\">$((var++))"; done)
			 </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=submit disabled value=OK></form> 
			 
			 <tr><td>
			 <form method=post><b>Set Ramp Rate:</b><td>
			 <select name=heyu_insteon_ramprate><option value=\"A\">A
			 $(for i in {B..P}; do echo "<option value=\"$i\">$i"; done)
			 </select>
			 <select name=heyu_insteon_ramprate><option>1<option value=\"1\">2
			 $(var=3;while [[ $var -le 16 ]]; do echo "<option value=\"$var\">$((var++))"; done)
			 </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=submit disabled value=OK></form> 
			 
			 
			 <tr><td>
			 <br>TRADEMARKS:<br><br>
			    Insteon is a trademark of INSTEON <a href=http://www.insteon.com target=_BLANK>http://www.insteon.com</a>
			 <br>   
			 <br>Need more help?: <a href=/Help/insteon-x10-programming.html target=_BLANK>Insteon-x10-programming</a>
			  
			  
			   </table> 
			 
			 
			 "
	
		
		 }

	fi 

   if [[ $QUERY_STRING == *heyu_music* ]];then
	  
          var=heyu_music
	  show() {
		
			 echo "</textarea><table valign=top width=$ctaw class=control_panel><tr><td valign=top align=center><iframe align=center 
		        	src=./CGI/music.sh border=0 height=$ctah width=$ctaw scrolling=yes></iframe></table>"		
		
		 }

	fi 
	
    if [[ $QUERY_STRING == *heyu_logs* ]];then
	  
          var=heyu_logs
	  show() {
	  
			 echo "</textarea><table valign=top width=$ctaw class=control_panel><tr><td valign=top align=center><iframe align=center 
		        	src=./heyu_logs.sh border=0 height=$ctah width=$ctaw scrolling=yes></iframe></table>"		
		
		 }

	fi 
	if [[ $QUERY_STRING == *heyu_reload* ]];then
	
	  show() {
		smenu && echo "</table>"
		echo "<textarea cols=$ctaw rows=$ctah name=config>"				
		var=$("$heyu" -v -c "${x10config}" restart)
		echo -e "\n $var"
		 }

	fi 

	if [[ $QUERY_STRING == *heyu_restart* ]];then
	
	  show() {
		smenu && echo "</table>"
		echo "<textarea cols=$ctaw rows=$ctah name=config>"				
 		var=$("$heyu" -c "${x10config}" stop && sleep 3s && "$heyu" -c "${x10config}" start)
		[[ $var != *heyu_relay* ]] && echo -e "\nError: Heyu relay did not restart correctly.\n" && halt=true
		[[ $var != *heyu_engine* ]] && echo -e "\nError: Heyu engine did not restart correctly.\n" && halt=true
		[[ $halt ]] && echo -e "Possible Solutions:\n\nTry restarting heyu again with the interface.\n\nIf that does not work try stopping heyu from terminal e.g., 'heyu stop' or 'sudo heyu stop' and restarting with the interface again w/ 'Heyu Restart'.\n\nGood Luck!" && exit
		echo "${var//starting/Restarted the}"
		 }

	fi 


	if [[ $QUERY_STRING == *heyu_cmd* ]];then
	
	  show() {
		smenu && echo "</table>"

		echo "<textarea cols=$ctaw rows=$ctah name=config readonly>"
				
		QUERY_STRING=${QUERY_STRING/heyu_cmd=}
		QUERY_STRING=${QUERY_STRING/monitor}
		QUERY_STRING=${QUERY_STRING/heyu}
		echo "$("$heyu" -c "${x10config}" ${QUERY_STRING})"
		 }
	  
	fi 

	if [[ $QUERY_STRING == *heyu=enter_cmd* ]];then
	
	  show() {
		smenu && echo "</table>"
		echo "<br><table class=control_panel><tr>
			<td>Enter Command:<input type=text name=heyu_cmd onsubmit=\"Status();\">
			<td><input type=submit value=Enter>
			<td><button type=button onclick=\"$(fstatus); show('heyu_cmd=help')\">Help</button>
		      </table>"

		 }
	  
	fi 


	if [[ $QUERY_STRING == *Action=Config* || $QUERY_STRING == *heyu_config_submit=Save ]];then
	
	  var=heyu_config
 	  show() {
	 	echo "<table width=$ctaw height=$ctah><tr><td><table class=control_panel><tr>
		<tr>
		<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('BasicUserConfig=css')\">Interface Config</button>
		<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('BasicUserConfig=sub3cookie')\">Groups</button>
		<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('BasicUserConfig=Buttons')\">Buttons</button>
		<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('BasicUserConfig=sub2cookie')\">Tweaks</button>
		<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('Action=Config')\">Overrides</button>			
		</table>"
		echo "<textarea cols=$ctaw rows=$ctah name=config>$(<./overrides)"
	    	 }    
	fi
	if [[ $QUERY_STRING == *Action=X10Config* && ${Mobile_User_Active^^} == TRUE ]];then
	
 	QUERY_STRING="BasicUserConfig=sub3cookie"
	fi	
	if [[ $QUERY_STRING == *Action=X10Config* || 
		    $QUERY_STRING == *x10config_* ]];then
	var=x10config
	 show() {
		smenu
	  echo "</table>"
   	  echo "<textarea cols=$ctaw rows=$ctah name=config>"
	  if    [[ $QUERY_STRING == *x10config_=Info ]];then "$heyu" -c "${x10config}" info
	 
          else 
		echo "$(<"$x10config")"
	  fi

		}		
	fi

	if [[ $QUERY_STRING == *manpage* ]];then
	  
	  var=${QUERY_STRING/manpage=}
	  read_manpages=$(man -E UTF-8 $var 2>/dev/null)	  
	  
	  show() {
		  smenu && echo "</table>"
		  echo "<textarea cols=$ctaw rows=$ctah name=config readonly>$read_manpages"
		 }    
	fi


	if [[ $QUERY_STRING == *Action=X10sched* 		|| 
	      $QUERY_STRING == *x10sched_*       		&& 
	      $QUERY_STRING != *heyu_userconfig_submit=Save 	&& 
	      $QUERY_STRING != *heyu_BasicUserConfig_submit=Save  ]];then
 	 
	 var=x10sched
	
	 show() {
	 	echo "<table width=$ctaw height=$ctah><tr><td><table class=control_panel><tr>
		<tr>		
		<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('x10sched_=Status')\">Status</button>
		<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('x10sched_=Examples')\">Examples</button>
		<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('x10sched_=Report')\">Report</button>
		<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('x10sched_=Upload')\">Upload</button>	
		<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('x10sched_=Erase')\">Erase</button>	
		</table>"
   	  
	   if   [[ $QUERY_STRING == *sched_=Upload ]];then 
		echo "<textarea cols=$ctaw rows=$ctah name=config readonly>"
		var=$("$heyu" -c "${x10config}" -s "$x10sched" upload)
  
		[[ $var != *Uploading* ]] && echo -e "Error in schedule file.\n\nPlease correct the errors and try again." && halt=true
		[[ -z $halt ]] && echo "${var}"
  
	   elif	[[ $QUERY_STRING == *sched_=Status ]];then 
	      echo "<textarea cols=$ctaw rows=$ctah name=config readonly>"
	      "$heyu" -c "${x10config}" -s "$x10sched" upload status
	   elif [[ $QUERY_STRING == *x10sched_=Examples ]];then 
	       echo "<textarea cols=$ctaw rows=$ctah name=config readonly>"
	       echo "$(man -E UTF-8 X10SCHED 2>/dev/null)"
	   elif	[[ $QUERY_STRING == *sched_=Report && -e $sched_report ]];then 
	       echo "<textarea cols=$ctaw rows=$ctah name=config readonly>"
	       echo "$(<"$sched_report")"
	   elif	[[ $QUERY_STRING == *sched_=Report && ! -e $sched_report ]];then 
	       echo "<textarea cols=$ctaw rows=$ctah name=config readonly>"
	       echo "$sched_report not found."
  	   elif	[[ $QUERY_STRING == *sched_=Erase ]];then 
  	       echo "<textarea cols=$ctaw rows=$ctah name=config readonly>"
  	       "$heyu" -c "${x10config}" -s "$x10sched" erase
		
           else 
               echo "<textarea cols=$ctaw rows=$ctah name=config>"
		[[ -e $x10sched ]] && echo "$(<"$x10sched")"

	   fi
	        }
	fi
	

	# Begin new User Config 

	if [[ $QUERY_STRING == *UserConfig* || $QUERY_STRING == *userconfig_submit=Save ]];then		

	do_userconfig() {


	do_buttons() {
	if [[ ${Mobile_User_Active^^} != TRUE ]];then

	do_subs() {	
	
	#valueis() { [[ -z $value ]] && echo False || echo True ; }
	
	[[ $name == Show_Power_Percentage ]]	&& 
	echo "<tr><td>Dim Level: <td><input type=text name='sub1cookie_$name' value='${value}'>
	<br> <i>When \"True\" this shows the percentage of luminosity <br>in the details part of the button.</i>"
	[[ $name == Show_Time_Stamp ]] 		&& 
	echo "<tr><td>Time Stamp: <td><input type=text name='sub1cookie_$name' value='${value}'>
	<br> <i>When \"True\" this shows the last time the Unit was turned on/off <br> in the details part of the button.</i>"
	[[ $name == Show_Module_Type   ]]	&& 
	echo "<tr><td>Module Type: <td><input type=text name='sub1cookie_$name' value='${value}'>
	<br> <i>When \"True\" this shows the module type if defined<br> in the details part of the button.</i>"
	[[ $name == Show_All_Modules_Height* ]] && 
	echo "<tr><td>Show All Modules Height: <td><input type=text name='sub1cookie_$name' value='${value}'>
	<br><i>This is the button height when viewing Show All Modules.</i>"
	[[ $name == Show_All_Modules_Width* ]]  && 
	echo "<tr><td>Show All Modules Width: <td><input type=text name='sub1cookie_$name' value='${value}'>
	<br><i>This is the button width when viewing Show All Modules.</i>"
	#[[ $name == *HTML5_Slider* ]] 		&& 
	#echo "<tr><td>HTML 5 Rheostat: <td><input type=text name='sub1cookie_${name}' value='${value}'>
	#<br> <i>When \"True\" this uses new HTML 5 range sliders to adjust luminosity.<br>
	#Important! HTML 5 is still unsupported by many browsers.<br>
	#Aliases must have the module type \"StdLM\" defined in $x10config.</i>"
	#[[ $name == Basic_Buttons ]] 		&& 
	#echo "<tr><td>HTML 4 Rheostat: <td><input type=text name='sub1cookie_${name}' value='${value}'>
	#<br> <i>When \"True\" this uses HTML 4 buttons to adjust luminosity.<br>
	#Aliases must have the module type \"StdLM\" defined in $x10config.</i>"
	}
	if [[ $name == sub1cookie* ]];then
		name=${name//sub1cookie_}
		if [[ $value == *\|* ]];then	
		subarr=(${value//^/ })
		while [[ $subi -lt ${#subarr[*]} ]]
			do
			subvar=${subarr[$subi]}
			name=${subvar%|*}
			value=${subvar#*|}
			do_subs
			((subi++))
			done
		else
			do_subs
		fi	
		
	fi
	

	else
	[[ $name == Show_Power_Percentage ]] 	&& 
	echo "<tr><td class=userconfig2>Dim Level: <td><input type=text class=text name='$name' value='${value}'>"
	[[ $name == Show_Time_Stamp ]] 		&& 
	echo "<tr><td class=userconfig2>Time Stamp: <td><input type=text class=text name='$name' value='${value}'>"
	[[ $name == Show_Module_Type   ]]	&& 
	echo "<tr><td class=userconfig2>Module Type: <td><input type=text class=text name='$name' value='${value}'>"
	fi
	}
	
	sub3click1(){
	
	if [[ $QUERY_STRING == sub3cookie_* ]];then
	 x=$QUERY_STRING
	 [[ ${x,,} == *groupstatus=on* ]] && x=${x/GroupStatus=On/GroupStatus=Off} || x=${x/GroupStatus=Off/GroupStatus=On}
	 echo $x
	
	
	else
	for x in $HTTP_COOKIE ; do
	  x=${x//;}
	  x=${x//|/=}
	  x=${x/sub3cookie=/sub3cookie_}
	  x=${x//^/&sub3cookie_}
	  x=${x%sub3cookie_}
	  if [[ ${x} == sub3cookie* ]];then
	      [[ ${x,,} == *groupstatus=on* ]] && x=${x/GroupStatus=On/GroupStatus=Off} || x=${x/GroupStatus=Off/GroupStatus=On}      
	      echo "${x}heyu_BasicUserConfig_submit=Save"
	      
	  fi
	  done
	fi
	}

	sub3cookie() {
	
	do_subs() {
	[[ ${name} == *GroupStatus* ]] 	&& 
	echo "<tr><td>Status: <td><input type=text readonly name='sub3cookie_${name}' value='${value}'>"
	[[ $name == *GroupStatus* ]] 	&& echo "<td><button type=button class=userconfigbutton onclick=\"show('$(sub3click1)')\">Change Status</button>"
	[[ $name == *Group1* ]] 	&& 
	echo "<tr><td>Group 1: <td><input type=text name='sub3cookie_${name}' value='${value}'>"
	[[ $name == *Group2*   ]]	 && 
	echo "<tr><td>Group 2: <td><input type=text name='sub3cookie_${name}' value='${value}'>"
	[[ $name == *Group3* ]]	 && 
	echo "<tr><td>Group 3: <td><input type=text name='sub3cookie_${name}' value='${value}'>"
	[[ $name == *Group4* ]] 	&& 
	echo "<tr><td>Group 4: <td><input type=text name='sub3cookie_${name}' value='${value}'>"
	[[ $name == *Group5* ]]	 && 
	echo "<tr><td>Group 5: <td><input type=text name='sub3cookie_${name}' value='${value}'>"
	[[ $name == *Group6* ]]	&& 
	echo "<tr><td>Group 6: <td><input type=text name='sub3cookie_${name}' value='${value}'>"
	[[ $name == *Group7* ]]	&& 
	echo "<tr><td>Group 7: <td><input type=text name='sub3cookie_${name}' value='${value}'>"
	[[ $name == *Group8* ]]	&& 
	echo "<tr><td>Group 8: <td><input type=text name='sub3cookie_${name}' value='${value}'>"
	[[ $name == *Group9* ]]	&& 
	echo "<tr><td>Group 9: <td><input type=text name='sub3cookie_${name}' value='${value}'>"
	[[ $name == *Group0* ]]	&& 
	echo "<tr><td>Group 10: <td><input type=text name='sub3cookie_${name}' value='${value}'>"
	}
	if [[ $name == sub3cookie* ]];then
		name=${name//sub3cookie_}
		if [[ $value == *\|* ]];then	
		subarr=(${value//^/ })
		while [[ $subi -lt ${#subarr[*]} ]]
			do
			subvar=${subarr[$subi]}
			name=${subvar%|*}
			value=${subvar#*|}
			do_subs
			((subi++))
			done
		else
			do_subs
		fi	

	fi

	}


	do_css() {
	[[ $name == *heyu_css*   ]] 		&& 
	echo "<tr><td>Location of CSS: <td><input type=text name='$name' value='${value}'>
	<br><i>Location and name of stylesheet that will be used by this web browser only. 
 	<br> Examples: ./heyu_style.css or http://$SERVER_NAME/heyu_style.css </i>"
	[[ $name == *Text_Area_Width*   ]] 	&& 
	echo "<tr><td>Screen Width: <td><input type=text name='$name' value='${value}'>
	<br> <i>This is the width of the control panel.</i>"
	[[ $name == *Text_Area_Height*   ]] 	&& 
	echo "<tr><td>Screen Height: <td><input type=text name='$name' value='${value}'>
	<br> <i>This is the height of the control panel.</i>"

	sub0cookie() {

	do_subs() {	
	value=${value//=}
	[[ $name == heyu ]]			&& 
	echo "<tr><td>Path to Heyu: <td><input type=text size=28 name='sub0cookie_$name' value='${value}'>
	<br> <i>Location of heyu binary.</i>"

	[[ $name == x10config ]]		&& 
	echo "<tr><td>X10 Config: <td><input type=text size=28 name='sub0cookie_$name' value='${value}'>
	<br> <i>Location of x10config.</i>"

	[[ $name == x10sched ]]			&& 
	echo "<tr><td>X10 Schedule: <td><input type=text size=28 name='sub0cookie_$name' value='${value}'>
	<br> <i>Location of x10sched. </i>"

	[[ $name == sched_report ]]		&& 
	echo "<tr><td>X10 Schedule Report: <td><input type=text size=28 name='sub0cookie_$name' value='${value}'>
	<br> <i>Location of x10sched report.</i>"
	
	[[ $name == hrr ]]			&& 
	echo "<tr><td>Auto Refresh Rate: <td><input type=text size=28 name='sub0cookie_$name' value='${value}'>
	<br> <i>Refresh rate intervals in seconds.</i>"
	
	[[ $name == camera1_location ]]		&& 
	echo "<tr><td>Camera 1 Location: <td><input type=text size=28 name='sub0cookie_$name' value='${value}'>
	<br> <i>Camera 1 URL.</i>"
	
	[[ $name == camera2_location ]]		&& 
	echo "<tr><td>Camera 2 Location: <td><input type=text size=28 name='sub0cookie_$name' value='${value}'>
	<br> <i>Camera 2 URL.</i>"
	
	[[ $name == camera3_location ]]		&& 
	echo "<tr><td>Camera 3 Location: <td><input type=text size=28 name='sub0cookie_$name' value='${value}'>
	<br> <i>Camera 3 URL.</i>"
	
	[[ $name == camera4_location ]]		&& 
	echo "<tr><td>Camera 4 Location: <td><input type=text size=28 name='sub0cookie_$name' value='${value}'>
	<br> <i>Camera 4 URL.</i>"

	}
	if [[ $name == sub0cookie* ]];then
		name=${name//sub0cookie_}
		if [[ $value == *\|* ]];then	
		subarr=(${value//^/ })
		while [[ $subi -lt ${#subarr[*]} ]]
			do
			subvar=${subarr[$subi]}
			name=${subvar%|*}
			value=${subvar#*|}
			do_subs
			((subi++))
			done
		else
			do_subs
		fi	
		
	fi

	 }
	sub0cookie
	}


	sub2cookie() {

	do_subs() {	
	[[ $name == *Hide_Scenes* ]]		&& 
	echo "<tr><td>Hide Scenes: <td><input type=text size=28 name='sub2cookie_$name' value='${value}'>
	<br> <i>If \"True\" the device will hide scenes and usersyns.</i>"	
	[[ $name == Debug_SCRIPT ]] 		&& 
	echo "<tr><td>Debug Script: <td><input type=text size=28 name='sub2cookie_${name}' value='${value}'>
	<br> <i>When \"True\" the script will display errors and warnings.</i>"
	[[ $name == All_Modules_Auto_Refresh ]]	&& 
	echo "<tr><td>Auto Refresh All Modules:<td><input type=text size=28 name='sub2cookie_${name}' value='${value}'>
	<br><i>When \"True\" auto refresh will be applied to \"Show All Modules\".</i>"
	[[ $name == Disable_HTML5 ]]	&& 
	echo "<tr><td>Disable HTML 5 Dimming: <td><input type=text size=28 name='sub2cookie_${name}' value='${value}'>
	<br> <i>If \"True\" HTML 4 dimming controls will be used by default.<br></i>"


	}
	if [[ $name == sub2cookie* ]];then
		name=${name//sub2cookie_}
		if [[ $value == *\|* ]];then	
		subarr=(${value//^/ })
		while [[ $subi -lt ${#subarr[*]} ]]
			do
			subvar=${subarr[$subi]}
			name=${subvar%|*}
			value=${subvar#*|}
			do_subs
			((subi++))
			done
		else
			do_subs
		fi	
		
	fi

	}


	if [[ $QUERY_STRING == *BasicUserConfig=Buttons* 	|| $QUERY_STRING == *BasicUserConfig_submit* ]];then	
	   [[ $QUERY_STRING == *BasicUserConfig=sub2cookie* 	|| $QUERY_STRING == *BasicUserConfig_submit* ]] && sub2cookie 
	   [[ $QUERY_STRING == *BasicUserConfig=sub3cookie* 	|| $QUERY_STRING == *BasicUserConfig_submit* ]] && sub3cookie
	   [[ $QUERY_STRING == *BasicUserConfig=css* 		|| $QUERY_STRING == *BasicUserConfig_submit* ]] && do_css

 		do_buttons		
	 
	elif    [[ $QUERY_STRING == *BasicUserConfig=sub2cookie* || $QUERY_STRING == *BasicUserConfig_submit* ]];then	
		sub2cookie
		
	elif [[ $QUERY_STRING == *BasicUserConfig=sub3cookie* || $QUERY_STRING == *BasicUserConfig_submit* ]];then
		sub3cookie
		
	        [[ ${Mobile_User_Active^^} == TRUE ]] && do_buttons

	elif [[ $QUERY_STRING == *BasicUserConfig=css* || $QUERY_STRING == *BasicUserConfig_submit* ]];then
		do_css	

	elif [[ $QUERY_STRING == *BasicUserConfig* || $QUERY_STRING == *BasicUserConfig_submit*  ]];then	
		do_buttons

	fi
	}

	  var=heyu_userconfig
 	  show() {
 	  

 	  
 	  
		[[ $QUERY_STRING != *BasicUserConfig* ]] && echo "<textarea cols=$ctaw rows=$ctah name=config>" 
		if [[ $QUERY_STRING == *BasicUserConfig* ]];then
		 echo "<table class=userconfig name=config>" 
		[[ ${Mobile_User_Active^^} == TRUE ]] && echo "<table><tr><td><table class=userconfig><tr>" # Mobile CSS doesn't care about screen width
		[[ ${Mobile_User_Active^^} != TRUE ]] && echo "<table width=$ctaw height=$ctah class=control_panel><tr><td>"
		 if [[ ${Mobile_User_Active^^} != TRUE ]];then		
	 	echo "<table width=$ctaw height=$ctah><tr><td><table class=control_panel><tr>
		<tr>
		<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('BasicUserConfig=css')\">Interface Config</button>
		<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('BasicUserConfig=sub3cookie')\">Groups</button>
		<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('BasicUserConfig=Buttons')\">Buttons</button>		
		<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('BasicUserConfig=sub2cookie')\">Tweaks</button>
		<td><button type=button class=userconfigbutton onclick=\"$(fstatus); show('Action=Config')\">Overrides</button>	
		</table>"
			# Not in the loop

			
			if [[ $QUERY_STRING == *sub2cookie* ]];then
		echo "<table class=userconfig><tr><td width=145>Delete Cookies: <td><form method=post><input type=checkbox size=28 name='Reset_Cookies' value=OK></form>
		<i>Check the box to delete cookies for domain: $SERVER_NAME.</i></table>"
			fi
			
			if [[ $QUERY_STRING == *sub3cookie* ]];then
		echo "<table class=userconfig><tr><td>Define Group ID's.  <br><br>
		      Group ID's are added to a Group with the directive \"Group=ID\" in the x10 config file.<br>
		      The below Group ID's must match the Group directive in the X10 config file.<br>
		      Examples are included in the x10 config file.
		      This directive only applies to the heyu web interface.<br>
		      Currently only 10 Groups are possible but future versions may include more.</table>"
			fi
	

		 fi	
			echo "<table class=userconfig2 name=config>" 
	
		fi		

	        
		# After Saving cookies display the new values

		if [[ $QUERY_STRING == *heyu_userconfig_submit=Save || $QUERY_STRING == *heyu_BasicUserConfig_submit=Save ]];then
		COOKIE_QUERY_STRING=${QUERY_STRING// /=}
		COOKIE_QUERY_STRING=${COOKIE_QUERY_STRING//&/\\n}
		COOKIE_QUERY_STRING=${COOKIE_QUERY_STRING//\\n/ }
		COOKIE_QUERY_STRING=${COOKIE_QUERY_STRING//&heyu_BasicUserConfig_submit=Save/}
		COOKIE_QUERY_STRING=${COOKIE_QUERY_STRING//heyu_userconfig_submit=Save/}

		arr=($COOKIE_QUERY_STRING)


		while [[ $i -lt ${#arr[*]} ]]
			do	
			cookies=${arr[$i]}
			cookies=${cookies/=/ }			
			cookies=${cookies//;/}
			cookies=(${cookies})
			name=${cookies[0]}
			value=${cookies[1]}
			
			do_userconfig	

			((i++))
		done 
		
		[[ $QUERY_STRING == *BasicUserConfig* ]] && echo "</table>"
		unset i		

		else

		# Show cookies current values
		
		arr=($HTTP_COOKIE)

		while [[ $i -lt ${#arr[*]} ]]
			do
			cookies=${arr[$i]}
			cookies=${cookies//&/;}
			cookies=${cookies/=/ }
			cookies=${cookies//;/ }
			cookies=(${cookies})
			name=${cookies[0]}
			value=${cookies[1]}
			
			 
			do_userconfig
			((i++))

			done
			
		[[ $QUERY_STRING == *BasicUserConfig* ]] && echo "</table>"
		unset i
			
		fi
			
		
	    	 }    
	fi

	## End New User Config

 	echo "	<form method=post>
		<table class=control_panel align=center border=0 cellspacing=0 cellpadding=15>
		<tr><td class=control_panel valign=top align=center style=\"background:#CCC\" >"

	
		if [[ $QUERY_STRING == *manpage* ]];then
		echo "
		<button class=control_panel_buttons type=button onclick=\"$(fstatus); show('BasicUserConfig=css')\">
		<table><tr><td width=20><img src=./imgs/edit_user.png width=25 height=25> 
		<td><span class=control_panel>Interface Config</table></button><br>

		<button class=control_panel_buttons type=button $([[ $QUERY_STRING == *manpage=heyu ]] && echo "disabled")
		onclick=\"$(fstatus);show('manpage=heyu')\">
		<table><tr><td width=20 height=25>
		$([[ $QUERY_STRING == *manpage=heyu ]] && echo "<img src=./imgs/filefind.png width=25 height=25>")
		<td><span class=control_panel>Heyu</table></button><br>

		<button class=control_panel_buttons type=button $([[ $QUERY_STRING == *manpage=x10config ]] && echo "disabled")
		onclick=\"$(fstatus);show('manpage=x10config')\">
		<table><tr><td width=20 height=25>
		$([[ $QUERY_STRING == *manpage=x10config  ]] && echo "<img src=./imgs/filefind.png width=25 height=25>")
		<td><span class=control_panel>Config</table></button><br>

		<button class=control_panel_buttons type=button $([[ $QUERY_STRING == *manpage=x10sched ]] && echo "disabled")
		onclick=\"$(fstatus);show('manpage=x10sched')\">
		<table><tr><td width=20 height=25>
		$([[ $QUERY_STRING == *manpage=x10sched ]] && echo "<img src=./imgs/filefind.png width=25 height=25>")
		<td><span class=control_panel>Schedule</table></button><br>

		<button class=control_panel_buttons type=button $([[ $QUERY_STRING == *manpage=x10scripts ]] && echo "disabled")
		onclick=\"$(fstatus);show('manpage=x10scripts')\">
		<table><tr><td width=20 height=25>
		$([[ $QUERY_STRING == *manpage=x10scripts ]] && echo "<img src=./imgs/filefind.png width=25 height=25>")
		<td><span class=control_panel>Scripts</table></button><br>

		<button class=control_panel_buttons type=button $([[ $QUERY_STRING == *manpage=x10cm17a ]] && echo "disabled")
		onclick=\"$(fstatus);show('manpage=x10cm17a')\">
		<table><tr><td width=20 height=25>
		$([[ $QUERY_STRING == *manpage=x10cm17a ]] && echo "<img src=./imgs/filefind.png width=25 height=25>")
		<td><span class=control_panel>CM17A</table></button><br>

		<button class=control_panel_buttons type=button $([[ $QUERY_STRING == *manpage=x10aux ]] && echo "disabled")
		onclick=\"$(fstatus);show('manpage=x10aux')\">
		<table><tr><td width=20 height=25>
		$([[ $QUERY_STRING == *manpage=x10aux ]] && echo "<img src=./imgs/filefind.png width=25 height=25>")
		<td><span class=control_panel>Aux</table></button><br>

		<button class=control_panel_buttons type=button $([[ $QUERY_STRING == *manpage=x10rfxsensors ]] && echo "disabled")
		onclick=\"$(fstatus);show('manpage=x10rfxsensors')\">
		<table><tr><td width=20 height=25>
		$([[ $QUERY_STRING == *manpage=x10rfxsensors ]] && echo "<img src=./imgs/filefind.png width=25 height=25>")
		<td><span class=control_panel>RFXSensors</table></button><br>

		<button class=control_panel_buttons type=button $([[ $QUERY_STRING == *manpage=x10rfxmeters ]] && echo "disabled")
		onclick=\"$(fstatus);show('manpage=x10rfxmeters')\">
		<table><tr><td width=20 height=25>
		$([[ $QUERY_STRING == *manpage=x10rfxmeters ]] && echo "<img src=./imgs/filefind.png width=25 height=25>")
		<td><span class=control_panel>RFXMeters</table></button><br>

		<button class=control_panel_buttons type=button $([[ $QUERY_STRING == *manpage=x10digimax ]] && echo "disabled")
		onclick=\"$(fstatus);show('manpage=x10digimax')\">
		<table><tr><td width=20 height=25>
		$([[ $QUERY_STRING == *manpage=x10digimax ]] && echo "<img src=./imgs/filefind.png width=25 height=25>")
		<td><span class=control_panel>Digimax</table></button><br>

		<button class=control_panel_buttons type=button $([[ $QUERY_STRING == *manpage=x10oregon ]] && echo "disabled")
		onclick=\"$(fstatus);show('manpage=x10oregon')\">
		<table><tr><td width=20 height=25>
		$([[ $QUERY_STRING == *manpage=x10oregon ]] && echo "<img src=./imgs/filefind.png width=25 height=25>")
		<td><span class=control_panel>Oregon</table></button><br>

		<button class=control_panel_buttons type=button $([[ $QUERY_STRING == *manpage=x10kaku ]] && echo "disabled")
		onclick=\"$(fstatus);show('manpage=x10kaku')\">
		<table><tr><td width=20 height=25>
		$([[ $QUERY_STRING == *manpage=x10kaku ]] && echo "<img src=./imgs/filefind.png width=25 height=25>")
		<td><span class=control_panel>Kaku</table></button><br>"

		else

		# Control Panel Main Menu
 	    	      if [[ ${Mobile_User_Active^^} != TRUE ]];then 
		echo "
	
		<button class=control_panel_buttons type=button onclick=\"$(fstatus); show('BasicUserConfig=css')\">
		<table><tr><td width=20><img src=./imgs/edit_user.png width=25 height=25> 
		<td><span class=control_panel>Interface Config</table></button><br>

		<button class=control_panel_buttons type=button onclick=\"$(fstatus); show('Action=X10Config')\">
		<table><tr><td width=20><img src=./imgs/OnLamp-icon.png width=25 height=25> 
		<td><span class=control_panel>Heyu Config</table></button><br>

		<button class=control_panel_buttons type=button onclick=\"$(fstatus); show('Action=X10sched')\">
		<table><tr><td width=20><img src=./imgs/macro.png width=25 height=25> 
		<td><span class=control_panel>Heyu Schedule</table></button><br>



	        <button class=control_panel_buttons type=button 
		onclick=\"$(fstatus); show('heyu_web_interface_version=${Heyu_web_interface_version/%=/}')\">
		<table><tr><td width=20><img src=./imgs/update3.png width=25 height=25><td><span class=control_panel>
		Updates</table></button><br>"
		

	
		
		if [[ -e ./CGI/cron_frontend.sh ]];then
		echo "<button class=control_panel_buttons type=button onclick=\"$(fstatus); show('Macro=Refresh')\">
		<table><tr><td width=20><img src=./imgs/cron.png width=25 height=25> 
		<td><span class=control_panel>Crontab</table></button><br>"
		fi

		echo "
		<button class=control_panel_buttons type=button onclick=\"$(fstatus); show('heyu_top')\">
		<table><tr><td width=20><img src=./imgs/top.png width=25 height=25> 
		<td><span class=control_panel>Top</table></button><br>
    
		<button class=control_panel_buttons type=button onclick=\"$(fstatus); show('heyu_music')\">
		<table><tr><td width=20><img src=./imgs/top.png width=25 height=25> 
		<td><span class=control_panel>Music Player</table></button><br>
		
		<button class=control_panel_buttons type=button onclick=\"$(fstatus); show('heyu_logs')\">
		<table><tr><td width=20><img src=./imgs/filefind.png width=25 height=25> 
		<td><span class=control_panel>Heyu Log</table></button><br>
		
		<button class=control_panel_buttons type=button onclick=\"$(fstatus); show('heyu_camera1')\">
		<table><tr><td width=20><img src=./imgs/scenes.png width=25 height=25> 
		<td><span class=control_panel>Camera</table></button><br>

		<button class=control_panel_buttons type=button onclick=\"$(fstatus); show('change_theme')\">
		<table><tr><td width=20><img src=./imgs/compact3.png width=25 height=25> 
		<td><span class=control_panel>Theme"
		[[ $heyu_theme == compact ]] && echo Default || echo Compact
		echo "</table></button><br>	
	
		<button class=control_panel_buttons type=button onclick=\"$(fstatus); show('exit')\" name=\"Exit\">
		<table><tr><td width=20>
		<img src=./imgs/alloff.png width=25 height=25><td><span class=control_panel>Exit</table></button>"

		 fi
			fi
		#Control Panel Bottom

		echo "<td class=control_panel valign=top align=center style=\"background:#CCC\">"
		
		 	  xstatus()
         {
                _addr_=$addr
                
                if [[ $addr == *,* ]];then
                    if [[ ${addr:0:4} != *,* ]];then
                        addr=${addr:0:2}
                    else
                        addr=${addr:0:3}
                    fi
                fi
                [[ $("$heyu" -c "${x10config}" enginestate) != 1 ]] && return
                
            
                state="$("$heyu" -c "${x10config}" onstate $addr)"
                raw_state="$state"
                state="${state//1/heyu_disable_}"
                state="${state//0/heyu_enable_}"
    
                if [[ -z $color ]];then 
                    echo $state
	            elif [[ $color == 0 ]];then 		
		            state="${state//heyu_disable_/On}"
		            state="${state//heyu_enable_/Off}" && echo "$state"     
	            elif [[ $color == 1 ]];then 
	                state="${state//heyu_disable_/<font class=info_on_color>On</font>}";
                    state="${state//heyu_enable_/<font class=info_off_color>Off</font>}" && 
	                echo "				$state"
	            elif [[ $color == 2 ]];then 
         	        if [[ ${heyu_show_all_modules^^} == TRUE ]];then
			            state="${state//heyu_disable_/background-color:green;}"
 			            state="${state//heyu_enable_/}" 
        		    else		
				        [[ ${Mobile_User_Active^^} == TRUE ]] && return		
				        state="${state//heyu_disable_/<img src=\"imgs/on2.png\" class=icons>}"
 				        state="${state//heyu_enable_/}" 
        	        fi
                    echo "$state"
                fi


         }
         
         
xinfo()
       {
                    _addr_=$addr
                
                    if [[ $addr == *,* ]];then
                        if [[ ${addr:0:4} != *,* ]];then
                            addr=${addr:0:2}
                        else
                            addr=${addr:0:3}
                        fi
                    fi
                    [[ $("$heyu" -c "${x10config}" enginestate) != 1 ]] && echo "<table class=buttons_dim><tr><td align=center><br><br><br></table>" && return
                
	            rawlevel=$(($("$heyu" -c "${x10config}" rawlevel $addr) / 10))
	            dimlevel=$("$heyu" -c "${x10config}" dimlevel $addr)
	            tstamp=$("$heyu" -c "${x10config}" show tstamp $addr)
	            tstamp=($tstamp) ; tstamp1="${tstamp[*]:3:2}," ; tstamp2=${tstamp[*]:2:1}
	            tstamp="$tstamp1 $tstamp2"
                time_stamp() { [[ ${Show_Time_Stamp^^} == TRUE ]] && echo "                              <br>$tstamp"  ; }
	            [[ $tstamp2 == has ]] && tstamp="Date: N/A"
	
                # Sensors
                
                source ./CGI/sensors.sh

                # Standard Button layout
	            echo " $_addr_ "
	            [[ ${Show_Power_Percentage^^} == TRUE		]] && echo "				$dimlevel&#37; Power"
	            [[ ${Show_Time_Stamp^^} == TRUE 			]] && echo "				<br>$tstamp"
	            [[ ${Show_Module_Type^^} == TRUE && -n ${Units[*]:3:1} ]] && echo "		<br>${units[*]:2:1}"
	            [[ ${Show_Module_Type^^} == TRUE && -z ${Units[*]:3:1} ]] && echo "		<br>&nbsp;"

	
       
       }
		
		show	
		
	
		if [[ ${HTTP_COOKIE,,} == *groupstatus\|on* && $QUERY_STRING == *heyugroup* || $QUERY_STRING == *\&heyugroup*  ]];then
		
		echo "</table>"
		

		while read -r f; do
			  
			  if [[ $QUERY_STRING == *heyugroup* ]];then
			     if [[ $QUERY_STRING == *\&* ]];then
			      string=${QUERY_STRING//heyugroup=}
			      string=${string,,}
			      string=${string//&/ }
			      string=($string)
			      string="${string[*]:2:1}"
			      
			     else 	      
			      
			      string=${QUERY_STRING//heyugroup=}
			      string=${string,,}	
			      
			      fi
			  fi

			  
		   
			   if [[ ${f,,} == *group=${string,,}* ]];then
			      
			      f=$f
			      f=($f)
			     
			      type=${f[*]:0:1}
			      addr=${f[*]:2:1}			      
			      label=${f[*]:1:1}
			      mod_type=${f[*]:3:1}
			      mod_type=${mod_type,,}
			   
		    
		  
                   # if [[ -z $z ]];then
                   #     echo "&nbsp;"        
		   #	        fi

		    if [[ ${type,,} == *scene* || ${type,,} == *usersyn* ]];then
		      if [[ $string == \*  ]];then
		    echo "<table class=button align=left><tr><td class=button>"
		     
		    else
		    scene=${f[*]:1:1}
		      echo "<table class=button align=left><tr><td class=button>"
                   	echo "<button type=button class=scene_button onclick=\"$(fstatus); show('do_scene=${scene}')\">
					<table class=scene_button><tr><td class=scene_button>
					<img src=\"imgs/scenes.png\" alt=none class=icons>
					${scene//_/ }</table></button>"
 		       fi
			    else
			    
		    Q=${QUERY_STRING//&/ }
		    Q=($Q)
		    Q=${Q[*]:2:1}
		    [[ -z $Q ]] && Q=$QUERY_STRING

                    echo "<table class=button align=left><tr><td class=button>"
                    echo "<button type=button class=scene_button onclick=\"Status(); show('Unit_$addr&$(xstatus)&$Q')\">"
                    echo "<table class=button><tr><td class=button>$(color=2;xstatus)&nbsp;${label//_/ } "
		     echo "<td class=info>$(color=3;xstatus)$(xinfo) <br></table></button>"	
					
			if [[ $mod_type == stdlm ]];then
				rawlevel="$("$heyu" -c "${x10config}" rawlevel $addr)"
				rawlevel=${rawlevel:0:2}
					
			if [[ $HTTP_COOKIE == *html_range=True* && ${Disable_HTML5^^} != TRUE ]];then
                           echo "<tr><td class=button><input type=range min=0 max=21 class=sliderfx value=\"$rawlevel\" step=1 onclick=\"Status(); show('Unit_$addr&heyu_rheo_&' + value + '&$rawlevel')\">" 
                        
                        else
                            r1=$(($rawlevel - 3))
                            r2=$(($rawlevel + 3))
                            echo "<tr><td class=button><img src=./imgs/down.png class=pbi onclick=\"Status(); show('Unit_$addr&heyu_dim_&null&$rawlevel')\">
                            <progress class=pb value=\"$rawlevel\" max=21></progress><img src=./imgs/up.png class=pbi onclick=\"Status(); show('Unit_$addr&heyu_bright_&null&$rawlevel')\">
                            "
                            
                        
                        fi	   
                    fi 
                    fi
                    echo "<tr><td class=button></table>"  
                    
                    ((z++))                
                    if [[ $z == 2 ]];then
                        echo "&nbsp;"
                        z=0          
			        fi                                
			    fi		    
			done < "$x10config"   
		
		echo "		</table>"
		
		
		
		
		fi
		
		echo "</textarea><br><br><table><tr><td>"
		

	       [[ $QUERY_STRING == *heyu_basicuserconfig_submit=Save || $QUERY_STRING == *BasicUserConfig* ]] && var=heyu_BasicUserConfig

	        #if [[ $QUERY_STRING == *heyu_userconfig_submit=Save || $QUERY_STRING == *Action=UserConfig && ${Mobile_User_Active^^} != TRUE ]];then
		#			echo "<button class=control_panel_buttons type=button 
		#		onclick=\"$(fstatus);show('Action=BasicUserConfig')\">
		#		<table>
		#		<td><span class=control_panel>Normal Mode</table></button>"
		#fi
		

		if [[ $QUERY_STRING == *Action=X10Config*      ||
		      $QUERY_STRING == *Action=X10sched*       || 
		      $QUERY_STRING == *Action=Config*         ||
		      $QUERY_STRING == *sched_submit=Save*     ||
		      $QUERY_STRING == *config_submit=Save*    ||
		      $QUERY_STRING == *UserConfig*            ||
		      $QUERY_STRING == *x10config_submit=Save* 	
		   ]];then 
	
		echo "
		<button class=userconfigbutton type=submit name=${var}_submit value=Save onclick=\"$(fstatus);show(null)\"> 
		Save</button>"
		
		if [[ ${Mobile_User_Active^^} == TRUE ]];then
		echo "<button class=userconfigbutton type=button onclick=\"$(fstatus); show('exit')\" name=\"Exit\">
		Exit</button>
		</table></table>"
		html_footer
		exit
		fi	
		 if [[ ${QUERY_STRING,,} == *basicuserconfig=buttons || ${QUERY_STRING,,} == *show_time_stamp*userconfig_submit=save ]];then
		 echo "<tr><td><button type=button><table class=button>
				<tr><td class=button><img src=./imgs/on2.png align=left class=icons>
				Example<td class=info>
				A1 $(example)</table></button>"
		 fi
		
		echo "
		</table></table>"
		fi  
		
	html_footer
   exit  

## End Control Panel

