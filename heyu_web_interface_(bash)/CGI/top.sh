#!/usr/bin/env bash
set -f

# Author: 	Kris Beazley
# Copyright     2014 
# Online: 	http://heyu.epluribusunix.net/
# Online email: http://heyu.epluribusunix.net/?contactus
# Licensed under the Apache License, Version 2.0 http://www.apache.org/licenses/LICENSE-2.0



echo Content-Type:Text/Html
echo

echo "
<html>
  <head>
<style type=text/css>
.sty {
	width:750px;
	height:60px;
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
	text-align:center;
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
}
</style>
</style>
       <script type=text/javascript src=../heyu_javascripts/update.js></script>
   </head>
   <body bgcolor=#E5E5E5 onload=ajax_update()>"
    if [[ $QUERY_STRING == kill_confirm=* ]];then
      kill_pid=${QUERY_STRING//kill_confirm=}
      kill -9 $kill_pid
    fi
    if [[ $QUERY_STRING == kill_pid* ]];then
      kill_=${QUERY_STRING//kill_pid=}
      kill_=${kill_//&/ }
      kill_=($kill_)

      echo "Are you sure you want to kill PID: <b>${kill_[0]}</b> Owner: <b>${kill_[2]}</b> Name: <b>${kill_[1]}</b>? &nbsp; <a href=?kill_confirm=$kill_>Yes</a>&nbsp;&nbsp; <a href=?>No</a><br>
      Notice: You may not have permissions to kill this process."
    fi
   echo "
     <div id=content>
     <table class=sty><tr>
     <td class=sty2>PID</td><td class=sty2>USER</td><td class=sty2>PR</td><td class=sty2>NI
     </td><td class=sty2>VIRT</td><td class=sty2>RES</td><td class=sty2>SHR</td><td class=sty2>S
     </td><td class=sty2>%CPU</td><td class=sty2>%MEM</td><td class=sty2>TIME+</td><td class=sty2>COMMAND
     </td><td class=sty2>KILL<tr>"
 

     
var=$(top -b -n 1)
arr=($var)
while [[ ${arr[*]:${i}:1} != COMMAND ]]
  do
    # Increment $i to = Command so we grab the data we want
    ((i++))
  done
  # Incrment one last time
((i++))
x=0
while [[ $c -le 25 ]]
do
  	while [[ $x -lt 12 ]]
	  do
	      [[ $x == 0 ]] && pid=${arr[*]:$i:1}
	      [[ $x == 1 ]] && powner=${arr[*]:$i:1}
	      [[ $x == 11 ]] && pname=${arr[*]:$i:1}	     
	      echo "<td class=sty>${arr[*]:$i:1}"
	      [[ $x == 11 ]] &&   echo "<td class=sty><a href=?kill_pid=$pid&$pname&$powner>
					<img src=../imgs/alloff.png width=20 height=20></a>"
	      ((x++))
	      ((i++))    
	  done 
	  unset x
echo "<tr>"
((c++))
done
echo "</table"
echo "</textarea></body></html>"





