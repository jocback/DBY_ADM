<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
br {mso-data-placement:same-cell;}
</style>

<table border="1">
<tr>
	<th bgcolor="#FBEBF1" colspan="2">총 주문 수</th>
	<td colspan="4"><c:out value="${fn:length(orderList)}"/></td>
	<th bgcolor="#FBEBF1" colspan="2">총 금액</th>
	<td><c:out value="${sumInfo.sumPrice}"/></td>
</tr>
</table>

<table border="1">
<tr height="34">
	<th bgcolor="#FBEBF1">번호</th>
	<th bgcolor="#FBEBF1">이름</th>
	<th bgcolor="#FBEBF1">주문일</th>
	<th bgcolor="#FBEBF1">구분</th>
	<th bgcolor="#FBEBF1">상품명</th>
	<th bgcolor="#FBEBF1">금액</th>
	<th bgcolor="#FBEBF1">상태</th>
	<th bgcolor="#FBEBF1">결제수단</th>
	<th bgcolor="#FBEBF1">입금일</th>
</tr>
	<c:forEach var="result" items="${orderList}" varStatus="status">
<tr>
	<td><c:out value="${status.index+1}"/></td>
	<td><c:out value="${result.oName}"/></td>
	<td><c:out value="${result.oDate}"/></td>
	<td><c:if test="${result.mobileOrderYn eq 'Y'}"><span style='color:#fa485b;'>mobile</span></c:if><c:if test="${result.mobileOrderYn ne 'Y'}"><span style='color:#4a89f2;'>PC</span></c:if></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.pName}"/></td>
	<td><c:out value="${result.pTotal}"/></td>
	<td><c:out value="${result.status}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.method}"/></td>
	<td>
		<c:if test="${result.status eq '결제완료' || result.status eq '거래완료' || fn:substring(result.status,0,2) eq '배송'}"><c:out value="${result.payday}"/></c:if>
		<c:if test="${result.status eq '입금요' || result.status eq '취소'}">-</c:if>
	</td>
</tr>
  	</c:forEach>
</table>
