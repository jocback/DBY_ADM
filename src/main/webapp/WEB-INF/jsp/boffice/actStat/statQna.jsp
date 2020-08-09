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
		document.frm.action = "/boffice/actStat/statQnaList.do";
		document.frm.submit();
	}
	$(document).on("click",".act_excel",function(){
		document.frm.action = "/boffice/actStat/statQnaExcel.do";
		document.frm.submit();
	});
	$(document).on('change', '#frm_search input[name=searchOp1]', function() {
		fnActResultList('1');
	});
	</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>학습게시판 답변현황</h3>
			</div>
			<div class="realCont">

			<!--search-->
				<form class="SearchForm" name="frm" id="frm_search" method="post">
					<input type="hidden" name="pageIndex" value="<c:out value='${orderVO.pageIndex}'/>"/>
  					<fieldset>
  						<table class="rowTable">
  							<colgroup>
  								<col style="width:9%">
  								<col style="width:25%">
  								<col style="width:9%">
  								<col style="width:*">
  							</colgroup>
  							<tbody>
  								<tr>
  									<th>보기형식</th>
  									<td>
										<p class="radioStyle">
											<input type="radio"  name="searchOp1" id="type1" value="1" <c:if test="${orderVO.searchOp1 eq '1'}">checked</c:if>><label for="type1"><span></span>강좌별</label>
											<input type="radio"  name="searchOp1" id="type2" value="2" <c:if test="${orderVO.searchOp1 eq '2'}">checked</c:if>><label for="type2"><span></span>교수별</label> 
										</p>
  									</td>
  									<th>담당교수</th>
  									<td>
										<p>
										<select name="searchOp2">
											<option value="">전체</option>
										<c:forEach var="profList" items="${profList}" varStatus="status">
											<option value="<c:out value='${profList.mId}'/>" <c:if test="${orderVO.searchOp2 eq profList.mId}">selected</c:if> ><c:out value="${profList.mName}"/>(<c:out value="${profList.mId}"/>)</option>
										</c:forEach>
										</select>
										</p>
									</td>
  								</tr>
  								<tr>
  									<th>검색어</th>
  									<td colspan="3">
										<p>
										<select name="searchCnd" id="searchCnd">
											<option value="all" <c:if test="${orderVO.searchCnd eq 'all'}"> selected</c:if>>전체</option>
											<option value="m.M_NAME" <c:if test="${orderVO.searchCnd eq 'm.M_NAME'}"> selected</c:if>>교수명</option>
											<option value="l.MV_SUBJECT" <c:if test="${orderVO.searchCnd eq 'l.MV_SUBJECT' || empty orderVO.searchCnd}"> selected</c:if>>강좌명</option>
										</select>
										</p>
										<p>
											<input  name="searchKeyword" type="text" size="35" class="shc_text" value='<c:out value="${orderVO.searchKeyword}" />' maxlength="35" onkeypress="press(event);" title="검색단어입력">
										</p>
									</td>
  								</tr>
  								<tr>
  									<th>등록일</th>
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
      					<button type="button" class="" onclick="javascript:fnActResultList(1);">검색</button>
      				</div>
  					</fieldset>
  				</form>
			  <!--//search-->

			  <p class="total">
  					<span class="total_left">검색 <strong><c:out value="${paginationInfo.totalRecordCount}"/></strong>, <c:out value="${orderVO.pageIndex}"/> of <c:out value="${paginationInfo.lastPageNo}"/> page</span>
  				</p>
			  <c:if test="${orderVO.searchOp1 eq '1'}">
			  <!--listTable-->
				<table class="commonTable detailTable">
  					<caption>관리자 회원관리 테이블</caption>
  					<colgroup>
						<col style="width:60px">
  						<col style="width:180px">
  						<col >
  						<col style="width:150px">
  						<col style="width:150px">
  						<col style="width:150px">
  						<col style="width:150px">
  					</colgroup>
  					<thead>
  						<tr>
 							<th scope="col">번호</th>
  							<th scope="col">강좌등록일시</th>
  							<th scope="col">강좌명</th>
  							<th scope="col">교수명</th>
  							<th scope="col">질문수</th>
  							<th scope="col">답변수</th>
  							<th scope="col">답변률</th>
  						</tr>
  					</thead>
  					<tbody>
  						<c:forEach var="result" items="${orderList}" varStatus="status">
  						<tr>
			                <td class="list-no"><c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/></td>
  							<td class="al"><c:out value="${fn:substring(result.wdate,0,19)}"/></td>
  							<td class="al"><c:out value="${result.goods}"/></td>
  							<td><c:out value="${result.name}"/></td>
  							<td class="ar chkmoney"><c:out value="${result.cnt}"/></td>
  							<td class="ar chkmoney"><c:out value="${result.ans}"/></td>
  							<td class="ar"><c:out value="${result.rate}"/></td>
  						</tr>
  						</c:forEach>
  						<c:if test="${fn:length(orderList) < 1}">
						<tr class="allmerge">
							<td>해당하는 자료가 없습니다.</td>
						</tr>
						</c:if>
  					</tbody>
  				</table>
			  <!--listTable-->
			  </c:if>

			  <!--listTable-->
			  <c:if test="${orderVO.searchOp1 eq '2'}">
				<table class="commonTable detailTable">
  					<caption>관리자 회원관리 테이블</caption>
  					<colgroup>
						<col style="width:60px">
  						<col >
  						<col style="width:150px">
  						<col style="width:150px">
  						<col style="width:150px">
  					</colgroup>
  					<thead>
  						<tr>
 							<th scope="col">번호</th>
  							<th scope="col">교수명</th>
  							<th scope="col">질문수</th>
  							<th scope="col">답변수</th>
  							<th scope="col">답변률</th>
  						</tr>
  					</thead>
  					<tbody>
  						<c:forEach var="result" items="${orderList}" varStatus="status">
  						<tr>
			                <td class="list-no"><c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/></td>
  							<td><c:out value="${result.name}"/></td>
  							<td class="chkmoney"><c:out value="${result.cnt}"/></td>
  							<td class="chkmoney"><c:out value="${result.ans}"/></td>
  							<td><c:out value="${result.rate}"/></td>
  						</tr>
  						</c:forEach>
  						<c:if test="${fn:length(orderList) < 1}">
						<tr class="allmerge">
							<td>해당하는 자료가 없습니다.</td>
						</tr>
						</c:if>
  					</tbody>
  				</table>
			  <!--//listTable-->
			  </c:if>

			  <!--pagenation-->
			  <div class="pageNation clear">
				<ul class="pagenation">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnActResultList" />
				</ul>
				<button class="right act_excel">엑셀전환</button>
			  </div>
	          <!--//pagenation-->
			</div>
		</section>

	</section>


<%@include file="../include/footer.jsp"%>