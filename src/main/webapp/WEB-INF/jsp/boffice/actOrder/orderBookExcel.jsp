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
	<th bgcolor="#FBEBF1">수취인명</th>
	<th bgcolor="#FBEBF1">우편번호</th>
	<th bgcolor="#FBEBF1">주소1</th>
	<th bgcolor="#FBEBF1">주소2</th>
	<th bgcolor="#FBEBF1">전화번호</th>
	<th bgcolor="#FBEBF1">휴대폰번호</th>
	<th bgcolor="#FBEBF1">주문상품</th>
</tr>
	 <c:forEach var="result" items="${orderList}" varStatus="status">
	<tr>
		<td class="list-no"><c:out value="${status.index+1}"/></td>
		<td style="mso-number-format:'\@'"><c:out value="${result.rName}"/></td>
		<td style="mso-number-format:'\@'"><c:out value="${result.rZip}"/></td>
		<td style="mso-number-format:'\@'"><c:out value="${result.rAdd}"/></td>
		<td style="mso-number-format:'\@'"><c:out value="${result.rAdd2}"/></td>
		<td style="mso-number-format:'\@'"><c:out value="${result.rTel}"/></td>
		<td style="mso-number-format:'\@'"><c:out value="${result.rHand}"/></td>
		<td style="mso-number-format:'\@'"><c:out value="${result.pName}"/></td>
	</tr>
	</c:forEach>
</table>
