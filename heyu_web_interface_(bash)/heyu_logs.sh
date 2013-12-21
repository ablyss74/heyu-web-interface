#!/usr/bin/env bash
set -f

# Author: 	Kris Beazley
# Copyright     2013 
# Online: 	http://heyu.epluribusunix.net/
# Online email: http://heyu.epluribusunix.net/?contactus
# Licensed under the Apache License, Version 2.0 http://www.apache.org/licenses/LICENSE-2.0

echo Content-Type:Text/Html
echo

for x in $HTTP_COOKIE ; do
	  x=${x//|/=}
	  x=${x/sub0cookie=/}
	  x=${x//^/ }
	  x=${x%sub0cookie_}	  
	      for i in $x ; do
		[[ ${i,,} == *heyu=* ]] && heyu="${i/heyu=/}"
		[[ ${i,,} == *x10config=* ]] && x10config="${i/x10config=/}"
	      done	
	  done

    while read -r config
	do
	[[ ${config} == TTY_AUX\ * ]] && TTY_AUX=(${config/TTY_AUX /}) && TTY_AUX=${TTY_AUX/\/dev\/}
	[[ ${config} == TTY\ * ]] && TTY=(${config/TTY /}) && TTY=${TTY/\/dev\/}
	done <"$x10config"
		

echo "
<html>
  <head>
       <title>Heyu Web Interface Logs</title>
       <script type=text/javascript src=../heyu_javascripts/update.js></script>
   </head>
   <body bgcolor=#E5E5E5 onload=ajax_update()>
      <div id=content>"
      
      
      logs=$(<./heyu_logs/heyu.log.$TTY)
      if [[ $QUERY_STRING == clear_log ]];then
	echo > ./heyu_logs/heyu.log.$TTY
      fi
 
      if [[ $((${#logs} / 1000)) -eq "0" ]];then 
	echo "Log File Size: (${#logs} B) "
	else
	  echo "Log File Size: ($((${#logs} / 1000)) KiB) "
      fi
      echo " | <a href=?clear_log>Erase Log File</a>"
      
      
      echo "<textarea cols=450 rows=100% readonly>"

     
 "$heyu" -c "${x10config}" logtail 25
echo "</textarea></div></body></html>"





