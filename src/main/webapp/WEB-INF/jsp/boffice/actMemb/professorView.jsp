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
.itemUl {border-bottom:1px solid #CCC;padding:5px;float:left;display:inline;}
.itemUl li {padding:3px;min-height:35px;float:left;display:inline;}
.itemUl li div {width:60px;padding:7px;float:left;}
</style>
<script type="text/javascript">

function fnActMembWrite(op){

	if(!confirm("수정하시겠습니까?")){
		return;
	}		

	$("input[name='pIntro']").val(DEXT5.getBodyValue('pIntro'));
	$("input[name='pIntro']").val(($("input[name='pIntro']").val()).replace(/\'/g,"&#39;"));

	$("input[name='file_1']").each(function(index){
		$(this).prop("name","file_"+index);
	});

	var aFrm = document.actEmpModifyForm;
    var target_name = 'iframe_upload';
    var iframe = $('<iframe src="javascript:false;" name="'+target_name+'" style="display:none;"></iframe>');
	aFrm.action = "<c:url value='/boffice/actMemb/modifyActMemb.do'/>";
    $('body').append(iframe);
    iframe.load(function(){
        var doc = this.contentWindow ? this.contentWindow.document : (this.contentDocument ? this.contentDocument : this.document);
        var root = doc.documentElement ? doc.documentElement : doc.body;
        var retStr = root.textContent ? root.textContent : root.innerText;
        iframe.remove();
    	if(retStr == "success"){
    		alert("수정되었습니다.");
			document.actEmpModifyForm.action = "/boffice/actMemb/actProfView.do";
			document.actEmpModifyForm.target = "_parent";
			document.actEmpModifyForm.submit();
    	}else if(retStr == "ERR_PIC"){
    		alert("사진파일 형식이 잘못되었습니다.");
    		return;
    	}else{
    		alert("오류입니다. 다시 시도하여 주세요.");
    		return;
    	}
    });
    aFrm.target = target_name;
    aFrm.submit();

}

function fnActMembDelete(idx){
	if(!confirm("삭제하시겠습니까?")){
		return;
	}
	var url = "<c:url value='/boffice/actMemb/deleteActMemb.do' />";
	var param = {
			mIdx : document.actEmpModifyForm.mIdx.value
	}
	if(commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.') == "success"){
		fnActMembList();
	}
}
function fnActMembList(){
	document.frm.action = "<c:url value='/boffice/actMemb/actProfList.do'/>";
	document.frm.submit();
}

function fnActFileAdd(){
	var str = '	<tr id="inputFileSpan"><th class="ta_l" scope="row"><label for="fileid">배너</label></th><td class="v3" colspan="5"><span>';
	var str = str + '<input type="file" name="file_1" style="width:500px;" />';
	var str = str + '<input type="hidden" name="fileSnum2" /><input type="text" name="fileCn" style="width:500px;" />';
	var str = str + '<a href="javascript:void(0);" class="button_v2" onclick="javascript:fnActFileCancel(this);"><span>취소</span></a></span></td></tr>';
	
	$("#inputFileSpan").after(str);
}
function fnActFileCancel(obj){
	$(obj).parent().parent().parent().remove();
	//$(obj).prev().prev().remove();
	//$(obj).prev().remove();
	$(obj).remove();
	if($("input[name='file_1']").size()<1){
		fnActFileAdd();
	}
}
function fnActFileReset(obj){
	$("input[name='fileThum']").val("");
}
function fnIFileDelCk(obj){
	if($(obj).prop("checked")){
		$("input[name='fileDel']").val("Y");
	}else{
		$("input[name='fileDel']").val("");
	}
}
function fnIThumDelCk(obj){
	if($(obj).prop("checked")){
		$("input[name='thumDel']").val("Y");
	}else{
		$("input[name='thumDel']").val("");
	}
	//alert($("input[name='thumDel']").val());
}
function fnFileDelOp(obj){
	if($(obj).prop("checked")){
		$(obj).parent().find("input[name='fileDel']").val("Y");
	}else{
		$(obj).parent().find("input[name='fileDel']").val("");
	}
}
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>교수 관리</h3>
				<div class="btnWrap">
					<c:if test="${empty resultInfo.mIdx}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActMembWrite('new');">등록</button>
					</c:if>
					<c:if test="${!empty resultInfo.mIdx}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActMembWrite('edit');">수정</button>
					</c:if>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActMembList();">목록</button>
				</div>
			</div>
			<div class="realCont">

			<form name="frm" method="post">
				<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
				<input name="searchOp1" type="hidden" value="<c:out value='${searchVO.searchOp1}'/>"/>
				<input name="searchOp2" type="hidden" value="<c:out value='${searchVO.searchOp2}'/>"/>
				<input name="searchOp3" type="hidden" value="<c:out value='${searchVO.searchOp3}'/>"/>
				<input name="searchOp6" type="hidden" value="<c:out value='${searchVO.searchOp6}'/>"/>
				<input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>">
				<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>">
				<input type="hidden" name="searchSdt" value="<c:out value='${searchVO.searchSdt}'/>">
				<input type="hidden" name="searchEdt" value="<c:out value='${searchVO.searchEdt}'/>">
			</form>
			<form name="actEmpModifyForm" id="actEmpModifyForm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
				<input name="searchOp1" type="hidden" value="<c:out value='${searchVO.searchOp1}'/>"/>
				<input name="searchOp2" type="hidden" value="<c:out value='${searchVO.searchOp2}'/>"/>
				<input name="searchOp3" type="hidden" value="<c:out value='${searchVO.searchOp3}'/>"/>
				<input name="searchOp6" type="hidden" value="<c:out value='${searchVO.searchOp6}'/>"/>
				<input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>">
				<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>">
				<input type="hidden" name="searchSdt" value="<c:out value='${searchVO.searchSdt}'/>">
				<input type="hidden" name="searchEdt" value="<c:out value='${searchVO.searchEdt}'/>">
				<input type="hidden" name="mIdx" id ="mIdx" value="<c:out value="${resultInfo.mIdx}"/>">
				<input type="hidden" name="pIdx" id ="pIdx" value="<c:out value="${resultInfo.pIdx}"/>">
				<input type="hidden" name="pIntro" />
				<input type="hidden" name="actListMode" value="PROF" />
				<div class="writeType03 mt_50">
					<table class="rowTable">
						<caption class="blind">회원정보 수정</caption>
						<colgroup>
								<col style="width:130px;">
								<col style="width:230px;">
								<col style="width:130px;">
								<col style="width:*">
								<col style="width:130px;">
								<col style="width:*">
						</colgroup>
						<tbody>	
							<tr>
								<th scope="row">이름</th>
								<td>
									<input type="text" name="mName" id="mName" style="width:150px;" value="<c:out value="${resultInfo.mName}"/>" maxlength="10" />
								</td>
								<th scope="row">아이디</th>
								<td>
									<c:if test="${empty resultInfo.mId}">					
										<input type="text" name="mId" id="mId" style="width:150px;"  maxlength="10" />
									</c:if>
									<c:if test="${not empty resultInfo.mId}">					
										<input type="hidden" name="mId" id="mId" style="width:150px;"  maxlength="10" value="<c:out value="${resultInfo.mId}"/>" />
										<c:out value="${resultInfo.mId}"/>
									</c:if>
								</td>
								<th scope="row">회원구분</th>
								<td>
									<select name="mGubun" id="mGubun">
										<option value="">선택</option>
										<c:import url="/boffice/activity/actFrmType.do" charEncoding="utf-8">
											<c:param name="frmTypeCode" value="COM044" />
											<c:param name="frmTypeValue" value="${resultInfo.mGubun}" />
										</c:import>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row">휴대폰번호</th>
								<td>
									<input type="text" name="mHp" id="mHp" style="width:150px;" value="<c:out value="${resultInfo.mHp}"/>" maxlength="13" />
								</td>
								<th scope="row">전화번호</th>
								<td>
									<input type="text" name="mTel" id="mTel" style="width:150px;" value="<c:out value="${resultInfo.mTel}"/>" maxlength="13" />
								</td>
								<th scope="row">비밀번호</th>
								<td>
									<input type="password" name="mPass" class="" title="비밀번호를 입력해주세요." maxlength="50" style="width:100px">
								</td>
							</tr>
							<tr>
								<th scope="row">이메일</th>
								<td>
									<input type="text" name="mEmail" id="mEmail" style="width:150px;" value="<c:out value="${resultInfo.mEmail}"/>"maxlength="25" />
								</td>
								<th scope="row">생년월일</th>
								<td>
									<input type="text" name="mBirth" id="mBirth" maxlength="8" class="chknum" value="<c:out value="${resultInfo.mBirth}"/>">
								</td>
								<th scope="row">성별</th>
								<td>
									<input type="radio" name="mSex" id="mSex1" value="M" <c:if test="${resultInfo.mSex eq 'M'}">checked</c:if> />
									<label for="mSex1">남</label>
									<input type="radio" name="mSex" id="mSex2" value="W" class="mls15" <c:if test="${resultInfo.mSex eq 'W'}">checked</c:if> />
									<label for="mSex2">여</label>
								</td>
							</tr>
							<tr>
								<th scope="row">주소</th>
								<td>
									<a href="javascript:void(0);" class="button_v2" onclick="execDaumPostcode('mZip','mAddr1')"><span>우편번호</span></a>
									<input type="text" name="mZip" id="mZip" style="text-align:center;width:80px;" value="<c:out value="${resultInfo.mZip}"/>" maxlength="5" class="chknum"  />
								</td>
								<td colspan="4" style="height:70px;">
									<input type="text" name="mAddr1" id="mAddr1" style="width:500px;margin-bottom:5px;" value="<c:out value="${resultInfo.mAddr1}"/>" maxlength="150" /><br/>
									<input type="text" name="mAddr2" id="mAddr2" style="width:500px;" value="<c:out value="${resultInfo.mAddr2}"/>" maxlength="150"/>
									<span id="guide" style="color:#999"></span>									
								</td>
							</tr>
							<tr>
								<th scope="row">가입경로/일시</th>
								<td>
									<select name="mWay" id="mWay" style="width:80px;">
										<option value="">선택</option>
										<c:import url="/boffice/activity/actFrmType.do" charEncoding="utf-8">
											<c:param name="frmTypeCode" value="COM122" />
											<c:param name="frmTypeValue" value="${resultInfo.mWay}" />
										</c:import>
									</select>
									/ <c:out value="${fn:substring(resultInfo.regdt,0,10)}"/>
								</td>
								<th scope="row">이메일수신여부</th>
								<td>
									<input type="radio" name="emailYn" id="emailY" value="Y" <c:if test="${resultInfo.emailYn eq 'Y'}"> checked</c:if>><label for="emailY">동의</label>
									<input type="radio" name="emailYn" id="emailN" value="N" <c:if test="${resultInfo.emailYn eq 'N'}"> checked</c:if> style="margin-left:5px;"><label for="emailN">동의안함</label>
								</td>
								<th scope="row">SMS수신여부</th>
								<td>
									<input type="radio" name="smsYn" id="smsY" value="Y" <c:if test="${resultInfo.smsYn eq 'Y'}"> checked</c:if>><label for="smsY">동의</label>
									<input type="radio" name="smsYn" id="smsN" value="N" <c:if test="${resultInfo.smsYn eq 'N'}"> checked</c:if> style="margin-left:5px;"><label for="smsN">동의안함</label>
								</td>
							</tr>
							<tr>
								<th scope="row">전공과목</th>
								<td>
									<input type="text" name="pMajor" id="pMajor" style="width:150px;" value="<c:out value="${resultInfo.pMajor}"/>"maxlength="50" />
								</td>
								<th scope="row">수수료율%</th>
								<td>
									<input type="text" size="10" maxlength="10" name="pRate" id="pRate" value="<c:out value="${resultInfo.pRate}"/>" />
								</td>
								<th scope="row">순서/노출여부</th>
								<td>
									<input type="text" size="5" maxlength="3" name="pSeq" id="pSeq" class="textNumOnly" value="<c:out value="${resultInfo.pSeq}"/>" />
									<input type="radio" name="pShow" id="pShowY" value="Y" <c:if test="${resultInfo.pShow eq 'Y'}"> checked</c:if>><label for="pShowY">노출</label>
									<input type="radio" name="pShow" id="pShowN" value="N" <c:if test="${resultInfo.pShow eq 'N'}"> checked</c:if> style="margin-left:5px;"><label for="pShowN">숨김</label>
								</td>
							</tr>
							<tr>
								<th scope="row">특이사항</th>
								<td colspan="5">
									<textarea name="mEtc" style="height:80px;"><c:out value="${resultInfo.mEtc}"/></textarea>
								</td>
							</tr>
								<c:if test="${not empty resultInfo.thumId}">
								<tr>
									<th class="ta_l" scope="row"><label for="thumId">사진</label></th>
									<td class="v3" colspan="5">
									<c:import url="/cmm/fms/selectThumFileInfsForUpdate2.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${resultInfo.thumId}" />
										<c:param name="param_delcheck" value="delck" />
									</c:import>
									<input type="hidden" name="thumDel" />
									<input type="hidden" name="thumId" value="${resultInfo.thumId}" />							
									</td>
								</tr>
								</c:if>
								<c:if test="${empty resultInfo.thumId}">
								<tr>
									<th class="ta_l" scope="row"><label for="thumId">사진</label></th>
									<td class="v3" colspan="5">
									<span>
										<input type="file" name="fileThum" style="width:500px;" />
										<a href="javascript:void(0);" class="button_v2" onclick="javascript:fnActFileReset(this);"><span>취소</span></a>
									</span>
									</td>
								</tr>								
								</c:if>
								<c:if test="${not empty resultInfo.fileid }">
								<tr id="inputFileSpan">
									<th class="ta_l" scope="row"><label for="">배너</label></th>
									<td colspan="5">
										<span>
											<a style="float:right" href="javascript:void(0);" class="button_v2" onclick="javascript:fnActFileAdd();"><span>배너추가</span></a>																				
											<c:import url="/cmm/fms/selectFileInfsForUpdate3.do" charEncoding="utf-8">																				
												<c:param name="param_atchFileId" value="${resultInfo.fileid}" />
												<c:param name="param_delcheck" value="delck" />
											</c:import>
											<input type="hidden" name="fileid" value="${resultInfo.fileid}" />
										</span>
									</td>
								</tr>
								</c:if>
								<c:if test="${empty resultInfo.fileid }">
								<tr id="inputFileSpan">
									<th class="ta_l" scope="row"><label for="fileid">배너</label></th>
									<td class="v3" colspan="5">
										<input type="file" name="file_1" style="width:500px;" />
										<input type="hidden" name="fileSnum2" />
										<input type="text" name="fileCn" style="width:500px;" />
										<a href="javascript:void(0);" class="button_v2" onclick="javascript:fnActFileCancel(this);"><span>취소</span></a>
										<a href="javascript:void(0);" class="button_v2" onclick="javascript:fnActFileAdd();"><span>배너추가</span></a>									
									</td>
								</tr>								
								</c:if>
							<tr>
								<th scope="row">교수소개</th>
								<td colspan="5">
									<input type="hidden" name="pIntroTp" id="pIntroTp" value="<c:out value="${fn:replace(resultInfo.pIntro,newLineChar, '<br/>')}"/>"/>
								  <!--editor-->
									<script type="text/javascript">
										DEXT5.config.Width = "100%";
										DEXT5.config.Height = "300px";
										var editor = new Dext5editor("pIntro");
									    function dext_editor_loaded_event(DEXT5Editor) {
									        DEXT5.setBodyValue($("#pIntroTp").val(), DEXT5Editor.ID);
									    }
									</script>
								  <!--//editor-->
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- //writeType03 -->

			</form>

			</div>
		</section>

	</section>

<%@include file="../include/footer.jsp"%>