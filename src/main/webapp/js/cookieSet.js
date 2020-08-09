/**
* cookLogId
* 로그인 정보 저장
* @param id
*/
function cookLogId(id) {
	if(id != "") {
		// userid 쿠키에 id 값을 7일간 저장
		setCoo_kie("userid", id, 7);
	}else{
		// userid 쿠키 삭제
		setCoo_kie("userid", id, -1);
	}
}

/**
* setCoo_kie
* Coo_kie에 user_id를 저장
* @param name
* @param value
* @param expiredays
*/
function setCoo_kie(name, value, expiredays) {
	var today = new Date();
	today.setDate( today.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + today.toGMTString() + ";"
}

/**
* getCoo_kie
* 쿠키값을 가져온다.
* @returns {String}
*/
function getCoo_kie() {
	// userid 쿠키에서 id 값을 가져온다.
	var cook = document.cookie + ";";
	var idx = cook.indexOf("userid", 0);
	var val = "";
	if(idx != -1) {
		cook = cook.substring(idx, cook.length);
		begin = cook.indexOf("=", 0) + 1;
		end = cook.indexOf(";", begin);
		val = unescape(cook.substring(begin, end));
	}
	return val;
}

function closeLayerPop(pidx){
	if($("#popDay"+pidx).is(":checked")){
		setCoo_kie(pidx, "done"+pidx, 1);
	}
	$("#pop"+pidx).css("display","none");
}
function closeWinPop(pidx)     {
	if ($("#popDay"+pidx).is(":checked"))    {
		setCoo_kie(pidx, "done"+pidx, 1);
	}
	this.close();
}
function getPopUpOpenLayer(sName,sMove) {
	var noticeCookie = event_getCookie(sName);
	if (noticeCookie != "done"+sName) {
		$("#pop"+sName).css("display","block");
		if(sMove=="Y"){
			$("#pop"+sName).draggable();
		}
	}
}

function event_getCookie(name) {
	var nameOfCookie = name + "=";
	var x = 0;
	while (x <= document.cookie.length) {
		var y = (x + nameOfCookie.length);
		if (document.cookie.substring(x, y) == nameOfCookie) {
			if ((endOfCookie = document.cookie.indexOf(";", y)) == -1)
				endOfCookie = document.cookie.length;
			return unescape(document.cookie.substring(y, endOfCookie));
		}
		x = document.cookie.indexOf(" ", x) + 1;
		if (x == 0)
			break;
	}
	return "";
}
