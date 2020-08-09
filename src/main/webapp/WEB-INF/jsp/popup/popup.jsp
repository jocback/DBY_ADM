<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>전쟁기념관</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/front/reset.css' />"  media="all" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/front/layout.css' />"  media="all" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/front/content.css' />"  media="all" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/front/board.css' />"  media="all" />

	<script type="text/javascript" src="<c:url value='/js/jquery-1.11.3.min.js' />" ></script>
	<script type="text/javascript" src="<c:url value='/js/jquery.fancybox.js' />" ></script>
	<script type="text/javascript" src="<c:url value='/js/common.js' />" ></script>
	<script type="text/javascript" src="<c:url value='/js/jquery.bxslider.min.js' />" ></script>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/front/main.css' />"  media="all" />
<script type="text/javascript" src="<c:url value='/js/main.js' />" ></script>
<script type="text/javascript" src="<c:url value='/js/cookieSet.js' />" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js' />" ></script>
<style type="text/css">
<!--
#contents {position:relative; display:block; height:<c:out value="${popupManageVO.popupHSize-23}"/>px;overflow:hidden;}
#bottom {position:relative; display:block;font-size:9pt}

//-->
</style>

</head>
<body style="overflow:hidden;padding:0;margin:0;">
<div id="contents" style="padding:0;margin:0;">
<c:out value="${popupManageVO.popupCn}" escapeXml="false"/>
</div>
<div id="bottom">
<c:if test="${stopVewAt eq 'Y'}">
<div style='background-color:#000000;width:100%;height:25px;text-align:left;position:absolute;left:-1px;float:bottom;border:1px solid black;overflow:hidden;'>
<span style='padding-left:5px;font-size:11px;font-family:dotum;color:#FFFFFF;line-height:25px;width:70%;height:25px;text-align:left;float:left;'>
<input type='checkbox' id='popDay<c:out value="${popupManageVO.popupId}"/>'>오늘 하루 보지 않기</span>
<span style='font-size:11px;font-family:dotum;color:#FFFFFF;line-height:25px;width:25%;height:25px;text-align:right;cursor:pointer;float:left;' onClick='javascript:closeWinPop("<c:out value="${popupManageVO.popupId}"/>")'>닫기</span>
</c:if>
</div>

</body>
</html>
