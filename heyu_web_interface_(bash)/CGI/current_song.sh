#!/usr/bin/env bash
set -f

# Author: 	Kris Beazley
# Online: 	http://heyu.epluribusunix.net/
# Online email: http://heyu.epluribusunix.net/?contactus

echo Content-Type:Text/Html
echo

echo "
<html>
  <head>
       <title>Heyu Web Interface v.$Heyu_web_interface_version</title>
       <script type=text/javascript src=../heyu_javascripts/update.js></script>
   </head>
   <body onload=ajax_update()>
      <div id=content> <B><center>Heyu Web Interface Internet Radio Player (Beta)</B><br>Currently Playing...<br>"
  
mapfile data <currently_playing

while [[ x -lt ${#data[*]} ]]
	do
	if [[ ${data[$x]} == *StreamTitle* ]];then
	  ((c++))
	  p=${data[$x]}
	  p=${p//ICY-META: StreamTitle=\'}
	  p=${p//\';StreamUrl=\'/ }
	  p=${p//\';/}
	  p=${p//http/<br>http}

	  fi	
	((x++))
    done  
   
echo "${p}"
echo "

echo "</body></html>"





