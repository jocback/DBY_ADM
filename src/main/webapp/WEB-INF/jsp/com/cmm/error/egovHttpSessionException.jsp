<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="X-UA-Compatible" content="text/html; charset=utf-8;IE=edge,chrome=1" />
	<title>전쟁기념관</title>
	<link rel="stylesheet" type="text/css" href="/css/common.css"  media="all" />
	<script type="text/javascript" src="/js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="/js/front/common.js"></script>
	<script type="text/javascript" src="/js/jquery.bxslider.min.js" ></script>
	<!--[if lte IE 8]>
	<script src="path/to/poly-checked.min.js"></script>
	<![endif]-->
	<script language="javascript">
	function fncGoAfterErrorPage(){
	    history.back(-2);
	}
	</script>
</head>
<body style="overflow:hidden;">
	<!-- Skip Nav -->
	<div id="skipnavigation">
		<a href="#container">본문내용 바로가기</a>
	</div>
	<!-- //Skip Nav -->

	<!-- Wrap -->
	<div class="wrap front">

	<h2 class="blind">본문</h2>
		<!-- Container -->
		<div class="container sub" id="container">


			<div class="cont">

				<div class="ta_c" style="margin-top:130px;">
					<img src="/images/front/error/error404.jpg" alt="" />
				</div>

				<div class="ta_c" style="margin-top:30px;">					
					<a href="/" class="ib"><img src="/images/front/error/btn_main.jpg" alt="" /></a>
					<a href="javascript:fncGoAfterErrorPage();" class="ib" style="margin-left:7px"><img src="/images/front/error/btn_prev.jpg" alt="" /></a>
				</div>

			</div>
			<!-- //cont -->
		</div>
		<!-- //Container -->

	</div>
	<!-- //Wrap -->
</body>
</html>