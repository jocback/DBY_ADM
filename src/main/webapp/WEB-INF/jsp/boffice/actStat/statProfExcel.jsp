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
	<th bgcolor="#FBEBF1">교수명</th>
	<th bgcolor="#FBEBF1">주문자</th>
	<th bgcolor="#FBEBF1">입금일</th>
	<th bgcolor="#FBEBF1">강좌명</th>
	<th bgcolor="#FBEBF1">구분</th>
	<th bgcolor="#FBEBF1">소비자가</th>
	<th bgcolor="#FBEBF1">할인금액</th>
	<th bgcolor="#FBEBF1">수강료</th>
	<th bgcolor="#FBEBF1">수강료제외금액</th>
	<th bgcolor="#FBEBF1">정산적용수강료</th>
	<th bgcolor="#FBEBF1">수수료율</th>
	<th bgcolor="#FBEBF1">수수료</th>
	<th bgcolor="#FBEBF1">수강구분</th>
	<th bgcolor="#FBEBF1">상태</th>
	<th bgcolor="#FBEBF1">주문일</th>
</tr>
						<c:set var="lectIdxE" value=""/>
						<c:set var="lectCnt" value="0"/>
						<c:set var="exPrice" value="0"/>
						<c:set var="payPrice" value="0"/>
						<c:set var="modPrice" value="0"/>
						<fmt:parseNumber var="feeAmt" integerOnly="true" value="0"/>
	<c:forEach var="result" items="${orderList}" varStatus="status">
  						<c:if test="${empty result.coIdx}">
	  						<c:if test="${result.lectureSno eq '0'}"><c:set var="lectIdxE" value="${result.jongNew}"/></c:if>
	  						<c:if test="${result.lectureSno ne '0'}"><c:set var="lectIdxE" value="${result.lectureSno}"/></c:if>
  						</c:if>
  						<c:if test="${result.coIdx eq '0' || result.coIdx*1 > 0}"><c:set var="lectIdxE" value="${result.pro}"/></c:if>
  						<c:set var="lectIdxE" value="${fn:split(lectIdxE,',')}"/>
  						<c:set var="lectCnt" value="${fn:length(lectIdxE)}"/>
  						<c:set var="payPrice" value="${result.price2*1+result.usePoint*1}"/>
  						<c:if test="${result.lectureSno ne '0'}">
  							<c:set var="exPrice" value="${result.exPrice}"/>
  							<c:set var="modPrice" value="${result.price2*1 - exPrice*1}"/>
  						</c:if>
  						<c:if test="${result.lectureSno eq '0'}">
  							<c:set var="exPrice" value="${result.exPriceJong}"/>
  							<c:set var="modPrice" value="${(result.price2*1 - exPrice*1)*1/lectCnt}"/>
  						</c:if>
  						<fmt:parseNumber var="feeAmt" integerOnly="true" value="${modPrice*(result.feeRate/100)}"/>
<tr>
	<td><c:out value="${status.index+1}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.tName}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.oName}"/></td>
	<td><c:out value="${result.payday}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.goods}"/><br/><c:out value="${result.subject}"/></td>
	<td>
		<c:if test="${result.lectureSno eq '0'}">종합(<c:out value="${lectCnt}"/>)</c:if>
		<c:if test="${result.lectureSno ne '0'}">단과</c:if>
		<c:if test="${result.freeBookCnt>0}"><br/>교재포함</c:if>
	</td>
	<td><c:out value="${result.price}"/></td>
	<td><c:out value="${result.price*1-payPrice}"/></td>
	<td><c:out value="${payPrice}"/></td>
	<td><c:out value="${exPrice}"/></td>
	<td><b><c:out value="${modPrice}"/></b></td>
	<td><c:out value="${result.feeRate}"/>%</td>
	<td><b><c:out value="${feeAmt}"/></b></td>
	<td style="mso-number-format:'\@'"><c:if test="${result.mobileYn eq 'Y'}"><span style='color:#fa485b;'>mobile</span></c:if><c:if test="${result.mobileYn eq 'N'}"><span style='color:#4a89f2;'>PC</span></c:if></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.status2}"/></td>
	<td><c:out value="${result.oDate}"/></td>
</tr>
  	</c:forEach>
</table>
