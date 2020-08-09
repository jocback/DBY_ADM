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
		document.frm.action = "<c:url value='/boffice/actOrder/actOrderBookList.do'/>";
		document.frm.submit();
	}
	function fnActOrderView(no) {
		 if(!no) return false;
		 document.frm.sno.value = no;
		 document.frm.action = "<c:url value='/boffice/actOrder/actOrderBookView.do'/>";
		 document.frm.submit();
	}

	$(document).on('click', '.act_del, .act_list_del', function() {
		if ($('#frm_list input[name=sno]:checked').length <= 0) {
				alert('선택된 주문이 없습니다.');
				return false;
		}
		var title = '선택주문 : '+$('#frm_list input[name=sno]:checked').length+'건';
		var param = $('#frm_list').serialize();
		if (confirm(title+' - 삭제하시겠습니까?')) {
			var url = "/boffice/actOrder/actOrderBookDelete.do";
			commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.');
			fnActResultList('1');
		}
		return false;
	});

	$(document).on("click",".act_excel",function(){
		document.frm.action = "/boffice/actOrder/actOrderBookExcel.do";
		document.frm.submit();
	});
	</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>서적 주문 관리</h3>
			</div>
			<div class="realCont">

			<!--search-->
				<form class="SearchForm" name="frm" method="post">
					<input type="hidden" name="pageIndex" value="<c:out value='${orderVO.pageIndex}'/>"/>
					<input type="hidden" name="sno"/>
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
											<option value="b_name" <c:if test="${orderVO.searchCnd eq 'b_name'}"> selected</c:if>>입금자명</option>
											<option value="uid" <c:if test="${orderVO.searchCnd eq 'uid'}"> selected</c:if>>주문자아이디</option>
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

				<!--menuTable-->
			  <p class="total">
  					<span class="total_left">총 <strong class="chkmoney"><c:out value="${totCnt}"/></strong>개, 검색 <strong><c:out value="${paginationInfo.totalRecordCount}"/></strong>, <c:out value="${orderVO.pageIndex}"/> of <c:out value="${paginationInfo.lastPageNo}"/> page</span>
  				</p>
				<form name="frm_list" id="frm_list" method="post">
				<input type="hidden" name="status" id="status"/>
				<table class="commonTable detailTable">
					<caption>교재 신청 리스트</caption>
					<colgroup>
						<col style="width:30px">
						<col style="width:60px">
						<col style="width:80px">
  						<col>
  						<col style="width:100px">
  						<col style="width:60px">
  						<col style="width:110px">
  						<col style="width:100px">
  						<col style="width:70px">
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
							<th scope="col">번호</th>
  							<th scope="col">주문일시<br/>주문경로</th>
  							<th scope="col">상품명</th>
  							<th scope="col">주문자</th>
  							<th scope="col">수령인</th>
  							<th scope="col">연락처</th>
  							<th scope="col">결제수단</th>
  							<th scope="col">결제금액</th>
  							<th scope="col">주문상태</th>
						</tr>
					</thead>
					<tbody>
	 <c:forEach var="result" items="${orderList}" varStatus="status">
						<tr>
							<td>
								<span class="checkBox">
									<input type="checkbox" class="no" name="sno" value="<c:out value='${result.sno}'/>" id="no<c:out value='${result.sno}'/>">
									<label for="no<c:out value='${result.sno}'/>"><span></span>선택</label>
								</span>
							</td>
							<td class="list-no">
								<c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/>
							</td>
  							<td><div class="date"><c:out value="${result.oDate}"/></div><c:if test="${result.mobileOrderYn eq 'Y'}"><div class=ord-mobile>mobile</div></c:if><c:if test="${result.mobileOrderYn ne 'Y'}"><div class=ord-pc>PC</div></c:if></td>
  							<td class="al"><a href="javascript:void(0);" onclick="javascript:fnActOrderView('<c:out value='${result.sno}'/>')">
								<c:out value="${result.pName}"/>
							</a> <button type="button" class="commonBtn" onclick="javascript:fnActOrderView('<c:out value='${result.sno}'/>')">변경</button></td>
  							<td><div class="name"><c:out value="${result.oName}"/></div><div><c:out value="${result.uid}"/></div></td>
							<td><c:out value="${result.rName}"/></td>
  							<td><div><c:out value="${result.oTel}"/></div><div><c:out value="${result.oHand}"/></div></td>
  							<td>
  								<div><c:out value="${result.method}"/></div><div><c:out value="${result.fname}"/></div>
  								<c:if test="${result.method eq '무통장입금' || result.method eq '가상계좌'}">
  								<div>(<c:out value="${result.sian}"/>)</div>
  								</c:if>
  							</td>
  							<td class="chkmoney"><c:out value="${result.pTotal}"/></td>
  							<td><c:out value="${result.status}"/></td>
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
				<!--//menuTable-->

				<!-- pagingType03 -->
				<div class="pageNation clear">
					<c:if test="${loginVO.actGrIdx eq 'G000001'}">
					<select class="list_status" id="list_status" style="width:90px;">
						<option value="">==선택==</option>
						<option value="입금요">입금요</option>
						<option value="주문접수">주문접수</option>
						<option value="결제완료">결제완료</option>
						<option value="배송준비중">배송준비중</option>
						<option value="배송중">배송중</option>
						<option value="배송완료">배송완료</option>
						<option value="거래완료">거래완료</option>
						<option value="주문취소">주문취소</option>
					</select>
					<button class="left act_list_status">주문상태변경</button>
  					<button class="left act_list_del">선택삭제</button>
  					</c:if> 
					<ul class="pagenation">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnActResultList" />
					</ul>
					<button class="right act_excel">엑셀전환</button>
				</div>
				<!-- //pagingType03 -->

			</div>
		</section>

	</section>

<style>
.list_status{float:left}
.act_list_status {margin-left:2px; margin-right:5px;}
</style>
<script>
$(function() {
	$(".act_list_status").click(function() {
		if ($(".no:checked").length == 0) {
			alert("선택된 주문이 없습니다.");
		} else if (!$("#list_status").val()) {
			alert("주문상태를 선택하세요");
			$("#list_status").focus();
		} else {
			$("#frm_list #status").val($("#list_status").val());
			title = "선택주문 : " + $(".no:checked").length + "건";
			param = $('#frm_list').serialize();

			if (confirm(title+' - 주문상태변경 하시겠습니까?')) {
				commonUtil.AjaxSynCall("/boffice/actOrder/actOrderBookTrans.do",param,'text','변경되었습니다.');
				location.reload();
			}
		}
	});
});
</script>

<%@include file="../include/footer.jsp"%>