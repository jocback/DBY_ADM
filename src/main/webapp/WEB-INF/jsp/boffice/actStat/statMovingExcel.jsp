<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
br {mso-data-placement:same-cell;}
</style>

<table border="1">
<tr>
	<th bgcolor="#FBEBF1" colspan="2">총 수강신청</th>
	<td colspan="4"><c:out value="${fn:length(orderList)}"/></td>
	<th bgcolor="#FBEBF1" colspan="2">총 금액</th>
	<td colspan="4"><c:out value="${sumInfo.sumPrice}"/></td>
</tr>
</table>

<table border="1">
<tr height="34">
	<th bgcolor="#FBEBF1">번호</th>
	<th bgcolor="#FBEBF1">이름</th>
	<th bgcolor="#FBEBF1">주문일</th>
	<th bgcolor="#FBEBF1">수강구분</th>
	<th bgcolor="#FBEBF1">강좌명</th>
	<th bgcolor="#FBEBF1">수강료</th>
	<th bgcolor="#FBEBF1">상태</th>
	<th bgcolor="#FBEBF1">교수명</th>
	<th bgcolor="#FBEBF1">결제수단</th>
	<th bgcolor="#FBEBF1">입금일</th>
	<th bgcolor="#FBEBF1">수강시작일</th>
	<th bgcolor="#FBEBF1">수강종료일</th>
</tr>
	<c:forEach var="result" items="${orderList}" varStatus="status">
<tr>
	<td><c:out value="${status.index+1}"/></td>
	<td><c:out value="${result.oName}"/></td>
	<td><c:out value="${result.oDate}"/></td>
	<td><c:if test="${result.mobileYn2 eq 'Y'}"><span style='color:#fa485b;'>mobile</span></c:if><c:if test="${result.mobileYn2 eq 'N'}"><span style='color:#4a89f2;'>PC</span></c:if></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.goods}"/></td>
	<td><c:out value="${result.bprice2}"/></td>
	<td><c:out value="${result.status2}"/></td>
	<td style="mso-number-format:'\@'"><c:if test="${result.lectureSno eq '0'}">종합</c:if><c:if test="${result.lectureSno ne '0'}"><c:out value="${result.tName}"/></c:if></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.method}"/></td>
	<td><c:out value="${result.payday}"/></td>
	<td><c:out value="${result.bsinDate}"/></td>
	<td><c:out value="${result.bsinDate2}"/></td>
</tr>
  	</c:forEach>
</table>
