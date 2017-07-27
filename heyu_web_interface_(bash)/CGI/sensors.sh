#!/usr/bin/env bash
set -f

# Author: 	Kris Beazley
# Copyright     2014 
# Online: 	http://heyu.epluribusunix.net/
# Online email: http://heyu.epluribusunix.net/?contactus
# Licensed under the Apache License, Version 2.0 http://www.apache.org/licenses/LICENSE-2.0
# Much thanks to Cyril for his effort and contributions

# Housecode and Unit code = $addr
# ${mod_type} = lowercase

low_battery_msg() {	[[ $("$heyu" -c "${x10config}" lobatstate $addr) == 1 ]] && echo "LowBat" ; }
time_stamp() 	  { [[ ${Show_Time_Stamp^^} == TRUE ]] && echo "<br>$tstamp"  ; }

# BMB Electronic Smoke Alarm

        if [[ ${mod_type} == bmb* ]];then                                                    
		if [[ $("$heyu" -c "${x10config}" alertstate $addr) == 0 ]];then
                	echo "Clean"
		else
                	echo "Alarm"
		fi
	      low_battery_msg
              time_stamp
             echo "</table></button>"
	    exit                                                                                   
        fi 

# Oregon     
# Oregon Temp Scaling = $ORE_TSCALE                                                                                                                                
	if [[ ${mod_type} == ore_t1 || ${mod_type} == ore_t2 || ${mod_type} == ore_t3 ]];then
	      echo "Temp : $("$heyu" -c "${x10config}" oretemp $addr) $ORE_TSCALE"  
	      low_battery_msg
              time_stamp
              echo "</table></button>"
	    exit   

        elif [[ ${mod_type} == ore_th1 || ${mod_type} == ore_th2 || 
		${mod_type} == ore_th3 || ${mod_type} == ore_th4 || 
		${mod_type} == ore_th5 || ${mod_type} == ore_th6 ]];then
              echo "Temp : $("$heyu" -c "${x10config}" oretemp $addr) $ORE_TSCALE - "
	      echo "Hum :  $("$heyu" -c "${x10config}" orerh $addr)&#37"  
   	      low_battery_msg
              time_stamp
              echo "</table></button>"
	    exit  

	elif [[ ${mod_type} == ore_thb1 || ${mod_type} == ore_thb2 ]];then
	      echo "Temp : $("$heyu" -c "${x10config}" oretemp $addr) $ORE_TSCALE - Hum : $("$heyu" -c "${x10config}" orerh $addr)&#37 - "
	      echo "BP :   $("$heyu" -c "${x10config}" orebp $addr)"    
	      low_battery_msg
              time_stamp
              echo "</table></button>"
	    exit  

	elif [[ ${mod_type} == ore_wind* ]];then
	      echo "windavsp :   $("$heyu" -c "${x10config}" orewindavsp $addr) - "
	      echo "windsp :  $("$heyu" -c "${x10config}" orewindsp   $addr) - "
	      echo "winddir : $("$heyu" -c "${x10config}" orewinddir  $addr)"
	      low_battery_msg
              echo "</table></button>"
	    exit  

	elif [[ ${mod_type} == ore_rain* ]];then
	      echo "orerainrate : $("$heyu" -c "${x10config}" orerainrate $addr) - "
	      echo "oreraintot :  $("$heyu" -c "${x10config}" oreraintot  $addr)"
	      low_battery_msg
              echo "</table></button>"
	    exit  

	fi

# DIGIMax
# RFX/DIGIMax Temp Scaling = $RFX_TSCALE
	if [[ ${mod_type} == digimax* ]];then
	      echo "Temp : $("$heyu" -c "${x10config}" dmxtemp  $addr) $RFX_TSCALE "
	      #echo "dmxsetpoint : $("$heyu" -c "${x10config}" dmxsetpoint $addr) - "
	      #echo "dmxstatus :   $("$heyu" -c "${x10config}" dmxstatus   $addr) - "
	      #echo "dmxmode :     $("$heyu" -c "${x10config}" dmxmode     $addr)"
              #echo "</table></button>"
	    exit  
	fi

# RFX
# RFX Temp Scaling = $RFX_TSCALE

	if [[ ${mod_type} == rfx*	 ]];then 
	   [[ ${mod_type} == rfxpower*	 ]] && echo "rfxpower : $("$heyu" -c "${x10config}" rfxpower $addr)" && echo "</table></button>"
	   [[ ${mod_type} == rfxwater*	 ]] && echo "rfxwater : $("$heyu" -c "${x10config}" rfxwater $addr)" && echo "</table></button>"
	   [[ ${mod_type} == rfxgas*	 ]] && echo "rfxgas :   $("$heyu" -c "${x10config}" rfxgas   $addr)" && echo "</table></button>"
	   [[ ${mod_type} == rfxpulse*	 ]] && echo "rfxpulse : $("$heyu" -c "${x10config}" rfxpulse $addr)" && echo "</table></button>"
	   [[ ${mod_type} == rfxcount* 	 ]] && echo "rfxcount : $("$heyu" -c "${x10config}" rfxcount $addr)" && echo "</table></button>"

  	  if [[ ${mod_type} == rfxsensor*  ]];then 
	       echo "Temp : $("$heyu" -c "${x10config}" rfxtemp $addr) $RFX_TSCALE"  && echo "</table></button>"
	      #echo "rfxtemp2 : $("$heyu" -c "${x10config}" rfxtemp2  $addr)" 	 && echo "</table></button>"
	      #echo "rfxrh :    $("$heyu" -c "${x10config}" rfxrh     $addr)"     && echo "</table></button>"
	      #echo "rfxbp :    $("$heyu" -c "${x10config}" rfxbp     $addr)"     && echo "</table></button>"
	      #echo "rfxvad :   $("$heyu" -c "${x10config}" rfxvad    $addr)"  	 && echo "</table></button>"
	      #echo "rfxpot :   $("$heyu" -c "${x10config}" rfxpot    $addr)" 	 && echo "</table></button>"
	      #echo "rfxvs :    $("$heyu" -c "${x10config}" rfxvs     $addr)"  	 && echo "</table></button>"
	      #echo "rfxvadi :  $("$heyu" -c "${x10config}" rfxvadi   $addr)" 	 && echo "</table></button>"
	      #echo "rfxlobat : $("$heyu" -c "${x10config}" rfxlobat  $addr)" 	 && echo "</table></button>"
	   fi
	exit
	fi
