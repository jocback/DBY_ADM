<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/header.jsp"%>
	<script type="text/javascript">
	function press(event) {
		if (event.keyCode==13) {
			fnActResultList('1');
		}
	}
	function fnActResultList(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/boffice/actOrder/actOrderEstiList.do'/>";
		document.frm.submit();
	}
	function fnActOcEstiWrite() {
		 document.frm.action = "<c:url value='/boffice/actOrder/actOrderEstiWrite.do'/>";
		 document.frm.submit();
	}

	$(document).on('click', '.act_del, .act_list_del', function() {
		if ($('#frm_list input[name=ocIdx]:checked').length <= 0) {
				alert('선택된 주문이 없습니다.');
				return false;
		}
		var title = '선택주문 : '+$('#frm_list input[name=ocIdx]:checked').length+'건';
		var param = $('#frm_list').serialize();
		if (confirm(title+' - 삭제하시겠습니까?')) {
			var url = "/boffice/actOrder/deleteActOrderEsti.do";
			commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.');
			fnActResultList('1');
		}
		return false;
	});

	$(function() {
		$(document).on('click', '.act_clear', function() {
			if (!confirm('삭제하시겠습니까?')) {
				return;
			}
			var url = "/boffice/actOrder/deleteActOrderEsti.do";
			var param = {ocIdx:$(this).data("no")}
			if(commonUtil.AjaxSynCall(url,param) == "success"){
				fnActResultList('1');
			}else{
				alert("오류가 발생하였습니다. 다시 시동하여 주세요.");
			}
		});
	});
	</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>견적 등록 리스트</h3>
				<div class="btnWrap">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onClick="javascript:fnActOcEstiWrite();">등록</button>
				</div>
			</div>
			<div class="realCont">

				<form name="frm" method="post" class="SearchForm">
  					<fieldset>
						<input name="pageIndex" type="hidden" value="<c:out value='${orderVO.pageIndex}'/>"/>
						<input name="ocIdx" type="hidden"/>
						<table class="rowTable">
							<colgroup>
								<col style="width:9%">
								<col style="width:350px">
								<col style="width:9%">
								<col style="width:*">
							</colgroup>
							<tbody>
								<tr>
									<th>검색어</th>
									<td colspan="3">
										<p>
											<select name="searchCnd" title="검색유형선력">
												<option value="1" <c:if test="${orderVO.searchCnd eq '1'}"> selected</c:if>>강좌명</option>
												<option value="2" <c:if test="${orderVO.searchCnd eq '2'}"> selected</c:if>>회원명</option>
												<option value="3" <c:if test="${orderVO.searchCnd eq '3'}"> selected</c:if>>회원ID</option>
											</select>
											<input  name="searchKeyword" type="text" size="35" class="shc_text" value='<c:out value="${orderVO.searchKeyword}" />' maxlength="35" onkeypress="press(event);" title="검색단어입력">
										</p>
									</td>
								</tr>
  								<tr>
  									<th>견적일</th>
  									<td colspan="3" class="daterange">
										<input class="calendar" type="text" name="searchSdt" value="<c:out value="${orderVO.searchSdt}" />">
										~
										<input class="calendar" type="text" name="searchEdt" value="<c:out value="${orderVO.searchEdt}" />">
										<button type="button" class="grybtn setdate today">오늘</button>
										<button type="button" class="grybtn setdate week">일주일</button>
										<button type="button" class="grybtn setdate month">한달</button>
										<button type="button" class="grybtn setdate clear">전체</button>
  									</td>
  								</tr>
							</tbody>
						</table>
						<div class="btnsWrap">
							<button type="button" class="" onclick="javascript:fnActResultList('1'); return false;">검색</button>
						</div>
  					</fieldset>
				</form>

				<!--menuTable-->
				<form name="frm_list" id="frm_list" method="post">
				<table class="commonTable detailTable">
					<caption>견적 등록 리스트</caption>
					<colgroup>
						<col style="width:40px">
						<col style="width:50px">
						<col style="width:160px">
						<col style="width:60px">
						<col style="width:60px">
						<col style="width:*">
						<col style="width:100px">
						<col style="width:180px">
						<col style="width:80px">
						<col style="width:60px">
						<col style="width:80px">
					</colgroup>
					<thead>
						<tr>
							<th>
								<span class="checkBox">
									<input type="checkbox" class="check_all" data-check="no" id="check_all" name="check_all" value="Y">
	  								<label for="check_all"><span></span>선택</label>
								</span>
							</th>
							<th>번호</th>
							<th>견적일시</th>
							<th>종류</th>
							<th>구분</th>
							<th>강좌명 or 교재명</th>
							<th>회원명</th>
							<th>회원ID</th>
							<th>결제금액</th>
							<th>처리상태</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
	 <c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td rowspan="<c:out value="${result.subListCnt+1}"/>">
								<span class="checkBox">
									<input type="checkbox" class="no" name="ocIdx" value="<c:out value='${result.ocIdx}'/>" id="no<c:out value='${result.ocIdx}'/>">
									<label for="no<c:out value='${result.ocIdx}'/>"><span></span>선택</label>
								</span>
							</td>
							<td class="list-no">
								<c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/>
							</td>
							<td><c:out value="${result.regdt}"/></td>
							<td>
								<c:if test="${result.ocGubun eq '11'}">단과</c:if>
								<c:if test="${result.ocGubun eq '12'}">종합</c:if>
								<c:if test="${result.ocGubun eq '13'}">교재</c:if>
							</td>
							<td>
								<c:if test="${result.ocLecmod eq 'P'}">PC</c:if>
								<c:if test="${result.ocLecmod eq 'M'}">mobile</c:if>
								<c:if test="${result.ocLecmod eq 'A'}">PC+mobile</c:if>
							</td>
							<td class="al">
								<c:if test="${result.ocGubun ne '13'}"><c:out value="${result.ocSubject}"/></c:if>
								<c:if test="${result.ocGubun eq '13'}"><c:out value="${result.ocBook}"/></c:if>
							</td>
							<td><c:out value="${result.mName}"/></td>
							<td><c:out value="${result.mId}"/></td>
							<td class="ar chkmoney"><c:out value="${result.ocEstiPrice}"/></td>
							<td><c:out value="${result.ocEsti}"/></td>
							<td><button type="button" class="commonBtn act_clear" data-no="<c:out value='${result.ocIdx}'/>">삭제</button></td>
						</tr>
	</c:forEach>
					</tbody>
				</table>
				</form>
				<!--//menuTable-->

				<!-- pagingType03 -->
				<div class="pageNation clear">
					<c:if test="${loginVO.actGrIdx eq 'G000001'}">
  					<button class="left act_list_del">선택삭제</button>
  					</c:if> 
					<ul class="pagenation">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnActResultList" />
					</ul>
				</div>
				<!-- //pagingType03 -->

			</div>
		</section>

	</section>

<%@include file="../include/footer.jsp"%>