function goPage (newURL) {
   	if (newURL != "") {
   		if (newURL == "-" ) {
			resetMenu();			
		} else {  
 		document.location.href = newURL;
   		}
   	}
}
function resetMenu() {
   document.gomenu.selector.selectedIndex = 2;
}

