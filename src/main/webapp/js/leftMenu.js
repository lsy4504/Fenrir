/**
 * 레프트 메뉴 js 입니다 .
 */
function openNav() {
	var flag=document.getElementById("side").getAttribute('flag');
	if(flag=='0'){
		document.getElementById("mySidenav").style.width = "380px";
		document.getElementById("main").style.marginLeft = "250px";
		document.getElementById("side").setAttribute('flag','1');
		
	}else{
		document.getElementById("mySidenav").style.width = "0";
		document.getElementById("main").style.marginLeft= "0";
		document.getElementById("side").setAttribute('flag','0');
	}
	
}

function closeNav() {
	document.getElementById("mySidenav").style.width = "0";
	document.getElementById("main").style.marginLeft= "0";
	document.getElementById("side").setAttribute('flag','0');
}
