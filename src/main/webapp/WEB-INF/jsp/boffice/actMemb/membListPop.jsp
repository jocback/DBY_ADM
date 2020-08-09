<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/headerPop.jsp"%>
	<script type="text/javascript">
	function press(event) {
		if (event.keyCode==13) {
			fnActMembList('1');
		}
	}
	function fnActMembList(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "/boffice/actMemb/actMembListPop.do";
		document.frm.submit();
	}
	</script>
	<form name="frm" method="post" class="SearchForm">
	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
	<table class="rowTable">
		<colgroup>
			<col style="width:100px">
			<col style="width:*">
			<col style="width:100px">
			<col style="width:*">
		</colgroup>
		<tbody>
			<tr>
				<th>회원구분</th>
				<td>
					<p>
					<select name="searchActgubun" id="searchActgubun">
						<option value="">선택</option>
						<c:import url="/boffice/activity/actFrmType.do" charEncoding="utf-8">
							<c:param name="frmTypeCode" value="COM044" />
							<c:param name="frmTypeValue" value="${searchVO.searchActgubun}" />
						</c:import>
					</select>
					</p>
				</td>
				<td colspan="2">
					<span class="btnsWrap">
						<button type="button" class="" onclick="javascript:fnActMembList('1'); return false;">검색</button>
					</span>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<p>
						<input type="text" class="sch_text" style="width:90px;" name="searchOp1" id="searchOp1" value='<c:out value="${searchVO.searchOp1}"/>' />
					</p>
				</td>
				<th>아이디</th>
				<td>
					<p>
						<input type="text" class="sch_text" style="width:90px;" name="searchOp2" id="searchOp2" value='<c:out value="${searchVO.searchOp2}"/>' />
					</p>
				</td>
			</tr>
		</tbody>
	</table>
	</form>

  <!--listTable-->
  <p class="total" style="margin-top:4px;">
		<span class="total_left">총 <strong><c:out value="${paginationInfo.totalRecordCount}"/></strong>개, <c:out value="${searchVO.pageIndex}"/> of <c:out value="${paginationInfo.lastPageNo}"/> page</span>
	</p>
	<form id="frm_list" name="frm_list">
	<input type="hidden" name="act" value="" />
	<table class="commonTable">
		<caption>회원 검색 테이블</caption>
		<colgroup>
			<col width="100">
			<col width="210">
			<col>
			<col width="60">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">회원명</th>
				<th scope="col">회원ID</th>
				<th scope="col">선택</th>
			</tr>
		</thead>
		<tbody>
	 <c:forEach var="result" items="${resultList}" varStatus="status">
			<tr data-no="<c:out value="${result.mId}"/>">
				<td><c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/></td>
				<td class="mName"><c:out value="${result.mName}"/></td>
				<td><b class="mId"><c:out value="${result.mId}"/></b></td>
				<td>
					<input type="hidden" name="mId" value="<c:out value="${result.mId}"/>"/>
			    	<button type="button" class="commonBtn act_select">선택</button>
				</td>
			</tr>
	</c:forEach>
		</tbody>
	</table>
	</form>
  <!--//listTable-->

	<!-- pagingType03 -->
	<div class="pageNation clear">
		<ul class="pagenation">
			<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnActMembList" />
		</ul>
	</div>
	<!-- //pagingType03 -->

<script>
$(function() {
	$(document).on('click', '.act_select', function() {
		$cont = $(this).closest('tr');
		parent.fnActAddMemb($cont.data('no'), $cont.find('.mName').text());
		return false;
	});
});
</script>


<%@include file="../include/footer.jsp"%>