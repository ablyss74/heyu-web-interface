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







