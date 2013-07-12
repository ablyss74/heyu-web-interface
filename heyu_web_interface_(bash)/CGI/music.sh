#!/usr/bin/env bash
set -f

# Author: 	Kris Beazley
# Online: 	http://heyu.epluribusunix.net/
# Online email: http://heyu.epluribusunix.net/?contactus

# Define player to use.
player="mpg123 -@"
#player="mplayer"

echo Content-Type:Text/Html
echo


echo "
<html>
  <head>
   </head>
   <script type=text/javascript src=/heyu_javascripts/update.js></script>
     <body onload=ajax_update()>
      <div id=content><hr><B><center>Heyu Web Interface Internet Radio Player (Beta)</B>"

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
    
    
vol() {
for l in "$(amixer get Master)"
do
  l=${l// /_}  
  l=${l/_[/ }
  l=${l/]_/ }
  l=($l)
  s="${l[5]}"
  [[ ${#s} != 2 ]] && s="${l[6]}"
  soundlevel=${s//%/}
  inc_sound=$(($soundlevel + 5))
  dec_sound=$(($soundlevel - 5))
  echo "Volume:<a href=?heyu_music=amixer_set_$dec_sound%>-</a><progress class=pb value=\"$soundlevel\" max=100></progress><a href=?heyu_music=amixer_set_$inc_sound%>+</a>" 

done
}    

if [[ $title ]];then 
echo "<br>
${title} - <a href=$url target=_BLANK>$url</a>"
else
echo "<br><br><br>"
fi
echo "</center><br><a href=\"https://play.google.com/store/search?q=${title}&c=music\" target=_BLANK>Search </a> | 
 <a href=?heyu_music=mpgstop>Stop</a>
 <br>$(vol)

<br><hr>"




QUERY_STRING=${QUERY_STRING/heyu_music=/}




(
[[ -n $QUERY_STRING ]] && [[ $QUERY_STRING != *amixer_set* ]] && [[ $QUERY_STRING != *current_song* ]] && echo > currently_playing && killall -9 ${player% -@} && sleep 2s
) & 
wait


if  [[ -n $QUERY_STRING ]] && [[ $QUERY_STRING != *amixer_set* ]] && [[ $QUERY_STRING != *current_song* ]];then

	([[ $QUERY_STRING == *pls || $QUERY_STRING == *m3u || $QUERY_STRING == *:* ]] && $player $QUERY_STRING)>&currently_playing &
fi

if [[ $QUERY_STRING == *amixer_set* ]];then
  
  amixer -q set Master ${QUERY_STRING/amixer_set_}
fi


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

isplayer_installed=($(${player% -@} --version))
if [[ -z ${isplayer_installed[0]} ]];then
  echo "${player% -@} not installed.  Please install it to play music.<br><br>"
fi


while read -r playlist
 do
     p=${playlist//#/ }
     p=($p)
     echo "<a href=?heyu_music=$playlist>${p[*]:1:9}</a><br>"
done <./playlist


echo "</div></body></html>"






