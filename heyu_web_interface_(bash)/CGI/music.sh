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
   </head>
   <script type=text/javascript src=../heyu_javascripts/update.js></script>
     <body onload=ajax_update()>
      <div id=content> <B><center>Heyu Web Interface Internet Radio Player (Beta)</B><br>
      
  <a href=?heyu_music=mpgstop>Stop Player</a><br>
  
"
echo $QUERY_STRING
mapfile data <currently_playing

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
    
if [[ $title ]];then 
echo "<br>
${title} - <a href=\"https://play.google.com/store/search?q=${title}&c=music\" target=_BLANK>Search </a><br><a href=$url target=_BLANK>$url</a>
"
else
echo "<br><br><br>"
fi
echo "</center><br>

Volume: <a href=?heyu_music=amixer_set_0%>0%</a> |<a href=?heyu_music=amixer_set_25%>25%</a> |<a href=?heyu_music=amixer_set_35%>35%</a> |<a href=?heyu_music=amixer_set_45%>45%</a> |<a href=?heyu_music=amixer_set_55%>55%</a> |<a href=?heyu_music=amixer_set_65%>65%</a> |
<a href=?heyu_music=amixer_set_75%>75%</a> |<a href=?heyu_music=amixer_set_85%>85%</a> |<a href=?heyu_music=amixer_set_100%>100%</a>
<br><br>"
player="mpg123 -@"
#player="mplayer"


QUERY_STRING=${QUERY_STRING/heyu_music=/}

(
[[ -n $QUERY_STRING ]] && [[ $QUERY_STRING != *amixer_set* ]] && [[ $QUERY_STRING != *current_song* ]] && echo > currently_playing && killall -9 ${player% -@}
) & 
wait

if [[ -n $QUERY_STRING ]] && [[ $QUERY_STRING != *amixer_set* ]] && [[ $QUERY_STRING != *current_song* ]];then
([[ $QUERY_STRING == *pls || $QUERY_STRING == *m3u || $QUERY_STRING == *:* ]] && $player $QUERY_STRING)>&currently_playing &


fi

[[ $QUERY_STRING == *amixer_set* ]] && amixer -q set Master ${QUERY_STRING/amixer_set_}



for line in $(</etc/group); 
do 
  [[ "$line" == *:$UID:* ]] && USER=${line/:x:$UID:};
done

for line in $(</etc/group); 
do 

  if [[ "$line" == *audio* ]] && [[ "$line" != *$USER* ]];then
    echo "User \"$USER\" must be added to group Audio. <br> In terminal type command \"sudo usermod -G audio $USER\" to add $USER to group audio.<BR>
    Then restart apache to have the new user settings updated.<br><br>";
  fi

done

ismpg123=($(${player% -@} --version))
[[ -z ${ismpg123[0]} ]] && echo "${player% -@} not installed.  Please install it to play music.<br><br>"


while read -r playlist
  do
    p=${playlist//#/ }
    p=($p)
    
    echo "<a href=?heyu_music=$playlist>${p[*]:1:9}</a><br>"
  done <./playlist


echo "</div></body></html>"






