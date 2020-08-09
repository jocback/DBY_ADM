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
	var url = "/boffice/actOrder/actOrderDelete.do";
	var param = {psno : obj}
	commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.');
	location.href="/boffice/actOrder/actOrderList.do";
}

function fnActOrderList(){
	document.frmForm.action = "/boffice/actOrder/actOrderList.do";
	document.frmForm.submit();
}
$(document).on('click', '.act_cancel', function() {
	$('#cont-cancel').toggle('slow');
	return false;
});
$(document).on('click','.act_goods_modi',function(){
	var sno = $(this).closest('tr').data('no');
	var sin_date = $(this).closest('tr').find('input[name=sinDate]').val();
	var gigan_day = uncomma($(this).closest('tr').find('input[name=giganDay]').val());
	var price2 = uncomma($(this).closest('tr').find('input[name=price2]').val());
	var status2 = $(this).closest('tr').find('select[name=status2]>option:selected').val();
	var mobile_yn = $(this).closest('tr').find('select[name=mobileYn]>option:selected').val();

	var url = "/boffice/actOrder/actOrderUpdate.do";
	var param = {'psno':'<c:out value="${resultInfo.sno}"/>', 'sno':sno, 'sinDate':sin_date, 'giganDay':gigan_day, 'price2':price2, 'status2':status2, 'mobileYn':mobile_yn}
	commonUtil.AjaxSynCall(url,param,'text','수정되었습니다.');
	
	document.frmForm.action = "/boffice/actOrder/actOrderView.do";
	document.frmForm.submit();
});

$(document).on('click','.orderBasicUpdate, .act_mod',function(){
	if(!confirm("수정하시겠습니까?")){ return false; }
	var url = "/boffice/actOrder/actOrderBasicUpdate.do";
	var param = $("#frm_write").serialize();
	commonUtil.AjaxSynCall(url,param,'text','수정되었습니다.');
	
	document.frmForm.action = "/boffice/actOrder/actOrderView.do";
	document.frmForm.submit();
});

$(document).on('click','.btnCancelInfo',function(){
	var url = "/boffice/actOrder/actOrderCancelInfo.do";
	var param = $("#frmOrderCnc").serialize();
	commonUtil.AjaxSynCall(url,param,'text','저장되었습니다.');
	
	document.frmForm.action = "/boffice/actOrder/actOrderView.do";
	document.frmForm.submit();
});

</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>동영상강의 등록</h3>
				<div class="btnWrap">
					<c:if test="${loginVO.groupLvl eq '20'}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_mod">수정</button>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_del" onclick="javascript:fnActOrderDel('<c:out value='${resultInfo.sno}'/>');">삭제</button>
					</c:if>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_list" onclick="javascript:fnActOrderList();">목록</button>
				</div>
			</div>
			<div class="realCont">

				<form name="frmForm" id="frmForm" method="post">
					<input type="hidden" name="pageIndex" value="<c:out value='${orderVO.pageIndex}'/>">
					<input name="searchOp1" type="hidden" value="<c:out value='${orderVO.searchOp1}'/>"/>
					<input name="searchOp2" type="hidden" value="<c:out value='${orderVO.searchOp2}'/>"/>
					<input name="searchOp3" type="hidden" value="<c:out value='${orderVO.searchOp3}'/>"/>
					<input name="searchOp6" type="hidden" value="<c:out value='${orderVO.searchOp6}'/>"/>
					<input type="hidden" name="searchCnd" value="<c:out value='${orderVO.searchCnd}'/>">
					<input type="hidden" name="searchKeyword" value="<c:out value='${orderVO.searchKeyword}'/>">
					<input type="hidden" name="searchSdt" value="<c:out value='${orderVO.searchSdt}'/>">
					<input type="hidden" name="searchEdt" value="<c:out value='${orderVO.searchEdt}'/>">
				
					<input type="hidden" name="psno" id="psno" value='<c:out value='${resultInfo.sno}'/>' />
				</form>

  <fieldset>
	<div class="info-msg" style="float:right;margin:0 4px 4px 0;"><c:out value='${resultInfo.jumun}'/> <button class="commonBtn act_print">프린트</button></div>
	<p style="font-size:16px;padding-bottom:7px;">주문 상품</p>
	<table class="commonTable detailTable">
		<caption>주문 내역 테이블</caption>
		<colgroup>
			<col width="40">
			<col width="100">
			<col>
			<col width="210">
			<col width="60">
			<col width="110">
			<col width="110">
			<col width="100">
			<col width="60">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">구분</th>
				<th scope="col">상품명</th>
				<th scope="col">기간</th>
				<th scope="col">일</th>
				<th scope="col">상품금액</th>
				<th scope="col">결제금액</th>
				<th scope="col">상태</th>
				<th scope="col">관리</th>
			</tr>
		</thead>
		<tbody>
			<c:set var="totPrice2" value="0"/>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:set var="totPrice2" value="${totPrice2+result.price2}"/>
			<tr data-no="<c:out value='${result.sno}'/>">
				<td><c:out value='${status.index+1}'/></td>
				<td>
					<select name="mobileYn">
						<option value="N" <c:if test="${result.mobileYn ne 'Y'}">selected</c:if>>PC</option>
						<option value="Y" <c:if test="${result.mobileYn eq 'Y'}">selected</c:if>>mobile</option>
					</select>
					</td>
				<td><c:out value='${result.goods}'/></td>
				<td><input type="text" name="sinDate" value="<c:out value='${result.sinDate}'/>" class="calendar req" title="시작일을 입력해주세요." /> ~ <c:out value='${result.sinDate2}'/></td>
				<td><input type="text" name="giganDay" value="<c:out value='${result.giganDay}'/>" class="chknum req" title="일 수를 입력해주세요." style="width:30px" /></td>
				<td class="chkmoney ar"><c:out value='${result.price2}'/></td>
				<td><input type="text" name="price2" value="<c:out value='${result.price2}'/>" class="chkmoney" title="결제금액을 입력해주세요." style="width:80px" <c:if test="${loginVO.groupLvl ne '20'}">disabled</c:if> /></td>
				<td>
					<p>
						<select name="status2" <c:if test="${result.status2 eq '취소' && loginVO.groupLvl ne '20'}">disabled</c:if>>
							<option value="입금요" <c:if test="${result.status2 eq '입금요'}">selected</c:if>>입금요</option>
							<option value="수강중" <c:if test="${result.status2 eq '수강중'}">selected</c:if>>수강중</option>
							<option value="수강종료" <c:if test="${result.status2 eq '수강종료'}">selected</c:if>>수강종료</option>
							<option value="취소" <c:if test="${result.status2 eq '취소'}">selected</c:if>>취소</option>
							<option value="일시정지" <c:if test="${result.status2 eq '일시정지'}">selected</c:if>>일시정지</option>
							<option value="취소고민" <c:if test="${result.status2 eq '취소고민'}">selected</c:if>>취소고민</option>
						</select>
					</p>
				</td>
				<td><c:if test="${result.status ne '취소' || loginVO.groupLvl eq '20'}"><button type="button" class="commonBtn act_goods_modi">수정</button></c:if></td>
			</tr>
			</c:forEach>
			<tr>
				<th colspan="5">합계</th>
				<th class="chkmoney ar"><c:out value='${totPrice2}'/></th>
				<th class="chkmoney ar"><c:out value='${totPrice2}'/></th>
				<th colspan="2"><button class="colorBtn grybtn act_cancel" style="width:120px">주문취소정보</button></th>
			</tr>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:if test="${!empty result.lectList}">
			<tr>
				<th colspan="2">종합반 상세</th>
				<th><c:out value='${result.goods}'/></th>
				<td colspan="6" class="al">
				<c:forEach var="lectList" items="${result.lectList}" varStatus="status">
				<div><c:out value="${lectList.mvSubject}"/></div>
				</c:forEach>
				</td>
			</tr>
			</c:if>
			</c:forEach>
			<tr>
				<th colspan="2">상품명 상세<br/>(교재포함)</th>
				<td colspan="7" class="al"><div><c:out value='${fn:replace(resultInfo.orderAllname,",[","</div><div>[")}' escapeXml="false"/></div></td>
			</tr>
		</tbody>
	</table>
  </fieldset>

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

  <fieldset style="padding-top:20px;">
	<p style="font-size:16px;padding-bottom:7px;">주문 상세</p>
	<form id="frm_write" name="frm_write">
	<input type="hidden" name="sno" value="<c:out value='${resultInfo.sno}'/>" />
	<div style="float:left;width:49%">
	<table class="commonTable detailTable">
		<caption>주문 내역 테이블</caption>
		<colgroup>
			<col width="100">
			<col width="250">
			<col width="100">
			<col>
		</colgroup>
		<thead>
			<tr>
				<th scope="col" colspan="4">주문자 정보</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th scope="col">회원구분</th>
				<td colspan="3" class="al"><c:out value='${resultInfo.mGubunNm}'/></td>
			</tr>
			<tr>
				<th scope="col">성명(아이디)</th>
				<td class="al"><c:out value='${resultInfo.mName}'/>(<c:out value='${resultInfo.mId}'/>)</td>
				<th scope="col">이메일</th>
				<td class="al"><c:out value='${resultInfo.oEmail}'/></td>
			</tr>
			<tr>
				<th scope="col">전화번호</th>
				<td class="al"><c:out value='${resultInfo.oTel}'/></td>
				<th scope="col">휴대폰</th>
				<td class="al"><c:out value='${resultInfo.oHand}'/></td>
			</tr>
			<tr style="display:none;">
				<th scope="col">우편번호</th>
				<td colspan="3" class="al"><c:out value='${resultInfo.oZip}'/></td>
			</tr>
			<tr style="display:none;">
				<th scope="col">주소(지역)</th>
				<td colspan="3" class="al"><c:out value='${resultInfo.oAdd}'/></td>
			</tr>
			<tr style="display:none;">
				<th scope="col">주소(상세)</th>
				<td colspan="3" class="al"><c:out value='${resultInfo.oAdd2}'/></td>
			</tr>
			<tr>
				<th scope="col">주문일</th>
				<td colspan="3" class="al"><c:out value='${resultInfo.oDate}'/></td>
			</tr>
			<tr>
				<th scope="col">결제</th>
				<td colspan="3" class="al">
					<div><label>결제방법</label><input type="text" name="method2" value="<c:out value='${resultInfo.method}'/>" style="width:120px" />
					<label>결제메모</label><input type="text" name="fname" value="<c:out value='${resultInfo.fname}'/>" style="width:120px" /></div>
				<c:if test="${resultInfo.method eq '무통장입금' || resultInfo.method eq '가상계좌'}">
					<div><label style="color:#fa485b">현금영수증</label>
					<input type="text" name="cardnum" value="<c:out value='${resultInfo.cardnum}'/>" style="width:180px" />
					<input type="text" name="sian" value="<c:out value='${resultInfo.sian}'/>" style="width:90px" />
					</div>
					<c:if test="${resultInfo.method eq '무통장입금'}">
						<div><label style="color:#4a89f2">은행명</label><input type="hidden" name="vBank" value="<c:out value='${resultInfo.vBank}'/>" /><input type="text" name="bank" value="<c:out value='${resultInfo.bank}'/>" style="width:230px" /></div>
					</c:if>
					<c:if test="${resultInfo.method eq '가상계좌'}">
						<div><label style="color:#4a89f2">은행명</label><input type="hidden" name="bank" value="<c:out value='${resultInfo.bank}'/>" /><input type="text" name="vBank" value="<c:out value='${resultInfo.vBank}'/>" style="width:230px" /></div>
					</c:if>
					<div><label>입금자</label><input type="text" name="bName" value="<c:out value='${resultInfo.bName}'/>" style="width:80px" />
					<label>입금일</label><input type="text" name="payday" value="<c:out value='${resultInfo.payday}'/>" style="width:100px" class="calendar" /> 자동처리</div>
				</c:if>
				<c:if test="${resultInfo.method ne '무통장입금' && resultInfo.method ne '가상계좌'}">
					<input type="hidden" name="bank" value="<c:out value='${resultInfo.bank}'/>" />
					<input type="hidden" name="vBank" value="<c:out value='${resultInfo.vBank}'/>" />
					<input type="hidden" name="bName" value="<c:out value='${resultInfo.bName}'/>" />
					<input type="hidden" name="payday" value="<c:out value='${resultInfo.payday}'/>" />
				</c:if>
				</td>
			</tr>
		</tbody>
	</table>
	</div>
	<div style="float:right;width:50%">
	<table class="commonTable detailTable">
		<caption>주문 내역 테이블</caption>
		<colgroup>
			<col width="100">
			<col>
			<col width="100">
			<col>
		</colgroup>
		<thead>
			<tr>
				<th scope="col" colspan="4">메모 사항</th>
			</tr>
		</thead>
		<tbody>
			<tr style="display:none;">
				<th scope="col">성명</th>
				<td class="al"><input type="text" name="rName" value="<c:out value='${resultInfo.rName}'/>" maxlength="50" style="width:95%" /></td>
				<th scope="col">이메일</th>
				<td class="al"><input type="text" name="rEmail" value="<c:out value='${resultInfo.rEmail}'/>" maxlength="50" style="width:95%" /></td>
			</tr>
			<tr style="display:none;">
				<th scope="col">전화번호</th>
				<td class="al"><input type="text" name="rTel" value="<c:out value='${resultInfo.rTel}'/>" maxlength="30" style="width:95%" /></td>
				<th scope="col">휴대폰</th>
				<td class="al"><input type="text" name="rHand" value="<c:out value='${resultInfo.rHand}'/>" maxlength="30" style="width:95%" /></td>
			</tr>
			<tr style="display:none;">
				<th scope="col">우편번호</th>
				<td colspan="3" class="al"><input type="text" name="rZip" value="<c:out value='${resultInfo.rZip}'/>" maxlength="7" style="width:80px" /></td>
			</tr>
			<tr style="display:none;">
				<th scope="col">주소(지역)</th>
				<td colspan="3" class="al"><input type="text" name="rAdd" value="<c:out value='${resultInfo.rAdd}'/>" maxlength="100" style="width:95%" /></td>
			</tr>
			<tr style="display:none;">
				<th scope="col">주소(상세)</th>
				<td colspan="3" class="al"><input type="text" name="rAdd2" value="<c:out value='${resultInfo.rAdd2}'/>" maxlength="100" style="width:95%" /></td>
			</tr>
			<tr>
				<th scope="col">남기실<br/>메세지</th>
				<td colspan="3" class="al"><textarea name="memo" style="width:92%;height:50px"><c:out value='${resultInfo.memo}'/></textarea></td>
			</tr>
			<tr>
				<th scope="col">관리자<br/>메모</th>
				<td colspan="3" class="al"><textarea name="memo2" style="width:92%;height:100px"><c:out value='${resultInfo.memo2}'/></textarea></td>
			</tr>
			<tr style="display:none;">
				<th scope="col">운송장번호</th>
				<td colspan="3" class="al"><input type="text" name="send" value="<c:out value='${resultInfo.send}'/>" maxlength="30" style="width:400px" /></td>
			</tr>
		</tbody>
	</table>
	</div>
	<!--btnsWrap-->
	<div style="float:right;width:100%">
	<div class="btnsWrap">
		<button type="button" class="orderBasicUpdate" style="width:150px">주문 정보 저장</button>
	</div>
	</div>
	<!--//btnsWrap-->
	</form>
  </fieldset>
  <c:if test="${fn:length(logList)>0}">
  <fieldset>
	<p>처리 기록</p>
	<form id="frm_cancel" name="frm_cancel">
	<table class="commonTable">
		<caption>주문 내역 테이블</caption>
		<colgroup>
			<col width="25%">
			<col width="25%">
			<col width="25%">
			<col>
		</colgroup>
		<thead>
			<tr>
				<th scope="col">처리상태</th>
				<th scope="col">처리자(관리자명)</th>
				<th scope="col">아이피</th>
				<th scope="col">처리일시</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="logResult" items="${logList}" varStatus="status">
			<tr>
				<td><c:out value="${logResult.stat}"/></td>
				<td><c:out value="${logResult.userid}"/>(<c:out value="${logResult.userNm}"/>)</td>
				<td><c:out value="${logResult.ipaddress}"/></td>
				<td><c:out value="${fn:substring(logResult.wdate,0,19)}"/></td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	</form>
  </fieldset>
  </c:if>
				<!-- //writeType03 -->

			</div>
		</section>

	</section>

	<%@include file="../include/footer.jsp"%>