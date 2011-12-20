
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


