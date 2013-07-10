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
      <div id=content> <B><center>Heyu Web Interface Internet Radio Player (Beta)</B>"
  
mapfile data <currently_playing

#while [[ x -lt ${#data[*]} ]]
#	do
#	if [[ ${data[$x]} == *StreamTitle* ]];then
#	  p=${data[$x]}
#	  p=${p//ICY-META: StreamTitle=\'}
#	  p=${p//\';StreamUrl=\'/ }
#	  p=${p//\';/}
#	  p=${p//http/<br>http}
#	  fi	
#	((x++))
 #   done  
    
    while [[ x -lt ${#data[*]} ]]
	do
	if [[ ${data[$x]} == *ICY-META* ]];then
	  p=${data[$x]}
	  p=${p//ICY-META: }
	  p=${p/StreamTitle/}
	  p=${p/StreamUrl/}
	  p=${p//=\'/}
	  p=${p// /_}
	  p=${p//\';/ }
	  m=($p)
	  title=${m[0]}
	  title=${title//_/ }
	  url=${m[1]}
	  url=${url//_/ }
	  #p=${p//\';StreamUrl=\'/ }
	  #p=${p//\';/}
	  #p=${p//http/<br>http}
	  fi	
	((x++))
    done  
[[ $title ]] && echo "<br>Now Playing...<br>"   
echo "${title} <a href='https://play.google.com/store/search?q=${title}&c=music' target=_BLANK>Search </a><br><a href=$url target=_BLANK>$url</a>"


echo "</body></html>"





