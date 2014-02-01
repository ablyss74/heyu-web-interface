#!/usr/bin/env bash
#set -f (leave this unset for globbing archives)

# Author: 	Kris Beazley
# Copyright     2014 
# Online: 	http://heyu.epluribusunix.net/
# Online email: http://heyu.epluribusunix.net/?contactus
# Licensed under the Apache License, Version 2.0 http://www.apache.org/licenses/LICENSE-2.0

echo Content-Type:Text/Html
echo



### Need to import some vars from our cookies.
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

      if [[ $QUERY_STRING == delete_archive_* ]];then
	rm ./${QUERY_STRING/delete_archive_/}
      fi
      
      if [[ $QUERY_STRING == backup_log ]];then
	echo "$logs" > ./heyu_logs/heyu.log.$TTY.Archive:$(date +%m.%d.%Y.%T)
      fi
      
      if [[ $QUERY_STRING == clear_log ]];then
	echo > ./heyu_logs/heyu.log.$TTY
      fi
 
      csize() {
	      if [[ $((${#logs} / 1000)) -eq "0" ]];then 
		echo "(${#logs} B) "
		  else
		    echo "($((${#logs} / 1000)) KiB) "
	      fi
	      }
      echo "<a href=/heyu_logs/heyu.log.$TTY>View Full Log</a> $(csize) || <a href=?clear_log>Erase Current Log File</a> || <a href=?backup_log>Backup Current Log File</a>"
      
      echo "<br>"
	for i in ./heyu_logs/heyu.log.$TTY.Archive*
	  do
		as() {
		  asize=$(<$i)
                  if [[ $((${#asize} / 1000)) -eq "0" ]];then 
		    echo "(${#asize} B) "
		    else
		      echo "($((${#asize} / 1000)) KiB) "
		    fi
		    }
	    file=${i/.\/heyu_logs\/heyu.log.$TTY.}
	    file=${file/Archive:/Archive }
	    file=${file/./\/}
	    file=${file/./\/}
	    file=${file/./ }
	    if [[ $file != "Archive*" ]];then
	    echo "<a href=$i>$file</a> $(as) || <a href=?delete_archive_$i>Delete</a><br>"
	    else
	    echo "There Are No Current Archives. <a href=?backup_log>Backup Current Log File Now?</a>"
	    fi
	 
	  done

      echo "<textarea cols=450 rows=100% readonly>"
      
### Only need to display a small amount
 "$heyu" -c "${x10config}" logtail 30
echo "</textarea></div></body></html>"





