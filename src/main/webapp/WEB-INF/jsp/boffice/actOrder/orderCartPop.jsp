<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/headerPop.jsp"%>
<body class="pop">

	<p style="text-align:right;margin-bottom:6px">
		<span class="total_left" style="float:left">총 <strong><c:out value="${paginationInfo.totalRecordCount}"/></strong>개</span>
		<span class="btnsWrap">
			<button type="button" class="act_clear" style="width:160px;height:28px">장바구니 비우기</button>
		</span>
	</p>

	<!--listTable-->
	<table class="commonTable">
		<caption>회원 검색 테이블</caption>
		<colgroup>
			<col width="40">
			<col width="100">
			<col>
			<col width="90">
			<col width="140">
			<col width="90">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">구분</th>
				<th scope="col">강의명/교재명/상품명</th>
				<th scope="col">정가</th>
				<th scope="col">할인</th>
				<th scope="col">금액</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td class="list-no"><c:out value="${status.index}"/></td>
				<td>
					<c:if test="${result.ocGubun eq '11'}">단과</c:if>
					<c:if test="${result.ocGubun eq '12'}">종합</c:if>
					<c:if test="${result.ocGubun eq '13'}">교재</c:if>
				</td>
				<td class="al">
					<c:if test="${result.ocGubun ne '13'}"><c:out value="${result.ocSubject}"/></c:if>
					<c:if test="${result.ocGubun eq '13'}"><c:out value="${result.ocBook}"/></c:if>
				</td>
				<td class="ar chkmoney"><c:out value="${result.ocPrice}"/></td>
				<td class="ar chkmoney"><c:out value="${result.ocPrice - result.ocEstiPrice}"/></td>
				<td class="ar chkmoney"><c:out value="${result.ocEstiPrice}"/></td>
			</tr>
		</c:forEach>
		<c:if test="${empty resultList}">
			<tr class="allmerge">
				<td>장바구니에 담긴 상품이 없습니다.</td>
			</tr>
		</c:if>
		</tbody>
	</table>
  <!--//listTable-->

<script>
$(function() {
	$(document).on('click', '.act_clear', function() {
		if (!confirm('회원의 장바구니에 담긴 상품을 모두 삭제하시겠습니까?')) {
			return;
		}
		var url = "/boffice/actOrder/actOrderCartDel.do";
		var param = {mId:"<c:out value='${orderVO.mId}'/>"}
		if(commonUtil.AjaxSynCall(url,param) == "success"){
			location.reload();
		}else{
			alert("오류가 발생하였습니다. 다시 시동하여 주세요.");
		}
	});
});
</script>
</body>

<%@include file="../include/footer.jsp"%>