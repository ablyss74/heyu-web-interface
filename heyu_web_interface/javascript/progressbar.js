//progress Bar script- by Todd King (tking@igpp.ucla.edu)
//Modified for heyu web internface

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


