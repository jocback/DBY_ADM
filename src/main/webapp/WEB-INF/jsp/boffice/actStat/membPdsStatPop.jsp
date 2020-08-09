<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/headerPop.jsp"%>

  <!--listTable-->
  <p class="total" style="margin-top:4px;"></p>
	<table class="commonTable">
		<caption>수강 회원 관리 - 자료실 파일 다운 현황</caption>
		<colgroup>
			<col width="40">
			<col>
			<col width="350">
			<col width="90">
			<col width="80">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">제목</th>
				<th scope="col">파일명</th>
				<th scope="col">작성일</th>
				<th scope="col">다운로드</th>
			</tr>
		</thead>
		<tbody>
	 <c:forEach var="result" items="${bbsList}" varStatus="status">
			<tr>
				<td><c:out value="${status.index+1}"/></td>
				<td><c:out value="${fn:substring(result.nttSj,0,30)}" escapeXml="false"/><c:if test="${fn:length(result.nttSj)>30}">...</c:if></td>
				<td><c:out value="${result.fileNm}"/></td>
				<td><c:out value="${result.nttRegdt}"/></td>
				<td><c:out value="${result.dCnt}"/></td>
			</tr>
	</c:forEach>
		</tbody>
	</table>
  <!--//listTable-->

<%@include file="../include/footer.jsp"%>