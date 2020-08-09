<%@page contentType="text/html;charset=utf-8"%>
<%@include file="../include/header.jsp"%>
<script type="text/javascript">

function fnActFreeLectModify(op){
	if(!form_val_chk($("#frmForm"))){
		return;
	}
	if($("#frmForm input[name='mId']").length < 1){
		alert("회원을 추가하여 주세요");
		return;
	}
	if($("#frmForm input[name='mvIdx']").length < 1){
		alert("강의를 추가하여 주세요");
		return;
	}
	
	if(!confirm("저장 하시겠습니까?")){
		return;
	}

	var url = "<c:url value='/boffice/actFreeLect/modifyActFreeLect.do' />";
	if(!document.frmForm.fmIdx.value){
		url = "<c:url value='/boffice/actFreeLect/insertActFreeLect.do' />";
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
    		if(!document.frmForm.fmIdx.value){
    			location.href="<c:url value='/boffice/actFreeLect/actFreeLectList.do' />";
    		}else{
    			document.frmForm.action = "/boffice/actFreeLect/actFreeLectView.do";
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

function fnActFreeLectDel(obj){
	if(!confirm("삭제하시겠습니까?")){
		return;
	}
	var url = "<c:url value='/boffice/actFreeLect/deleteActFreeLect.do' />";
	var param = {fmIdx : obj}
	commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.');
	location.href="<c:url value='/boffice/actFreeLect/actFreeLectList.do' />";
}

function fnActFreeLectList(){
	document.frmForm.action = "<c:url value='/boffice/actFreeLect/actFreeLectList.do'/>";
	document.frmForm.submit();
}

$(document).on('click', '.act_usr_add', function() {
	dialog_doc('회원추가', '/boffice/actMemb/actMembListPop.do', 800, 780);
	return false;
});

function fnActAddMemb(selVal,selName){
	var isExit = false;
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
		addStr = addStr +	'<td> </td>';
		addStr = addStr +	'<td> </td>';
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




$(document).on('click', '.act_lect_add', function() {
	dialog_doc('강의추가', '/boffice/actLecture/actMovingListPop.do', 800, 780);
	return false;
});

function fnActAddLect(selVal,selSubject,selClCode,selClCodeNm,selProf){
	var isExit = false;
	$("input[name=mvIdx]").each(function(index){ if($(this).val()==selVal) isExit = true; });
	if(isExit){ alert("추가된 항목입니다."); return; }
	var addStr = '<tr id="trLect'+selVal+'" height="35px"><td>';
		addStr = addStr +	'<input type="hidden" name="mvIdx" id="mvIdx" value="'+selVal+'"/>';
		addStr = addStr +	'<input type="hidden" name="mvSubject" id="mvSubject" value="'+selSubject+'"/>';
		addStr = addStr +	'<span class="checkBox">';
		addStr = addStr +	'<input type="checkbox" class="noLect" name="noLectChk" id="noLect'+selVal+'">';
		addStr = addStr +	'<label for="noLect'+selVal+'"><span></span>선택</label></span></td>';
		addStr = addStr +	'<td>'+selSubject+'</td>';
		addStr = addStr +	'<td>'+selProf+'</td>';
		addStr = addStr +	'<td> </td>';
		addStr = addStr +	'<td><button type="button" class="commonBtn" onclick="javascript:fnActLectDel(\''+selVal+'\');">삭제</button>';
		addStr = addStr +	'</td></tr>';
	$("#lectListTbody").append(addStr);
}

function fnActLectDel(obj){
	$("#trLect"+obj).remove();
}
function fnActLectALLDel(){
	$("input[name=noLectChk]:checked").each(function(index){ $(this).closest("tr").remove(); });
}

function fnActMembLectView(mid){
	$("form[name='frmForm'] input[name='regid']").val(mid);
	document.frmForm.action = "/boffice/actFreeLect/actFreeLectStat.do";
	document.frmForm.submit();
}

</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>무료 강의 상세</h3>
				<div class="btnWrap">
					<c:if test="${empty resultInfo.fmIdx}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActFreeLectModify('new');">등록</button>
					</c:if>
					<c:if test="${!empty resultInfo.fmIdx}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActFreeLectModify('edit');">수정</button>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActFreeLectDel('<c:out value='${resultInfo.mvIdx}'/>');">삭제</button>
					</c:if>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActFreeLectList();">목록</button>
				</div>
			</div>
			<div class="realCont">

				<form name="frmForm" id="frmForm" method="post" class="articleWrite">
					<input type="hidden" name="pageIndex" value="<c:out value='${freeVO.pageIndex}'/>">
					<input name="searchOp1" type="hidden" value="<c:out value='${freeVO.searchOp1}'/>"/>
					<input name="searchOp2" type="hidden" value="<c:out value='${freeVO.searchOp2}'/>"/>
					<input name="searchOp3" type="hidden" value="<c:out value='${freeVO.searchOp3}'/>"/>
					<input name="searchOp6" type="hidden" value="<c:out value='${freeVO.searchOp6}'/>"/>
					<input type="hidden" name="searchCnd" value="<c:out value='${freeVO.searchCnd}'/>">
					<input type="hidden" name="searchKeyword" value="<c:out value='${freeVO.searchKeyword}'/>">
					<input type="hidden" name="searchSdt" value="<c:out value='${freeVO.searchSdt}'/>">
					<input type="hidden" name="searchEdt" value="<c:out value='${freeVO.searchEdt}'/>">
				
					<input type="hidden" name="sno_" id="sno_" value='<c:out value='${resultInfo.sno}'/>' />
				
					<input type="hidden" name="regid" id="regid" />
					<input type="hidden" name="fmIdx" id="fmIdx" value='<c:out value="${resultInfo.fmIdx}"/>' />
					<input type="hidden" name="fmSdt" id="fmSdt" value='<c:out value="${resultInfo.fmSdt}"/>' />
					<input type="hidden" name="fmSta" id="fmSta" value='<c:out value="${resultInfo.fmSta}"/>' />

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
								<th scope="row">무료 강의명</th>
								<td colspan="3">
									<input type="text" name="fmSubject" id="fmSubject" title="강좌명을 입력하여 주세요" value="<c:out value="${resultInfo.fmSubject}"/>" class="req" maxlength="200" style="width:350px" />
								</td>
							</tr>
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
							<col style="width:120px">
							<col style="width:120px">
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
								<th>무료등록일</th>
								<th>수강현황</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody id="membListTbody">
		 <c:forEach var="membList" items="${membList}" varStatus="status">
							<tr id="trMemb<c:out value="${fn:replace(membList.mId,'@','')}"/>">
								<td style="height:32px">
									<input type="hidden" name="mId" id="mId" value="<c:out value="${membList.mId}"/>"/>
									<input type="hidden" name="mName" id="mName" value="<c:out value="${membList.mName}"/>"/>
									<span class="checkBox">
										<input type="checkbox" class="noMemb" name="noMembChk" id="noMemb<c:out value="${fn:replace(membList.mId,'@','')}"/>">
										<label for="noMemb<c:out value="${fn:replace(membList.mId,'@','')}"/>"><span></span>선택</label>
									</span>
								</td>
								<td><c:out value="${membList.mName}"/></td>
								<td><c:out value="${membList.mId}"/></td>
								<td><c:out value="${fn:substring(membList.regdt,0,10)}"/></td>
								<td>
							    	<button type="button" class="commonBtn" onclick="javascript:fnActMembLectView('<c:out value="${membList.mId}"/>');">상세보기</button>
								</td>
								<td>
							    	<button type="button" class="commonBtn" onclick="javascript:fnActMembDel('<c:out value="${fn:replace(membList.mId,'@','')}"/>');">삭제</button>
								</td>
							</tr>
		</c:forEach>
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
								<th scope="row">분류</th>
								<td>
									<p class="radioStyle">
										<input type="radio" name="fmEq" value="P" id="fmEq1" <c:if test="${resultInfo.fmEq eq 'P' || empty resultInfo.fmEq}">checked</c:if>>
										<label for="fmEq1"><span></span>PC</label>
										<input type="radio" name="fmEq" value="M" id="fmEq2" <c:if test="${resultInfo.fmEq eq 'M'}">checked</c:if>>
										<label for="fmEq2"><span></span>Mobile</label>
										<input type="radio" name="fmEq" value="A" id="fmEq3" <c:if test="${resultInfo.fmEq eq 'A'}">checked</c:if>>
										<label for="fmEq3"><span></span>PC+Mobile</label>
									</p>
								</td>
							</tr>
							<tr>
								<th scope="row">일수</th>
								<td>
									<input type="text" name="fmGigan" value="<c:out value='${resultInfo.fmGigan}'/>" class="req chknum" maxlength="3">
								</td>
							</tr>
							<tr>
								<th scope="row">강의 검색</th>
								<td>
									<button type="button" class="colorBtn rightbluebtn plusIcon act_ins act_lect_add">검색</button>
								</td>
							</tr>
						</tbody>	
					</table>
					<table class="commonTable detailTable">
						<caption>강의등록 리스트 테이블</caption>
						<colgroup>
							<col style="width:130px">
							<col style="width:*">
							<col style="width:120px">
							<col style="width:120px">
							<col style="width:120px">
						</colgroup>
						<thead>
							<tr>
								<th>
									<span class="checkBox">
										<input type="checkbox" class="check_all2" data-check="noLect" id="check_all2" name="check_all2" value="Y">
		  								<label for="check_all2"><span></span>선택</label>
									</span>
									<button type="button" class="commonBtn" onclick="javascript:fnActLectALLDel();">삭제</button>
								</th>
								<th>강의명</th>
								<th>교수명</th>
								<th>무료등록일</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody id="lectListTbody">
		 <c:forEach var="lectList" items="${lectList}" varStatus="status">
							<tr id="trLect<c:out value="${lectList.mvIdx}"/>" height="35px">
								<td>
									<input type="hidden" name="mvIdx" id="mvIdx" value="<c:out value="${lectList.mvIdx}"/>"/>
									<input type="hidden" name="mvSubject" id="mvSubject" value="<c:out value="${lectList.mvSubject}"/>"/>
									<span class="checkBox">
										<input type="checkbox" class="noLect" name="noLectChk" id="noLect<c:out value='${lectList.mvIdx}'/>">
										<label for="noLect<c:out value='${lectList.mvIdx}'/>"><span></span>선택</label>
									</span>
								</td>
								<td><c:out value="${lectList.mvSubject}"/></td>
								<td><c:out value="${lectList.mvProfNm}"/></td>
								<td><c:out value="${fn:substring(lectList.regdt,0,10)}"/></td>
								<td>
							    	<button type="button" class="commonBtn" onclick="javascript:fnActLectDel('<c:out value="${lectList.mvIdx}"/>');">삭제</button>
								</td>
							</tr>
		</c:forEach>
						</tbody>
					</table>
				</fieldset>

				<!-- //writeType03 -->
				</form>

			</div>
		</section>

	</section>

	<%@include file="../include/footer.jsp"%>