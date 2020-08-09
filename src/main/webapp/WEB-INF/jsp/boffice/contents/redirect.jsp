<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/header.jsp"%>
<%
pageContext.setAttribute("CR", "\r");
pageContext.setAttribute("LF", "\n");
pageContext.setAttribute("CRLF", "\r\n");
pageContext.setAttribute("SP", "&nbsp;");
pageContext.setAttribute("BR", "<br/>");
%> 
<script type="text/javaScript" language="javascript">
alert("권한없는 접근입니다.");
location.href="/boffice/main.do";
</script>
</head>

	<h2 class="blind">본문</h2>
		<!-- Container -->
		<div class="container sub" id="container">
			<div class="cont">
				<h3 class="tit2 mt_60">REDIRECT</h3>
			</div>

		</div>
		<!-- //Container -->

<%@include file="../include/footer.jsp"%>