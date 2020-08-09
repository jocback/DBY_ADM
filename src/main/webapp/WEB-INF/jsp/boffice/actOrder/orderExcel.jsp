<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
br {mso-data-placement:same-cell;}
</style>

<table border="1">
<tr height="34">
	<th bgcolor="#FBEBF1">주문자</th>
	<th bgcolor="#FBEBF1">주문경로</th>
	<th bgcolor="#FBEBF1">강좌</th>
	<th bgcolor="#FBEBF1">수강구분</th>
	<th bgcolor="#FBEBF1">결제금액</th>
	<th bgcolor="#FBEBF1">결제수단</th>
</tr>
	 <c:forEach var="result" items="${orderList}" varStatus="status">
		<tr>
			<td rowspan="<c:out value="${result.subListCnt+1}"/>"><c:out value="${result.oName}"/></td>
			<td rowspan="<c:out value="${result.subListCnt+1}"/>">
				<c:if test="${result.mobile ne 'Y'}">PC</c:if><c:if test="${result.mobile eq 'Y'}">mobile</c:if>
			</td>
			<td class="al"><c:out value="${result.goods}"/></td>
			<td><c:if test="${result.mobileYn ne 'Y'}">PC</c:if><c:if test="${result.mobileYn eq 'Y'}">mobile</c:if></td>
			<td class="ar chkmoney"><c:out value="${result.price2}"/></td>
			<td rowspan="<c:out value="${result.subListCnt+1}"/>"><c:out value="${result.method2}"/></td>
		</tr>
	 <c:forEach var="resultSub" items="${result.subList}" varStatus="status">
		<tr>
			<td class="al"><c:out value="${resultSub.goods}"/></td>
			<td><c:if test="${resultSub.mobileYn ne 'Y'}">PC</c:if><c:if test="${resultSub.mobileYn eq 'Y'}">mobile</c:if></td>
			<td class="ar chkmoney"><c:out value="${resultSub.price2}"/></td>
		</tr>
	</c:forEach>
	</c:forEach>
</table>
