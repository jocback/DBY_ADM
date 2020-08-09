<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
br {mso-data-placement:same-cell;}
</style>

<table border="1">
<tr height="34">
	<th bgcolor="#FBEBF1">번호</th>
	<th bgcolor="#FBEBF1">아이디</th>
	<th bgcolor="#FBEBF1">이름</th>
	<th bgcolor="#FBEBF1">전화번호</th>
	<th bgcolor="#FBEBF1">휴대폰번호</th>
	<th bgcolor="#FBEBF1">구분</th>
	<th bgcolor="#FBEBF1">수강강의</th>
	<th bgcolor="#FBEBF1">시작일</th>
	<th bgcolor="#FBEBF1">종료일</th>
	<th bgcolor="#FBEBF1">수강상태</th>
</tr>
	<c:forEach var="result" items="${orderList}" varStatus="status">
<tr>
	<td><c:out value="${status.index+1}"/></td>
	<td><c:out value="${result.uid}"/></td>
	<td><c:out value="${result.oName}"/></td>
	<td><c:out value="${result.oTel}"/></td>
	<td><c:out value="${result.oHand}"/></td>
	<td><c:if test="${result.mobileYn2 eq 'Y'}"><div class=ord-mobile>mobile</div></c:if><c:if test="${result.mobileYn2 eq 'N'}"><div class=ord-pc>PC</div></c:if></td>
	<td class="al"><span><c:out value="${result.goods}"/></td>
	<td><c:out value="${result.bsinDate}"/></td>
	<td><c:out value="${result.bsinDate2}"/></td>
	<td><c:out value="${result.status2}"/></td>
</tr>
  	</c:forEach>
</table>
