<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
br {mso-data-placement:same-cell;}
</style>

<c:if test="${orderVO.searchOp1 eq '2'}">
<table border="1">
<tr height="34">
	<th bgcolor="#FBEBF1">번호</th>
	<th bgcolor="#FBEBF1">교수명</th>
	<th bgcolor="#FBEBF1">질문수</th>
	<th bgcolor="#FBEBF1">답변수</th>
	<th bgcolor="#FBEBF1">답변률</th>
</tr>
	<c:forEach var="result" items="${orderList}" varStatus="status">
<tr>
	<td><c:out value="${status.index+1}"/></td>
	<td><c:out value="${result.name}"/></td>
	<td><c:out value="${result.cnt}"/></td>
	<td><c:out value="${result.ans}"/></td>
	<td><c:out value="${result.rate}"/></td>
</tr>
  	</c:forEach>
</table>
</c:if>
<c:if test="${orderVO.searchOp1 eq '1'}">
<table border="1">
<tr height="34">
	<th bgcolor="#FBEBF1">번호</th>
	<th bgcolor="#FBEBF1">강좌등록일시</th>
	<th bgcolor="#FBEBF1">강좌명</th>
	<th bgcolor="#FBEBF1">교수명</th>
	<th bgcolor="#FBEBF1">질문수</th>
	<th bgcolor="#FBEBF1">답변수</th>
	<th bgcolor="#FBEBF1">답변률</th>
</tr>
	<c:forEach var="result" items="${orderList}" varStatus="status">
<tr>
	<td><c:out value="${status.index+1}"/></td>
	<td><c:out value="${fn:substring(result.wdate,0,19)}"/></td>
	<td><c:out value="${result.goods}"/></td>
	<td><c:out value="${result.name}"/></td>
	<td><c:out value="${result.cnt}"/></td>
	<td><c:out value="${result.ans}"/></td>
	<td><c:out value="${result.rate}"/></td>
</tr>
  	</c:forEach>
</table>
</c:if>
