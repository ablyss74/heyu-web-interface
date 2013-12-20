#!/usr/bin/env bash
set -f

# Author: 	Kris Beazley
# Copyright     2013 
# Online: 	http://heyu.epluribusunix.net/
# Online email: http://heyu.epluribusunix.net/?contactus
# Licensed under the Apache License, Version 2.0 http://www.apache.org/licenses/LICENSE-2.0

echo Content-Type:Text/Html
echo


echo "
<html>
  <head>
       <title>Heyu Web Interface Logs</title>
       <script type=text/javascript src=../heyu_javascripts/update.js></script>
   </head>
   <body bgcolor=#E5E5E5 onload=ajax_update()>
      <div id=content>
      <textarea cols=450 rows=100% readonly>"
for x in $HTTP_COOKIE ; do
#[[ $x == sub0cookie* ]] && echo $x
	  x=${x//|/=}
	  x=${x/sub0cookie=/}
	  x=${x//^/ }
	  x=${x%sub0cookie_}	  
	      for i in $x ; do
		[[ ${i,,} == *heyu=* ]] && heyu="${i/heyu=/}"
		[[ ${i,,} == *x10config=* ]] && x10config="${i/x10config=/}"
	      done	
	  done
"$heyu" -c "${x10config}" logtail 25
echo "</textarea></body></html>"





