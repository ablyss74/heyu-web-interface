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
       <title>Heyu Web Interface v.$Heyu_web_interface_version</title>
       <script type=text/javascript src=../heyu_javascripts/update.js></script>
   </head>
   <body bgcolor=#E5E5E5 onload=ajax_update()>
      <div id=content>
      <textarea cols=450 rows=100% readonly>"
top -b  -n 1
echo "</textarea></body></html>"





