
var frame = new Array();
var dots = 0;

frame[0] = 'Please Wait';
frame[1] = 'Please Wait.';
frame[2] = 'Please Wait..';
frame[3] = 'Please Wait...';

if (document.getElementById) {
   try {
      ani = 'document.getElementById("progress").innerHTML =  frame[dots++];';
       }
   catch(err) {alert(err);}   
}

function PhoneProgress() {
   try {
      eval(ani);
      if (dots == frame.length) dots = 0;
      if (document.all) { if (progress.className = 'hide') dots == 0; }
      if (document.layers) { if (document.progress.visibility == false) dots = 0; }
      if (document.getElementById) { if (document.getElementById("progress").className == 'hide') dots = 0 ; }
      setTimeout("PhoneProgress()", 500);
       }
   catch(err) {alert(err);}
}

function hideURLbar() {
   try {
      setTimeout("window.scrollTo(0,1)", 100);
       }
   catch(err) {alert(err);}
}

