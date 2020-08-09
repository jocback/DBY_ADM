<%@page contentType="text/html;charset=utf-8"%>
<%@include file="../include/header.jsp"%>
<script type="text/javascript">

function fnActOrderList(){
	document.frmForm.action = "/boffice/actMemb/actMembLectList.do";
	document.frmForm.submit();
}
$(document).on('click', '.act_lecture', function() {
	dialog_doc('수강현황', '/boffice/actMemb/actMembLectStatPop.do?orderSno=<c:out value='${orderInfo.lsno}'/>&mobileYn=<c:out value='${orderInfo.mobileYn}'/>&ID=<c:out value='${orderInfo.uid}'/>&mvIdx='+$(this).data('no'), 1000, 780);
	return false;
});
$(document).on('click', '.act_bbs', function() {
	dialog_doc('수강현황', '/boffice/actMemb/actMembPdsStatPop.do?bbsId=BBS_0007&ntcrId=<c:out value='${orderInfo.uid}'/>&nttCat='+$(this).data('no'), 1000, 780);
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
					<input type="hidden" name="pageIndex" value="<c:out value='${orderVO.pageIndex}'/>">
					<input name="searchOp1" type="hidden" value="<c:out value='${orderVO.searchOp1}'/>"/>
					<input name="searchOp2" type="hidden" value="<c:out value='${orderVO.searchOp2}'/>"/>
					<input name="searchOp3" type="hidden" value="<c:out value='${orderVO.searchOp3}'/>"/>
					<input name="searchOp6" type="hidden" value="<c:out value='${orderVO.searchOp6}'/>"/>
					<input type="hidden" name="searchCnd" value="<c:out value='${orderVO.searchCnd}'/>">
					<input type="hidden" name="searchKeyword" value="<c:out value='${orderVO.searchKeyword}'/>">
					<input type="hidden" name="searchSdt2" value="<c:out value='${orderVO.searchSdt2}'/>">
					<input type="hidden" name="searchEdt2" value="<c:out value='${orderVO.searchEdt2}'/>">
				
  <c:if test="${orderInfo.lectureSno ne '0'}">
  <fieldset>
	<table class="commonTable detailTable">
		<caption>수강현황 테이블</caption>
		<colgroup>
			<col width="100">
			<col>
			<col width="120">
			<col width="200">
			<col width="125">
			<col width="125">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">구분</th>
				<th scope="col">강의명</th>
				<th scope="col">전체 수강 현황</th>
				<th scope="col">기간</th>
				<th scope="col">상세보기</th>
				<th scope="col">자료 다운 횟수</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>단과반</td>
				<td><c:out value="${orderInfo.goods}"/></td>
				<td><c:out value="${orderInfo.playRate}"/></td>
				<td><c:out value="${orderInfo.sinDate}"/> ~ <c:out value="${orderInfo.sinDate2}"/></td>
				<td><button type="button" class="commonBtn act_lecture" data-no="<c:out value="${orderInfo.lectureSno}"/>">수강현황</button></td>
				<td><button type="button" class="commonBtn act_bbs" data-no="<c:out value="${orderInfo.lectureSno}"/>" style="width:60px;"><c:out value="${orderInfo.downSum}"/></button></td>
			</tr>
		</tbody>
	</table>
  </fieldset>
  </c:if>


  <c:if test="${orderInfo.lectureSno eq '0'}">
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
				<td>종합반</td>
				<td><c:out value="${orderInfo.goods}"/></td>
				<td><c:out value="${orderInfo.playEvrg}"/></td>
				<td><c:out value="${orderInfo.sinDate}"/> ~ <c:out value="${orderInfo.sinDate2}"/></td>
			</tr>
		</tbody>
	</table>
  </fieldset>

  <fieldset>
	<p style="font-size:16px;padding:10px 0 7px 0;">연장신청</p>
	<table class="commonTable detailTable">
		<caption>연장신청 테이블</caption>
		<colgroup>
			<col width="100">
			<col>
			<col width="150">
			<col width="250">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">차수</th>
				<th scope="col">연장 일수</th>
				<th scope="col">결제금액</th>
				<th scope="col">연장된 기간</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="extList" items="${orderExtList}" varStatus="status">
			<tr>
				<td><c:out value="${status.index+1}"/></td>
				<td><c:out value="${extList.giganDay}"/></td>
				<td class="chkmoney"><c:out value="${extList.payPrice}"/></td>
				<td><c:out value="${extList.sinDate3}"/></td>
			</tr>
			</c:forEach>
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
  </c:if>

			</div>
		</section>

	</section>

	<%@include file="../include/footer.jsp"%>