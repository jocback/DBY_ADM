<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<%@include file="../include/inc_log_corp.jsp"%>
	<title>대방열림 관리자</title>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/css/reset.css" />
	<link rel="stylesheet" href="/css/style.css" />
	<link rel="stylesheet" href="/css/dev.css" />
	<script src="//code.jquery.com/jquery-1.12.4.js"></script>
	<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="/js/jquery.mask.js"></script>
	<script src="/js/common.js"></script>
	<script src="/js/boffice/common.js"></script>
	<script type="text/javascript" src="/editor/dext5editor/js/dext5editor.js"></script>
	<script type="text/javascript">
	$(function(){
		<c:if test="${loginVO.groupLvl eq '20'}">
		var url = '/boffice/activity/actCodeList.do';
		var param = {
				codeId: "COM042",
		};
		</c:if>
		<c:if test="${loginVO.groupLvl ne '20'}">
		var url = '/boffice/activity/actMenuCodeList.do';
		var param = {
				codeId: "COM041"
		};
		</c:if>
		commonUtil.AjaxSynCall(url,param,'json','',fnAjaxMainMenuCallBack);
	});
	function fnAjaxMainMenuCallBack(result){
		var infoCodeList = result.ajaxCodeResult;
		var mainStr = "";
		var subStr = "";
		var menuName = "";
		$("#subMenuList").empty();
		$("#mainMenuList").empty();
		for(var i=0; i<infoCodeList.length; i++){
			menuName = infoCodeList[i].codeNm;
			<c:if test="${loginVO.groupLvl ne '20'}">
			menuName = infoCodeList[i].codeEtc3;
			</c:if>
			mainStr = mainStr + '<li id="mainMenu'+infoCodeList[i].seq+'"><a href="'+infoCodeList[i].codeEtc2+'"><span> <img src="/img/gnbIcon'+(i+1)+'.jpg" alt="">'+menuName+'</span></a></li>';
		}
		$("#mainMenuList").append(mainStr);
		fnAjaxSubMenuListCall();
	}
	function fnAjaxSubMenuListCall(){
		//var currPath = window.location.pathname;
		var url = '/boffice/activity/actMenuCodeList.do';
		var param = {
				codeId: "COM041",
				menuCode: "<c:out value='${menuCode}'/>"
		};
		commonUtil.AjaxSynCall(url,param,'json','',fnAjaxSubMenuListCallBack);
	}
	function fnAjaxSubMenuListCallBack(result){
		var infoCodeList = result.ajaxCodeResult;
		var styleRed;
		for(var i=0; i<infoCodeList.length; i++){
			//"<c:out value='${menuCode}'/>"==infoCodeList[i].code?styleRed=' class="on"':styleRed='';
			$('#subMenuList').append( '<li id="subMenu'+infoCodeList[i].code+'"><a href="javascript:void(0);" onclick="javascript:fnActMenu(\''+infoCodeList[i].codeEtc2+'\');">'+infoCodeList[i].codeNm+'</a></li>');
		}
		var mMSeq = (infoCodeList[0].seq).substring(0,2);
		//alert($("#mainMenu"+mMSeq+"0").find("span").text());
		var mMname = $("#mainMenu"+mMSeq+"0").find("span").text();
		$(".lnb").find("span").html('<img src="/img/lnbIcon'+(mMSeq-10)+'.jpg" alt="'+mMname+' 아이콘" \/>'+mMname);
		//$("#mainMenuList").find("li").removeClass("on");
		$("#mainMenu"+mMSeq+"0").addClass("on");
		$("#subMenu<c:out value='${menuCode}'/>").addClass("on");
	}
	function fnActMenu(url){
		document.frmMenu.action = url;
		document.frmMenu.submit();
	}
	</script>
</head>
<body>
	<header class="gnbMenu">
		<div class="gnbTop">
			<form name="frmMenu" id="frmMenu" method="post">
			<input type="hidden" name="webMode" value="menu"/>
			</form>
			<h1><a href=""></a></h1>
			<span><c:out value="${loginVO.name}"/>님 로그인 중입니다. </span>
			<ul>
				<li class="home"><a href="/boffice/main.do">HOME</a></li>
				<li class="homepage"><a href="http://www.yulimgosi.com" target="_blank">학원홈페이지</a></li>
				<li class="logout"><a href="/boffice/actionLogout.do">로그아웃</a></li>
			</ul>
		</div>
		<div class="gnb">
			<ul id="mainMenuList"></ul>
		</div>
	</header>
