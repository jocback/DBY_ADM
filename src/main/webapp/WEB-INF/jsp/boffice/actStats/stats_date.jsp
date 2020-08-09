<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/header.jsp"%>
<script type="text/javascript">
function fnStatsList(page){
	document.frm.pageIndex.value = page;
	document.frm.action = "<c:url value='/boffice/actStats/actStatsDateList.do'/>";
	document.frm.submit();
}
</script>

	<h2 class="blind">본문</h2>
		<!-- Container -->
		<div class="container sub" id="container">
		
			<h3 class="cont tit2 mt_60">접속통계 (날짜별 유입수)</h3>

			<div class="cont mt_30">
				<a href="/boffice/actStats/actStatsDateList.do" class="button_v2" style="color:#000;"><span>날짜별 유입수</span></a>
				<a href="/boffice/actStats/actStatsDeviceList.do" class="button_v2" style="color:#AAA;"><span>장치별 유입수</span></a>
				<a href="/boffice/actStats/actStatsMenuList.do" class="button_v2" style="color:#AAA;"><span>메뉴별 유입수</span></a>
				<a href="/boffice/actStats/actStatsHistoryList.do" class="button_v2" style="color:#AAA;"><span>접속로그</span></a>
				<a href="/boffice/actStats/actStatsAdminLogList.do" class="button_v2" style="color:#AAA;"><span>접속로그(관리자)</span></a>
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
					<a href="javascript:void(0);" class="btn_css" onClick="javascript:fnStatsList('1');">
						<img src="/images/boffice/board/btn_search.jpg" alt="검색" />
					</a>
				</form>
				</div>
				<!-- //sch_list -->

				<div class="ask mt_50">총 <span><c:out value="${paginationInfo.totalRecordCount}"/></span>건 (※ 방문수(중복제외):일별로 IP당 1회만 카운트)</div>

				<!-- listType05 -->
				<div class="listType05 mt_15">
					<table>
						<colgroup>
							<col width="*" />
							<col width="300px" />
							<col width="300px" />
						</colgroup>

						<thead>
							<tr>
								<th scope="col">일자</th>
								<th scope="col">요일</th>
								<th scope="col">방문수</th>
								<th scope="col">방문수(중복제외)</th>
							</tr>
						</thead>
						<tbody>
						 <c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
								<td>
									<fmt:parseDate value='${result.occrrncDe}' var='plnSdt' pattern="yyyymmdd" scope="page"/>
									<fmt:formatDate value="${plnSdt}" pattern="yyyy-mm-dd"/>
								</td>
								<td><c:out value="${result.daynm}"/></td>
								<td><c:out value="${result.rcnt}"/></td>
								<td><c:out value="${result.vcnt}"/></td>
							</tr>
						</c:forEach>
						<c:if test="${empty resultList}">
							<tr>
								<td colspan="6">등록된 게시물이 없습니다.</td>
							</tr>
						</c:if>
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
					<a href="javascript:void(0);" class="button_v2" onClick="javascript:document.frm.action='/boffice/actStats/actStatsDateExcel.do';document.frm.submit();"><span>엑셀 다운</span></a>
				</div>

			</div>
			<!-- //cont -->

		</div>
		<!-- //Container -->

<%@include file="../include/footer.jsp"%>