#!/usr/bin/env bash
set -f

# Author: 	Kris Beazley
# Online: 	http://heyu.epluribusunix.net/
# Online email: http://heyu.epluribusunix.net/?contactus


    ### Before we do anything check if bash is version 4* or greater
    if [[ -z $BASHPID ]];then 
	echo Content-type:text/html 
	echo 
	echo "<h1>Alert!</h1><hr> This script requires Bash 4* or greater.
	      <br>Download the latest version @ <a href=http://www.gnu.org/software/bash>http://www.gnu.org/software/bash</a>"
     	exit
    fi

    ### Current Version ###
    Heyu_web_interface_version="11.59.7_beta"

    ### Simple URL decoder
    ### Normally QUERY_STRING only uses GET data
    ### Using a simple temporary var to test STDIN we can let QUERY_STRING use GET or POST data 

    ### Assign GET to temporary var
	QUERY=$QUERY_STRING
	

    ### Cat STDIN (POST METHOD) to QUERY_STRING 	
	QUERY_STRING="$(cat)"


    ### If POST METHOD is NULL then reassign QUERY_STRING to GET method temporary var
        [[ -n $QUERY_STRING ]] && unset QUERY
	[[ -z $QUERY_STRING ]] && QUERY_STRING=$QUERY
    

    ### Take the url encoded strings and decode them.

	decode="${QUERY_STRING}"
	decode="${decode//%95/}"
	decode="${decode//%C2/}"
	decode="${decode//%20/ }"
	decode="${decode//%09/}"
	decode="${decode//%3C/<}"
	decode="${decode//%2F//}"
	decode="${decode//%3E/>}"
	decode="${decode//%26/&}"
	decode="${decode//+/ }"
	decode="${decode//%7E/~}"
	decode="${decode//%60/\`}"
	decode="${decode//%21/!}"
	decode="${decode//%40/@}"
	decode="${decode//%23/#}"
	decode="${decode//%24/$}"
	decode="${decode//%25/%}"
	decode="${decode//%5E/^}"
	decode="${decode//%2A/*}"
	decode="${decode//%28/(}"
	decode=${decode//%B4/\'}
	#' Some wysiwg editors go nuts with quotes
	decode="${decode//%29/)}"
	decode="${decode//%2D/-}"
	decode="${decode//%2B/+}"
	decode="${decode//%7C/|}"
	decode="${decode//%5C/\\}"
	decode="${decode//%5B/[}"
	decode="${decode//%5D/]}"
	decode="${decode//%3A/:}"
	decode="${decode//%3B/;}"
	decode="${decode//%3F/?}"
	decode="${decode//%2C/,}"
	decode="${decode//%0A/}"
	decode=${decode//%27/\'}
	decode="${decode//%22/\"}"
	decode="${decode//%3D/=}"
	decode="${decode//%0D/\n}"
	decode=${decode//%7D/\}}
	decode="${decode//%7B/{}"

	# ISO 8859-1 Symbol Entities 
	decode="${decode//%A9/&copy;}"
	decode="${decode//%A0/nbsp;}"
	decode="${decode//%95/&bull;}"
	decode="${decode//%99/&trade;}"


	Decoded_QUERY_STRING="${decode/%=/}"
	
        QUERY_STRING=$Decoded_QUERY_STRING
	  

	### Cookie Function(s)

	#if [[ -z $HTTP_COOKIE ]];then
	#  alert_user=true
	#  fi

     [[ $HTTP_COOKIE == *heyu* && $HTTP_COOKIE != *Interface_version* 	]] && alert_user=true		
	
   expires="expires=01-Jan-2036 12:00:00 GMT"
   	
   # Only store necessary cookies
   [[ $HTTP_COOKIE != *Interface_version* 		]] && echo "Set-Cookie: Interface_version=$Heyu_web_interface_version; $expires"
   [[ $HTTP_COOKIE != *heyu_show_all_modules* 		]] && echo "Set-Cookie: heyu_show_all_modules=False" 		&& show_all_modules=False
   [[ $HTTP_COOKIE != *heyu_theme*  			]] && echo "Set-Cookie: heyu_theme=default" 			&& heyu_theme=default
   [[ $HTTP_COOKIE != *auto_refresh* 			]] && echo "Set-Cookie: auto_refresh=False" 			&& auto_refresh=False	 
   [[ $HTTP_COOKIE != *heyu_css*			]] && echo "Set-Cookie: heyu_css=heyu_style.css; $expires" 	&& heyu_css=heyu_style.css
   [[ $HTTP_COOKIE != *Control_Panel_Text_Area_Height* 	]] && echo "Set-Cookie: Control_Panel_Text_Area_Height=400px; $expires"
   [[ $HTTP_COOKIE != *Control_Panel_Text_Area_Width* 	]] && echo "Set-Cookie: Control_Panel_Text_Area_Width=650px; $expires"


   [[ $HTTP_COOKIE != *sub0cookie* ]] && echo "Set-Cookie: sub0cookie=heyu|/usr/local/bin/heyu^x10config|./x10config^x10sched|./x10.sched^sched_report|./report.txt^hrr|10^; $expires"
	
   [[ $HTTP_COOKIE != *sub1cookie* ]] && echo "Set-Cookie: sub1cookie=Show_All_Modules_Width|70px^Show_All_Modules_Height|70px^Show_Power_Percentage|True^Show_On_Off_Status|True^Show_Time_Stamp|True^Show_Module_Type|False^; $expires"

   [[ $HTTP_COOKIE != *sub2cookie* ]] && echo "Set-Cookie: sub2cookie=All_Modules_Auto_Refresh|False^Hide_Scenes|False^Debug_SCRIPT|True^Disable_HTML5|False^; $expires"

   [[ $HTTP_COOKIE != *sub3cookie* ]] && echo "Set-Cookie: sub3cookie=GroupStatus|Off^Group1|Master^Group2|Living_Room^Group3|Landscape^Group4|Garage^Group5|Irrigation^Group6|Pool^Group7|Basement^Group8|Null^Group9|Null^Group0|Null^; $expires"

		      arr=($HTTP_COOKIE)
				while [[ $i -lt ${#arr[*]} ]]
				do	
					cookies=${arr[$i]}					
					cookies=${cookies/=/ }
					cookies=(${cookies})
					name=${cookies[0]}
					value=${cookies[1]}
					[[ $HTTP_COOKIE == *$name* && $value ]] && export $name=${value//;/ }
					((i++))
			done 
			unset i
	
			
			for cookie in $HTTP_COOKIE ; do
						if [[ $cookie == *sub0cookie* ]];then
						cookie=${cookie//sub0cookie=}
						cookie=${cookie//^/ }
						cookie=${cookie//|/=}
						export ${cookie//;/ }
						fi
						if [[ $cookie == *sub1cookie* ]];then
						cookie=${cookie//sub1cookie=}
						cookie=${cookie//^/ }
						cookie=${cookie//|/=}
						export ${cookie//;/ }
						fi
						if [[ $cookie == *sub2cookie* ]];then
						cookie=${cookie//sub2cookie=}
						cookie=${cookie//^/ }
						cookie=${cookie//|/=}							
						export ${cookie//;/ }
						fi
						if [[ $cookie == *sub3cookie* ]];then
						cookie=${cookie//sub3cookie=}
						cookie=${cookie//^/ }
						cookie=${cookie//|/=}
						export ${cookie//;/ }
						fi
				done

	
			# Cookies the User can control w/ a button
       			[[ $QUERY_STRING == show_all_modules && ${heyu_show_all_modules,,} == false ]] && 
			echo "Set-Cookie: heyu_show_all_modules=True; $expires" && heyu_show_all_modules=True && unset QUERY_STRING
       			[[ $QUERY_STRING == show_all_modules && ${heyu_show_all_modules,,} == true  ]] &&  
           		echo "Set-Cookie: heyu_show_all_modules=False; $expires" && heyu_show_all_modules=False	&& unset QUERY_STRING 

       			[[ $QUERY_STRING == auto_refresh && ${auto_refresh,,} == false ]] && 
          		echo "Set-Cookie: auto_refresh=True; $expires" && auto_refresh=True && unset QUERY_STRING
       			[[ $QUERY_STRING == auto_refresh && ${auto_refresh,,} == true  ]] &&  
           		echo "Set-Cookie: auto_refresh=False; $expires" && auto_refresh=False && unset QUERY_STRING

			[[ $QUERY_STRING == change_theme && ${heyu_theme,,} == default ]] && 
          		echo "Set-Cookie: heyu_theme=compact; $expires" && heyu_theme=compact && unset QUERY_STRING
       			[[ $QUERY_STRING == change_theme && ${heyu_theme,,} == compact ]] && 
           		echo "Set-Cookie: heyu_theme=default; $expires" && heyu_theme=default && heyu_redirect=1 && unset QUERY_STRING

			
			# Reassign textarea cookies with new shorter value names
		
			ctah=$Control_Panel_Text_Area_Height
			ctaw=$Control_Panel_Text_Area_Width


	
	###  This is the POST contents of the User Configuration 

	if [[ $QUERY_STRING == *heyu_userconfig_submit=Save || $QUERY_STRING == *BasicUserConfig_submit=Save ]];then
		COOKIE_QUERY_STRING=${QUERY_STRING// /=}
		COOKIE_QUERY_STRING=${COOKIE_QUERY_STRING//&/\\n}
		COOKIE_QUERY_STRING=${COOKIE_QUERY_STRING//\\n/ }
		arr=($COOKIE_QUERY_STRING)
		
		while [[ $i -lt ${#arr[*]} ]]
			do	
					cookies=${arr[$i]}					
					cookies=${cookies/=/ }
					cookies=(${cookies})
					name=${cookies[0]}
					value=${cookies[1]}
		
		value=${value//=}
		if [[ $name == *sub0cookie* ]];then 
			export ${name//sub0cookie_}=${value}			
			sub0cookie_subvalue="${name//sub0cookie_}|${value}^"
			sub0cookie_subvalue+=($sub0cookie_subvalue)
			
		fi
		if [[ $name == *sub1cookie* ]];then 
			export ${name//sub1cookie_}=${value}			
			sub1cookie_subvalue="${name//sub1cookie_}|${value}^"
			sub1cookie_subvalue+=($sub1cookie_subvalue)
			
		fi
		if [[ $name == *sub2cookie* ]];then 
			export ${name//sub2cookie_}=${value}			
			sub2cookie_subvalue="${name//sub2cookie_}|${value}^"
			sub2cookie_subvalue+=($sub2cookie_subvalue)
			
		fi
		if [[ $name == *sub3cookie* ]];then 
			export ${name//sub3cookie_}=${value}			
			sub3cookie_subvalue="${name//sub3cookie_}|${value}^"
			sub3cookie_subvalue+=($sub3cookie_subvalue)
			
		fi


	[[ $HTTP_COOKIE == *$name* ]] && echo "Set-Cookie: $name=${value//=/} ; $expires"  && export $name=${value//=/}

			ctah=$Control_Panel_Text_Area_Height
			ctaw=$Control_Panel_Text_Area_Width
					
			((i++))
		done 
		unset i
			if [[ $sub0cookie_subvalue ]];then
			i=1
			while [[ $i -lt ${#sub0cookie_subvalue[*]} ]]; do
			sub0cookie_subvalue=${sub0cookie_subvalue[$i]}
			subvaluefix+=($sub0cookie_subvalue)
			((i++))
			done
			subvaluefix=${subvaluefix[*]}
			subvaluefix=${subvaluefix// }
			echo "Set-Cookie: sub0cookie=$subvaluefix ; $expires" 
			unset i			
			fi

			if [[ $sub1cookie_subvalue ]];then
			i=1
			while [[ $i -lt ${#sub1cookie_subvalue[*]} ]]; do
			sub1cookie_subvalue=${sub1cookie_subvalue[$i]}
			subvaluefix+=($sub1cookie_subvalue)
			((i++))
			done
			subvaluefix=${subvaluefix[*]}
			subvaluefix=${subvaluefix// }
			echo "Set-Cookie: sub1cookie=$subvaluefix ; $expires" 
			unset i			
			fi

			if [[ $sub2cookie_subvalue ]];then
			i=1
			while [[ $i -lt ${#sub2cookie_subvalue[*]} ]]; do
			sub2cookie_subvalue=${sub2cookie_subvalue[$i]}
			subvaluefix+=($sub2cookie_subvalue)
			((i++))
			done
			subvaluefix=${subvaluefix[*]}
			subvaluefix=${subvaluefix// }
			echo "Set-Cookie: sub2cookie=$subvaluefix ; $expires" 
			unset i			
			fi

			if [[ $sub3cookie_subvalue ]];then
			i=1
			while [[ $i -lt ${#sub3cookie_subvalue[*]} ]]; do
			sub3cookie_subvalue=${sub3cookie_subvalue[$i]}
			subvaluefix+=($sub3cookie_subvalue)
			((i++))
			done
			subvaluefix=${subvaluefix[*]}
			subvaluefix=${subvaluefix// }
			echo "Set-Cookie: sub3cookie=$subvaluefix ; $expires" 
			unset i			
			fi		

	fi

	### End New Cookie Function

# Read config for overrides.
while read -r config
	do 
	
	[[ $config == path_to_heyu*		]] && heyu=(${config/path_to_heyu /})
	[[ $config == path_to_x10config* 	]] && x10config=(${config/path_to_x10config /})
	[[ $config == path_to_x10sched*		]] && x10sched=(${config/path_to_x10sched /})
	[[ $config == path_to_report.txt* 	]] && sched_report=(${config/path_to_report.txt /})
	[[ $config == heyu_refresh_rate* 	]] && hrr=(${config/heyu_refresh_rate /})

	[[ $config == Hide_Scenes* 		]] && Hide_Scenes=(${config/Hide_Scenes /})
	[[ $config == Debug_SCRIPT* 		]] && Debug_SCRIPT=(${config/Debug_SCRIPT /})
    [[ $config == Disable_HTML5* 		]] && Disable_HTML5=(${config/Disable_HTML5 /})
	[[ $config == Show_All_Modules_Width* 	]] && Show_All_Modules_Width=(${config/Show_All_Modules_Width /})
	[[ $config == Show_All_Modules_Height* 	]] && Show_All_Modules_Height=(${config/Show_All_Modules_Height /})
	[[ $config == Show_Power_Percentage*	]] && Show_Power_Percentage=(${config/Show_Power_Percentage /})
	[[ $config == Show_On_Off_Status* 	]] && Show_On_Off_Status=(${config/Show_On_Off_Status /})
	[[ $config == Show_Time_Stamp*		]] && Show_Time_Stamp=(${config/Show_Time_Stamp /})
	[[ $config == Show_Module_Type* 	]] && Show_Module_Type=(${config/Show_Module_Type /})
	[[ $config == heyu_css* 		]] && heyu_css=(${config/heyu_css /})
	[[ $config == heyu_show_all_modules* 	]] && heyu_show_all_modules=(${config/heyu_show_all_modules /})
	[[ $config == heyu_theme* 		]] && heyu_theme=(${config/heyu_theme /})
	[[ $config == auto_refresh* 		]] && auto_refresh=(${config/auto_refresh /})
	[[ $config == Screen_Height* 		]] && ctah=(${config/Screen_Height /})
	[[ $config == Screen_Width* 		]] && ctaw=(${config/Screen_Width /})
	[[ $config == All_Modules_Auto_Refresh* ]] && All_Modules_Auto_Refresh=(${config/All_Modules_Auto_Refresh /})

	config=${config,,}
	[[ $config == user_agent_override*      ]] && user_agent_override=(${config/user_agent_override /}) && export user_agent_override=${user_agent_override[*]}

done <./overrides

# On initial startup cookies are null which may cause certain problems so we assign them temporary values
[[ -z $Debug_SCRIPT		]] && Debug_SCRIPT=True
[[ -z $Disable_HTML5    ]] && Disable_HTML5=False
[[ -z $Show_Power_Percentage 	]] && Show_Power_Percentage=True
[[ -z $Show_On_Off_Status   	]] && Show_On_Off_Status=True
[[ -z $Show_Time_Stamp 	  	]] && Show_Time_Stamp=True
[[ -z $Show_Module_Type 	]] && Show_Module_Type=False
[[ -z $heyu 			]] && heyu=/usr/local/bin/heyu
[[ -z $x10config 		]] && x10config=./x10config
[[ -z $x10sched			]] && x10sched=./x10.sched
[[ -z $sched_report		]] && sched_report=./report.txt
[[ -z $hrr			]] && hrr=10

   

    ### Check if TTY's are owned by us.
    while read -r config
	do
	[[ ${config} == TTY_AUX\ * ]] && TTY_AUX=(${config/TTY_AUX /}) && TTY_AUX=${TTY_AUX/\/dev\/}
	[[ ${config} == TTY\ * ]] && TTY=(${config/TTY /}) && TTY=${TTY/\/dev\/}
	done <"$x10config"
	[[ -z $TTY_AUX ]] && TTY_AUX=heyu_empty_aux_variable
	[[ -z $TTY     ]] && TTY=heyu_empty_tty_variable

    ### Create heyu list array and export to ENV ###
	hla+=($("$heyu" -c "${x10config}" list))
	for list in ${hla[*]};do
		export $list
	done
    	
    ### If HouseCode is set in x10config we give it priority from previous versions of heyu web interface
    while read -r config
	do
	[[ $config == HOUSECODE\ * ]] && Default_House_Code=(${config/HOUSECODE/})
	done <"$x10config"

    ### Because we need a default house code
    [[ -z $Default_House_Code ]] && Default_House_Code=A
    
    ### Set Temp Scale for Oregon sensors if defined else set to default Celsius
    while read -r config
	do
	[[ ${config^^} == ORE_TSCALE\ * ]] && ORE_TSCALE=(${config/ORE_TSCALE/})
	done <"$x10config"
    
    [[ -z $ORE_TSCALE ]] && ORE_TSCALE=C

    ### Set Temp Scale for RFX sensors if defined else set to default Celsius
    while read -r config
	do
	[[ ${config^^} == RFX_TSCALE\ * ]] && RFX_TSCALE=(${config/RFX_TSCALE/})
	done <"$x10config"
    
    [[ -z $RFX_TSCALE ]] && RFX_TSCALE=C

    ### Include heyu in our usr path ###
    PATH=${PATH}:${heyu//heyu/}
    

html_footer() { echo "	
	       </div>
	</body>

</html>";}

page_refresh() { [[ $heyu_redirect ]] && echo '<meta http-equiv="refresh" content="0;url=/"' ; }

# Hide the popup status
fstatus() { [[ ${Mobile_User_Active^^} == TRUE && ${Hide_Status_Popup^^} == TRUE ]] && echo || echo 'Status()' ; }

# Set refresh for mobile device
frefresh() { 
if [[ ${heyu_show_all_modules,,} == true && ${All_Modules_Auto_Refresh,,} != true && ${auto_refresh^^} == TRUE ]];then 
	echo 'clearInterval(refreshInterval);' 
elif [[ ${Mobile_User_Active^^} == TRUE && ${auto_refresh^^} == TRUE && $QUERY_STRING != *BasicUserConfig_submit=Save ]];then 
	echo '" id="refresh'
else    echo ''
fi
}  

if [[ $QUERY_STRING == *Reset_Cookies* ]];then
		
		arr=($HTTP_COOKIE)		
		while [[ $i -lt ${#arr[*]} ]]
			do	
				cookies=${arr[$i]}					
				cookies=${cookies/=/ }
				cookies=(${cookies})
				name=${cookies[0]}
				value=${cookies[1]}

	[[ $HTTP_COOKIE == *$name* ]] && echo "Set-Cookie: $name=$value"
				
			((i++))
		done 
		unset i
		unset arr
	fi

source ./CGI/User_Agent_Overrides.sh

# Modify the HTTP_COOKIE header this way because we need keep the values separated.
export HTTP_COOKIE=${HTTP_COOKIE//;/; }

