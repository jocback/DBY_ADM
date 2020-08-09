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
		document.frm.action = "<c:url value='/boffice/actStat/statMovingExtList.do'/>";
		document.frm.submit();
	}
	$(document).on("click",".act_excel",function(){
		document.frm.action = "/boffice/actStat/statMovingExtExcel.do";
		document.frm.submit();
	});
	</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>동영상 연장 신청 리스트</h3>
			</div>
			<div class="realCont">

				<form name="frm" method="post" class="SearchForm">
  					<fieldset>
						<input name="pageIndex" type="hidden" value="<c:out value='${orderVO.pageIndex}'/>"/>
						<input name="searchOp1" type="hidden" value="<c:out value='${orderVO.searchOp1}'/>"/>
						<input name="sno" type="hidden"/>
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
												<option value="1" <c:if test="${orderVO.searchCnd eq '1'}"> selected</c:if>>주문자명</option>
												<option value="2" <c:if test="${orderVO.searchCnd eq '2'}"> selected</c:if>>주문번호</option>
												<option value="3" <c:if test="${orderVO.searchCnd eq '3'}"> selected</c:if>>입금자명</option>
												<option value="4" <c:if test="${orderVO.searchCnd eq '4'}"> selected</c:if>>아이디</option>
												<option value="5" <c:if test="${orderVO.searchCnd eq '5'}"> selected</c:if>>강좌명</option>
												<option value="6" <c:if test="${orderVO.searchCnd eq '6'}"> selected</c:if>>관리자메모</option>
											</select>
											<input  name="searchKeyword" type="text" size="35" class="shc_text" value='<c:out value="${orderVO.searchKeyword}" />' maxlength="35" onkeypress="press(event);" title="검색단어입력">
										</p>
									</td>
								</tr>
								<tr>
									<th>주문상태</th>
									<td colspan="3">
										<p class="checkBox">
											<input type="checkbox" name="searchOp2" id="searchOp20" value="" <c:if test="${empty orderVO.searchOp2}"> checked</c:if> class="check-all" ><label for="searchOp20"><span></span>전체</label>
											<input type="checkbox" name="searchOp2" id="searchOp21" value="입금요" <c:if test="${fn:indexOf(orderVO.searchOp2,'입금요') > -1}"> checked</c:if>><label for="searchOp21"><span></span>입금요</label>
											<input type="checkbox" name="searchOp2" id="searchOp22" value="수강중" <c:if test="${fn:indexOf(orderVO.searchOp2,'수강중') > -1}"> checked</c:if>><label for="searchOp22"><span></span>수강중</label>
											<input type="checkbox" name="searchOp2" id="searchOp23" value="수강종료" <c:if test="${fn:indexOf(orderVO.searchOp2,'수강종료') > -1}"> checked</c:if>><label for="searchOp23"><span></span>수강종료</label>
											<input type="checkbox" name="searchOp2" id="searchOp24" value="취소" <c:if test="${fn:indexOf(orderVO.searchOp2,'취소') > -1}"> checked</c:if>><label for="searchOp24"><span></span>취소</label>
											<input type="checkbox" name="searchOp2" id="searchOp25" value="일시정지" <c:if test="${fn:indexOf(orderVO.searchOp2,'일시정지') > -1}"> checked</c:if>><label for="searchOp25"><span></span>일시정지</label>
										</p>
									</td>
								</tr>
  								<tr>
  									<th>주문일</th>
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
								<tr>
									<th>결제방법</th>
									<td colspan="3">
										<p class="checkBox">
											<input type="checkbox" name="searchOp3" id="searchOp30" value="" <c:if test="${empty orderVO.searchOp3}"> checked</c:if> class="check-all" ><label for="searchOp30"><span></span>전체</label>
											<input type="checkbox" name="searchOp3" id="searchOp31" value="무통장입금" <c:if test="${fn:indexOf(orderVO.searchOp3,'무통장입금') > -1}"> checked</c:if>><label for="searchOp31"><span></span>무통장</label>
											<input type="checkbox" name="searchOp3" id="searchOp32" value="카드" <c:if test="${fn:indexOf(orderVO.searchOp3,'카드') > -1}"> checked</c:if>><label for="searchOp32"><span></span>카드</label>
											<input type="checkbox" name="searchOp3" id="searchOp33" value="가상계좌" <c:if test="${fn:indexOf(orderVO.searchOp3,'가상계좌') > -1}"> checked</c:if>><label for="searchOp33"><span></span>가상계좌</label>
											<input type="checkbox" name="searchOp3" id="searchOp34" value="학원결제" <c:if test="${fn:indexOf(orderVO.searchOp3,'학원결제') > -1}"> checked</c:if>><label for="searchOp34"><span></span>학원결제</label>
											<input type="checkbox" name="searchOp3" id="searchOp35" value="실강변경" <c:if test="${fn:indexOf(orderVO.searchOp3,'실강변경') > -1}"> checked</c:if>><label for="searchOp35"><span></span>실강변경</label>
											<input type="checkbox" name="searchOp3" id="searchOp36" value="모바일강의" <c:if test="${fn:indexOf(orderVO.searchOp3,'모바일강의') > -1}"> checked</c:if>><label for="searchOp35"><span></span>모바일강의</label>
										</p>
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
			  <p class="total">
  					<span class="total_left">총 <strong class="chkmoney"><c:out value="${totInfo.totCnt}"/></strong>개, 검색 <strong><c:out value="${paginationInfo.totalRecordCount}"/></strong>, <c:out value="${orderVO.pageIndex}"/> of <c:out value="${paginationInfo.lastPageNo}"/> page</span>
  				</p>
				<fieldset>
					<table class="commonTable detailTable">
						<colgroup>
							<col style="width:9%">
							<col style="width:*">
							<col style="width:9%">
							<col style="width:*">
							<col style="width:9%">
							<col style="width:*">
						</colgroup>
						<thead>
							<tr>
								<th>총 주문 수</th>
								<td class="chkmoney"><c:out value="${sumInfo.cnt}"/></td>
								<th>총 신청</th>
								<td class="chkmoney"><c:out value="${paginationInfo.totalRecordCount}"/></td>
								<th>총 금액</th>
								<td class="chkmoney"><c:out value="${sumInfo.sumPrice}"/></td>
							</tr>
						</thead>
					</table>
				</fieldset>
				<form name="frm_list" id="frm_list" method="post">
				<table class="commonTable detailTable">
					<caption>동영상 연장 신청 리스트</caption>
					<colgroup>
						<col style="width:40px">
						<col style="width:80px">
						<col style="width:100px">
						<col style="width:50px">
						<col style="width:*">
						<col style="width:90px">
						<col style="width:100px">
						<col style="width:100px">
						<col style="width:80px">
						<col style="width:80px">
						<col style="width:100px">
						<col style="width:100px">
						<col style="width:100px">
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>이름</th>
							<th>주문일시</th>
							<th>수강구분</th>
							<th>강좌명</th>
							<th>연장신청일수</th>
							<th>연장료</th>
							<th>입금</th>
							<th>결제수단</th>
							<th>주문상태</th>
							<th>입금일</th>
							<th>수강종료일</th>
							<th>연장 후 종료일</th>
						</tr>
					</thead>
					<tbody>
	 <c:forEach var="result" items="${orderList}" varStatus="status">
						<tr>
							<td class="list-no">
								<c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/>
							</td>
							<td>
								<c:out value="${result.oName}"/>
							</td>
							<td><c:out value="${result.oDate}"/></td>
							<td><c:if test="${result.mobileYn ne 'Y'}">PC</c:if><c:if test="${result.mobileYn eq 'Y'}">mobile</c:if></td>
							<td class="al"><c:out value="${result.goods}"/></td>
							<td><c:out value="${result.giganDay}"/></td>
							<td class="ar chkmoney"><c:out value="${result.price}"/></td>
							<td class="ar chkmoney"><c:out value="${result.payPrice}"/></td>
							<td><c:out value="${result.method}"/></td>
							<td><c:out value="${result.status}"/></td>
							<td><c:out value="${result.payday}"/></td>
							<td><c:out value="${result.sinDate2}"/></td>
							<td><c:out value="${result.sinDate3}"/></td>
						</tr>
	</c:forEach>
					</tbody>
				</table>
				</form>
				<!--//menuTable-->

				<!-- pagingType03 -->
				<div class="pageNation clear">
					<ul class="pagenation">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnActResultList" />
					</ul>
					<button class="right act_excel">엑셀전환</button>
				</div>
				<!-- //pagingType03 -->

			</div>
		</section>

	</section>

<%@include file="../include/footer.jsp"%>