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
	  p=${data[$x]}
	  p=${p//ICY-META: StreamTitle=\'}
	  p=${p//\';StreamUrl=\'/ }
	  p=${p//\';/}
	  echo "$p<br>"
	  #export current_song=$p
	  #[[ -z $c ]] && exit
	  #[[ $c -gt 1 ]] && echo $p > textfile && exit
	  #((c++))
	fi
	#[[ ${data[$x]} == *StreamTitle* ]] && echo "${data[$x]}<br>"
	((x++))
	
done

#echo "<pre>${title}"
echo "</body></html>"





