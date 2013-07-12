#!/usr/bin/env bash
set -f

# Author: 	Kris Beazley
# Online: 	http://heyu.epluribusunix.net/
# Online email: http://heyu.epluribusunix.net/?contactus



source ./CGI/header.sh

echo Content-type:text/html
echo


source ./CGI/alerts.sh

#### HTML / CSS / Javascript

echo "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/1998/REC-html40-19980424/loose.dtd\">
<html><head><title>Heyu Web Interface v.$Heyu_web_interface_version</title>"


[[ ${Mobile_User_Active^^} == TRUE ]] && heyu_css=$mobile_css
echo "<style type=text/css>
@import url($heyu_css);
@import url(tinyboxstyle.css);
textarea {
	width: $ctaw;
	height: $ctah;
}
</style>"

 echo '
        <script type=text/javascript>
        var testrange=document.createElement("input")
        testrange.setAttribute("type", "range")
        if (testrange.type=="range"){ 
        document.cookie = "html_range=True; expires=01-Jan-2036 12:00:00 GMT";}
         </script>
       '

echo "
<script type=text/javascript>refreshInterval=setInterval('ajax_update()', $(($hrr * 1000)));</script>
<script type=text/javascript src=heyu_javascripts/ajax.js></script>
<script type=text/javascript src=heyu_javascripts/phone.js></script>
<script type=text/javascript src=heyu_javascripts/progressbar.js></script>
<script type=text/javascript src=heyu_javascripts/compact_theme.js></script>
<script type=text/javascript src=heyu_javascripts/packed.js></script>
<meta name=\"viewport\" content=\"width=device-width\">
<META HTTP-EQUIV=\"Content-Type\" content=\"text/html;charset=utf-8\">
<META HTTP-EQUIV=\"CACHE-CONTROL\" CONTENT=\"NO-CACHE\">
<META HTTP-EQUIV=\"Pragma\" CONTENT=\"no-cache\">
<META HTTP-EQUIV=\"Expires\" CONTENT=\"-1\">"



echo "</head>"   
	page_refresh

if [[ ${Mobile_User_Active^^} == TRUE ]]; then 
	echo "	<body onload=\"hideURLbar();$(frefresh)\" >
		<div id=\"progress\" class=\"hide\">Please Wait</div><script>PhoneProgress()</script>"
		else 
	echo "	<body onload=\"$(frefresh)\" >
		<div id=progress class=hide><img src=imgs/loading2.gif alt=none>  Please Wait</div>"
fi

	echo "<div id=content>"
	
	
	# Check if file has been modified 
	# Read the unmodified contents for x10config and x10sched into a temporary var
	[[ -e $x10sched  ]] && tmpsched=$(<$x10sched)
	[[ -e $x10config ]] && tmpconfig=$(<$x10config)
	
	
	#### Save Web Config Info
  	[[ $QUERY_STRING == *heyu_config_submit=Save ]] && QUERY_STRING=${QUERY_STRING//config=} && echo -e "${QUERY_STRING//&heyu_config_submit=Save/}" > ./overrides 

	#### Save x10 config Info
 	 [[ $QUERY_STRING == *x10config_submit=Save ]] && QUERY_STRING=${QUERY_STRING//config=} && echo -e "${QUERY_STRING//&x10config_submit=Save/}" > "$x10config"

	#### Save x10 schedule Info
 	 [[ $QUERY_STRING == *x10sched_submit=Save ]] && QUERY_STRING=${QUERY_STRING//config=} && echo -e "${QUERY_STRING//&x10sched_submit=Save/}" > "$x10sched"

	
	# Read the contents of x10config and x10sched into a another temporary var to test modification 
	[[ -e $x10sched  ]] &&  tmpsched2=$(<$x10sched)  
	[[ -e $x10config ]] &&  tmpconfig2=$(<$x10config)

	# Test the two vars for modifications and alert with tinybox javascript
	 if [[ ${tmpsched2} != ${tmpsched}  ]];then
	 echo "<script type=\"text/javascript\">var content = \"<table align=center><tr><td valign=top><img src=imgs/OnLamp-icon.png><td valign=top>x10sched file must be uploaded for changes to take effect.<br>This window will close automatically.</table>\";TINY.box.show(content,0,0,0,0,5);</script>"
	 fi	
 	 if [[ ${tmpconfig2//\[} != ${tmpconfig//\[} ]];then
	 echo "<script type=\"text/javascript\">var content = \"<table align=center><tr><td valign=top><img src=imgs/OnLamp-icon.png><td valign=top>Heyu must be restarted for changes to take effect.<br>This window will close automatically.</table>\";TINY.box.show(content,0,0,0,0,5);</script>" 
	 fi

	 # Fix for auto_refresh reading QUERY_STRINGs in the URL
	   [[ ${auto_refresh^^} == TRUE && $QUERY == BasicUserConfig=css && ${heyu_theme,,} != compact ]] && unset QUERY_STRING




# Housecode and Unit assignment

if [[ $QUERY_STRING != *Macro* ]];then

		if [[ $QUERY_STRING == do_scene* ]];then
			do_scene=${QUERY_STRING//do_scene=/}
			do_scene=${do_scene/=/}
			"$heyu" -c "${x10config}" "${do_scene}"
			unset QUERY_STRING
		fi

	[[ $QUERY_STRING == *heyu_enable_all_units*  ]] && "$heyu" -c "${x10config}" allon $Default_House_Code && unset QUERY_STRING
	[[ $QUERY_STRING == *heyu_disable_all_units* ]] && "$heyu" -c "${x10config}" alloff $Default_House_Code && unset QUERY_STRING

		unit="${QUERY_STRING//&/ }"
		unit=($unit)
		unit=${unit//Unit_/}
		unit="${unit[0]}"	
		

	[[ $QUERY_STRING == *kill_all_hc* 	]] && "$heyu" -c "${x10config}" kill_all_hc
	[[ $QUERY_STRING == *heyu_disable_* 	]] && "$heyu" -c "${x10config}" off $unit 
	[[ $QUERY_STRING == *heyu_enable_* 	]] && "$heyu" -c "${x10config}" on $unit

	if [[ $QUERY_STRING == *heyu_rheo_* ]];then
	[[ ${unit[2]} -gt ${unit[3]} ]] && "$heyu" -c "${x10config}" bright $unit $((${unit[2]} - ${unit[3]}))
	[[ ${unit[2]} -lt ${unit[3]} ]] && "$heyu" -c "${x10config}" dim $unit $((${unit[3]} - ${unit[2]}))
	fi
	
	

	[[ $QUERY_STRING == *heyu_dim_*		]] && "$heyu" -c "${x10config}" dim $unit 3
	[[ $QUERY_STRING == *heyu_bright_* 	]] && "$heyu" -c "${x10config}" bright $unit 3


fi


	 # Test for QUERY_STRING parameters that match Control Panel and source the control_panel.sh if true
	
     
    if  [[ $QUERY_STRING != *Macro* ]] && 
		 [[   $QUERY_STRING == *Action=Config*   	    || 	$QUERY_STRING == *submit=Save*     		         || 
		 ${QUERY_STRING,,} == *heyu_camera* 		    ||   ${QUERY_STRING^^} == *X10CONFIG* 		         ||	
		 ${QUERY_STRING^^} == *X10SCHED*       		    || 	$QUERY_STRING == *heyu_help* 			         || 	
		 $QUERY_STRING == *heyu_top* 			    || 	$QUERY_STRING == *cp_options*   		         ||  
		 $QUERY_STRING == *heyu_restart* 		    || 	$QUERY_STRING == *Interface_=Info            	  	 ||
		 $QUERY_STRING == *heyu*cmd*           	            ||   ${QUERY_STRING,,} == *basicuserconfig*          	 || 
		 -z $HTTP_COOKIE 				    || 	$QUERY_STRING == *heyu_reload*  	 		 ||      
	         $QUERY_STRING == *manpage*	                    ||   $QUERY_STRING == *heyu_music*                  	 ||     
	         $QUERY_STRING == *heyu_web_interface_version*             
 	  ]]
		then			
			[[ -e ./CGI/control_panel.sh ]] && source ./CGI/control_panel.sh
		return
	fi
	
	macro() 
{ 
	if [[ -e ./CGI/cron_frontend.sh ]];then
		source ./CGI/cron_frontend.sh	
	else
		echo "Error: cron_frontend.sh not found.<br><a href=/>Exit</a>"
	
	fi
	exit
}

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
                
	            rawlevel=$("$heyu" -c "${x10config}" rawlevel $addr)
	            #rawlevel=${rawlevel:0:-1} # Why do we need this?
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
 top_buttons() {
 
	    echo "<button type=button class=scene_button onclick=\"$(fstatus); show('BasicUserConfig=css')\"><table class=scene_button><tr><td class=scene_button><img src=\"imgs/tool.png\" alt=none class=icons>Control Panel</table></button>"
	    echo "<button type=button class=scene_button onclick=\"$(fstatus); show('')\"><table class=scene_button><tr><td class=scene_button><img src=\"imgs/scenes.png\" alt=none class=icons>Groups</table></button>"

	        }
	        
if [[ ${QUERY_STRING,,} != *macro* && ${HTTP_COOKIE,,} == *groupstatus\|on* && $QUERY_STRING == *heyugroup* || $QUERY_STRING == *\&heyugroup*   ]];then
	
		top_buttons



		while read -r f; do
			  
			  if [[ $QUERY_STRING == *heyugroup* ]];then
			     if [[ $QUERY_STRING == *\&* ]];then
			      
			      string=${QUERY_STRING}
			      string=${string,,}
			      string=${string//&/ }
			      string=($string)
			         for i in ${string[*]}; do
			             [[ ${i,,} == heyugroup* ]] && string=${i//heyugroup=}
			         done
		      
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
			   

		    if [[ ${type,,} == *scene* || ${type,,} == *usersyn* ]];then
		      if [[ $string == \*  ]];then		    
		    echo  

		    else
		    scene=${f[*]:1:1}


                   	echo "<button type=button class=scene_button onclick=\"$(fstatus); show('do_scene=${scene}')\">
					<table class=scene_button><tr><td class=scene_button>
					<img src=\"imgs/scenes.png\" alt=none class=icons>
					${scene//_/ }</table></button>"
					
 		       fi
 		        
			    else
			    
		    Q=${QUERY_STRING//&/ }
		    Q=($Q)
		        for i in ${Q[*]}; do
		           [[ ${i,,} == heyugroup* ]] && Q=${i}
		        done
	
		    
		    
		    [[ -z $Q ]] && Q=$QUERY_STRING
		    echo "<table class=button align=left><tr><td class=button>"
                    echo "<button type=button class=scene_button onclick=\"Status(); show('Unit_$addr&$(xstatus)&$Q')\">"
                    echo "<table class=button><tr><td class=button>$(color=2;xstatus)&nbsp;${label//_/ } "
		     echo "<td class=info>$(color=3;xstatus)$(xinfo) <br></table></button>"	
					
			if [[ $mod_type == stdlm ]];then
				rawlevel="$("$heyu" -c "${x10config}" rawlevel $addr)"				
				rawlevel=${rawlevel:0:-1}
				[[ -z $rawlevel ]] && rawlevel=0
			if [[ $HTTP_COOKIE == *html_range=True* && ${Disable_HTML5^^} != TRUE ]];then
                           echo "<tr><td class=button><input type=range min=0 max=21 class=sliderfx value=\"$rawlevel\" step=1 onclick=\"Status(); show('Unit_$addr&heyu_rheo_&' + value + '&$rawlevel&$Q')\">" 
                        
                        else
                            r1=$(($rawlevel - 3))
                            r2=$(($rawlevel + 3))
                            echo "<tr><td class=button><img src=./imgs/down.png class=pbi onclick=\"Status(); show('Unit_$addr&heyu_dim_&null&$rawlevel&$Q')\">
                            <progress class=pb value=\"$rawlevel\" max=21></progress><img src=./imgs/up.png class=pbi onclick=\"Status(); show('Unit_$addr&heyu_bright_&null&$rawlevel&$Q')\">"
                            
                          
                        fi	   
                    fi 
                    fi
                    echo "</table>"  
                    
                    ((z++))                
                    if [[ $z == 2 ]];then
                        echo "&nbsp;"
                        z=0          
			        fi                                
			    fi		    
			done < "$x10config"   

		echo "</table>"
	exit	
		
fi

if [[ ${QUERY_STRING,,} != *macro* && ${HTTP_COOKIE,,} && ${HTTP_COOKIE,,} == *groupstatus\|on* ]];then
	show() {
	        
	        top_buttons
		#echo "<button type=button class=scene_button onclick=\"$(fstatus); show('heyugroup=*')\"><table class=scene_button><tr><td class=scene_button><img src=\"imgs/scenes.png\" alt=none class=icons>All Groups</table></button>"
		echo "<button type=button class=scene_button onclick=\"$(fstatus); show('heyugroup=SCENE')\"><table class=scene_button><tr><td class=scene_button><img src=\"imgs/scenes.png\" alt=none class=icons>Scenes</table></button>"


	sub3cookie() {
	
	do_subs() {
	
	[[ $name == *Group1* && ${value,,} != "null"  && $value != "" ]] &&  echo "<button type=button class=scene_button onclick=\"$(fstatus); show('heyugroup=$value')\"><table class=scene_button><tr><td class=scene_button><img src=\"imgs/scenes.png\" alt=none class=icons>${value//_/ }</table></button>"
	[[ $name == *Group2* && ${value,,} != "null"  && $value != "" ]] &&  echo "<button type=button class=scene_button onclick=\"$(fstatus); show('heyugroup=$value')\"><table class=scene_button><tr><td class=scene_button><img src=\"imgs/scenes.png\" alt=none class=icons>${value//_/ }</table></button>"
	[[ $name == *Group3* && ${value,,} != "null"  && $value != "" ]] &&  echo "<button type=button class=scene_button onclick=\"$(fstatus); show('heyugroup=$value')\"><table class=scene_button><tr><td class=scene_button><img src=\"imgs/scenes.png\" alt=none class=icons>${value//_/ }</table></button>"
	[[ $name == *Group4* && ${value,,} != "null"  && $value != "" ]] &&  echo "<button type=button class=scene_button onclick=\"$(fstatus); show('heyugroup=$value')\"><table class=scene_button><tr><td class=scene_button><img src=\"imgs/scenes.png\" alt=none class=icons>${value//_/ }</table></button>"
	[[ $name == *Group5* && ${value,,} != "null"  && $value != "" ]] &&  echo "<button type=button class=scene_button onclick=\"$(fstatus); show('heyugroup=$value')\"><table class=scene_button><tr><td class=scene_button><img src=\"imgs/scenes.png\" alt=none class=icons>${value//_/ }</table></button>"
	[[ $name == *Group6* && ${value,,} != "null"  && $value != "" ]] &&  echo "<button type=button class=scene_button onclick=\"$(fstatus); show('heyugroup=$value')\"><table class=scene_button><tr><td class=scene_button><img src=\"imgs/scenes.png\" alt=none class=icons>${value//_/ }</table></button>"
	[[ $name == *Group7* && ${value,,} != "null"  && $value != "" ]] &&  echo "<button type=button class=scene_button onclick=\"$(fstatus); show('heyugroup=$value')\"><table class=scene_button><tr><td class=scene_button><img src=\"imgs/scenes.png\" alt=none class=icons>${value//_/ }</table></button>"
	[[ $name == *Group8* && ${value,,} != "null"  && $value != "" ]] &&  echo "<button type=button class=scene_button onclick=\"$(fstatus); show('heyugroup=$value')\"><table class=scene_button><tr><td class=scene_button><img src=\"imgs/scenes.png\" alt=none class=icons>${value//_/ }</table></button>"
	[[ $name == *Group9* && ${value,,} != "null"  && $value != "" ]] &&  echo "<button type=button class=scene_button onclick=\"$(fstatus); show('heyugroup=$value')\"><table class=scene_button><tr><td class=scene_button><img src=\"imgs/scenes.png\" alt=none class=icons>${value//_/ }</table></button>"
	[[ $name == *Group0* && ${value,,} != "null"  && $value != "" ]] &&  echo "<button type=button class=scene_button onclick=\"$(fstatus); show('heyugroup=$value')\"><table class=scene_button><tr><td class=scene_button><img src=\"imgs/scenes.png\" alt=none class=icons>${value//_/ }</table></button>"
 

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
	  show
      # exit
fi





[[ ${QUERY_STRING,,} != *macro* && ${HTTP_COOKIE,,} && ${HTTP_COOKIE,,} == *groupstatus\|on* ]] && exit     



 
	
############ Begin show all modules and Aliases

if [[ ${heyu_show_all_modules^^} == TRUE ]];then
	 echo "
	<table>
	<tr>
	<td class=top_show_all_button>
		<form method=post>
		<button id=refresh type=submit  onclick=\"$(fstatus); show('show_all_modules')\" name=show_all_modules>
			<table>
			<tr>
			<td class=top_show_all_button>

				Return to $heyu_theme view 

			</table>
		</button>
		</form>
	<td class=top_show_all_button>
		<button id=refresh type=button onclick=\"$(fstatus); show('')\">
			<table>
			<tr>
			<td class=top_show_all_button>
			
				Refresh 
		
			</table>
		</button>
	<td class=top_show_all_button>
		<button id=refresh type=button onclick=\"$(fstatus); show('kill_all_hc')\">
			<table>
			<tr>
			<td class=top_show_all_button>

			All Off A-P 
		
			</table>
		</button>
	<td class=top_show_all_button>
		<button id=refresh type=button onclick=\"$(fstatus); show('BasicUserConfig=css')\">
			<table>
			<tr>
			<td class=top_show_all_button>

			Control Panel
		
			</table>
		</button>
	</table>

	<table><tr>"	
	arr=({A..P})
		i=0
		while [[ $i -lt ${#arr[*]} ]]; do 
		
			echo "<td><button style=\"width:$Show_All_Modules_Width;Height:20;\" type=submit 
				onclick=\"$(fstatus); show('Unit_${arr[$i]}1-16&heyu_enable_')\">
				 <font size=1>All On ${arr[$i]}</font></button>"
		((i++))		
		done
	
	echo "<tr>"
	
	
	arr=({A..P})
		i=0
		while [[ $i -lt ${#arr[*]} ]]; do 
		
			echo "<td><button style=\"width:$Show_All_Modules_Width;Height:20;\" type=submit 
				onclick=\"$(fstatus); show('Unit_${arr[$i]}1-16&heyu_disable_')\">
				 <font size=1>All Off ${arr[$i]}</font></button>"
		((i++))		
		done

	echo "</form>"
fi



show_all_status()
{
[[ $("$heyu" -c "${x10config}" enginestate) != 1 ]] && return
[[ $b ]] && x=$b || x=$d
state="$("$heyu" -c "${x10config}" onstate $i$x)"
raw_state="$state"
state="${state//1/heyu_disable_}"
state="${state//0/heyu_enable_}"

if [[ -z $color ]];then 
  echo $state
	elif [[ $color == 2 ]];then 
         	if [[ ${heyu_show_all_modules^^} == TRUE ]];then
			state="${state//heyu_disable_/background-color:green;}"
 			state="${state//heyu_enable_/}" 
        	fi
        echo "$state"
fi

}




       
function_show_all_modules()
{

[[ -z $b ]] && b=1 
echo "<tr>"
for i in {A..P} ; do 
	while read -r Units; do 
	[[ -n $i && -n $b ]] && [[ ${Units^^} == ALIAS\ *\ ${i}${b}\ * || 
	${Units^^} == ALIAS\ *\ ${i}${b},* || ${Units^^} == ALIAS\ *\ ${i}${b} ]] && 
	Units=($Units) && label="${Units[*]:1:1}" && m=${Units[*]:2:1} && vl=1; 
	done <"$x10config"      
   
echo "<td nowrap width=$Show_All_Modules_Width Height=$Show_All_Modules_Height valign=top>
<form method=post><button style=\"width:$Show_All_Modules_Width;Height:$Show_All_Modules_Height;$(color=2;show_all_status)\" type=button onclick=\"$(fstatus); show('Unit_${i}$([[ -n ${m:(2)} ]] && echo "${m:(1)}" || echo "$x")&${label// /}&$(show_all_status)')\"><span class=info>${label/_/ }</b><br>$i $([[ -n ${m:(2)} ]] && echo "${m:(1)}" || echo "$x")</font></button></form>"

[[ $vl == 1 ]] && unset label && unset m
done

}      
       
function_show_aliases()
{
if [[ $heyu_theme == compact && $QUERY_STRING != *Macro* ]];then
echo "	<form method=post>
	<select name=states onChange=\"goPage(this.options[this.selectedIndex].value)\" size=1>
	<option>Heyu<optgroup label=ALIASES>"
	
		    while read -r units; do
			    if [[ $units == *alias* ]];then
			        units=${units//alias /}
			        units=($units)                    
                    label=${units[*]:0:1} 
                    addr=${units[*]:1:1}                    
                    mod_type=${units[*]:2:1}
                    mod_type=${mod_type,,}
                    echo "<option value=\"?Unit_$addr&$(xstatus)\">${label//_/ } --  $(color=1;xstatus)"
                 fi
                 done <<< "$("$heyu" -c "${x10config}" webhook config_dump)"
	echo "</optgroup>
	      <optgroup label=SCENES>"
	      
				while read -r units; do
				if [[ $units == *scene* || $units == *usersyn* ]];then
			        scene=${units//scene /}
			        scene=($scene)
			        scene=${scene[0]}
                   echo "<option value=\"?do_scene=$scene\">${scene//_/ }"
                 fi
                 done <<< "$("$heyu" -c "${x10config}" webhook config_dump)"	

		echo "</optgroup>
			<optgroup label=CONFIG>
			<option value=?BasicUserConfig=css>Control Panel
			<option value=?heyu_enable_all_units>All Units On $Default_House_Code
			<option value=?heyu_disable_all_units>All Units Off $Default_House_Code
			<option value=?kill_all_hc>All Units Off A-P
			</optgroup>
			</select>
			</form>"
	    echo "<form method=post><button class=userconfigbutton type=button onclick=\"Status(); show('change_theme')\"> Change Theme</button></form>"
		
elif [[ $QUERY_STRING == *Macro* && -e ./CGI/cron_frontend.sh ]];then
echo "<form method=post>
<table border=0 align=center cellspacing=0 cellpadding=5>
<th><span>Heyu Web Interface Crontab Frontend</span></th>
<tr><td align=center valign=top><select name=Unit>
<option value=?Refresh>Select one...<option value=Refresh disabled></option>"

				while read -r units; do
			    if [[ $units == *alias* ]];then
			        units=${units//alias /}
			        units=($units)                    
                    label=${units[*]:0:1} 
                    addr=${units[*]:1:1}                    
                    mod_type=${units[*]:2:1}
                    mod_type=${mod_type,,}
                   echo "<option value=\"?Unit_$addr&$label&$(xstatus)\">$label$([[ $QUERY_STRING != *Macro* ]] && echo "--  $(color=1;status)")" 
                 fi
                 done <<< "$("$heyu" -c "${x10config}" webhook config_dump)"

    if [[ $QUERY_STRING == *Macro* && -e ./CGI/cron_frontend.sh ]];then echo "</option></table>" && return ;fi

else

#Options
	if [[ ${Mobile_User_Active^^} != TRUE ]]; then echo "	
	<h4 style=\"font-family:Tahoma\">HEYU WEB INTERFACE </h4>"
	fi	


	if [[ ${Mobile_User_Active^^} == TRUE  && ${Show_Menu^^} == TRUE ]]; then echo "
	<button type=button class=scene_button onclick=\"$(fstatus); clearInterval(refreshInterval); show('BasicUserConfig=sub3cookie')\">
	<table class=scene_button><tr><td class=scene_button>
	<img src=\"imgs/tool.png\" alt=none class=icons>
	Control Panel</table></button>"
	fi
	
	if [[ ${Mobile_User_Active^^} != TRUE ]]; then 
	    echo "<table><tr><td><form method=post>
	    <button type=button class=scene_button onclick=\"$(fstatus); show('BasicUserConfig=css')\">
	    <table class=scene_button><tr><td class=scene_button>
	    <img src=\"imgs/tool.png\" alt=none class=icons>
	    Control Panel</table></button>"

	    echo "
	    <button type=submit class=scene_button onclick=\"$(fstatus); show('show_all_modules')\" name=show_all_modules>
	    <table class=scene_button><tr><td class=scene_button>
	    <img src=\"imgs/horizon.png\" alt=none class=icons>
	    Show All Modules</table></button>"

	    echo "
	    <button id=refresh type=submit class=scene_button onclick=\"$(fstatus); show('auto_refresh')\" name=auto_refresh >
	    <table class=scene_button><tr><td class=scene_button>
	    <img src=./imgs/reload.png alt=none class=icons>
	    Auto Refresh"
	    [[ ${auto_refresh^^} == TRUE ]] && echo "( ${hrr}s )"
	    [[ ${auto_refresh^^} != TRUE ]] && echo "Off"
	    
	    echo "</table></button></form></table>"
	    
		
	fi
			
	#Scene / USERSYN 
	
	if   [[ ${Mobile_User_Active^^} == TRUE ]]; then echo 
	elif [[ ${Hide_Scenes^^} == TRUE ]]; then echo 
		else
			echo "<h4 style=\"font-family:Tahoma\">SCENES</h4>"	
	fi
	
	if   [[ ${Show_Scenes^^} != TRUE && ${Mobile_User_Active^^} == TRUE ]];  then echo 
	elif [[ ${Hide_Scenes^^} == TRUE ]]; then echo
		else
			while read -r units; do
				if [[ $units == *scene* || $units == *usersyn* ]];then
			        scene=${units//scene /}
			        scene=($scene)
			        scene=${scene[0]}
                   	echo "<button type=button class=scene_button onclick=\"$(fstatus); show('do_scene=${scene}')\">
					<table class=scene_button><tr><td class=scene_button>
					<img src=\"imgs/scenes.png\" alt=none class=icons>
					${scene//_/ }</table></button>"
                 fi
            done <<< "$("$heyu" -c "${x10config}" webhook config_dump)"

				echo "		</table>"
	fi
			
	#Aliases
   
	if [[ ${Mobile_User_Active^^} == TRUE && ${Show_Aliases^^} != TRUE ]];then return	
		else
			if [[ ${Mobile_User_Active^^} != TRUE ]];then 
				echo "
				<h4 style=\"font-family:Tahoma\">ALIASES</h4>"			  
			fi				
			
			while read -r units; do
			    if [[ $units == *alias* ]];then
			        units=${units//alias /}
			        units=($units)                    
                    label=${units[*]:0:1} 
                    addr=${units[*]:1:1}                    
                    mod_type=${units[*]:2:1}
                    mod_type=${mod_type,,}

                    if [[ -z $z ]];then
                        echo "&nbsp;"        
			        fi
                    echo "<table class=button align=left><tr><td class=button>"
                    echo "<button type=button class=scene_button onclick=\"Status(); show('Unit_$addr&$(xstatus)')\">"
                    echo "<table class=button><tr><td class=button>$(color=2;xstatus)&nbsp;${label//_/ } "
					echo "<td class=info>$(color=3;xstatus)$(xinfo) <br></table></button>"	
					
					if [[ $mod_type == stdlm && $("$heyu" -c "${x10config}" enginestate) == 1 ]];then
					    rawlevel="$("$heyu" -c "${x10config}" rawlevel $addr)"
					    rawlevel=${rawlevel:0:-1}
					    [[ -z $rawlevel ]] && rawlevel=0

					   
					    if [[ $HTTP_COOKIE == *html_range=True* && ${Disable_HTML5^^} != TRUE ]];then
                            echo "<tr><td class=button><input type=range  min=0 max=21 class=sliderfx value=\"$rawlevel\" step=1 onclick=\"Status(); show('Unit_$addr&heyu_rheo_&' + value + '&$rawlevel')\">" 
                        
                        else
                            r1=$(($rawlevel - 3))
                            r2=$(($rawlevel + 3))
                            echo "<tr><td class=button><img src=./imgs/down.png class=pbi onclick=\"Status(); show('Unit_$addr&heyu_dim_&null&$rawlevel')\">
                            <progress class=pb value=\"$rawlevel\" max=21></progress><img src=./imgs/up.png class=pbi onclick=\"Status(); show('Unit_$addr&heyu_bright_&null&$rawlevel')\">
                            </table>"
                        
                        fi	   
                    fi 
                    echo "<tr><td class=button></table>"  
                    
                    ((z++))                
                    if [[ $z == 2 ]];then
                        echo "&nbsp;"
                        z=0          
			        fi                                
			    fi		    
			    
			done <<< "$("$heyu" -c "${x10config}" webhook config_dump)"
		
		echo "		</table>"

	fi	

fi


[[ $QUERY_STRING != *Macro* ]] && html_footer
}
############ End show all modules and Aliases

if [[ $QUERY_STRING == *Macro* && -e ./CGI/cron_frontend.sh ]];then 
	function_show_aliases
	macro	
fi        


main()
{



if [[ ${heyu_show_all_modules^^} != TRUE ]];then
    function_show_aliases
	exit
else
    n=16
    x=1 
    while [[ $n -gt 0 ]]; do
        ((b++))
        function_show_all_modules
        ((n--))
        ((x++))
    done
fi


html_footer

}

main




