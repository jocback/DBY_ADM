<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<title>대방열림고시학원 관리자</title>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/css/jquery-ui.min.css" />
	<link rel="stylesheet" href="/css/reset.css" />
	<link rel="stylesheet" href="/css/style.css" />
	<script src="//code.jquery.com/jquery-1.12.4.js"></script>
	<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="/js/jquery.mask.js"></script>
	<script src="/js/common.js"></script>
	<script src="/js/boffice/common.js"></script>
<script type="text/javaScript">

function checkLogin(userSe) {
      document.loginForm.rdoSlctUsr[0].checked = false;
      document.loginForm.rdoSlctUsr[1].checked = false;
      document.loginForm.rdoSlctUsr[2].checked = true;
      document.loginForm.userSe.value = "USR";
}

function actionLogin() {
    if (document.loginForm.id.value =="") {
        alert("아이디를 입력하세요");
    } else if (document.loginForm.password.value =="") {
        alert("비밀번호를 입력하세요");
    } else {
        document.loginForm.action="/boffice/actionLogin.do";
        //document.loginForm.j_username.value = document.loginForm.userSe.value + document.loginForm.username.value;
        //document.loginForm.action="/j_spring_security_check";
        document.loginForm.submit();
    }
}

function actionCrtfctLogin() {
    document.defaultForm.action="/uat/uia/actionCrtfctLogin.do";
    document.defaultForm.submit();
}

function setCookie (name, value, expires) {
    document.cookie = name + "=" + escape (value) + "; path=/; expires=" + expires.toGMTString();
}

function getCookie(Name) {
    var search = Name + "=";
    if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
        offset = document.cookie.indexOf(search);
        if (offset != -1) { // 쿠키가 존재하면
            offset += search.length;
            // set index of beginning of value
            end = document.cookie.indexOf(";", offset);
            // 쿠키 값의 마지막 위치 인덱스 번호 설정
            if (end == -1)
                end = document.cookie.length;
            return unescape(document.cookie.substring(offset, end));
        }
    }
    return "";
}

function saveid(form) {
    var expdate = new Date();
    // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
    if (form.checkId.checked)
        expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
    else
        expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건
    setCookie("saveid", form.id.value, expdate);
}

function getid(form) {
    form.checkId.checked = ((form.id.value = getCookie("saveid")) != "");
}

$(document).ready(function(){
	if ("<c:out value='${messageLogin}'/>" != "" && "<c:out value='${message}'/>" == "") {
		alert("<c:out value='${messageLogin}'/>");
	}
	if ("<c:out value='${message}'/>" != "") {
		alert("<c:out value='${message}'/>");
	}
	if("<c:out value='${loginVo.id}'/>"){
		actionLogin();
	}
	if("<c:out value='${message}'/>"=="비밀번호를 변경하여주세요."){
		document.frm.action="<c:url value='/front/changePass.do'/>";
		document.frm.submit();
	}
});

</script>
</head>
<body class="loginPage">

      <div class="wrap">
        <form name="loginForm" action ="/boffice/actionLogin.do" method="post">
			<div style="visibility:hidden;display:none;"><input name="iptSubmit1" type="submit" value="전송" title="전송"></div>
			
			<input type="hidden" id="message" name="message" value="<c:out value='${message}'/>">
          <fieldset>
            <section class="login">
              <div class="imgsection">
                <img src="/img/loginImg.jpg" alt="">
              </div>
              <div>
                <h1><img src="/img/login_logo.jpg" alt="대방열림고시학원"></h1>
                <legend>로그인</legend>
                <input type="text" name="id" id="id" placeholder="아이디" class="req" title="아이디를 입력해주세요.">
                <input type="password" name="password" id="password" placeholder="비밀번호" onKeyDown="javascript:if (event.keyCode == 13) { actionLogin(); }">
                <button type="button" onClick="actionLogin()">로그인</button>
              </div>
            </section>
        </fieldset>
		<input name="userSe" type="hidden" value="USR"/>
		<input name="j_username" type="hidden"/>
      </form>
      </div>
</body>
</html>
