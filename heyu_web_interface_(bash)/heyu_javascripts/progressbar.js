//progress Bar script- by Todd King (tking@igpp.ucla.edu)
/* Modified for heyu web internface

   Author: 	Kris Beazley
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

function Status() {

// Move layer to center of window to show
	 if (document.getElementById) { // Most Recent Browsers
	try { 
		document.getElementById("progress").className = 'show';
		document.getElementById("progress").style.left = (window.innerWidth/2) - 100 + "px";
		document.getElementById("progress").style.top = pageYOffset + (window.innerHeight/2) - 50 + "px";
            } 
	catch(err) {
	   try { 
		document.getElementById("progress").className = 'show';
                document.getElementById("progress").style.left = (document.body.clientWidth/2) - 100 + "px";
                document.getElementById("progress").style.top = document.documentElement.scrollTop + (document.body.clientHeight/2) - 50 + "px";
	       }
	   catch(err) {alert(err);}
              }
	} else if (document.all) {     // Internet Explorer 4
	   try {
                progress.className = 'show';
                progress.style.left = (document.body.clientWidth/2) - (progress.offsetWidth/2);
                progress.style.top = document.body.scrollTop + (document.body.clientHeight/2) - (progress.offsetHeight/2);
	       }
	   catch(err) {alert(err);}
        } else if (document.layers) {   // Netscape 5
	   try {
                document.progress.visibility = true;
                document.progress.left = (window.innerWidth/2) - 100 + "px";
                document.progress.top = pageYOffset + (window.innerHeight/2) - 50 + "px";
	       }
	   catch(err) {alert(err);}
	}
}

// Hide the progress layer
function StatusDestroy() {
   try {
	// Move off screen to hide
	   if (document.getElementById) {	// Most Recent Browsers
		      document.getElementById("progress").className = 'hide';
           } else if (document.all) {     // Internet Explorer 4
                      progress.className = 'hide';
           } else if (document.layers) {   // Netscape 5
                      document.progress.visibility = false;
           }
        }
   catch(err) {alert(err);}
}


