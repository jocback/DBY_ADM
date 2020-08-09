<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>



<!DOCTYPE html>
<html lang="ko">
<head>
	<title>대방열림 관리자</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<link rel="stylesheet" type="text/css" href="/css/boffice/common.css"  media="all" />
	<link rel="stylesheet" type="text/css" href="/css/codeErr.css"  media="all" />
	<script type="text/javascript" src="/js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="/js/jquery.bxslider.min.js" ></script>
	<!--[if lte IE 8]>
	<script src="path/to/poly-checked.min.js"></script>
	<![endif]-->
	<script type="text/javascript">
	function fncGoAfterErrorPage(){
	    history.back(-2);
	}
	</script>
</head>
<body>
	<div class="codeErrWrap">
		<div class="codeErr">
			
			<div class="imgWrap">
				<img src="/images/pcErr.jpg" alt="" />
				
			</div>
			
			<div class="textWrap">
				<h1>
					<img class="mobilenone" src="/images/logoErr.jpg" alt="" />
					<img class="penone" src="/images/logoErr_m.jpg" alt="" />
				</h1>
			
				<p class="tit">죄송합니다. 현재 찾을 수 없는 페이지를 요청 하셨습니다.</p>
				<p>존재하지 않는 주소를 입력하셨거나, 요청하신 페이지의 주소가 변경, 삭제되어 찾을 수 없습니다. <br/>궁금한 점이 있으시면 언제든 고객센터를 통해 문의해 주시기 바랍니다.</p>
				
				<ul class="btnWrap">
					<li><a href="/">메인으로</a></li>
					<li><a href="javascript:void(0);" onclick="javascript:fncGoAfterErrorPage();">이전 페이지</a></li>
				</ul>
			</div>
			
		</div>
	</div>
</body>
</html>