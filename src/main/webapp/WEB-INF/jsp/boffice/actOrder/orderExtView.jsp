<%@page contentType="text/html;charset=utf-8"%>
<%@include file="../include/header.jsp"%>
<script type="text/javascript">

function fnReturnFrm(obj,str){
	if(!$("#frmForm input[name='"+obj+"']").val()){
		alert(str);
		$("#frmForm input[name='"+obj+"']").focus();
		return;
	}
}
function fnActOrderDel(obj){
	if(!confirm("삭제하시겠습니까?")){
		return;
	}
	var url = "/boffice/actOrder/actOrderExtDelete.do";
	var param = {psno : obj}
	commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.');
	location.href="/boffice/actOrder/actOrderExtList.do";
}

function fnActOrderList(){
	document.frmForm.action = "/boffice/actOrder/actOrderExtList.do";
	document.frmForm.submit();
}
$(document).on('click', '.act_cancel', function() {
	$('#cont-cancel').toggle('slow');
	return false;
});

$(document).on('click','.act_mod',function(){
	if(!confirm("수정하시겠습니까?")){ return false; }
	var url = "/boffice/actOrder/actOrderExtUpdate.do";
	$("#frmForm input[name='payPrice']").val(uncomma($("#frmForm input[name='payPrice']").val()));
	var param = $("#frmForm").serialize();
	commonUtil.AjaxSynCall(url,param,'text','수정되었습니다.');
	
	document.frmForm.action = "/boffice/actOrder/actOrderExtView.do";
	document.frmForm.submit();
});


$(document).on('click','.btnCancelInfo',function(){
	var url = "/boffice/actOrder/actOrderExtCancelInfo.do";
	var param = $("#frmOrderCnc").serialize();
	commonUtil.AjaxSynCall(url,param,'text','저장되었습니다.');
	
	document.frmForm.action = "/boffice/actOrder/actOrderExtView.do";
	document.frmForm.submit();
});

</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>동영상 연장신청 상세</h3>
				<div class="btnWrap">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_mod">수정</button>
					<c:if test="${loginVO.actGrIdx eq 'G000001'}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_del" onclick="javascript:fnActOrderDel('<c:out value='${resultInfo.sno}'/>');">삭제</button>
					</c:if>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_list" onclick="javascript:fnActOrderList();">목록</button>
				</div>
			</div>
			<div class="realCont">

			<form name="frmForm" id="frmForm" method="post">
				<input type="hidden" name="pageIndex" value="<c:out value='${orderVO.pageIndex}'/>">
				<input type="hidden" name="searchCnd" value="<c:out value='${orderVO.searchCnd}'/>">
				<input type="hidden" name="searchKeyword" value="<c:out value='${orderVO.searchKeyword}'/>">
				<input type="hidden" name="searchActstt" value="<c:out value='${orderVO.searchActstt}'/>">
			
				<input type="hidden" name="sno" id="sno" value='<c:out value='${resultInfo.sno}'/>' />
				<input type="hidden" name="psno" id="psno" value='<c:out value='${resultInfo.osno}'/>' />
			
			  <fieldset>
				<div class="info-msg" style="float:right;margin:0 4px 4px 0;"><c:out value='${resultInfo.jumun}'/> <button class="commonBtn act_print">프린트</button></div>
				<p style="font-size:16px;padding-bottom:7px;">주문 상품</p>
				<table class="commonTable detailTable">
					<caption>주문 내역 테이블</caption>
					<colgroup>
						<col width="40">
						<col>
						<col width="60">
						<col width="110">
						<col width="110">
						<col width="120">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">구분</th>
							<th scope="col">상품명</th>
							<th scope="col">일</th>
							<th scope="col">상품금액</th>
							<th scope="col">결제금액</th>
							<th scope="col">상태</th>
						</tr>
					</thead>
					<tbody>
						<tr data-no="<c:out value='${resultInfo.sno}'/>">
							<td><c:if test="${resultInfo.mobileYn ne 'Y'}">PC</c:if><c:if test="${resultInfo.mobileYn eq 'Y'}">mobile</c:if></td>
							<td><c:out value='${resultInfo.goods}'/></td>
							<td><input type="text" name="giganDay" value="<c:out value='${resultInfo.giganDay}'/>" class="chknum req" title="일 수를 입력해주세요." style="width:30px" /></td>
							<td class="chkmoney"><c:out value='${resultInfo.price}'/></td>
							<td><input type="text" name="payPrice" value="<c:out value='${resultInfo.payPrice}'/>" class="chkmoney" title="결제금액을 입력해주세요." style="width:80px" <c:if test="${loginVO.actGrIdx ne 'G000001'}">disabled</c:if> /></td>
							<td>
								<p>
									<select name="status" <c:if test="${resultInfo.status eq '취소' && loginVO.groupLvl ne '20'}">disabled</c:if>>
										<option value="입금요" <c:if test="${resultInfo.status eq '입금요'}">selected</c:if>>입금요</option>
										<option value="수강중" <c:if test="${resultInfo.status eq '수강중'}">selected</c:if>>수강중</option>
										<option value="수강종료" <c:if test="${resultInfo.status eq '수강종료'}">selected</c:if>>수강종료</option>
										<option value="취소" <c:if test="${resultInfo.status eq '취소'}">selected</c:if>>취소</option>
										<option value="취소고민" <c:if test="${resultInfo.status eq '취소고민'}">selected</c:if>>취소고민</option>
									</select>
								</p>
							</td>
						</tr>
						<tr>
							<th colspan="6"><button class="colorBtn grybtn act_cancel" style="width:120px">주문취소정보</button></th>
						</tr>
					</tbody>
				</table>
			  </fieldset>
			  <fieldset style="padding-top:20px;">
				<p style="font-size:16px;padding-bottom:7px;">결제 정보</p>
				<table class="commonTable detailTable">
					<caption>주문 내역 테이블</caption>
					<colgroup>
						<col width="12%">
						<col>
						<col width="8%">
						<col width="20%">
						<col width="10%">
						<col width="22%">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<th scope="col">결제방법</th>
							<td class="al"><input type="text" name="method2" id="method2" value="<c:out value='${resultInfo.method}'/>" maxlength="25" class="req" /></td>
							<th scope="col">입금자</th>
							<td class="al"><input type="text" name="bName" id="bName" value="<c:out value='${resultInfo.bName}'/>" /></td>
							<th scope="col">입금일</th>
							<td class="al"><input type="text" name="payday" id="payday" value="<c:out value='${resultInfo.payday}'/>" class="calendar" /></td>
						</tr>
						<tr>
							<th scope="col">관리자메모</th>
							<td class="al" colspan="5"><textarea name="memo" id="memo" style="width:96%;height:50px"><c:out value='${resultInfo.memo}'/></textarea></td>
						</tr>
					</tbody>
				</table>
			  </fieldset>
				</form>
			
			  <fieldset style="display:none;padding-top:20px;" id="cont-cancel">
				<p style="font-size:16px;padding-bottom:7px;">주문 취소 정보</p>
				<form id="frmOrderCnc" name="frmOrderCnc">
				<input type="hidden" name="psno" value="<c:out value='${resultInfo.sno}'/>" />
				<input type="hidden" name="sno" value="<c:out value='${cancelInfo.sno}'/>" />
				<table class="commonTable detailTable">
					<caption>주문 내역 테이블</caption>
					<colgroup>
						<col width="12%">
						<col>
						<col width="8%">
						<col width="20%">
						<col width="10%">
						<col width="22%">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<th scope="col">처리담당자</th>
							<td class="al"><input type="text" name="dName" id="dName" value="<c:out value='${cancelInfo.dName}'/>" maxlength="25" class="req" title="처리담당자명을 입력해주세요." /></td>
							<th scope="col">사유</th>
							<td class="al">
								<select name="dReason" id="dReason" style="width:100px" class="req" title="사유를 선택해주세요.">
									 <option value="단순변심" <c:if test="${cancelInfo.dReason eq '단순변심'}">selected</c:if>>단순변심</option>
									 <option value="상품불량" <c:if test="${cancelInfo.dReason eq '상품불량'}">selected</c:if>>상품불량</option>
									 <option value="품절취소" <c:if test="${cancelInfo.dReason eq '품절취소'}">selected</c:if>>품절취소</option>
									 <option value="기타" <c:if test="${cancelInfo.dReason eq '기타'}">selected</c:if>>기타</option>
								 </select>
							</td>
							<th scope="col">취소일</th>
							<td class="al"><input type="text" name="dDate" id="dDate" value="<c:out value='${cancelInfo.dDate}'/>" class="calendar req" title="취소일을 입력해주세요." /></td>
						</tr>
						<tr>
							<th scope="col">상세사유</th>
							<td class="al" colspan="5"><textarea name="dMemo" id="dMemo" style="width:96%;height:50px" class="req" title="상세사유를 입력해주세요."><c:out value='${cancelInfo.dMemo}'/></textarea></td>
						</tr>
						<tr>
							<th scope="col">환불계좌정보</th>
							<td class="al" colspan="5"><input type="text" name="dBank" id="dBank" value="<c:out value='${cancelInfo.dBank}'/>" maxlength="25" style="width:98%" title="환불계좌정보를 입력해주세요." ></td>
						</tr>
					</tbody>
				</table>
				<!--btnsWrap-->
				<div class="btnsWrap">
					<button type="button" class="btnCancelInfo" style="width:150px">주문 취소 정보 저장</button>
				</div>
				<!--//btnsWrap-->
				</form>
			  </fieldset>


			</div>
		</section>

	</section>

	<%@include file="../include/footer.jsp"%>