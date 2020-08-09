<%@page contentType="text/html;charset=utf-8"%>
<%@include file="../include/header.jsp"%>
<script type="text/javascript">

function fnActList(){
	document.frmSearch.action = "/boffice/actOrder/actOrderEstiList.do";
	document.frmSearch.submit();
}

$(document).on('click','.act_save',function(){
	if(!form_val_chk($("#frmForm"))){
		return;
	}
	if($("input[name='mId']").length < 1){
		alert("회원을 추가하여 주세요");
		return;
	}
	if($("input[name='ocPidx']").length < 1){
		alert("상품을 추가하여 주세요");
		return;
	}
	if(!confirm("저장하시겠습니까?")){ return; }
	
	$("input[name='coIdx']").each(function(){
		var idx = $(this).val();
		var lecArr = [];
		$("input[name='ocLecidx"+idx+"']").each(function(){
			lecArr.push($(this).val());
		});
		$(".ocLecidx"+idx).val(lecArr.join("||"));
	});
	
	var url = "/boffice/actOrder/actOrderEstiAdd.do";
	var param = $("#frm_write").serialize();
	if(commonUtil.AjaxSynCall(url,param) == "success"){
		alert("저장되었습니다");
		fnActList();
	}else{
		alert("오류입니다 다시 저장하여 주세요.");
	}
});


$(document).on('change','#clCode',function(){
	var url = "/boffice/activity/actLecType.do";
	var param = {frmTypeCode:"selectOp", searchOp1:$(this).val(), searchOp2:"Y", searchOp3:"N"}
	$("select[name='lectype']").empty().append('<option value="">선택</option>'+commonUtil.AjaxSynCall(url,param,'html'));
});
$(document).on('click','.act_lecture',function(){
	var isExit = false;
	$("input[name=mvIdx]").each(function(index){ if($(this).val()==$("select[name='lectype']").val()) isExit = true; });
	if(isExit){ alert("추가된 항목이 있습니다."); return; }
	if(!$("select[name='lectype']").val()){
		alert("강좌를 선택하여 주세요");
		return;
	}
	if(!$("input[name='lecgubun']:checked").val()){
		alert("분류를 선택하여 주세요");
		return;
	}
	var url = "/boffice/actOrder/actAddEstiLecture.do";
	var param = {mvIdx:$("select[name='lectype']").val(), searchOp1:$("input[name='lecgubun']:checked").val()}
	$("#addLecture").append(commonUtil.AjaxSynCall(url,param,'html'));
});
$(document).on('click','.act_del',function(){
	$(this).closest('tr').remove();
});

$(document).on('change','#leCode',function(){
	var url = "/boffice/actLecture/actCollegeType.do";
	var param = {searchOp1:$(this).val()}
	$("select[name='coltype']").empty().append(commonUtil.AjaxSynCall(url,param,'html'));
});
$(document).on('click','.act_college',function(){
	var isExit = false;
	$("input[name=coIdx]").each(function(index){ if($(this).val()==$("select[name='coltype']").val()) isExit = true; });
	if(isExit){ alert("추가된 항목이 있습니다."); return; }
	if(!$("select[name='coltype']").val()){
		alert("강의를 선택하여 주세요");
		return;
	}
	if(!$("input[name='lecgubun']:checked").val()){
		alert("분류를 선택하여 주세요");
		return;
	}
	var url = "/boffice/actOrder/actAddEstiCollege.do";
	var param = {coIdx:$("select[name='coltype']").val(), searchOp1:$("input[name='lecgubun']:checked").val()}
	$("#addLecture").append(commonUtil.AjaxSynCall(url,param,'html'));
});
$(document).on('change','select[name="ocLecdayCo"]',function(){
	$("#priceTxt"+$(this).data("no")).text($('option:selected',this).data("price"));
	$("#price"+$(this).data("no")).val($('option:selected',this).data("price"));
	$("#lecday"+$(this).data("no")).val($(this).val());
});

$(document).on('change','#bleCode, #bclCode',function(){
	var url = "/boffice/actLecture/actBookType.do";
	var param = {searchOp1:$("#bleCode").val(),searchOp2:$("#bclCode").val(),searchOp3:'Y'}
	$("select[name='booktype']").empty().append(commonUtil.AjaxSynCall(url,param,'html'));
});
$(document).on('click','.act_book',function(){
	var isExit = false;
	$("input[name=bmIdx]").each(function(index){ if($(this).val()==$("select[name='booktype']").val()) isExit = true; });
	if(isExit){ alert("추가된 항목이 있습니다."); return; }
	if(!$("select[name='booktype']").val()){
		alert("강의를 선택하여 주세요");
		return;
	}
	var url = "/boffice/actOrder/actAddEstiBook.do";
	var param = {bmIdx:$("select[name='booktype']").val()}
	$("#addLecture").append(commonUtil.AjaxSynCall(url,param,'html'));
});

$(document).on('click', '.act_usr_add', function() {
	dialog_doc('회원추가', '/boffice/actMemb/actMembListPop.do', 800, 780);
	return false;
});

function fnActAddMemb(selVal,selName){
	var isExit = false;
	selVal = String(selVal);
	$("input[name=mId]").each(function(index){ if($(this).val()==selVal) isExit = true; });
	if(isExit){ alert("추가된 항목입니다."); return; }
	var addStr = '<tr id="trMemb'+selVal.replace('@','')+'" height="35px"><td>';
		addStr = addStr +	'<input type="hidden" name="mId" id="mId" value="'+selVal+'"/>';
		addStr = addStr +	'<input type="hidden" name="mName" id="mName" value="'+selName+'"/>';
		addStr = addStr +	'<span class="checkBox">';
		addStr = addStr +	'<input type="checkbox" class="noMemb" name="noMembChk" id="noMemb'+selVal+'">';
		addStr = addStr +	'<label for="noMemb'+selVal+'"><span></span>선택</label></span></td>';
		addStr = addStr +	'<td>'+selName+'</td>';
		addStr = addStr +	'<td>'+selVal+'</td>';
		addStr = addStr +	'<td><button type="button" class="commonBtn act_cart">장바구니보기</button></td>';
		addStr = addStr +	'<td><button type="button" class="commonBtn" onclick="javascript:fnActMembDel(\''+selVal.replace('@','')+'\');">삭제</button>';
		addStr = addStr +	'</td></tr>';
	$("#membListTbody").append(addStr);
}
function fnActMembDel(obj){
	$("#trMemb"+obj).remove();
}
function fnActMembALLDel(){
	$("input[name=noMembChk]:checked").each(function(index){ $(this).closest("tr").remove(); });
}

$(document).on('click', '.act_cart', function() {
	if ($(this).closest('tr').find('input[name=mId]').val() == '') {
		alert('먼저 회원을 선택해주세요.');
		return false;
	}
	dialog_doc('장바구니 - '+$(this).closest('tr').find('input[name=mName]').val(), '/boffice/actOrder/actOrderCartView.do?mId='+$(this).closest('tr').find('input[name=mId]').val(), 800, 500);
	return false;
});

</script>
	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<form name="frmSearch" id="frmSearch" method="post">
			<input type="hidden" name="pageIndex" value="<c:out value="${orderVO.pageIndex}"/>">
			<input type="hidden" name="searchCnd" value="<c:out value="${orderVO.searchCnd}"/>">
			<input type="hidden" name="searchKeyword" value="<c:out value="${orderVO.searchKeyword}"/>">
			<input type="hidden" name="searchSdt" value="<c:out value="${orderVO.searchSdt}"/>">
			<input type="hidden" name=searchEdt value="<c:out value="${orderVO.searchEdt}"/>">
		</form>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>견적 등록</h3>
				<div class="btnWrap">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_list">목록</button>
				</div>
			</div>
			<div class="realCont">

				<form class="articleWrite" id="frm_write" name="frm_write" method="post">
					<fieldset>
						<table class="rowTable">
  							<colgroup>
  								<col style="width:150px">
 								<col style="width:*">
  							</colgroup>
  							<tbody>
							<tr>
								<th scope="row">회원검색</th>
								<td colspan="3"><button type="button" class="colorBtn rightbluebtn plusIcon act_ins act_usr_add">검색</button></td>
							</tr>
  							</tbody>
  						</table>
					<table class="commonTable detailTable">
						<caption>회원 리스트 테이블</caption>
						<colgroup>
							<col style="width:130px">
							<col style="width:*">
							<col style="width:180px">
							<col style="width:160px">
							<col style="width:120px">
						</colgroup>
						<thead>
							<tr>
								<th>
									<span class="checkBox">
										<input type="checkbox" class="check_all" data-check="noMemb" id="check_all" name="check_all" value="Y">
		  								<label for="check_all"><span></span>선택</label>
									</span>
									<button type="button" class="commonBtn" onclick="javascript:fnActMembALLDel();">삭제</button>
								</th>
								<th>회원명</th>
								<th>회원ID</th>
								<th>장바구니보기</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody id="membListTbody">
						</tbody>
					</table>
  
						<table class="rowTable">
  							<colgroup>
  								<col style="width:150px">
 								<col style="width:*">
  							</colgroup>
  							<tbody>
  								<tr>
									<th scope="row">분류</th>
									<td>
										<p class="radioStyle">
											<input type="radio" name="lecgubun" value="P" id="lecgubun1" checked><label for="lecgubun1"><span></span>PC</label>
											<input type="radio" name="lecgubun" value="M" id="lecgubun2"><label for="lecgubun2"><span></span>Mobile</label>
											<input type="radio" name="lecgubun" value="A" id="lecgubun3"><label for="lecgubun3"><span></span>PC+Mobile</label>
										</p>
									</td>
  								</tr>
  								<tr>
  									<th>단과강의선택</th>
									<td>
										<select name="clCode" id="clCode" class="req" title="과목 카테고리를 선택하여 주세요" style="width:150px;padding-left:10px;">
											<option value="">과목 선택</option>
										<c:forEach var="lecCodeList" items="${clCodeList}" varStatus="status">
											<option value='<c:out value="${lecCodeList.codeId}"/>'><c:out value="${lecCodeList.codeNm}"/></option>
										</c:forEach>
										</select>
										<select name="lectype" id="lectype" class="req" title="강좌를 선택하여 주세요" style="width:500px;padding-left:10px;">
											<option value="">선택</option>
										</select>
										<button type="button" class="commonBtn act_lecture">추가</button>
									</td>
  								</tr>
  								<tr>
  									<th>종합반강의선택</th>
									<td>
										<select name="leCode" id="leCode" class="req" title="직렬 카테고리를 선택하여 주세요" style="width:150px;padding-left:10px;">
											<option value="">직렬 선택</option>
										<c:forEach var="lecCodeList" items="${leCodeList}" varStatus="status">
											<option value='<c:out value="${lecCodeList.codeId}"/>'><c:out value="${lecCodeList.codeNm}"/></option>
										</c:forEach>
										</select>
										<select name="coltype" id="coltype" class="req" title="강의를 선택하여 주세요" style="width:500px;padding-left:10px;">
											<option value="">선택</option>
										</select>
										<button type="button" class="commonBtn act_college">추가</button>
									</td>
  								</tr>
  								<tr>
  									<th>교재선택</th>
									<td>
										<select name="bleCode" id="bleCode" class="req" title="직렬 카테고리를 선택하여 주세요" style="width:150px;padding-left:10px;">
											<option value="">직렬 선택</option>
										<c:forEach var="lecCodeList" items="${leCodeList}" varStatus="status">
											<option value='<c:out value="${lecCodeList.codeId}"/>'><c:out value="${lecCodeList.codeNm}"/></option>
										</c:forEach>
										</select>
										<select name="bclCode" id="bclCode" class="req" title="과목 카테고리를 선택하여 주세요" style="width:150px;padding-left:10px;">
											<option value="">과목 선택</option>
										<c:forEach var="lecCodeList" items="${clCodeList}" varStatus="status">
											<option value='<c:out value="${lecCodeList.codeId}"/>'><c:out value="${lecCodeList.codeNm}"/></option>
										</c:forEach>
										</select>
										<select name="booktype" id="booktype" class="req" title="과목 카테고리를 선택하여 주세요" style="width:350px;padding-left:10px;">
											<option value="">선택</option>
										</select>
										<button type="button" class="commonBtn act_book">추가</button>
									</td>
  								</tr>
  							</tbody>
  						</table>
  
						<table class="commonTable detailTable">
  							<colgroup>
  								<col style="width:120px">
  								<col style="width:80px">
  								<col style="width:180px">
  								<col style="width:130px">
 								<col style="width:*">
  								<col style="width:160px">
  								<col style="width:60px">
  							</colgroup>
							<thead>
  								<tr>
									<th>종류</th>
									<th>분류</th>
									<th>수강일수</th>
									<th>금액</th>
									<th>강의명 or 교재명</th>
									<th>결제금액</th>
									<th>삭제</th>
  								</tr>
  							</thead>
  							<tbody id="addLecture">
  							</tbody>
  						</table>
  
					</fieldset>

					<!--btnsWrap-->
					<div class="btnsWrap" >
						<button type="button" class="act_save">등록</button>
						<button type="button" class="cancle act_list">취소</button>
					</div>
					<!--//btnsWrap-->
  				</form>
			</div>
		</section>

	</section>


	<%@include file="../include/footer.jsp"%>