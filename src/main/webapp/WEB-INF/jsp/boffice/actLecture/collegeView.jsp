<%@page contentType="text/html;charset=utf-8"%>
<%@include file="../include/header.jsp"%>
<%
pageContext.setAttribute("CR", "\r");
pageContext.setAttribute("LF", "\n");
pageContext.setAttribute("CRLF", "\r\n");
pageContext.setAttribute("SP", "&nbsp;");
pageContext.setAttribute("BR", "<br/>");
pageContext.setAttribute("newLineChar", "\n");
%> 
<style type="text/css">

#sortWrap div {
	margin: 2px 0 2px 0;
	padding: 2px;
	background-color: #FFF;
	border: 1px solid #ddd;
	cursor: ns-resize;
}
#sortWrap td, #sortWrapHead td {
	text-align:center;
	font-size:14px;
	border-bottom:none;
	padding:0;
}
</style>
<script type="text/javascript">

function fnReturnFrm(obj,str){
	if(!$("#frmForm input[name='"+obj+"']").val()){
		$("#frmForm input[name='"+obj+"']").focus();
		return;
	}
}
function fnActCollegeModify(op){
	if(!form_val_chk($("#frmForm"))){
		return;
	}

	if($("#frmForm input[name='mvIdx']").length < 1){
		alert("강의를 추가하여 주세요");
		return;
	}
	if($("#frmForm input[name='coSec']:checked").val() == "12"){
		if($("#frmForm input[name='cpDay']").length < 1){
			alert("금액을 추가하여 주세요");
			return;
		}
		if(!$("#frmForm input[name='coCharge']").val()){
			alert("수수료제외금액을 입력하여주세요");
			return;
		}
	}
	if(!confirm("저장 하시겠습니까?")){
		return;
	}
	if(!$("#frmForm input[name='coCharge']").val()) $("#frmForm input[name='coCharge']").val("0");
	if(!$("#frmForm input[name='coExten1']").val()) $("#frmForm input[name='coExten1']").val("0");
	if(!$("#frmForm input[name='coExten2']").val()) $("#frmForm input[name='coExten2']").val("0");
	if(!$("#frmForm input[name='coExten3']").val()) $("#frmForm input[name='coExten3']").val("0");
	
	$("input[name='coDesc']").val(DEXT5.getBodyValue('coDesc'));
	$("input[name='coDesc']").val(($("input[name='coDesc']").val()).replace(/\'/g,"&#39;"));
	$("input[name='coDecm']").val(DEXT5.getBodyValue('coDecm'));
	$("input[name='coDecm']").val(($("input[name='coDecm']").val()).replace(/\'/g,"&#39;"));

	var url = "<c:url value='/boffice/actLecture/modifyActCollege.do' />";
	if(!document.frmForm.coIdx.value){
		url = "<c:url value='/boffice/actLecture/insertActCollege.do' />";
	}

    var aFrm = document.frmForm;
    var target_name = 'iframe_upload';
    var iframe = $('<iframe src="javascript:false;" name="'+target_name+'" style="display:none;"></iframe>');
	aFrm.action = url;
    $('body').append(iframe);
    iframe.load(function(){
        var doc = this.contentWindow ? this.contentWindow.document : (this.contentDocument ? this.contentDocument : this.document);
        var root = doc.documentElement ? doc.documentElement : doc.body;
        var retStr = root.textContent ? root.textContent : root.innerText;
        iframe.remove();
    	if(retStr == "success"){
    		alert("저장되었습니다.");
    		if(!document.frmForm.coIdx.value){
    			location.href="<c:url value='/boffice/actLecture/actCollegeList.do' />";
    		}else{
    			document.frmForm.action = "/boffice/actLecture/actCollegeView.do";
    			document.frmForm.target = "_parent";
    			document.frmForm.submit();
    		}
    	}else{
    		alert("오류입니다. 다시 시도하여 주세요.");
    		return;
    	}
    });
    aFrm.target = target_name;
    aFrm.submit();
}

function fnActCollegeDel(obj){
	if(!confirm("삭제하시겠습니까?")){
		return;
	}
	var url = "<c:url value='/boffice/actLecture/deleteActCollege.do' />";
	var param = {coIdx : obj}
	commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.');
	location.href="<c:url value='/boffice/actLecture/actCollegeList.do' />";
}

function fnActCollegeList(){
	document.frmForm.action = "<c:url value='/boffice/actLecture/actCollegeList.do'/>";
	document.frmForm.submit();
}

function fnActAddPrice(){
	var selVal = $("input[name=cpDayInput]").val();
	if(!selVal){
		alert("추가하고자 하는 기간을 입력하여 주세요");
		return;
	}
	var isExit = false;
	$("input[name=cpDay]").each(function(index){ if($(this).val()==selVal) isExit = true; });
	if(isExit){ alert("추가된 항목입니다."); return; }
	var addStr = '<tr id="trPrice'+selVal+'"><th>';
		addStr = addStr +	'<span class="checkBox">';
		addStr = addStr +	'<input type="checkbox" class="noPrice" name="noPriceChk" id="noPrice'+selVal+'">';
		addStr = addStr +	'<label for="noPrice'+selVal+'"><span></span></label></span></th>';
		addStr = addStr +	'<td align="center"><input type="text" name="cpDay" id="cpDay" class="chknum reg" title="기간은 필수입니다" value="'+selVal+'" readonly />일</td>';
		addStr = addStr +	'<td align="center"><input type="text" name="cpPrice1" class="chkmoney req" title="금액을 입력하여 주세요" />원</td>';
		addStr = addStr +	'<td align="center"><input type="text" name="cpPrice2" class="chkmoney req" title="금액을 입력하여 주세요" />원</td>';
		addStr = addStr +	'<td align="center"><input type="text" name="cpPrice3" class="chkmoney req" title="금액을 입력하여 주세요" />원</td>';
		addStr = addStr +	'<td><button type="button" class="commonBtn" onclick="javascript:fnActPriceDel(\''+selVal+'\');">삭제</button>';
		addStr = addStr +	'</td></tr>';
		$("input[name=cpDayInput]").val("");
	$("#priceListTbody").append(addStr);
}
function fnActPriceDel(obj){
	$("#trPrice"+obj).remove();
}
function fnActPriceALLDel(){
	$("input[name=noPriceChk]:checked").each(function(index){ $(this).parent().parent().parent().remove(); });
}

function fnActAddLect(selVal,selSubject,selClCode,selClCodeNm){
	var isExit = false;
	var maxSeq = 0;
	$(".mvIdxClass").each(function(index){
		if($(this).val()==selVal) isExit = true;
		maxSeq = $(this).closest("tr").find("input[name='ccSeq']").val();
	});
	maxSeq = maxSeq*1+1;
	if(isExit){ alert("추가된 항목입니다."); return; }
	var addStr = '<tr id="trLect'+selVal+'" height="35px"><td>';
		addStr = addStr +	'<input type="hidden" name="mvIdx" id="mvIdx" value="'+selVal+'" class="mvIdxClass"/>';
		addStr = addStr +	'<input type="hidden" name="clCode" value="'+selClCode+'" class="clCode'+selClCode+'"/>';
		addStr = addStr +	'<input type="hidden" name="ccOpt" value=""/>';
		addStr = addStr +	'<span class="checkBox">';
		addStr = addStr +	'<input type="checkbox" class="noLect" name="noLectChk" id="noLect'+selVal+'">';
		addStr = addStr +	'<label for="noLect'+selVal+'"><span></span>선택</label></span></td>';
		addStr = addStr +	'<td><input type="text" name="ccSeq" value="'+maxSeq+'" class="chknum req" title="순서를 입력하여 주세요" style="width:60px"/></td>';
		addStr = addStr +	'<td>'+selSubject+'</td>';
		addStr = addStr +	'<td>'+selClCodeNm+'</td>';
		//addStr = addStr +	'<td><input type="checkbox" name="ccOptCk" value="Y" class="ccOpt'+selClCode+'"/></td>';
		addStr = addStr +	'<td><button type="button" class="commonBtn" onclick="javascript:fnActLectDel(\''+selVal+'\');">삭제</button>';
		addStr = addStr +	'</td></tr>';
	$("#lectListTbody").append(addStr);
	fnActOptCntr(selClCode,selClCodeNm);
	/*$("input[name=ccOptCk]").each(function(index){
		$(this).css("display","none");
	});*/
}
function fnActOptCntr(cd,nm){
	$("input[name=clCode]").each(function(index){
		var optCnm = $(this).prop("class");
		if($(("."+optCnm)).length > 1){
			//$(this).css("display","inline");
			if($(("#tr"+optCnm)).length < 1){
				fnActAddOpt(optCnm,cd,nm);
			}
		}else{
			$(("#tr"+optCnm)).remove();
		}
	});
	if($(".trClCode").length > 0){
		$("#optListHead").show();
	}else{
		$("#optListHead").hide();
	}
}
function fnActAddOpt(cnm,cd,nm){
	if(nm!=undefined && nm){
		var addStr = '<tr id="tr'+cnm+'" class="trClCode">';
		addStr = addStr +'<th scope="row"><input type="hidden" name="ctCode" value="'+cd+'"/><input type="hidden" name="ctOpt" value="N"/><span>'+nm+'</span></th>';
		addStr = addStr +'<td>';
		addStr = addStr +'	<p class="radioStyle">';
		addStr = addStr +'		<input type="radio" name="ctOpt'+cd+'" value="N" id="ctOpt'+cd+'1" onClick="javascript:fnCtOptSet(this);" checked>';
		addStr = addStr +'		<label for="ctOpt'+cd+'1"><span></span>사용안함</label>';
		addStr = addStr +'		<input type="radio" name="ctOpt'+cd+'" value="Y" id="ctOpt'+cd+'2" onClick="javascript:fnCtOptSet(this);">';
		addStr = addStr +'		<label for="ctOpt'+cd+'2"><span></span>사용</label>';
		addStr = addStr +'	</p>';
		addStr = addStr +'</td>';
		addStr = addStr +'</tr>';
		$("#optListTbody").append(addStr);
	}
}
function fnActLectDel(obj){
	$("#trLect"+obj).remove();
	$("#divLect"+obj).remove();
	fnActOptCntr();
}
function fnActLectALLDel(){
	$("input[name=noLectChk]:checked").each(function(index){ $(this).closest("div[id^=divLect]").remove(); });
	$("input[name=noLectChk]:checked").each(function(index){ $(this).closest("tr").remove(); });
	fnActOptCntr();
}

$(document).on('click', '.act_lect_add', function() {
	dialog_doc('강의추가', '/boffice/actLecture/actMovingListPop.do', 800, 780);
	return false;
});

$(document).on('click','#frmForm input[name="coSec"]',function(){
	jongToggle();
});
function jongToggle(){
	if($('#frmForm input[name="coSec"]:checked').val() == "11"){
		$(".jonghabBan").hide();
	}else{
		$(".jonghabBan").show();
	}
}
function fnCtOptSet(obj){
	$(obj).closest("tr").find("input[name='ctOpt']").val($(obj).val());
}
$(function(){
	fnActOptCntr();
	jongToggle();
	/*$("input[name=ccOptCk]").each(function(index){
		$(this).css("display","none");
	});
	$("input[name=ccOptCk]").each(function(index){
		var optCnm = $(this).prop("class");
		if($(("."+optCnm)).length > 1){
			$(this).css("display","inline");
		}
	});*/
});

//순서변경 기능--------------------------------------------------------------------------
function fnTranSeqAuto(){
	$("input[name=ccSeq]").each(function(idx,elem){
		$(this).val(idx+1);
	});
}

$(function() {
	$("#sortWrap").sortable({
		axis: "y",
		containment: "parent",
		update: function (event, ui) {
			var order = $(this).sortable('toArray', {
				attribute: 'data-order'
			});
			console.log(order);
		}
	});
});
</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>클래스강의 등록</h3>
				<div class="btnWrap">
					<c:if test="${empty resultInfo.coIdx}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActCollegeModify('new');">등록</button>
					</c:if>
					<c:if test="${!empty resultInfo.coIdx}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActCollegeModify('edit');">수정</button>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActCollegeDel('<c:out value='${resultInfo.coIdx}'/>');">삭제</button>
					</c:if>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActCollegeList();">목록</button>
				</div>
			</div>
			<div class="realCont">

				<form name="frmForm" id="frmForm" method="post" class="articleWrite">
					<input type="hidden" name="pageIndex" value="<c:out value="${searchVO.pageIndex}"/>">
					<input type="hidden" name="pageUnit" value="<c:out value="${searchVO.pageUnit}"/>">
					<input type="hidden" name="searchCnd" value="<c:out value="${searchVO.searchCnd}"/>">
					<input type="hidden" name="searchKeyword" value="<c:out value="${searchVO.searchKeyword}"/>">
					<input type="hidden" name="searchActstt" value="<c:out value="${searchVO.searchActstt}"/>">
					<input type="hidden" name="searchOp1" value="<c:out value="${searchVO.searchOp1}"/>">
					<input type="hidden" name="searchOp2" value="<c:out value="${searchVO.searchOp2}"/>">
					<input type="hidden" name="searchOp3" value="<c:out value="${searchVO.searchOp3}"/>">
					<input type="hidden" name="searchOp4" value="<c:out value="${searchVO.searchOp4}"/>">
					<input type="hidden" name="searchSdt" value="<c:out value="${searchVO.searchSdt}"/>">
					<input type="hidden" name="searchEdt" value="<c:out value="${searchVO.searchEdt}"/>">
				
					<input type="hidden" name="coIdx" id="coIdx" value='<c:out value="${resultInfo.coIdx}"/>' />
					<input type="hidden" name="coDesc" />
					<input type="hidden" name="coDecm" />

				<fieldset>
					<p>기본 정보</p>
					<table class="rowTable">
						<caption class="blind">기본 정보</caption>
						<colgroup>
							<col style="width:130px">
							<col style="width:*">
							<col style="width:130px">
							<col style="width:*">
						</colgroup>
						<tbody>	
							<tr>
								<th scope="row">직렬</th>
								<td colspan="3">
									<select name="leCode" id="leCode" class="req" title="직렬을 선택하여 주세요" style="width:250px;padding-left:10px;">
										<option value="">선택</option>
									<c:forEach var="lecCodeList" items="${lecCodeList}" varStatus="status">
										<option value='<c:out value="${lecCodeList.codeId}"/>' <c:if test="${lecCodeList.codeId eq resultInfo.leCode}">selected</c:if> ><c:out value="${lecCodeList.codeNm}"/></option>
									</c:forEach>
								</td>
							</tr>
							<tr>
								<th scope="row">클래스 명</th>
								<td colspan="3">
									<input type="text" name="coSubject" id="coSubject" title="클래스명을 입력하여 주세요" value="<c:out value="${resultInfo.coSubject}"/>" class="req" maxlength="100" style="width:350px" />
								</td>
							</tr>
							<tr>
								<th scope="row">구분</th>
								<td colspan="3">
									<p class="radioStyle">
										<input type="radio" name="coSec" value="12" id="coSec1" <c:if test="${resultInfo.coSec eq '12' || empty resultInfo.coSec}">checked</c:if>>
										<label for="coSec1"><span></span>종합</label>
									</p>
								   <p class="radioStyle">
										<input type="radio" name="coSec" value="11" id="coSec2" <c:if test="${resultInfo.coSec eq '11'}">checked</c:if>>
										<label for="coSec2"><span></span>단과</label>
									</p>
								</td>
							</tr>
						</tbody>
					</table>
				</fieldset>

				<fieldset>
					<p>강의 추가</p>
					<table class="rowTable">
						<caption class="blind">강의 추가</caption>
						<colgroup>
							<col width="130px" />
							<col width="*" />
						</colgroup>
						<tbody>	
							<tr>
								<th scope="row">강의 검색</th>
								<td>
									<button type="button" class="colorBtn rightbluebtn plusIcon act_ins act_lect_add">검색</button>
								</td>
							</tr>
							<tr id="optListHead" class="jognhabBan">
								<th scope="row">과목</th>
								<th>
									택일 강의 설정 여부
								</th>
							</tr>
						</tbody>	
						<tbody id="optListTbody">	
		 <c:forEach var="collegeOpt" items="${collegeOpt}" varStatus="status">
							<tr id="trclCode<c:out value='${collegeOpt.ctCode}'/>" class="trClCode">
								<th scope="row">
									<input type="hidden" name="ctCode" value="<c:out value='${collegeOpt.ctCode}'/>"/>
									<input type="hidden" name="ctOpt" value="<c:out value='${collegeOpt.ctOpt}'/>"/>
									<span><c:out value='${collegeOpt.ctCodeNm}'/></span>
								</th>
								<td>
									<p class="radioStyle">
										<input type="radio" name="ctOpt<c:out value='${collegeOpt.ctCode}'/>" value="N" onClick="javascript:fnCtOptSet(this);" id="ctOpt<c:out value='${collegeOpt.ctCode}'/>1" <c:if test="${collegeOpt.ctOpt eq 'N' || empty collegeOpt.ctOpt}">checked</c:if>>
										<label for="ctOpt<c:out value='${collegeOpt.ctCode}'/>1"><span></span>사용안함</label>
										<input type="radio" name="ctOpt<c:out value='${collegeOpt.ctCode}'/>" value="Y" onClick="javascript:fnCtOptSet(this);" id="ctOpt<c:out value='${collegeOpt.ctCode}'/>2" <c:if test="${collegeOpt.ctOpt eq 'Y'}">checked</c:if>>
										<label for="ctOpt<c:out value='${collegeOpt.ctCode}'/>2"><span></span>사용</label>
									</p>
									<button type="button" class="commonBtn" onclick="javascript:$(this).closest('tr').remove();">삭제</button>
								</td>
							</tr>
		</c:forEach>
						</tbody>
					</table>
					<table class="commonTable detailTable">
						<caption>강의등록 리스트 테이블</caption>
						<thead>
							<tr>
								<th width="104px">
									<span class="checkBox">
										<input type="checkbox" class="check_all2" data-check="noLect" id="check_all2" name="check_all2" value="Y">
		  								<label for="check_all2"><span></span>선택</label>
									</span>
									<button type="button" class="commonBtn" onclick="javascript:fnActLectALLDel();">삭제</button>
								</th>
								<th width="120px"><button type="button" class="commonBtn" onclick="javascript:fnTranSeqAuto();">순서입력</button></th>
								<th width="*">강의명</th>
								<th width="120px">과목</th>
								<th width="120px">삭제</th>
							</tr>
						</thead>
						<tbody id="lectListTbody">
						</tbody>
					</table>
				<div id="sortWrap">
		 <c:forEach var="collegeLect" items="${collegeLect}" varStatus="status">
					<div data-order=<c:out value="${status.index+1}"/> id="divLect<c:out value="${collegeLect.mvIdx}"/>">
						<table class="commonTable" style="border:0;">
							<tr id="trLect<c:out value="${collegeLect.mvIdx}"/>" height="35px">
								<td width="100px">
									<input type="hidden" name="mvIdx" id="mvIdx" value="<c:out value="${collegeLect.mvIdx}"/>" class="mvIdxClass"/>
									<input type="hidden" name="clCode" value="<c:out value="${collegeLect.clCode}"/>" class="clCode<c:out value="${collegeLect.clCode}"/>"/>
									<input type="hidden" name="ccOpt" value="<c:out value="${collegeLect.ccOpt}"/>"/>
									<span class="checkBox">
										<input type="checkbox" class="noLect" name="noLectChk" id="noLect<c:out value='${collegeLect.mvIdx}'/>">
										<label for="noLect<c:out value='${collegeLect.mvIdx}'/>"><span></span>선택</label>
									</span>
								</td>
								<td width="120px"><input type="text" name="ccSeq" value="<c:out value="${collegeLect.ccSeq}"/>" class="chknum req" title="순서를 입력하여 주세요" style="width:60px" /></td>
								<td width="*"><c:out value="${collegeLect.mvSubject}"/></td>
								<td width="120px"><c:out value="${collegeLect.clName}"/></td>
								<!-- td><input type="checkbox" name="ccOptCk" class="ccOpt<c:out value="${collegeLect.clCode}"/>"/></td -->
								<td width="120px">
							    	<button type="button" class="commonBtn" onclick="javascript:fnActLectDel('<c:out value="${collegeLect.mvIdx}"/>');">삭제</button>
								</td>
							</tr>
						</table>
					</div>
		</c:forEach>
				</div>
				</fieldset>

				<fieldset>
					<p>노출 여부<span class="jonghabBan"> / 수수료 제외 금액</span></p>
					<table class="rowTable">
						<caption class="blind">노출 여부<span class="jonghabBan"> / 수수료 제외 금액</span></caption>
						<colgroup>
							<col style="width:130px">
							<col style="width:*">
							<col style="width:130px">
							<col style="width:*">
						</colgroup>
						<tbody>	
							<tr>
								<th scope="row">노출 여부</th>
								<td>
									<p class="radioStyle">
										<input type="radio" name="coSta" value="Y" id="coSta1" <c:if test="${resultInfo.coSta eq 'Y' || empty resultInfo.coSta}">checked</c:if>>
										<label for="coSta1"><span></span>보임</label>
										<input type="radio" name="coSta" value="N" id="coSta2" <c:if test="${resultInfo.coSta eq 'N'}">checked</c:if>>
										<label for="coSta2"><span></span>숨김</label>
									</p>
								</td>
								<th scope="row">모바일 노출 여부</th>
								<td>
									<p class="radioStyle">
										<input type="radio" name="coMobile" value="Y" id="coMobile1" <c:if test="${resultInfo.coMobile eq 'Y' || empty resultInfo.coMobile}">checked</c:if>>
										<label for="coMobile1"><span></span>보임</label>
										<input type="radio" name="coMobile" value="N" id="coMobile2" <c:if test="${resultInfo.coMobile eq 'N'}">checked</c:if>>
										<label for="coMobile2"><span></span>숨김</label>
									</p>
								</td>
							</tr>
							<tr class="jonghabBan">
								<th scope="row">수수료 제외 금액</th>
								<td colspan="3">
									<input type="text" name="coCharge" class="chkmoney" value="<c:out value='${resultInfo.coCharge}'/>">원
								</td>
							</tr>
						</tbody>
					</table>
				</fieldset>

				<fieldset class="jonghabBan">
					<p>수강료 설정</p>
					<table class="rowTable">
						<caption class="blind">수강료 설정</caption>
						<colgroup>
							<col width="130px" />
							<col width="*" />
						</colgroup>
						<tbody>	
							<tr>
								<th scope="row">수강기간 추가</th>
								<td>
									<input type="text" name="cpDayInput" class="chknum" />
									<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActAddPrice();">추가</button>
								</td>
							</tr>
						</tbody>
					</table>
					<table class="rowTable">
						<caption>수강료 설정 테이블</caption>
						<colgroup>
							<col style="width:130px">
							<col style="width:*">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:60px">
						</colgroup>
						<tbody id="priceListTbody">
							<tr>
								<th>
									<span class="checkBox">
										<input type="checkbox" class="check_all" data-check="noPrice" id="check_all" name="check_all" value="Y">
		  								<label for="check_all"><span></span>선택</label>
									</span>
									<button type="button" class="commonBtn" onclick="javascript:fnActPriceALLDel();">삭제</button>
								</th>
								<th>기간</th>
								<th>PC수강료</th>
								<th>모바일 수강료</th>
								<th>PC+모바일 수강료</th>
								<th>삭제</th>
							</tr>
		 <c:forEach var="collegePrice" items="${collegePrice}" varStatus="status">
							<tr id="trPrice<c:out value="${collegePrice.cpDay}"/>">
								<th>
									<span class="checkBox">
										<input type="checkbox" class="noPrice" name="noPriceChk" id="noPrice<c:out value='${collegePrice.cpDay}'/>">
										<label for="noPrice<c:out value='${collegePrice.cpDay}'/>"><span></span></label>
									</span>
								</th>
								<td align="center"><input type="text" name="cpDay" id="cpDay" class="chknum req" title="기간은 필수입니다." value="<c:out value="${collegePrice.cpDay}"/>" readonly />일</td>
								<td align="center"><input type="text" name="cpPrice1" class="chkmoney req" title="금액을 입력하여 주세요" value="<c:out value="${collegePrice.cpPrice1}"/>"/>원</td>
								<td align="center"><input type="text" name="cpPrice2" class="chkmoney req" title="금액을 입력하여 주세요" value="<c:out value="${collegePrice.cpPrice2}"/>"/>원</td>
								<td align="center"><input type="text" name="cpPrice3" class="chkmoney req" title="금액을 입력하여 주세요" value="<c:out value="${collegePrice.cpPrice3}"/>"/>원</td>
								<td>
							    	<button type="button" class="commonBtn" onclick="javascript:fnActPriceDel('<c:out value="${collegePrice.cpDay}"/>');">삭제</button>
								</td>
							</tr>
		</c:forEach>
						</tbody>
					</table>
				</fieldset>

				<fieldset class="jonghabBan">
					<p>연장설정</p>
					<table class="rowTable">
						<caption class="blind">연장설정</caption>
						<colgroup>
							<col style="width:*">
							<col style="width:27%">
							<col style="width:27%">
							<col style="width:27%">
						</colgroup>
						<tbody>	
							<tr>
								<th>구분(수강종료일 + x일)</th>
								<th>7일 추가 금액</th>
								<th>15일 추가 금액</th>
								<th>30일 추가 금액</th>
							</tr>
							<tr>
								<th>
									<p class="radioStyle">
										<input type="radio" name="coExtyn" value="Y" id="coExtyn1" <c:if test="${resultInfo.coExtyn eq 'Y'}">checked</c:if>>
										<label for="coExtyn1"><span></span>사용</label>
										<input type="radio" name="coExtyn" value="N" id="coExtyn2" <c:if test="${resultInfo.coExtyn eq 'N' || empty resultInfo.coExtyn}">checked</c:if>>
										<label for="coExtyn2"><span></span>미사용</label>
									</p>
								</th>
								<td align="center"><input type="text" name="coExten1" value="<c:out value='${resultInfo.coExten1}'/>" class="chkmoney"/>원</td>
								<td align="center"><input type="text" name="coExten2" value="<c:out value='${resultInfo.coExten2}'/>" class="chkmoney"/>원</td>
								<td align="center"><input type="text" name="coExten3" value="<c:out value='${resultInfo.coExten3}'/>" class="chkmoney"/>원</td>
							</tr>
						</tbody>
					</table>
				</fieldset>

				<fieldset>
					<p>강좌 설명(PC)</p>
					<table class="rowTable">
						<caption class="blind">강좌 설명(PC)</caption>
						<colgroup>
							<col style="width:130px">
							<col style="width:*">
							<col style="width:130px">
							<col style="width:*">
						</colgroup>
						<tbody>	
							<tr>
								<th scope="row">강좌 설명(PC)</th>
								<td colspan="3">
								  <!--editor-->
									<script type="text/javascript">
										DEXT5.config.Width = "100%";
										DEXT5.config.Height = "300px";
										var editor = new Dext5editor("coDesc");
									</script>
								  <!--//editor-->
								</td>
							</tr>
						</tbody>
					</table>
				</fieldset>

				<fieldset>
					<p>강좌 설명(모바일)</p>
					<table class="rowTable">
						<caption class="blind">강좌 설명(모바일)</caption>
						<colgroup>
							<col style="width:130px">
							<col style="width:*">
							<col style="width:130px">
							<col style="width:*">
						</colgroup>
						<tbody>	
							<tr>
								<th scope="row">강좌 설명(모바일)</th>
								<td colspan="3">
								<c:set var="nttCnVal" value="${fn:replace(resultInfo.coDesc,CRLF, '')}"/>
								<c:set var="nttCnVal" value="${fn:replace(nttCnVal,CR, '')}"/>
								<c:set var="nttCnVal" value="${fn:replace(nttCnVal,LF, '')}"/>

								<c:set var="nttCnVal2" value="${fn:replace(resultInfo.coDecm,CRLF, '')}"/>
								<c:set var="nttCnVal2" value="${fn:replace(nttCnVal2,CR, '')}"/>
								<c:set var="nttCnVal2" value="${fn:replace(nttCnVal2,LF, '')}"/>
								  <!--editor-->
									<script type="text/javascript">
										DEXT5.config.Width = "100%";
										DEXT5.config.Height = "300px";
										var editor = new Dext5editor("coDecm");
									    function dext_editor_loaded_event(DEXT5Editor) {
									        DEXT5.setBodyValue('${nttCnVal}', "coDesc");
									        DEXT5.setBodyValue('${nttCnVal2}', "coDecm");
									    }
									</script>
								  <!--//editor-->
								</td>
							</tr>
						</tbody>
					</table>
				</fieldset>

				<!-- //writeType03 -->
				</form>

			</div>
		</section>

	</section>

	<%@include file="../include/footer.jsp"%>