<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/header.jsp"%>
	<script type="text/javascript">

	function press(event) {
		if (event.keyCode==13) {
			fnActMembList('1');
		}
	}
	function fnActMembList(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "/boffice/actMemb/actMembDelList.do";
		document.frm.submit();
	}

	function fnActCancelDel(didx,midx,did){
		if (confirm('탈퇴 취소 하시겠습니까?')) {
			var url = '/boffice/actMemb/cancelDelActMemb.do';
			var formData = {dIdx : didx, mIdx : midx, dId : did};
			var param = formData;
			if(commonUtil.AjaxSynCall(url,param,'text','처리되었습니다.') == "success"){
				fnActMembList(document.frm.pageIndex.value);
			}
		}
	}

	function fnActWithDraw(didx,midx,did){
		if (confirm('정보 삭제 하시겠습니까?\n처리 시 등록된 개인 정보가 삭제되며 복구할 수 없습니다.')) {
			var url = '/boffice/actMemb/withdrawActMembInfo.do';
			var formData = {dIdx : didx,mIdx : midx,dId : did};
			var param = formData;
			if(commonUtil.AjaxSynCall(url,param,'text','처리되었습니다.') == "success"){
				fnActMembList(document.frm.pageIndex.value);
			}
		}
	}

	</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>회원 리스트</h3>
			</div>
			<div class="realCont">

			<form name="frm" method="post" class="SearchForm">
				<input name="pageIndex" type="hidden"
					value="<c:out value='${searchVO.pageIndex}'/>" /> <input
					name="mIdx" type="hidden" />
				<table class="rowTable">
					<colgroup>
						<col style="width: 9%">
						<col style="width: *">
					</colgroup>
					<tbody>
						<tr>
							<th>검색어</th>
							<td>
								<p>
									<select name="searchCnd" id="searchCnd">
										<option value="all" <c:if test="${searchVO.searchCnd eq 'all'}">selected</c:if>>전체</option>
										<option value="name" <c:if test="${searchVO.searchCnd eq 'name'}">selected</c:if>>회원명</option>
										<option value="id" <c:if test="${searchVO.searchCnd eq 'id'}">selected</c:if>>아이디</option>
									</select>
								</p>
								<p>
									<input type="text" name="searchWrd" value="<c:out value="${searchVO.searchWrd}" />">
								</p>
							</td>
						</tr>
						<tr>
							<th>메모</th>
							<td><input type="text" name="searchOp2" value="<c:out value="${searchVO.searchOp2}" />" style="width: 400px;"></td>
						</tr>
						<tr>
							<th>탈퇴일</th>
							<td class="daterange">
								<input class="calendar" type="text" name="searchSdt" value="<c:out value="${searchVO.searchSdt}" />"> ~ 
								<input class="calendar" type="text" name="searchEdt" value="<c:out value="${searchVO.searchEdt}" />">
								<button type="button" class="grybtn setdate today">오늘</button>
								<button type="button" class="grybtn setdate week">일주일</button>
								<button type="button" class="grybtn setdate month">한달</button>
								<button type="button" class="grybtn setdate clear">전체</button>
							</td>
						</tr>
					</tbody>
				</table>
			</form>

			<div style="margin:20px 0 5px 0;">검색결과 총 <span><c:out value="${paginationInfo.totalRecordCount}"/></span>건, <span><c:out value="${searchVO.pageIndex}"/></span>/<span><c:out value="${paginationInfo.lastPageNo}"/></span>pages</div>
				
				<!-- //sch_list -->
				<form name="listFrm" id="listFrm" method="post">
				<!-- listType05 -->
					<table class="commonTable detailTable">
						<caption class="blind">목록</caption>
						<colgroup>
						<col style="width:60px">
  						<col style="width:120px">
  						<col style="width:120px">
  						<col style="width:50px">
  						<col style="width:120px">
  						<col style="width:220px">
  						<col>
  						<col style="width:200px">
						</colgroup>
						<thead>
							<tr>
 							<th scope="col">번호</th>
  							<th scope="col">이름</th>
  							<th scope="col">아이디</th>
  							<th scope="col">성별</th>
  							<th scope="col">상태</th>
  							<th scope="col">탈퇴일시</th>
  							<th scope="col">관리메모</th>
  							<th scope="col">관리</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status">
  							<tr data-no="<c:out value="${result.dIdx}"/>">
								<td><c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/></td>
								<td><c:out value="${result.mName}"/></td>
								<td><c:out value="${result.dId}"/></td>
	  							<td><c:out value="${result.mSex}"/></td>
	  							<td><c:if test="${result.delYn eq 'Y'}">개인정보삭제</c:if><c:if test="${result.delYn ne 'Y'}">탈퇴</c:if></td>
	  							<td><c:out value="${result.deldt}"/></td>
	  							<td class="al etc"><c:out value="${result.etc}"/></td></td>
	  							<td class="ar">
									<c:if test="${result.delYn ne 'Y'}">
									<button type="button" class="commonBtn" onClick="javascript:fnActCancelDel('<c:out value="${result.dIdx}"/>','<c:out value="${result.mIdx}"/>','<c:out value="${result.dId}"/>');">탈퇴취소</button> 
									<button type="button" class="commonBtn" onClick="javascript:fnActWithDraw('<c:out value="${result.dIdx}"/>','<c:out value="${result.mIdx}"/>','<c:out value="${result.dId}"/>');">정보삭제</button>
									</c:if>
									<button type="button" class="commonBtn act_dialog" data-act="etc">메모</button>
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</form>
				<!-- //listType05 -->

				<!-- pagingType03 -->
				<div class="pageNation clear">
					<ul class="pagenation">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnActMembList" />
					</ul>
				</div>
				<!-- //pagingType03 -->

			</div>
		</section>

	</section>

	<div class="dialog" id="lyr_etc" title="관리 메모" data-width="540" data-height="320">
		<form method="post">
		<input type="hidden" name="act" value="etc" />
		<input type="hidden" name="dIdx" />
		<textarea name="etc" class="" title="내용을 입력해주세요." style="width:95%;height:180px;"></textarea>
		</form>
	</div>

<script>
$(function() {
	var dialog
	$(document).on('click', '.act_dialog', function() {
		var didx = $(this).closest('tr').data('no');
		var etc = $(this).closest('tr').find('.etc').text();
		$obj_dialog = $('#lyr_'+$(this).data('act'));
		$obj_dialog.find('input[name=dIdx]').val(didx);
		$obj_dialog.find('textarea').val(etc.replace('<br/>', "\n"));
		open_dialog($obj_dialog);
		return false;
	});
	function open_dialog($obj) {
		var d_width = $obj.data('width');
		var d_height = $obj.data('height');
		dialog = $obj.dialog({
			autoOpen: true,
			resizable:false,
			modal:true,
			height:d_height,
			width:d_width,
			buttons: {
				"저장": function() {
					if (form_val_chk($obj.find('form'))) {
						var url = '/boffice/actMemb/delMemoActMembInfo.do';
						var param = $obj.find('form').serialize();
						if(commonUtil.AjaxSynCall(url,param,'text','처리되었습니다.') == "success"){
							fnActMembList(document.frm.pageIndex.value);
						}
					}
				},
				"취소": function() {
					dialog.dialog( "destroy" );
				}
			},
			close: function() {
				dialog.dialog( "destroy" );
			}
		});
	}
});
</script>

<%@include file="../include/footer.jsp"%>