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
		document.frm.action = "/boffice/actMemb/actMembLectList.do";
		document.frm.submit();
	}
	$(document).on("click",".act_excel",function(){
		document.frm.action = "/boffice/actMemb/actMembLectExcel.do";
		document.frm.submit();
	});
	function fnActMembLectView(sno,psno){
		$("form[name='frm'] input[name='sno']").val(sno);
		$("form[name='frm'] input[name='psno']").val(psno);
		document.frm.action = "/boffice/actMemb/actMembLectView.do";
		document.frm.submit();
	}
	$(document).on("click",".act_excel",function(){
		document.frm.action = "/boffice/actMemb/actMembLectExcel.do";
		document.frm.submit();
	});
	</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>수강 회원 관리</h3>
			</div>
			<div class="realCont">

			<!--search-->
				<form class="SearchForm" name="frm" method="post">
					<input type="hidden" name="pageIndex" value="<c:out value='${orderVO.pageIndex}'/>"/>
					<input type="hidden" name="sno"/>
					<input type="hidden" name="psno"/>
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
  									<th>검색어</th>
  									<td colspan="3">
										<p>
										<select name="searchCnd" id="searchCnd">
											<option value="o_name" <c:if test="${orderVO.searchCnd eq 'o_name'}"> selected</c:if>>주문자명</option>
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
											<input type="checkbox" name="searchOp2" id="searchOp22" value="수강중" <c:if test="${fn:indexOf(orderVO.searchOp2,'수강중') > -1}"> checked</c:if>><label for="searchOp22"><span></span>수강중</label>
											<input type="checkbox" name="searchOp2" id="searchOp23" value="수강종료" <c:if test="${fn:indexOf(orderVO.searchOp2,'수강종료') > -1}"> checked</c:if>><label for="searchOp23"><span></span>수강종료</label>
											<input type="checkbox" name="searchOp2" id="searchOp21" value="입금요" <c:if test="${fn:indexOf(orderVO.searchOp2,'입금요') > -1}"> checked</c:if>><label for="searchOp21"><span></span>입금요</label>
											<input type="checkbox" name="searchOp2" id="searchOp24" value="취소" <c:if test="${fn:indexOf(orderVO.searchOp2,'취소') > -1}"> checked</c:if>><label for="searchOp24"><span></span>취소</label>
											<input type="checkbox" name="searchOp2" id="searchOp25" value="일시정지" <c:if test="${fn:indexOf(orderVO.searchOp2,'일시정지') > -1}"> checked</c:if>><label for="searchOp25"><span></span>일시정지</label>
										</p>
  									</td>
									<th>강의형태</th>
  									<td>
										<p class="checkBox">
											<input type="checkbox" name="searchOp6" id="searchOp60" value="" <c:if test="${empty orderVO.searchOp6}"> checked</c:if> class="check-all"><label for="searchOp60"><span></span>전체</label>
											<input type="checkbox" name="searchOp6" id="searchOp61" value="N" <c:if test="${orderVO.searchOp6 eq 'N'}"> checked</c:if>><label for="searchOp61"><span></span>PC</label>
											<input type="checkbox" name="searchOp6" id="searchOp62" value="Y" <c:if test="${orderVO.searchOp6 eq 'Y'}"> checked</c:if>><label for="searchOp62"><span></span>모바일</label>
										</p>
  									</td>
  								</tr>
  								<tr>
  									<th>주문일</th>
  									<td colspan="3" class="daterange">
										<input class="calendar" type="text" name="searchSdt2" value="<c:out value="${orderVO.searchSdt2}" />">
										~
										<input class="calendar" type="text" name="searchEdt2" value="<c:out value="${orderVO.searchEdt2}" />">
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
											<input type="checkbox" name="searchOp3" id="searchOp34" value="학원결제" <c:if test="${fn:indexOf(orderVO.searchOp3,'학원결제') > -1}"> checked</c:if>><label for="searchOp34"><span></span>학원결제</label>
											<input type="checkbox" name="searchOp3" id="searchOp35" value="실강변경" <c:if test="${fn:indexOf(orderVO.searchOp3,'실강변경') > -1}"> checked</c:if>><label for="searchOp35"><span></span>실강변경</label>
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
				<table class="commonTable detailTable">
  					<caption>관리자 회원관리 테이블</caption>
  					<colgroup>
						<col style="width:60px">
						<col style="width:80px">
						<col style="width:110px">
  						<col style="width:120px">
  						<col style="width:60px">
  						<col>
  						<col style="width:110px">
  						<col style="width:80px">
  					</colgroup>
  					<thead>
  						<tr>
							<th scope="col">번호</th>
  							<th scope="col">이름</th>
  							<th scope="col">아이디</th>
  							<th scope="col">연락처</th>
  							<th scope="col">구분</th>
  							<th scope="col">수강강의</th>
  							<th scope="col">수강기간</th>
  							<th scope="col">수강상태</th>
  						</tr>
  					</thead>
  					<tbody>
  						<c:forEach var="result" items="${orderList}" varStatus="status">
  						<tr>
			                <td class="list-no"><c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/></td>
  							<td><a href="javascript:fnActMembLectView('<c:out value="${result.sno2}"/>','<c:out value="${result.sno}"/>')"><c:out value="${result.oName}"/></a></td>
  							<td><a href="javascript:fnActMembLectView('<c:out value="${result.sno2}"/>','<c:out value="${result.sno}"/>')"><c:out value="${result.uid}"/></a></td>
  							<td><div><c:out value="${result.oTel}"/></div><div><c:out value="${result.oHand}"/></div></td>
  							<td><c:if test="${result.mobileYn2 eq 'Y'}"><div class=ord-mobile>mobile</div></c:if><c:if test="${result.mobileYn2 eq 'N'}"><div class=ord-pc>PC</div></c:if></td>
  							<td class="al"><a href="javascript:fnActMembLectView('<c:out value="${result.sno2}"/>','<c:out value="${result.sno}"/>')"><c:out value="${result.goods}"/></a></td>
  							<td><c:out value="${result.bsinDate}"/><br/><c:out value="${result.bsinDate2}"/></td>
  							<td><c:out value="${result.status2}"/></td>
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