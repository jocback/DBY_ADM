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
		document.frm.action = "<c:url value='/boffice/actOrder/actOrderList.do'/>";
		document.frm.submit();
	}
	function fnActOrderView(no) {
		 if(!no) return false;
		 document.frm.psno.value = no;
		 document.frm.action = "<c:url value='/boffice/actOrder/actOrderView.do'/>";
		 document.frm.submit();
	}

	$(document).on('click', '.act_del, .act_list_del', function() {
		if ($('#frm_list input[name=psno]:checked').length <= 0) {
				alert('선택된 주문이 없습니다.');
				return false;
		}
		var title = '선택주문 : '+$('#frm_list input[name=psno]:checked').length+'건';
		var param = $('#frm_list').serialize();
		if (confirm(title+' - 삭제하시겠습니까?')) {
			var url = "/boffice/actOrder/actOrderDelete.do";
			commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.');
			fnActResultList('1');
		}
		return false;
	});
	$(document).on('click', '.act_lecture', function() {
		dialog_doc($(this).closest('tr').find('.date').text()+' '+$(this).closest('tr').find('.name').text()+' - 강좌변경', '/boffice/actLecture/actMovingListPop2.do?sapStatus='+$(this).data("no")+'&searchMyAct='+$(this).data("sno"), 900, 780);
		return false;
	});

	$(document).on("click",".act_excel",function(){
		document.frm.action = "/boffice/actOrder/actOrderExcel.do";
		document.frm.submit();
	});
	</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>동영상 신청 리스트</h3>
				<!-- div class="btnWrap">
					<button type="button" class="colorBtn act_lecture_closing" style="background-color:#f00281;">수강정리</button>
				</div-->
			</div>
			<div class="realCont">

				<form name="frm" method="post" class="SearchForm">
  					<fieldset>
						<input name="pageIndex" type="hidden" value="<c:out value='${orderVO.pageIndex}'/>"/>
						<input name="searchOp1" type="hidden" value="<c:out value='${orderVO.searchOp1}'/>"/>
						<input name="psno" type="hidden"/>
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
												<option value="6" <c:if test="${orderVO.searchCnd eq '6'}"> selected</c:if>>결제메모</option>
												<option value="7" <c:if test="${orderVO.searchCnd eq '7'}"> selected</c:if>>관리자메모</option>
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
							<button type="button" class="" onclick="javascript:fnActResultList('1'); return false;">검색</button>
						</div>
  					</fieldset>
				</form>

				<!--menuTable-->
				<form name="frm_list" id="frm_list" method="post">
				<input type="hidden" name="status2" id="order_status"/>
				<table class="commonTable detailTable">
					<caption>동영상 신청 리스트</caption>
					<colgroup>
						<col style="width:40px">
						<col style="width:50px">
						<col style="width:100px">
						<col style="width:60px">
						<col style="width:80px">
						<col style="width:*">
						<col style="width:80px">
						<col style="width:120px">
						<col style="width:70px">
						<col style="width:80px">
						<col style="width:100px">
						<col style="width:120px">
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
							<th>주문일시<br/>주문경로</th>
							<th>수강구분</th>
							<th>강좌구분</th>
							<th>강좌</th>
							<th>결제금액</th>
							<th>결제수단</th>
							<th>주문상태</th>
							<th>주문자<br/>입금자</th>
							<th>시작일<br/>종료일</th>
							<th>연락처</th>
						</tr>
					</thead>
					<tbody>
	 <c:forEach var="result" items="${orderList}" varStatus="status">
						<tr>
							<td rowspan="<c:out value="${result.subListCnt+1}"/>">
								<span class="checkBox">
									<input type="checkbox" class="no" name="psno" value="<c:out value='${result.psno}'/>" id="no<c:out value='${result.psno}'/>">
									<label for="no<c:out value='${result.psno}'/>"><span></span>선택</label>
								</span>
							</td>
							<td rowspan="<c:out value="${result.subListCnt+1}"/>" class="list-no">
								<a href="javascript:void(0);" onclick="javascript:fnActOrderView('<c:out value='${result.psno}'/>');">
								<c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/>
								</a>
							</td>
							<td rowspan="<c:out value="${result.subListCnt+1}"/>">
								<a href="javascript:void(0);" onclick="javascript:fnActOrderView('<c:out value='${result.psno}'/>');">
								<div class="date"><c:out value="${result.oDate}"/></div><c:if test="${result.mobile ne 'Y'}"><div class=ord-pc>PC</div></c:if><c:if test="${result.mobile eq 'Y'}"><div class=ord-mobile>mobile</div></c:if>
								</a>
							</td>
							<td><c:if test="${result.mobileYn ne 'Y'}"><div class=ord-pc>PC</div></c:if><c:if test="${result.mobileYn eq 'Y'}"><div class=ord-mobile>mobile</div></c:if></td>
							<td><c:if test="${result.lectureSno eq '0'}">종합<br/><button type="button" class="commonBtn act_lecture" data-no="<c:out value='${result.psno}'/>" data-sno="<c:out value='${result.sno}'/>">강좌변경</button></c:if><c:if test="${result.lectureSno ne '0'}">단과</c:if></td>
							<td class="al">
								<a href="javascript:void(0);" onclick="javascript:fnActOrderView('<c:out value='${result.psno}'/>');">
								<c:out value="${result.goods}"/></a>
							</td>
							<td class="ar chkmoney"><c:out value="${result.price2}"/></td>
							<td rowspan="<c:out value="${result.subListCnt+1}"/>">
								<div><c:out value="${result.method2}"/></div>
  								<c:if test="${result.method2 eq '무통장입금' || result.method2 eq '가상계좌'}">
  								<div>(<c:out value="${result.sian}"/>)</div>
  								</c:if>
							</td>
							<td><c:out value="${result.status2}"/></td>
							<td rowspan="<c:out value="${result.subListCnt+1}"/>"><div class="name"><c:out value="${result.oName}"/></div><div>(<c:out value="${result.uid}"/>)</div><div><c:out value="${result.bName}"/></div></td>
							<td><c:out value="${result.sinDate}"/><br/><c:out value="${result.sinDate2}"/></td>
							<td rowspan="<c:out value="${result.subListCnt+1}"/>"><div><c:out value="${result.oTel}"/></div><div><c:out value="${result.oHand}"/></div></td>
						</tr>
					 <c:forEach var="resultSub" items="${result.subList}" varStatus="status">
						<tr>
							<td><c:if test="${resultSub.mobileYn ne 'Y'}"><div class=ord-pc>PC</div></c:if><c:if test="${resultSub.mobileYn eq 'Y'}"><div class=ord-mobile>mobile</div></c:if></td>
							<td><c:if test="${resultSub.lectureSno eq '0'}">종합<br/><button type="button" class="commonBtn act_lecture" data-no="<c:out value='${result.psno}'/>" data-sno="<c:out value='${resultSub.sno}'/>">강좌변경</button></c:if><c:if test="${resultSub.lectureSno ne '0'}">단과</c:if></td>
							<td class="al">
								<a href="javascript:void(0);" onclick="javascript:fnActOrderView('<c:out value='${result.psno}'/>');">
								<c:out value="${resultSub.goods}"/></a>
							</td>
							<td class="ar chkmoney"><c:out value="${resultSub.price2}"/></td>
							<td><c:out value="${resultSub.status2}"/></td>
							<td><div><c:out value="${resultSub.sinDate}"/></div><div><c:out value="${resultSub.sinDate2}"/></div></td>
						</tr>
					</c:forEach>
	</c:forEach>
					</tbody>
				</table>
				</form>
				<!--//menuTable-->

<style>
.list_status{float:left}
.act_list_status {margin-left:2px; margin-right:5px;}
</style>
				<!-- pagingType03 -->
				<div class="pageNation clear">
					<c:if test="${loginVO.groupLvl eq '20'}">
					<select class="list_status" id="list_status" style="width:90px;">
						<option value="">==선택==</option>
						<option value="입금요">입금요</option>
						<option value="수강중">수강중</option>
						<option value="수강종료">수강종료</option>
						<option value="취소">취소</option>
						<option value="일시정지">일시정지</option>
						<option value="취소고민">취소고민</option>
					</select>
					<button class="left act_list_status">주문상태변경</button>
  					</c:if> 
  					<button class="left act_list_del">선택삭제</button>
					<c:if test="${loginVO.groupLvl eq '20'}">
  					<button class="left act_gigan" style="margin-left:4px;">수강일수변경</button>
					<button class="left act_sin_date" style="margin-left:4px;">수강기간변경</button>
					<button class="left act_price" style="margin-left:4px;">수강금액변경</button>
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

<div class="dialog" id="lyr_popup" title="수강일수변경">
	<form id="frm">
	<p>선택한 주문의 수강일수를 변경합니다. </p>
	<input type="hidden" name="psno" value="" />
	  <div>
			<p class="radioStyle">
				<input type="radio" name="mode" id="mode_add" value="add" checked="checked" ><label for="mode_add"><span></span>추가</label>
				<input type="radio" name="mode" id="mode_sub" value="sub" ><label for="mode_sub"><span></span>차감</label>
				일 수 : <input type="text" name="giganDay" value="" class="chknum req" title="추가 또는 차감 일 수를 입력해주세요." style="width:50px" />일 
			</p>
	  </div>
	</form>
</div>

<div class="dialog" id="lyr_sin_date" title="수강기간변경">
	<form id="frm_sin_date">
	<p>선택한 주문의 수강기간를 변경합니다. </p>
	<input type="hidden" name="psno" value="" />
	  <div>
			<p class="radioStyle">
				<input class="calendar" type="text" id="s_sin_date" name="searchSdt" />
				~
				<input class="calendar" type="text" id="e_sin_date" name="searchEdt" />
			</p>
	  </div>
	</form>
</div>

<div class="dialog" id="lyr_price" title="수강금액변경">
	<form id="frm_price">
	<p>선택한 주문의 수강금액을 변경합니다. </p>
	<input type="hidden" name="psno" value="" />
	  <div>
			<p class="radioStyle">
				<input type="text" id="price2" name="price2" />
			</p>
	  </div>
	</form>
</div>

<script>
$(function() {
	var dialog;
	$(document).on('click', '.act_lecture_closing', function() {
		//var url = "/boffice/actOrder/transActOrderClosing.do";
		//var param = {};
		//alert("testing....");
		//commonUtil.AjaxSynCall(url,param,'text','변경되었습니다.');
		//location.reload();
	});
	$(document).on('click', '.act_gigan', function() {
		if ($('#frm_list input[name=psno]:checked').length <= 0) {
			alert('선택된 주문이 없습니다.');
			return false;
		}
		var no = '';
		$.each($('#frm_list input[name=psno]:checked'), function() {
			no += (no == '' ? '' : ',')+$(this).val();
		});
		$('#frm input[name=psno]').val(no);
		$('#frm input[name=giganDay]').val('');
		dialog.dialog('open');
		return false;
	});

	$(document).on('click', '.act_sin_date', function() {
		if ($('#frm_list input[name=psno]:checked').length <= 0) {
			alert('선택된 주문이 없습니다.');
			return false;
		}
		var no = '';
		$.each($('#frm_list input[name=psno]:checked'), function() {
			no += (no == '' ? '' : ',')+$(this).val();
		});
		$('#frm_sin_date input[name=psno]').val(no);
		dialog_sin_date.dialog('open');
		return false;
	});

	$(document).on('click', '.act_price', function() {
		if ($('#frm_list input[name=psno]:checked').length <= 0) {
			alert('선택된 주문이 없습니다.');
			return false;
		}
		var no = '';
		$.each($('#frm_list input[name=psno]:checked'), function() {
			no += (no == '' ? '' : ',')+$(this).val();
		});
		$('#frm_price input[name=psno]').val(no);
		dialog_price.dialog('open');
		return false;
	});

	$(document).ready(function() {
		dialog = $('#lyr_popup').dialog({
			autoOpen: false,
			resizable:false,
			modal:true,
			height:180,
			width:360,
			buttons: {
				"적용": function() {
					if($("#lyr_popup input[name='mode']:checked").val() == "sub"){
						$("#lyr_popup input[name='giganDay']").val("-"+$("#lyr_popup input[name='giganDay']").val());
					}
					if (form_val_chk($('#frm'))) {
						var url = "/boffice/actOrder/transActOrderGigan.do";
						var param = $('#frm').serialize();
						commonUtil.AjaxSynCall(url,param,'text','변경되었습니다.');
						location.reload();
					}
				},
				"취소": function() {
					dialog.dialog( "close" );
				}
			},
			close: function() {
				$('#lyr_popup').hide();
			}
		});

		dialog_sin_date = $('#lyr_sin_date').dialog({
			autoOpen: false,
			resizable:false,
			modal:true,
			height:180,
			width:360,
			buttons: {
				"적용": function() {
					var s_sin_date = $("#frm_sin_date #s_sin_date").val().trim();
					var e_sin_date = $("#frm_sin_date #e_sin_date").val().trim();
					var s_date = new Date(s_sin_date);
					var e_date = new Date(e_sin_date);

					if (!s_sin_date) {
						alert("시작일을 입력해 주세요");
						$("#s_sin_date").focus();
						return false;
					} else if (!e_sin_date) {
						alert("종료일을 입력해 주세요");
						$("#e_sin_date").focus();
						return false;
					} else if (s_date >= e_date) {
						alert("기간입력이 잘못되었습니다");
						$("#s_sin_date").focus();
						return false;
					} else {
						var url = "/boffice/actOrder/transActOrderSinDate.do";
						var param = $('#frm_sin_date').serialize();
						commonUtil.AjaxSynCall(url,param,'text','변경되었습니다.');
						location.reload();
					}
				},
				"취소": function() {
					dialog_sin_date.dialog( "close" );
				}
			},
			close: function() {
				$('#lyr_sin_date').hide();
			}
		});

		dialog_price = $('#lyr_price').dialog({
			autoOpen: false,
			resizable:false,
			modal:true,
			height:180,
			width:360,
			buttons: {
				"적용": function() {
					if (!$("#frm_price #price2").val().trim()) {
						alert("수강금액 입력해 주세요");
						$("#frm_price #price2").focus();
						return false;
					} else if (isNaN($("#frm_price #price2").val().trim()) == true) {
						alert("수강금액을 숫자로 입력해 주세요");
						$("#frm_price #price2").focus();
						return false;
					} else {
						var url = "/boffice/actOrder/transActOrderPrice2.do";
						var param = $('#frm_price').serialize();
						commonUtil.AjaxSynCall(url,param,'text','변경되었습니다.');
						location.reload();
					}
				},
				"취소": function() {
					dialog_price.dialog( "close" );
				}
			},
			close: function() {
				$('#lyr_price').hide();
			}
		});
	});

	$(".act_list_status").click(function() {
		if ($(".no:checked").length == 0) {
			alert("선택된 주문이 없습니다.");
		} else if (!$("#list_status").val()) {
			alert("주문상태를 선택하세요");
			$("#list_status").focus();
		} else {
			$("#frm_list #order_status").val($("#list_status").val());
			title = "선택주문 : " + $(".no:checked").length + "건";
			req = $('#frm_list').serialize();
			url = "/boffice/actOrder/transOrderStatus.do";

			if (confirm(title+' - 주문상태변경 하시겠습니까?')) {
				commonUtil.AjaxSynCall(url,req,'text','변경되었습니다.');
				location.reload();
			}
		}
	});
});
</script>

<%@include file="../include/footer.jsp"%>