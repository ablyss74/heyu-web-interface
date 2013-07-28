/*
   Author: ﻿  Kris Beazley
   Copyright  2013 Kris Beazley

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
   Apache License, Version 2.0 http://www.apache.org/licenses/LICENSE-2.0
*/
var xmlhttp

function show(str) {	

xmlhttp = GetXmlHttpObject();
  if (xmlhttp == null) {
    StatusDestroy();
    alert ("Your browser does not support AJAX!");
    return;
  }
  try {
    xmlhttp.onreadystatechange = stateChanged;
    xmlhttp.open("POST",location.href,true);
    xmlhttp.send(str);
  }
  catch(err) {alert(err);}
	
}

function stateChanged() {

  try {
    if (xmlhttp.readyState == 4) {
      document.getElementById("content").innerHTML = xmlhttp.responseText;
      StatusDestroy();
    }
  }
  catch(err) {alert(err);}

}

function GetXmlHttpObject() {

  if (typeof XMLHttpRequest != 'undefined') {
    return new XMLHttpRequest();
  }
  else {
    try {
         return new ActiveXObject("Msxml2.XMLHTTP");
        }
  catch (err) {
      try {
           return new ActiveXObject("Microsoft.XMLHTTP");
          }
      catch (err) {return null;}
      }
  }

}


function ajax_update() {
  try {
    if (document.getElementById('refresh') != null) {
      if (document.cookie.match('auto_refresh=True') != null) {
	 show();
      }
    }
 
 }
  catch(err) {alert(err);}

}


