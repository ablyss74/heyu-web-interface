#!/usr/bin/env bash
#set -f

# Author: 	Kris Beazley
# Copyright     2014 
# Online: 	http://heyu.epluribusunix.net/
# Online email: http://heyu.epluribusunix.net/?contactus
# Licensed under the Apache License, Version 2.0 http://www.apache.org/licenses/LICENSE-2.0



echo Content-Type:Text/Html
echo



exec 2>&1

folder() {
     for f in /var/log/$folder* ; do
	if [[ -d $f && -r $f ]];then
	f=${f}
	echo "${f//\/var\/log\/}"
	fi
     done
}

file() {
     for log in /var/log/$folder/* ; do
     if [[ ! -d $log  ]];then
     log=${log/\/\//\/}
     echo "$log"
     fi
     done
}




echo "
<html>
  <head>
    <!--<script type=text/javascript src=../heyu_javascripts/update.js></script>-->
    <style type=text/css>
.sty {
	width:100%;
	height:85%;
	font-family: verdana,arial,sans-serif;
	font-size:11px;
	color:#333333;
	border: 1px solid black;
	border-width: 1px;
	border-color: #ccc;
	-moz-border-radius:8px;
	-webkit-border-radius:8px;
	-khtml-border-radius:8px;
	border-radius:4px;
	border: 1px solid black;
	-moz-box-shadow:2px 2px 6px rgba(0,0,0,0.6);
	-webkit-box-shadow:2px 2px 6px rgba(0,0,0,0.6);
	-khtml-box-shadow:2px 2px 6px rgba(0,0,0,0.6);
	box-shadow:2px 2px 6px rgba(0,0,0,0.6);
	border-radius:4px;
	text-align:left;
    }
.sty2 {
	
	font-family: verdana,arial,sans-serif;
	font-size:11px;
	font-weight:bold;
	color:#333333;
	border-radius:4px;
	border: 1px solid black;
        text-align:center;

      }
.sty3 {
	
	font-family: verdana,arial,sans-serif;
	font-size:11px;
      }
</style>
   </head>
   <body bgcolor=#E5E5E5 onload=ajax_update()>"
   



     lf() {
      if [[ $QUERY_STRING == heyu_log_folder* ]];then  
	 folder=${QUERY_STRING//heyu_log_folder=}
         folder=${folder//%2F}
         [[ $folder == "" ]] && echo "log" || echo "$folder"
      else
         echo "log"
      fi
      }
      
  
	 echo "<form><b class=sty3>Folder</b>
	 <select class=sty2 name=heyu_log_folder><option value=/>$(lf)$(for i in $(folder); do echo "<option value=\"$i\">$i"; done)
	 </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input class=sty2  type=submit value=OK></form>"  

	 if [[ $QUERY_STRING == heyu_log_folder* ]];then  
	 folder=${QUERY_STRING//heyu_log_folder=}	
         folder=${folder//%2F}
         fi

	 echo "<form><b class=sty3>File</b><td>
	 <select class=sty2  name=heyu_view_log>$(for i in $(file); do echo "<option value=\"$i\">$i"; done)
	 </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input class=sty2  type=submit value=OK></form>"
   
		
data=$QUERY_STRING
data=${data//heyu_view_log=}
data=${data//%2F/\/}



echo $data
    # echo "<div id=content>"
    echo "<table class=sty><tr><td bgcolor=white>"
  
if [[ $QUERY_STRING != heyu_log_folder* && -n $QUERY_STRING ]];then
  if [[ $data == *.gz ]];then
    echo "<pre>$(gzip -c --decompress $data)</pre>"
  else
    echo "<pre>$(<$data)</pre>"
  fi

fi
echo "</div></body></html>"





