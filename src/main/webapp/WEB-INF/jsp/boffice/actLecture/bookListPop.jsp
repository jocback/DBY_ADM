<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/headerPop.jsp"%>
	<script type="text/javascript">
	function press(event) {
		if (event.keyCode==13) {
			fnActBookList('1');
		}
	}
	function fnActBookList(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/boffice/actLecture/actBookListPop.do'/>";
		document.frm.submit();
	}
	</script>
	<form name="frm" method="post" class="SearchForm">
	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
	<table class="rowTable">
		<colgroup>
			<col style="width:100px">
			<col style="width:*">
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">카테고리</th>
				<td class="category_select" data-part="book">
					<p>
						<select name="searchOp1" id="searchOp1" style="width:250px;padding-left:10px;">
							<option value="">직렬선택</option>
							<c:import url="/boffice/activity/actLecCdType.do" charEncoding="utf-8">
								<c:param name="codeGb" value="LE" />
								<c:param name="frmTypeValue" value="${searchVO.searchOp1}" />
							</c:import>
						</select>
							</p>
							<p>
						<select name="searchOp2" id="searchOp2" style="width:250px;padding-left:10px;">
							<option value="">과목선택</option>
							<option value="ALL" <c:if test="${searchVO.searchOp2 eq 'ALL'}"> selected</c:if>>(전체과목)</option>
							<c:import url="/boffice/activity/actLecCdType.do" charEncoding="utf-8">
								<c:param name="codeGb" value="CL" />
								<c:param name="frmTypeValue" value="${searchVO.searchOp2}" />
							</c:import>
						</select>
					</p>
				</td>
			</tr>
			<tr>
				<th>검색어</th>
				<td>
					<p>
						<select name="searchCnd" title="검색유형선력">
							<option value="0" <c:if test="${searchVO.searchCnd eq '0'}"> selected</c:if>>전체</option>
							<option value="1" <c:if test="${searchVO.searchCnd eq '1'}"> selected</c:if>>상품명</option>
							<option value="2" <c:if test="${searchVO.searchCnd eq '2'}"> selected</c:if>>저자</option>
							<option value="3" <c:if test="${searchVO.searchCnd eq '3'}"> selected</c:if>>출판사</option>
						</select>
					</p>
					<p>
						<input  name="searchKeyword" type="text" size="35" class="shc_text" value='<c:out value="${searchVO.searchKeyword}" />' maxlength="35" onkeypress="press(event);" title="검색단어입력">
						<span class="btnsWrap">
							<button type="button" class="" onclick="javascript:fnActBookList('1'); return false;">검색</button>
						</span>
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
		<caption>서적 검색 테이블</caption>
		<colgroup>
			<col width="40">
			<col>
			<col width="100">
			<col width="70">
			<col width="100">
			<col width="90">
			<col width="60">
		</colgroup>
		<thead>
			<tr>
				<!-- <th>
					<span class="checkBox">
						<input type="checkbox" class="check_all" data-check="no" id="check_all" name="check_all" value="Y">
								<label for="check_all"><span></span>선택</label>
					</span>
				</th> -->
				<th scope="col">번호</th>
				<th scope="col">교재명</th>
				<th scope="col">저자</th>
				<th scope="col">가격</th>
				<th scope="col">출판사</th>
				<th scope="col">등록일</th>
				<th scope="col">선택</th>
			</tr>
		</thead>
		<tbody>
	 <c:forEach var="result" items="${resultList}" varStatus="status">
			<tr data-no="<c:out value="${result.bmIdx}"/>" <c:if test="${result.bmShow eq 'N'}">style="background-color:#EFEFEF;"</c:if>>
				<!-- <th>
					<span class="checkBox">
						<input type="checkbox" class="no" name="no" value="<c:out value='${status.index}'/>" id="no<c:out value='${status.index}'/>">
						<label for="no<c:out value='${status.index}'/>"><span></span>선택</label>
					</span>
				</th> -->
				<td><c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/></td>
				<td><b class="bname"><c:out value="${result.bmSubject}"/></b></td>
				<td class="bauthor"><c:out value="${result.bmAuthor}"/></td>
				<td class="bprice chkmoney"><c:out value="${result.bmPrice2}"/></td>
				<td class="bpress"><c:out value="${result.bmPress}"/></td>
				<td class="bdate"><c:out value="${fn:substring(result.regdt,0,10)}"/></td>
				<td>
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
			<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnActBookList" />
		</ul>
	</div>
	<!-- //pagingType03 -->

<script>
$(function() {
	$(document).on('click', '.act_select', function() {
		$cont = $(this).closest('tr');
		parent.fnActAddBook($cont.data('no'), $cont.find('.bname').text(), $cont.find('.bpress').text(), $cont.find('.bprice').text(), $cont.find('.bdate').text());
		return false;
	});
});
</script>


<%@include file="../include/footer.jsp"%>