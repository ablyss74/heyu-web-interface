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
       <script type=text/javascript src=../heyu_javascripts/update.js></script>
   </head>
   <body bgcolor=#E5E5E5 onload=ajax_update()>"
   
   echo "
     <div id=content><table><tr><td><textarea cols=450 rows=100% readonly>"
    
tail -n 35 /var/log/syslog

echo "</textarea></body></html>"





