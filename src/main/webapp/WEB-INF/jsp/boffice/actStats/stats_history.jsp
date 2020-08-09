<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/header.jsp"%>
<script type="text/javascript">
function press(event) {
	if (event.keyCode==13) {
		fnStatsList('1');
	}
}
function fnStatsList(page){
	document.frm.pageIndex.value = page;
	document.frm.action = "<c:url value='/boffice/actStats/actStatsHistoryList.do'/>";
	<c:if test="${searchVO.searchWorkpart eq 'WEBLOG_ADMIN'}">
	document.frm.action = "<c:url value='/boffice/actStats/actStatsAdminLogList.do'/>";
	</c:if>
	document.frm.submit();
}
$(function(){
	var scnd = "<c:out value='${searchVO.searchCnd}'/>";
	if(!scnd){
		scnd = "0";
	}
	$("#searchCnd").val(scnd);
})
</script>

	<h2 class="blind">본문</h2>
		<!-- Container -->
		<div class="container sub" id="container">
		
			<h3 class="cont tit2 mt_60">접속통계 (접속로그<c:if test="${searchVO.searchWorkpart eq 'WEBLOG_ADMIN'}">_관리자</c:if>)</h3>

			<div class="cont mt_30">
				<a href="/boffice/actStats/actStatsDateList.do" class="button_v2" style="color:#AAA;"><span>날짜별 유입수</span></a>
				<a href="/boffice/actStats/actStatsDeviceList.do" class="button_v2" style="color:#AAA;"><span>장치별 유입수</span></a>
				<a href="/boffice/actStats/actStatsMenuList.do" class="button_v2" style="color:#AAA;"><span>메뉴별 유입수</span></a>
				<c:if test="${searchVO.searchWorkpart eq 'WEBLOG_FRONT'}">
				<a href="/boffice/actStats/actStatsHistoryList.do" class="button_v2" style="color:#000;"><span>접속로그</span></a>
				<a href="/boffice/actStats/actStatsAdminLogList.do" class="button_v2" style="color:#AAA;"><span>접속로그(관리자)</span></a>
				</c:if>
				<c:if test="${searchVO.searchWorkpart eq 'WEBLOG_ADMIN'}">
				<a href="/boffice/actStats/actStatsHistoryList.do" class="button_v2" style="color:#AAA;"><span>접속로그</span></a>
				<a href="/boffice/actStats/actStatsAdminLogList.do" class="button_v2" style="color:#000;"><span>접속로그(관리자)</span></a>
				</c:if>
			</div>

			<div class="cont">

				<div class="sch_list v2">
				<form name="frm" method="post">
					<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
					<div class="schWrap v2" style="float:left;">
						<label class="blind" for="term">시작 일</label>
						<input type="text" class="sch_text datePickerDate" id="searchSdt" name="searchSdt" value="<c:out value='${searchVO.searchSdt}'/>" readonly />
					</div>
					<div style="float:left;">&nbsp;&nbsp;~&nbsp;&nbsp;</div>
					<div class="schWrap v2" style="float:left;">
						<label class="blind" for="term2">종료 일</label>
						<input type="text" class="sch_text datePickerDate" id="searchEdt" name="searchEdt" value="<c:out value='${searchVO.searchEdt}'/>" readonly />
					</div>
					<ul class="clear" style="float:left;">
						<li class="schWrap">
					<label class="blind" for="term2">검색옵션</label>
					<select name="searchOp1" id="searchOp1" class="searchSelect" style="width:120px;" onchange="javascript:fnStatsList(1);">
						<option value="">- 메뉴 선택 -</option>
						<c:forEach var="codeResult41" items="${codeResult41}" varStatus="status">
						<option value='100' <c:if test="${searchVO.searchOp1 eq '100'}"> selected</c:if>>메인페이지</option>
						<option value='<c:out value="${codeResult41.code}"/>' <c:if test="${searchVO.searchOp1 eq codeResult41.code}"> selected</c:if>><c:out value="${codeResult41.codeNm}"/></option>
						</c:forEach>
					</select>
					<label class="blind" for="term2">검색옵션</label>
					<select name="searchCnd" id="searchCnd" class="searchSelect">
						<option value="0">전체</option>
						<option value="1">이름</option>
						<option value="2">아이디</option>
						<option value="3">아이피</option>
						<option value="4">URL</option>
					</select>
					<input type="text" class="sch_text" name="searchWrd" id="searchWrd" class="sch_text" value="<c:out value='${searchVO.searchWrd}'/>" maxlength="35" onkeypress="press(event);"/>
					<a href="javascript:void(0);" class="btn_css" onClick="javascript:fnStatsList('1');">
						<img src="/images/boffice/board/btn_search.jpg" alt="검색" />
					</a>
					</li>
					</ul>
				</form>
				</div>
				<!-- //sch_list -->

				<div class="ask mt_50">총 <span><c:out value="${paginationInfo.totalRecordCount}"/></span>건  (※ 1년간의 자료만 조회 가능)</div>

				<!-- listType05 -->
				<div class="listType05 mt_15">
					<table>
						<colgroup>
							<col width="150px" />
							<col width="120px" />
							<col width="120px" />
							<col width="80px" />
							<col width="*" />
							<col width="120px" />
						</colgroup>

						<thead>
							<tr>
								<th scope="col">접속 날짜/시간</th>
								<th scope="col">IP주소</th>
								<th scope="col">아이디</th>
								<th scope="col">이름</th>
								<th scope="col">URL</th>
								<th scope="col">메뉴명</th>
							</tr>
						</thead>
						<tbody>
						 <c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
								<td><c:out value="${result.regDate}"/></td>
								<td><c:out value="${result.rqesterIp}"/></td>
								<td><c:out value="${result.rqesterId}"/></td>
								<td><c:out value="${result.rqesterIdNm}"/></td>
								<td><c:out value="${result.url}"/></td>
								<td><c:out value="${result.menuNm}"/></td>
							</tr>
						 </c:forEach>
							<!-- 게시물없을때
							<tr>
								<td colspan="6">등록된 게시물이 없습니다.</td>
							</tr> -->
						</tbody>
					</table>
				</div>
				<!-- //listType05 -->

				<!-- pagingType03 -->
				<div class="basePaging pagingType03">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnStatsList" />
				</div>
				<!-- //pagingType03 -->
				
				<div class="ta_r">
					<a href="javascript:void(0);" class="button_v2" onClick="javascript:document.frm.action='/boffice/actStats/actStatsHistoryExcel.do';document.frm.submit();"><span>엑셀 다운</span></a>
				</div>

			</div>
			<!-- //cont -->

		</div>
		<!-- //Container -->

<%@include file="../include/footer.jsp"%>