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
		document.frm.action = "/boffice/actStat/statBookList.do";
		document.frm.submit();
	}
	$(document).on("click",".act_excel",function(){
		document.frm.action = "/boffice/actStat/statBookExcel.do";
		document.frm.submit();
	});
	</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>서적 매출 통계</h3>
			</div>
			<div class="realCont">

			<!--search-->
				<form class="SearchForm" name="frm" method="post">
					<input type="hidden" name="pageIndex" value="<c:out value='${orderVO.pageIndex}'/>"/>
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
											<option value="o_name" <c:if test="${orderVO.searchCnd eq 'o_name'}"> selected</c:if>>주문자명</option>
											<option value="jumun" <c:if test="${orderVO.searchCnd eq 'jumun'}"> selected</c:if>>주문번호</option>
											<option value="p_name" <c:if test="${orderVO.searchCnd eq 'p_name'}"> selected</c:if>>강좌명</option>
											<option value="method" <c:if test="${orderVO.searchCnd eq 'method'}"> selected</c:if>>카드종류</option>
										</select>
										</p>
										<p>
											<input  name="searchKeyword" type="text" size="35" class="shc_text" value='<c:out value="${orderVO.searchKeyword}" />' maxlength="35" onkeypress="press(event);" title="검색단어입력">
										</p>
									</td>
  								</tr>
  								<tr>
									<th>주문상태</th>
  									<td>
										<p class="checkBox">
											<input type="checkbox" name="searchOp2" id="searchOp20" value="" <c:if test="${empty orderVO.searchOp2}"> checked</c:if> class="check-all" ><label for="searchOp20"><span></span>전체</label>
											<input type="checkbox" name="searchOp2" id="searchOp21" value="입금요" <c:if test="${fn:indexOf(orderVO.searchOp2,'입금요') > -1}"> checked</c:if>><label for="searchOp21"><span></span>입금요</label>
											<input type="checkbox" name="searchOp2" id="searchOp22" value="결제완료" <c:if test="${fn:indexOf(orderVO.searchOp2,'결제완료') > -1}"> checked</c:if>><label for="searchOp22"><span></span>결제완료</label>
											<input type="checkbox" name="searchOp2" id="searchOp23" value="배송준비중" <c:if test="${fn:indexOf(orderVO.searchOp2,'배송준비중') > -1}"> checked</c:if>><label for="searchOp23"><span></span>배송준비중</label>
											<input type="checkbox" name="searchOp2" id="searchOp24" value="배송중" <c:if test="${fn:indexOf(orderVO.searchOp2,'배송중') > -1}"> checked</c:if>><label for="searchOp24"><span></span>배송중</label>
											<input type="checkbox" name="searchOp2" id="searchOp25" value="배송완료" <c:if test="${fn:indexOf(orderVO.searchOp2,'배송완료') > -1}"> checked</c:if>><label for="searchOp25"><span></span>배송완료</label>
											<input type="checkbox" name="searchOp2" id="searchOp26" value="거래완료" <c:if test="${fn:indexOf(orderVO.searchOp2,'거래완료') > -1}"> checked</c:if>><label for="searchOp26"><span></span>거래완료</label>
											<input type="checkbox" name="searchOp2" id="searchOp27" value="주문취소" <c:if test="${fn:indexOf(orderVO.searchOp2,'주문취소') > -1}"> checked</c:if>><label for="searchOp27"><span></span>주문취소</label>
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
  									<th>입금일</th>
  									<td colspan="3" class="daterange">
										<input class="calendar" type="text" name="searchActSday" value="<c:out value="${orderVO.searchActSday}" />">
										~
										<input class="calendar" type="text" name="searchActEday" value="<c:out value="${orderVO.searchActEday}" />">
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
											<input type="checkbox" name="searchOp3" id="searchOp31" value="무통장" <c:if test="${fn:indexOf(orderVO.searchOp3,'무통장') > -1}"> checked</c:if>><label for="searchOp31"><span></span>무통장</label>
											<input type="checkbox" name="searchOp3" id="searchOp32" value="카드" <c:if test="${fn:indexOf(orderVO.searchOp3,'카드') > -1}"> checked</c:if>><label for="searchOp32"><span></span>카드</label>
											<input type="checkbox" name="searchOp3" id="searchOp33" value="가상계좌" <c:if test="${fn:indexOf(orderVO.searchOp3,'가상계좌') > -1}"> checked</c:if>><label for="searchOp33"><span></span>가상계좌</label>
											<input type="checkbox" name="searchOp6" id="searchOp6" value="Y" <c:if test="${orderVO.searchOp6 eq 'Y'}"> checked</c:if>><label for="searchOp6"><span></span>교재포함무료</label>
										</p>
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
  					<span class="total_left">총 <strong class="chkmoney"><c:out value="${sumInfo.totCnt}"/></strong>개, 검색 <strong><c:out value="${paginationInfo.totalRecordCount}"/></strong>, <c:out value="${orderVO.pageIndex}"/> of <c:out value="${paginationInfo.lastPageNo}"/> page</span>
  				</p>
				<fieldset>
					<table class="commonTable detailTable">
						<colgroup>
							<col style="width:9%">
							<col style="width:41%">
							<col style="width:9%">
							<col style="width:*">
						</colgroup>
						<thead>
							<tr>
								<th>총 주문 수</th>
								<td class="chkmoney"><c:out value="${paginationInfo.totalRecordCount}"/></td>
								<th>총 결제완료 금액</th>
								<td class="chkmoney"><c:out value="${sumInfo.sumPrice}"/></td>
							</tr>
						</thead>
					</table>
				</fieldset>
				<form id="frm_list" name="frm_list">
				<input type="hidden" name="act" value="" />
				<table class="commonTable detailTable">
  					<caption>관리자 회원관리 테이블</caption>
  					<colgroup>
						<col style="width:60px">
						<col style="width:70px">
						<col style="width:90px">
						<col style="width:60px">
  						<col >
  						<col style="width:100px">
  						<col style="width:70px">
  						<col style="width:90px">
  						<col style="width:90px">
  					</colgroup>
  					<thead>
  						<tr>
 							<th scope="col">번호</th>
  							<th scope="col">이름</th>
  							<th scope="col">주문일</th>
  							<th scope="col">구분</th>
  							<th scope="col">상품명</th>
  							<th scope="col">금액</th>
  							<th scope="col">상태</th>
  							<th scope="col">결제수단</th>
  							<th scope="col">입금일</th>
  						</tr>
  					</thead>
  					<tbody>
  						<c:forEach var="result" items="${orderList}" varStatus="status">
  						<tr>
			                <td class="list-no"><c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/></td>
  							<td><c:out value="${result.oName}"/></td>
  							<td><c:out value="${result.oDate}"/></td>
  							<td><c:if test="${result.mobileOrderYn eq 'Y'}"><div class=ord-mobile>mobile</div></c:if><c:if test="${result.mobileOrderYn ne 'Y'}"><div class=ord-pc>PC</div></c:if></td>
  							<td class="al"><c:out value="${result.pName}"/></td>
  							<td><c:if test="${result.pTotal*1>0}"><span><span class="chkmoney"><c:out value="${result.pTotal}"/></span></c:if><c:if test="${result.pTotal*1==0}">무료</c:if></td>
  							<td><c:out value="${result.status}"/></td>
  							<td><c:out value="${result.method}"/></td>
  							<td>
  								<c:if test="${result.status eq '결제완료' || result.status eq '거래완료' || fn:substring(result.status,0,2) eq '배송'}"><c:out value="${result.payday}"/></c:if>
  								<c:if test="${result.status eq '입금요' || result.status eq '취소'}">-</c:if>
  							</td>
  						</tr>
  						</c:forEach>
  						<c:if test="${fn:length(orderList) < 1}">
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
				<button class="right act_excel">엑셀전환</button>
			  </div>
	          <!--//pagenation-->
			</div>
		</section>

	</section>


<%@include file="../include/footer.jsp"%>