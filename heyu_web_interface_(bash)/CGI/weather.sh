#!/usr/bin/env bash
set -f

# Author: 	Kris Beazley
# Copyright     2014 
# Online: 	http://heyu.epluribusunix.net/
# Online email: http://heyu.epluribusunix.net/?contactus
# Licensed under the Apache License, Version 2.0 http://www.apache.org/licenses/LICENSE-2.0

# Define weather_app to use.

weather_app="/usr/bin/weather"


echo Content-Type:Text/Html
echo

echo "
<html>
  <head>
  <style type=text/css>
@import url(../heyu_style.css);
</style>
   </head>
        <body>
	<table class=weather1><tr><td>Heyu Web Interface Weather
        <tr>
        <td>"
        
        
     

if [[ $QUERY_STRING == heyu_weather* ]];then
QUERY_STRING=${QUERY_STRING/heyu_weather=/}   
while read -r weather; 
  do 
  
  [[ $weather == *Current\ conditions\ at* ]] && Location=$weather
  [[ $weather == *Temperature:* 	   ]] && Temperature=$weather
  [[ $weather == *Relative\ Humidity:* 	   ]] && Humidity=$weather
  [[ $weather == *Wind:*		   ]] && Wind=$weather
  [[ $weather == *Sky\ conditions:* 	   ]] && Sky=$weather
 
  done <<< "$($weather_app ${QUERY_STRING/Code=})"

if [[ $Temperature ]];then 
echo "
<br>
$Location <br>
$Temperature <br>
$Humidity <br>
$Wind <br>
$Sky <br>
<br>
"
 fi
 else
 echo "<br><br><br><br><br><br><br>"
fi




is_weather_app_installed=($(${weather_app% -@} --version))
if [[ -z ${is_weather_app_installed[0]} ]];then
  echo "Error: ${weather_app% -@} app not installed. <a href=http://fungi.yuggoth.org/weather/ target=_BLANK>Install</a><br><br>"
fi

echo "<tr><td><u>Favorites</u><Br>"
while read -r locations
 do
     l=${locations//#/ }
     l=($l)
    
     echo "<a href=\"?heyu_weather=$locations\">${l[*]:1:9}</a><br>"    
     
done <./weather_stations

echo "<tr><td><u>Tools</u><Br>
Weather Source: <a href=http://weather.noaa.gov/ target=_BLANK>weather.noaa.gov</a>,
<a href=http://fungi.yuggoth.org/weather/ target=_BLANK>source code</a>,
<a href=http://fungi.yuggoth.org/weather/doc/license.rst target=_BLANK>license</a><br><br>
"
echo 'Crontab example 1 checks every 30 mintues, everyday, every month and every week between the hours of 11am and 3pm and turns on A7 if temperature is equal to or above 60F.
<br><br>
Crontab example 2 checks every 30 minutes and turns off A7 if temperature is less than 60F.<br><br><textarea readonly cols=70 rows=15>
SHELL=/bin/bash
MAILTO=""
'
echo '
#Example 1
*/30 11-15 * * * while read -r w; do [[ $w = *Temp* ]] && w=${w//./ } && w=(${w}) && [[ ${w[1]} -gt 60 ]] && /usr/local/bin/heyu on A7; done <<< "$(/usr/bin/weather KATL)"

#Example 2
*/30 * * * * while read -r w; do [[ $w = *Temp* ]] && w=${w//./ } && w=(${w}) && [[ ${w[1]} -lt 60 ]] && /usr/local/bin/heyu off A7; done <<< "$(/usr/bin/weather KATL)"

'


echo "</textarea>"

echo "</table></body></html>"






