<%@page contentType="text/html;charset=utf-8"%>
<%@include file="../include/header.jsp"%>
<script type="text/javascript">

function fnActOrderList(){
	document.frmForm.action = "/boffice/actFreeLect/actFreeLectView.do";
	document.frmForm.target = "_parent";
	document.frmForm.submit();
}
$(document).on('click', '.act_lecture', function() {
	dialog_doc('수강현황', '/boffice/actMemb/actMembLectStatPop.do?orderSno=0&mobileYn=<c:out value='${freeVO.fmEq}'/>&ID=<c:out value='${freeVO.regid}'/>&fmIdx=<c:out value="${orderInfo.fmIdx}"/>&mvIdx='+$(this).data('no'), 1000, 780);
	return false;
});
$(document).on('click', '.act_bbs', function() {
	dialog_doc('자료다운현황', '/boffice/actMemb/actMembPdsStatPop.do?bbsId=BBS_0007&ntcrId=<c:out value='${freeVO.regid}'/>&nttCat='+$(this).data('no'), 1000, 780);
	return false;
});

</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>수강 회원 관리 - 수강 현황</h3>
				<div class="btnWrap">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_list" onclick="javascript:fnActOrderList();">목록</button>
				</div>
			</div>
			<div class="realCont">

				<form name="frmForm" id="frmForm" method="post">
					<input type="hidden" name="pageIndex" value="<c:out value="${freeVO.pageIndex}"/>">
					<input type="hidden" name="searchCnd" value="<c:out value="${freeVO.searchCnd}"/>">
					<input type="hidden" name="searchKeyword" value="<c:out value="${freeVO.searchKeyword}"/>">
					<input type="hidden" name="searchOp1" value="<c:out value="${freeVO.searchOp1}"/>">
					<input type="hidden" name="searchOp2" value="<c:out value="${freeVO.searchOp2}"/>">
				
					<input type="hidden" name="fmIdx" id="fmIdx" value='<c:out value="${orderInfo.fmIdx}"/>' />
				
  <fieldset>
	<table class="commonTable detailTable">
		<caption>수강현황 테이블</caption>
		<colgroup>
			<col width="100">
			<col>
			<col width="150">
			<col width="250">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">구분</th>
				<th scope="col">강의명</th>
				<th scope="col">전체 수강 현황</th>
				<th scope="col">기간</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>무료강의</td>
				<td><c:out value="${orderInfo.fmSubject}"/></td>
				<td><c:out value="${orderInfo.playEvrg}"/></td>
				<td><c:out value="${orderInfo.sinDate}"/> ~ <c:out value="${orderInfo.sinDate2}"/></td>
			</tr>
		</tbody>
	</table>
  </fieldset>

  <fieldset>
	<p style="font-size:16px;padding:10px 0 7px 0;">강의리스트</p>
	<table class="commonTable detailTable">
		<caption>강의리스트 테이블</caption>
		<colgroup>
			<col width="100">
			<col>
			<col width="150">
			<col width="125">
			<col width="125">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">강의명</th>
				<th scope="col">전체 수강 현황</th>
				<th scope="col">상세보기</th>
				<th scope="col">자료 다운 횟수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="lectList" items="${orderInfo.lectList}" varStatus="status">
			<tr>
				<td><c:out value="${status.index+1}"/></td>
				<td><c:out value="${lectList.mvSubject}"/></td>
				<td><c:out value="${lectList.playRate}"/></td>
				<td><button type="button" class="commonBtn act_lecture" data-no="<c:out value="${lectList.mvIdx}"/>">수강현황</button></td>
				<td><button type="button" class="commonBtn act_bbs" data-no="<c:out value="${lectList.mvIdx}"/>" style="width:60px;"><c:out value="${lectList.downSum}"/></button></td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
  </fieldset>

			</div>
		</section>

	</section>

	<%@include file="../include/footer.jsp"%>