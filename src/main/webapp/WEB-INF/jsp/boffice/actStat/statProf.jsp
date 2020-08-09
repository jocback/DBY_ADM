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
		document.frm.action = "/boffice/actStat/statProfList.do";
		document.frm.submit();
	}
	$(document).on("click",".act_excel",function(){
		document.frm.action = "/boffice/actStat/statProfExcel.do";
		document.frm.submit();
	});
	</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>교수별 정산</h3>
			</div>
			<div class="realCont">

			<!--search-->
				<form class="SearchForm" name="frm" method="post">
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
  									<th>담당교수</th>
  									<td>
										<p>
										<select name="searchOp4">
											<option value="">전체</option>
										<c:forEach var="profList" items="${profList}" varStatus="status">
											<option value="<c:out value='${profList.mId}'/>" <c:if test="${orderVO.searchOp4 eq profList.mId}">selected</c:if> ><c:out value="${profList.mName}"/>(<c:out value="${profList.mId}"/>)</option>
										</c:forEach>
										</select>
										</p>
									</td>
  									<th>유형</th>
  									<td>
										<p>
										<select name="searchOp5" style="width:70px">
										<option value="">전체</option>
										<option value="0" <c:if test="${orderVO.searchOp5 eq '0'}"> selected</c:if>>종합</option>
										<option value="1" <c:if test="${orderVO.searchOp5 eq '1'}"> selected</c:if>>단과</option>
										</select>
										</p> 교수선택시 무조건 단과 검색
									</td>
  								</tr>
  								<tr>
  									<th>검색어</th>
  									<td colspan="3">
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
  									<th>입금일</th>
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
											<input type="checkbox" name="searchOp3" id="searchOp34" value="학원결제" <c:if test="${fn:indexOf(orderVO.searchOp3,'학원결제') > -1}"> checked</c:if>><label for="searchOp34"><span></span>학원결제</label>
											<input type="checkbox" name="searchOp3" id="searchOp35" value="실강변경" <c:if test="${fn:indexOf(orderVO.searchOp3,'실강변경') > -1}"> checked</c:if>><label for="searchOp35"><span></span>실강변경</label>
											<input type="checkbox" name="searchOp6" id="searchOp6" value="Y" <c:if test="${orderVO.searchOp6 eq 'Y'}"> checked</c:if>><label for="searchOp6"><span></span>모바일강의</label>
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
  					<span class="total_left">검색 <strong><c:out value="${paginationInfo.totalRecordCount}"/></strong>, <c:out value="${orderVO.pageIndex}"/> of <c:out value="${paginationInfo.lastPageNo}"/> page</span>
  				</p>
				<form id="frm_list" name="frm_list">
				<input type="hidden" name="act" value="" />
				<table class="commonTable detailTable">
  					<caption>관리자 회원관리 테이블</caption>
  					<colgroup>
						<col style="width:60px">
  						<col style="width:70px">
						<col style="width:70px">
						<col style="width:90px">
  					</colgroup>
  					<thead>
  						<tr>
 							<th scope="col">번호</th>
  							<th scope="col">교수명</th>
  							<th scope="col">주문자</th>
  							<th scope="col">입금일</th>
  							<th scope="col">강좌명</th>
  							<th scope="col">구분</th>
  							<th scope="col">소비자가 /<br/>할인금액</th>
  							<th scope="col">수강료 /<br/>제외금액</th>
  							<th scope="col">정산적용<br/>수강료</th>
  							<th scope="col">수수료율</th>
  							<th scope="col">수수료</th>
  							<th scope="col">수강구분</th>
  							<th scope="col">상태</th>
  							<th scope="col">주문일</th>
  						</tr>
  					</thead>
  					<tbody>
  						<c:set var="lectIdxE" value=""/>
  						<c:set var="lectCnt" value="0"/>
  						<c:set var="exPrice" value="0"/>
  						<c:set var="payPrice" value="0"/>
  						<c:set var="modPrice" value="0"/>
  						<fmt:parseNumber var="feeAmt" integerOnly="true" value="0"/>
  						<c:forEach var="result" items="${orderList}" varStatus="status">
  						<c:if test="${empty result.coIdx}">
	  						<c:if test="${result.lectureSno eq '0'}"><c:set var="lectIdxE" value="${result.jongNew}"/></c:if>
	  						<c:if test="${result.lectureSno ne '0'}"><c:set var="lectIdxE" value="${result.lectureSno}"/></c:if>
  						</c:if>
  						<c:if test="${result.coIdx eq '0' || result.coIdx*1 > 0}"><c:set var="lectIdxE" value="${result.pro}"/></c:if>
  						<c:set var="lectIdxE" value="${fn:split(lectIdxE,',')}"/>
  						<c:set var="lectCnt" value="${fn:length(lectIdxE)}"/>
  						<c:set var="payPrice" value="${result.price2*1+result.usePoint*1}"/>
  						<c:if test="${result.lectureSno ne '0'}">
  							<c:set var="exPrice" value="${result.exPrice}"/>
  							<c:set var="modPrice" value="${result.price2*1 - exPrice*1}"/>
  						</c:if>
  						<c:if test="${result.lectureSno eq '0'}">
  							<c:set var="exPrice" value="${result.exPriceJong}"/>
  							<c:set var="modPrice" value="${(result.price2*1 - exPrice*1)*1/lectCnt}"/>
  						</c:if>
  						<fmt:parseNumber var="feeAmt" integerOnly="true" value="${modPrice*(result.feeRate/100)}"/>
  						<tr>
			                <td class="list-no"><c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/></td>
  							<td><c:out value="${result.tName}"/></td>
  							<td><c:out value="${result.oName}"/></td>
  							<td><c:out value="${result.payday}"/></td>
  							<td class="al"><div><c:out value="${result.goods}"/></div><div style="font-weight:bolder"><c:out value="${result.subject}"/></div></td>
  							<td>
  								<div>
			  						<c:if test="${result.lectureSno eq '0'}">종합(<label class=ord-mobile><c:out value="${lectCnt}"/></label>)</c:if>
			  						<c:if test="${result.lectureSno ne '0'}">단과</c:if>
  								</div>
  								<div><c:if test="${result.freeBookCnt>0}">교재포함</c:if></div>
  							</td>
  							<td class="ar">
  								<div class="chkmoney"><c:out value="${result.price}"/></div>
  								<div class="chkmoney"><c:out value="${result.price*1-payPrice}"/></div>
  							</td>
  							<td class="ar">
  								<div class="chkmoney"><c:out value="${payPrice}"/></div>
  								<div class="chkmoney"><c:out value="${exPrice}"/></div>
  							</td>
  							<td class="ar"><b class="chkmoney"><c:out value="${modPrice}"/></b></td>
  							<td class="ar"><c:out value="${result.feeRate}"/>%</td>
  							<td class="ar"><b class="chkmoney"><c:out value="${feeAmt}"/></b></td>
  							<td><c:if test="${result.mobileYn2 eq 'Y'}"><div class=ord-mobile>mobile</div></c:if><c:if test="${result.mobileYn2 eq 'N'}"><div class=ord-pc>PC</div></c:if></td>
  							<td><c:out value="${result.status2}"/></td>
  							<td><c:out value="${result.oDate}"/></td>
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