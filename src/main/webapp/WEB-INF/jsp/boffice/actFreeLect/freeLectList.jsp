<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/header.jsp"%>
	<script type="text/javascript">
	function press(event) {
		if (event.keyCode==13) {
			fnActFreeLectList('1');
		}
	}
	function fnActFreeLectList(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/boffice/actFreeLect/actFreeLectList.do'/>";
		document.frm.submit();
	}
	function fnActFreeLectView(no) {
		 if(!no) return false;
		 document.frm.fmIdx.value = no;
		 document.frm.action = "<c:url value='/boffice/actFreeLect/actFreeLectView.do'/>";
		 document.frm.submit();
	}
	function fnActFreeLectWrite() {
		 document.frm.fmIdx.value = "";
		 document.frm.action = "<c:url value='/boffice/actFreeLect/actFreeLectView.do'/>";
		 document.frm.submit();
	}
	function fnActFreeLectDel(obj){
		if(!confirm("삭제하시겠습니까?")){
			return;
		}
		var url = "<c:url value='/boffice/actFreeLect/deleteActFreeLect.do' />";
		var param = {fmIdx : obj}
		commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.');
		fnActFreeLectList('1');
	}
	</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>무료 강의 리스트</h3>
				<div class="btnWrap">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onClick="javascript:fnActFreeLectWrite();">등록</button>
				</div>
			</div>
			<div class="realCont">

				<form name="frm" method="post" class="SearchForm">
  					<fieldset>
						<input name="pageIndex" type="hidden" value="<c:out value='${freeVO.pageIndex}'/>"/>
						<input name="fmIdx" type="hidden"/>
						<table class="rowTable">
							<colgroup>
								<col style="width:9%">
								<col style="width:350px">
								<col style="width:9%">
								<col style="width:*">
							</colgroup>
							<tbody>
								<!-- tr>
									<th>카테고리 선택</th>
									<td colspan="3">
										<p>
									<select name="searchOp1" id="searchOp1" style="width:250px;padding-left:10px;">
										<option value="">선택</option>
									<c:forEach var="lecCodeList" items="${lecCodeList}" varStatus="status">
										<option value='<c:out value="${lecCodeList.codeId}"/>' <c:if test="${freeVO.searchOp1 eq lecCodeList.codeId}"> selected</c:if>><c:out value="${lecCodeList.codeNm}"/></option>
									</c:forEach>
									</select>
										</p>
									</td>
								</tr>
								<tr-->
									<th>검색어</th>
									<td colspan="3">
										<p>
											<select name="searchCnd" title="검색유형선력">
												<option value="0" <c:if test="${freeVO.searchCnd eq '0'}"> selected</c:if>>전체</option>
												<option value="1" <c:if test="${freeVO.searchCnd eq '1'}"> selected</c:if>>무료강의명</option>
												<option value="2" <c:if test="${freeVO.searchCnd eq '2'}"> selected</c:if>>강좌명</option>
												<option value="3" <c:if test="${freeVO.searchCnd eq '3'}"> selected</c:if>>회원</option>
												<option value="4" <c:if test="${freeVO.searchCnd eq '4'}"> selected</c:if>>회원ID</option>
											</select>
											<input  name="searchKeyword" type="text" size="35" class="shc_text" value='<c:out value="${freeVO.searchKeyword}" />' maxlength="35" onkeypress="press(event);" title="검색단어입력">
										</p>
									</td>
								</tr>
								<tr>
									<th>분류</th>
									<td colspan="3">
										<p class="radioStyle">
											<input type="radio" name="searchOp2" value="" id="searchOp20" <c:if test="${empty freeVO.searchOp2}"> checked</c:if>><label for="searchOp20"><span></span>전체</label>
											<input type="radio" name="searchOp2" value="P" id="searchOp21" <c:if test="${freeVO.searchOp2 eq 'P'}"> checked</c:if>><label for="searchOp21"><span></span>PC</label>
											<input type="radio" name="searchOp2" value="M" id="searchOp22" <c:if test="${freeVO.searchOp2 eq 'M'}"> checked</c:if>><label for="searchOp22"><span></span>Mobile</label>
											<input type="radio" name="searchOp2" value="A" id="searchOp23" <c:if test="${freeVO.searchOp2 eq 'A'}"> checked</c:if>><label for="searchOp23"><span></span>PC+Mobile</label>
										</p>
									</td>
								</tr>
  								<tr>
  									<th>등록일</th>
  									<td colspan="3" class="daterange">
										<input class="calendar" type="text" name="searchSdt" value="<c:out value="${freeVO.searchSdt}" />">
										~
										<input class="calendar" type="text" name="searchEdt" value="<c:out value="${freeVO.searchEdt}" />">
										<button type="button" class="grybtn setdate today">오늘</button>
										<button type="button" class="grybtn setdate week">일주일</button>
										<button type="button" class="grybtn setdate month">한달</button>
										<button type="button" class="grybtn setdate clear">전체</button>
  									</td>
  								</tr>
							</tbody>
						</table>
						<div class="btnsWrap">
							<button type="button" class="" onclick="javascript:fnActFreeLectList('1'); return false;">검색</button>
						</div>
  					</fieldset>
				</form>

				<!--menuTable-->
				<table class="commonTable detailTable">
					<caption>무료 강의 리스트</caption>
					<colgroup>
						<col style="width:50px">
						<col style="width:50px">
						<col style="width:60px">
						<col style="width:300px">
						<col style="width:*">
						<col style="width:50px">
						<col style="width:100px">
						<col style="width:100px">
						<col style="width:100px">
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
							<th>구분</th>
							<th>무료강의명</th>
							<th>강좌</th>
							<th>회원수</th>
							<th>등록자</th>
							<th>등록일</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
	 <c:forEach var="result" items="${resultList}" varStatus="status">
						<tr <c:if test="${result.mvSta eq 'N'}">style="background-color:#EFEFEF;"</c:if>>
							<td>
								<span class="checkBox">
									<input type="checkbox" class="no" name="no" value="<c:out value='${status.index}'/>" id="no<c:out value='${status.index}'/>">
									<label for="no<c:out value='${status.index}'/>"><span></span>선택</label>
								</span>
							</td>
							<td class="list-no"><c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/></td>
							<td>
								<c:if test="${result.fmEq eq 'P'}">PC</c:if>
								<c:if test="${result.fmEq eq 'M'}">Mobile</c:if>
								<c:if test="${result.fmEq eq 'A'}">PC+Mobile</c:if>
							</td>
							<td>
								<a href="javascript:fnActFreeLectView('<c:out value="${result.fmIdx}"/>');">
								<c:out value="${result.fmSubject}"/></a>
							</td>
							<td>
								<a href="javascript:fnActFreeLectView('<c:out value="${result.fmIdx}"/>');">
								<c:out value="${result.lecNm}"/><c:if test="${result.lecCnt > 1}"> 외 <c:out value="${result.lecCnt}"/></c:if></a>
							</td>
							<td><c:out value="${result.usrCnt}"/></td>
							<td><c:out value="${result.regid}"/></td>
							<td><c:out value="${fn:substring(result.regdt,0,10)}"/></td>
							<td>
						    	<button type="button" class="commonBtn" onclick="javascript:fnActFreeLectView('<c:out value="${result.fmIdx}"/>');">수정</button>
						    	<button type="button" class="commonBtn" onclick="javascript:fnActFreeLectDel('<c:out value="${result.fmIdx}"/>');">삭제</button>
							</td>
						</tr>
	</c:forEach>
					</tbody>
				</table>
				<!--//menuTable-->

				<!-- pagingType03 -->
				<div class="pageNation clear">
					<ul class="pagenation">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnActFreeLectList" />
					</ul>
				</div>
				<!-- //pagingType03 -->

			</div>
		</section>

	</section>

<%@include file="../include/footer.jsp"%>