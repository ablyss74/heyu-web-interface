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
  <style type=text/css>
@import url(../heyu_style.css);
</style>
   </head>
   <script type=text/javascript src=/heyu_javascripts/update.js></script>
     <body onload=ajax_update()>
      <div id=content>
	<button class=mainplayerbutton><table class=control_panel_music><tr>
        <td><B><center>Heyu Web Interface Internet Radio Player (Beta)</B>
        <tr>
        <td><button class=currentlyplaying>"

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
  
  [[ ${#s} -gt 3 ]] && s="${l[6]}"
  soundlevel=${s//%/}
  inc_sound=$(($soundlevel + 5))
  dec_sound=$(($soundlevel - 5))
  echo " <button class=volbutton>Vol: ${s}<a href=?heyu_music=amixer_set_$dec_sound%><img src=/imgs/down.png width=25 heigth=25 align=center></a>
  <progress value=\"$soundlevel\" max=100></progress><a href=?heyu_music=amixer_set_$inc_sound%><img src=/imgs/up.png width=25 heigth=25 align=center></a></button>" 

done
}    
echo $QUERY_STRING
if [[ $title ]];then 
echo "
<a href=\"https://play.google.com/store/search?q=${title}&c=music\" title=\"Search this artist on Google Play\" target=_BLANK>${title}</a> 
<br> <a href=$url target=_BLANK>$url</a><br><br><br>
"
else
echo "<br><br><br>"
fi
echo "

  <table class=control_panel_music2 width=500><tr>
        <td >
        $(vol) 
        </td><form method=post action=?heyu_music=mpgstop>
	<td>
	  
	    <button class=stop_button type=submit>Stop</button>
	  </form>
	 </td>
	 </tr>

</table>
</button>"




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

echo "  <table class=control_panel_playlist><tr><td align=center><b>Playlist</b><tr><td><button class=playlistbutton>"
while read -r playlist
 do
     p=${playlist//#/ }
     p=($p)
     echo "<a href=?heyu_music=$playlist>${p[*]:1:9}</a><br>"
done <./playlist
echo "</button></table>"

echo "</button></table></button></div></body></html>"






