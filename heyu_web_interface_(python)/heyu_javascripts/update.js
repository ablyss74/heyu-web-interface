/*
   Author: ﻿  Kris Beazley
   Copyright  2012 Kris Beazley

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

function myXMLHttpRequest() {
	if (window.XMLHttpRequest)  {  return new XMLHttpRequest();  }
	if (window.ActiveXObject)   {  return new ActiveXObject("Microsoft.XMLHTTP");  }
	
return null;
}

function ajax_update()
{
	
	url = "?";
	
	top_xmlhttp = new myXMLHttpRequest ();
	
	if (top_xmlhttp) { 
				top_xmlhttp.open ("POST", url, true);
				top_xmlhttp.send ("?auto_refresh"); 
					top_xmlhttp.onreadystatechange = function () {
						if (top_xmlhttp.readyState == 4) {
							document.getElementById("content").innerHTML=top_xmlhttp.responseText;
					
								}
						}

			   }

	setTimeout('ajax_update()', 1000);
}







