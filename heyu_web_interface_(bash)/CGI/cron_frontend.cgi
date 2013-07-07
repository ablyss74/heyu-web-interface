#!/usr/bin/env bash
set -f

# Author: 	Kris Beazley
# Online: 	http://heyu.epluribusunix.net/
# Online email: http://heyu.epluribusunix.net/?contactus

    file="./macro_config.cron"

    # Cron user for the interface
    user=www-data

 while read -r passwd; do [[ $passwd == *heyu_macro_web_interface* ]] && 
    echo "<table><tr><td bgcolor=yellow><font color=red><b>Warning: The user \"heyu_macro_web_interface\" is no longer used by this script.<br>
	  You should remove this user from your system as this might conflict with current versions of Heyu Web Interface.<br> Open Terminal
	  and become root or sudo and type \"deluser heyu_macro_web_interface\".</b></table>"; done</etc/passwd


if [[ $QUERY_STRING != *Macro_Save_All=Save* ]];then
aq="${QUERY_STRING//+/}"
aq="${QUERY_STRING//&/ }"
aq=($aq)
aq="${aq[0]//Unit=?Unit_/}"
Unit="${aq[0]}"
Label="${aq[1]}"
Action="${aq[2]}"
HouseCode="${aq[3]//HouseCode=/}"
Minutes="${aq[3]//Minutes=/}"
Hour="${aq[4]//Hour=/}"
Day="${aq[5]//Day=/}"
Month="${aq[6]//Month=/}"
Week="${aq[7]//Week=/}"
Action="${aq[8]//Action=/}"
Brighter="${aq[9]//Brighter=/}"
Dimmer="${aq[10]//Dimmer=/}"

[[ $Hour == Hour 	 ]] && Hour=*
[[ -z $Hour 		 ]] && Hour=0
[[ $Minutes == Minutes 	 ]] && Minutes=*
[[ -z $Minutes 		 ]] && Minutes=0
[[ $Day == Day 		 ]] && Day=*
[[ $Month == Month 	 ]] && Month=* 
[[ $Week == Week	 ]] && Week=* 
[[ -z $Week 		 ]] && Week=0 
[[ $Action == Action 	 ]] && Action=$NULL
[[ $Brighter == Brighter ]] && Brighter=$NULL
[[ $Dimmer == Dimmer 	 ]] && Dimmer=$NULL 

fi


do_p()
{
for i in $var; do

 [[ $i == 22 ]] && echo 100%
 [[ $i == 21 ]] && echo 95%
 [[ $i == 20 ]] && echo 90%
 [[ $i == 19 ]] && echo 85%
 [[ $i == 18 ]] && echo 80%
 [[ $i == 17 ]] && echo 75%
 [[ $i == 16 ]] && echo 70%
 [[ $i == 15 ]] && echo 65%
 [[ $i == 14 ]] && echo 60% 
 [[ $i == 13 ]] && echo 55% 
 [[ $i == 12 ]] && echo 50% 
 [[ $i == 11 ]] && echo 45% 
 [[ $i == 10 ]] && echo 40%
 [[ $i == 9  ]] && echo 35% 
 [[ $i == 8  ]] && echo 30% 
 [[ $i == 7  ]] && echo 25% 
 [[ $i == 6  ]] && echo 20% 
 [[ $i == 5  ]] && echo 15% 
 [[ $i == 4  ]] && echo 10% 
 [[ $i == 3  ]] && echo 5% 
 [[ $i == 2  ]] && echo 3% 
 [[ $i == 1  ]] && echo 1% 

done
}
echo "<br>
<table align=center><tr><form method=post><td align=center valign=center>
<span style=\"font:  11px Arial\">Current Time: $(date +%T)
<td width=30 align=center valign=center>
<td>
</table><table align=center>
<tr><td width=30 align=center><span style=\"font: 10px Arial\">$(date +%M)
<select name=Minutes>
<option>Minutes
<option value=\"*\">*
$(while [[ $var -le 59 ]]; do echo "<option value=\"$var\">$((var++))"; done)
</select> 
<td width=30 align=center><span style=\"font: 10px Arial\">$(date +%H)
<select name=Hour>
<option>Hour
<option value=\"*\">*
$(while [[ $var -le 23 ]]; do echo "<option value=\"$var\">$((var++))"; done)
</select>
<td width=30 align=center><span style=\"font: 10px Arial\">$(date +%d)
<select name=Day>
<option>Day
<option value=\"*\">*
$(var=1;while [[ $var -le 31 ]]; do echo "<option value=\"$var\">$((var++))"; done)
</select> 
<td width=30 align=center><span style=\"font: 10px Arial\">$(date +%m)
<select name=Month>
<option>Month
<option value=\"*\">*
$(var=1;while [[ $var -le 12 ]]; do echo "<option value=\"$var\">$((var++))"; done)
</select> 
<td width=30 align=center><span style=\"font: 10px Arial\">$(date +%w)
<select name=Week>
<option>Week
<option value=\"*\">*
$(while [[ $var -le 6 ]]; do echo "<option value=\"$var\">$((var++))"; done)
</select> 
<td width=30 align=center><span style=\"font: 10px Arial\">On/Off
<select name=Action>
<option>Action
<option value=\"on\">On
<option value=\"off\">Off
</select> 
<td width=30 align=center><span style=\"font: 10px Arial\">Brighter
<select name=Brighter>
<option>Brighter
$(while [[ $var -le 21 ]]; do echo "<option value=\"$((var++))\">$(do_p)"; done)
</select>
<td width=30 valign=center align=center><span style=\"font: 10px Arial\">Dimmer
<select name=Dimmer>
<option>Dimmer
$(while [[ $var -le 21 ]]; do echo "<option value=\"$((var++))\">$(do_p)"; done)
</select>

<tr>

<table align=center><tr><td valign=top>
<input style=\"Height:30;width:100;font: 13 Arial\" type=submit name=Macro value=Wizard onclick=\"Status();show(this.value)\">
<input style=\"Height:30;width:100;font: 13 Arial\" type=button onclick=\"Status();show('Macro=Refresh')\" value=Refresh>
<input style=\"Height:30;width:100;font: 13 Arial\" type=button onclick=\"Status();show('BasicUserConfig=css')\" value=Exit>


</form></button>
</form>
</table><table align=center><tr><td>"


[[ ${aq[0]} == Unit=?Refresh && $QUERY_STRING == *Macro=Wizard* ]] && 
echo "<table align=center><tr><td>
<span style=\"font:  13 Arial\"><font color=red>A Selection is required.<br>
</table></div></body></html>" && exit


[[ ! -e $file ]] && echo -e "#Examples \n#52 20 * * * /usr/local/bin/heyu on B13 # Front Porch\n#30 5 * * * /usr/local/bin/heyu off B13 # Front Porch" > $file

echo "

<table width=60% align=center><tr><td>
<form method=post><span style=\"font: bold 10 Arial\">
<textarea style=\"width:$ctaw\px;height:400\px;background-color:#fff;border-width: 3px;border-style: groove;border-color: #ccc;\" name=MacroData>"

if [[ $QUERY_STRING == *Macro_Save_All* ]];then
QUERY_STRING="${QUERY_STRING//&Macro_Save_All=Save All/}"
QUERY_STRING="${QUERY_STRING//MacroData=/}"
QUERY_STRING="${QUERY_STRING/&Save\ All/}"
echo -e "${QUERY_STRING}" > "$file"
fi

if [[ $QUERY_STRING == *Macro=Wizard* ]];then
   
   var_file="$(<$file)"
   if [[ -n $Action ]];then
     echo -e "$Minutes $Hour $Day $Month $Week $heyu $Action $Unit #$Label\n$var_file" > $file
   elif [[ -n $Brighter ]];then
     echo -e "$Minutes $Hour $Day $Month $Week $heyu bright $Unit $Brighter #$Label\n$var_file" > $file
   elif [[ -n $Dimmer ]];then
     echo -e "$Minutes $Hour $Day $Month $Week $heyu dim $Unit $Dimmer #$Label\n$var_file" > $file
   fi
fi

# Print the contents of the cron file
# Crontab loads the file into memory.
# This creates a time delay in showing real-time status of the file ~ 5 seconds
# To work around this we test the file to crontabs memory
cl="$(<$file)"
cl="${cl/#\n/}"
cl="${cl/%$'\n'/}"

[[ ! -e $file ]] && echo -e "#Examples \n#52 20 * * * /usr/local/bin/heyu on B13 # Front Porch\n#30 5 * * * /usr/local/bin/heyu off B13 # Front Porch"
[[ $(crontab -u $user -l) != "$cl" ]] && echo -e "${cl}"
[[ $(crontab -u $user -l) == "$cl" ]] && crontab -u $user -l
crontab -u $user $file

echo "</textarea>

<input type=submit onclick=\"Status();show(this.value)\" name=Macro_Save_All value='Save All'></form>

<font size=1>
Help:<br>
Save All: Skips the Wizard and directly edits the cron file.<br>
Cron uses sh not bash.<br>
<br>
Format of a cron job file: <br>
[min] [hour] [day of month] [month] [day of week] [program to be run]<p>

[min] Minutes that program should be executed on. 0-59. Do not set as * or the program will be run once a minute.<br>
[hour]	Hour that program should be executed on. 0-23. * for every hour.<br>
[day of month]	Day of the month that process should be executed on. 1-31. * for every day.<br>
[month]	Month that program would be executed on. 1-12 * for every month.<br>
[day of week]	Day of the week. 0-6 where Sunday = 0, Monday = 1, ...., Saturday = 6. * for everyday of the week.<br>
<br>
		</div>
	</body>

</html>
"

