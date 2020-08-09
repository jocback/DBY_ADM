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
		document.frm.action = "/boffice/actMobile/actDownList.do";
		document.frm.submit();
	}
	</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>강의 다운로드 현황</h3>
			</div>
			<div class="realCont">

			<!--search-->
				<form class="SearchForm" name="frm" method="post">
					<input type="hidden" name="pageIndex" value="<c:out value='${freeVO.pageIndex}'/>"/>
  					<fieldset>
  						<table class="rowTable">
  							<colgroup>
  								<col style="width:9%">
  								<col style="width:*">
  							</colgroup>
  							<tbody>
  								<tr>
  									<th>검색어</th>
  									<td>
										<p>
										<select name="searchCnd" id="searchCnd">
											<option value="user_id" <c:if test="${freeVO.searchCnd eq 'user_id'}"> selected</c:if>>아이디</option>
											<option value="device_id" <c:if test="${freeVO.searchCnd eq 'device_id'}"> selected</c:if>>기기정보</option>
										</select>
										</p>
										<p>
											<input  name="searchKeyword" type="text" size="35" class="shc_text" value='<c:out value="${freeVO.searchKeyword}" />' maxlength="35" onkeypress="press(event);" title="검색단어입력">
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
      					<button type="button" class="" onclick="javascript:fnActResultList(1);">검색</button>
      				</div>
  					</fieldset>
  				</form>
			  <!--//search-->

			  <!--listTable-->
			  <p class="total">
  					<span class="total_left">총 <strong class="chkmoney"><c:out value="${totCnt.cnt}"/></strong>개, 검색 <strong><c:out value="${paginationInfo.totalRecordCount}"/></strong>, <c:out value="${orderVO.pageIndex}"/> of <c:out value="${paginationInfo.lastPageNo}"/> page</span>
  				</p>
				<form id="frm_list" name="frm_list">
				<input type="hidden" name="act" value="" />
				<table class="commonTable detailTable">
  					<caption>관리자 메뉴관리 테이블</caption>
  					<colgroup>
						<col width="60">
						<col width="150">
  						<col>
						<col width="150">
						<col width="100">
  						<col>
						<col width="200">
  					</colgroup>
  					<thead>
  						<tr>
							<th scope="col">번호</th>
  							<th scope="col">아이디</th>
  							<th scope="col">기기정보</th>
  							<th scope="col">OS</th>
  							<th scope="col">상품아이디</th>
  							<th scope="col">URL</th>
  							<th scope="col">다운로드일시</th>
  						</tr>
  					</thead>
  					<tbody>
						<c:forEach var="result" items="${resultList}" varStatus="status">
  						<tr>
			                <td class="list-no"><c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/></td>
  							<td><c:out value="${result.userId}"/></td>
  							<td><c:out value="${result.deviceId}"/></td>
  							<td><c:out value="${result.osVersion}"/></td>
  							<td><c:out value="${result.contentId}"/></td>
  							<td class="al"><c:out value="${fn:replace(result.contentUrl,'http://daebang1.hscdn.com/daebang','')}"/></td>
  							<td>
	  							<c:out value="${fn:substring(result.date,0,4)}"/>-<c:out value="${fn:substring(result.date,4,6)}"/>-<c:out value="${fn:substring(result.date,6,8)}"/>
	  							<c:out value="${fn:substring(result.date,8,10)}"/>:<c:out value="${fn:substring(result.date,10,12)}"/>
							</td>
  						</tr>
  						</c:forEach>
  						<c:if test="${fn:length(resultList) < 1}">
						<tr class="allmerge">
							<td>해당하는 자료가 없습니다.</td>
						</tr>
						</c:if>
  					</tbody>
  				</table>
				</form>
			  <!--//listTable-->

			  <!--pagenation-->
			  <div class="pageNation clear">
				<ul class="pagenation">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnActResultList" />
				</ul>
			  </div>
	          <!--//pagenation-->
			</div>
		</section>

	</section>


<%@include file="../include/footer.jsp"%>