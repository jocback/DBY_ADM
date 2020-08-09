<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/headerPop.jsp"%>

  <!--listTable-->
  <p class="total" style="margin-top:4px;"></p>
	<table class="commonTable">
		<caption>수강 회원 관리 - 수강 현황</caption>
		<colgroup>
			<col width="40">
			<col>
			<col width="160">
			<col width="90">
			<col width="90">
			<col width="80">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">강의명</th>
				<th scope="col">최종수강일시</th>
				<th scope="col">강좌시간(m)</th>
				<th scope="col">수강시간(m)</th>
				<th scope="col">수강률(%)</th>
			</tr>
		</thead>
		<tbody>
	 <c:forEach var="result" items="${clipList}" varStatus="status">
			<tr>
				<td><c:out value="${status.index+1}"/></td>
				<td><c:out value="${result.cpTitle}"/></td>
				<td>
					<c:if test="${empty result.playTime || result.playTime eq '0'}">-</c:if>
					<c:if test="${!empty result.playTime && result.playTime ne '0'}"><c:out value="${result.endTime}"/></c:if>
				</td>
				<td><c:out value="${result.cpTime}"/></td>
				<td>
					<c:if test="${empty result.playTime || result.playTime eq '0'}">-</c:if>
					<c:if test="${!empty result.playTime && result.playTime ne '0'}"><c:out value="${result.playTime}"/></c:if>
				</td>
				<td>
					<c:if test="${empty result.playTime || result.playTime eq '0'}">-</c:if>
					<c:if test="${!empty result.playTime && result.playTime ne '0'}">
					<b class="progressBar text-center">
					<i class="colorBar" style="width: <c:out value="${result.playRate}"/>%"></i>
					<i class="num"><c:out value="${result.playRate}"/>%</i></b>
					</c:if>
				</td>
			</tr>
	</c:forEach>
		</tbody>
	</table>
  <!--//listTable-->

<%@include file="../include/footer.jsp"%>