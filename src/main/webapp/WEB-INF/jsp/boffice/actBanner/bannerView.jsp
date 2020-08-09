<%@page contentType="text/html;charset=utf-8"%>
<%@include file="../include/header.jsp"%>
<script type="text/javascript">

function fnActBannerModify(op){
    var aFrm = document.actEmpModifyForm;
    aFrm.frmMode.value = op;
    var useynV = $("input:radio[name='useYn']:checked").val();
    var useynB = false;
    if(useynV == "Y" || useynV == "N") useynB = true;
	if(!aFrm.tPart.value){
		alert("분류를 선택하여 주세요.");
		return;
	}
	if(!aFrm.tName.value){
		alert("제목을 입력하여 주세요.");
		return;
	}
	if($("input:checkbox[name='tOpdt']").prop("checked") && (!aFrm.tSdt.value || !aFrm.tEdt.value)){
		alert("게시기간을 입력하여 주세요.");
		return;
	}
	if(op=="new" && !confirm("신규로 등록하시겠습니까?")){
		return;
	}
	if(op=="del" && !confirm("삭제하시겠습니까?")){
		return;
	}
    var target_name = 'iframe_upload';
    var iframe = $('<iframe src="javascript:false;" name="'+target_name+'" style="display:none;"></iframe>');

    //var formData = $("#actEmpModifyForm").serialize();
	aFrm.action = "<c:url value='/boffice/actBanner/modifyActBanner.do' />";
	if(op=="new"){
		aFrm.action = "<c:url value='/boffice/actBanner/insertActBanner.do' />";
	}
    $('body').append(iframe);
    iframe.load(function(){
        var doc = this.contentWindow ? this.contentWindow.document : (this.contentDocument ? this.contentDocument : this.document);
        var root = doc.documentElement ? doc.documentElement : doc.body;
        var result = root.textContent ? root.textContent : root.innerText;
        iframe.remove();
        if(result=="success"){
        	alert("저장되었습니다.");
        	fnActBannerList();
        }else if(result=="noneEx"){
        	alert("이미지 파일(jpg,gif,png)만 가능합니다.");
        }else{
        	alert("첨부파일이 없습니다. 다시 저장하여 주세요.");
        }
    });
    aFrm.target = target_name;
    aFrm.submit();
	//var param = formData;
	//commonUtil.AjaxSynCall(url,param,'text','저장되었습니다.');
	//location.href="<c:url value='/boffice/actBanner/actBannerList.do' />";
}
function fnActBannerList(){
	document.frm.action = "<c:url value='/boffice/actBanner/actBannerList.do'/>";
	document.frm.submit();
}
function fnIFileDelCk(obj){
	if($(obj).prop("checked")){
		$(obj).parent().parent().parent().parent().parent().find("input[name='fileDel1']").val("Y");
		$(obj).parent().parent().parent().parent().parent().find("input[name='fileDel2']").val("Y");
		$(obj).parent().parent().parent().parent().parent().find("input[name='fileDel3']").val("Y");
	}else{
		$(obj).parent().parent().parent().parent().parent().find("input[name='fileDel']1").val("");
		$(obj).parent().parent().parent().parent().parent().find("input[name='fileDel']2").val("");
		$(obj).parent().parent().parent().parent().parent().find("input[name='fileDel']3").val("");
	}
}

</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>메인 관리</h3>
				<div class="btnWrap">
					<c:if test="${empty resultInfo.idx}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActBannerModify('new');">등록</button>
					</c:if>
					<c:if test="${!empty resultInfo.idx}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActBannerModify('edit');">수정</button>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActBannerModify('del');">삭제</button>
					</c:if>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActBannerList();">목록</button>
				</div>
			</div>
			<div class="realCont">

			<form name="frm" method="post">
				<input type="hidden" name="pageIndex" value="<c:out value="${searchVO.pageIndex}"/>">
				<input type="hidden" name="searchOp1" value="<c:out value="${searchVO.searchOp1}"/>">
				<input type="hidden" name="searchCnd" value="<c:out value="${searchVO.searchCnd}"/>">
				<input type="hidden" name="searchKeyword" value="<c:out value="${searchVO.searchKeyword}"/>">
				<input type="hidden" name="searchActstt" value="<c:out value="${searchVO.searchActstt}"/>">
			</form>
			<form name="actEmpModifyForm" id="actEmpModifyForm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="frmMode">
				<input type="hidden" name="idx" value="<c:out value="${resultInfo.idx}"/>">

					<table class="rowTable">
						<caption class="blind">배너 상세보기 및 수정</caption>
						<colgroup>
							<col width="153px" />
							<col width="*" />
						</colgroup>
						<tbody>	
							<tr>
								<th scope="row"><label for="tPart">분류</label></th>
								<td>
									<select class="v2" name="tPart" id="tPart" style="width:300px;">
									<c:forEach var="codeResult56" items="${codeResult56}" varStatus="status">
										<option value='<c:out value="${codeResult56.code}"/>' <c:if test="${resultInfo.tPart eq codeResult56.code}"> selected</c:if>><c:out value="${codeResult56.codeNm}"/> <c:out value="${codeResult56.codeEtc1}"/></option>
									</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="tName">제목</label></th>
								<td>
									<input type="text" name="tName" id="tName" style="width:188px;" value="<c:out value="${resultInfo.tName}"/>" maxlength="100" />
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="tUrl">게시기간</label></th>
								<td>
									<input type="checkbox" name="tOpdt" id="tOpdt" value="Y" <c:if test="${resultInfo.tOpdt eq 'Y'}">checked</c:if>/> 게시기간 설정<br/>
									<input type="text" name="tSdt" id="tSdt" value="<c:out value="${resultInfo.tSdt}"/>" class="calendar" style="width:80px;" maxlength="10" pattern="yyyy-mm-dd" readonly /> ~ 
									<input type="text" name="tEdt" id="tEdt" value="<c:out value="${resultInfo.tEdt}"/>" class="calendar" style="width:80px;" maxlength="10" pattern="yyyy-mm-dd" readonly />
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="tUrl">URL</label></th>
								<td>
									<input type="text" name="tUrl" id="tUrl" style="width:70%;" value="<c:out value="${resultInfo.tUrl}"/>" maxlength="500" />
									<input type="radio" name="tTarget" id="tTarget" value="S" <c:if test="${resultInfo.tTarget eq 'S' || empty resultInfo.tTarget}">checked</c:if> />현재창
									<input type="radio" name="tTarget" id="tTarget" value="B" <c:if test="${resultInfo.tTarget eq 'B'}">checked</c:if> />새창
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="useYn">노출여부</label></th>
								<td>
									<input type="radio" name="useYn" id="useYn" value="Y" <c:if test="${resultInfo.useYn eq 'Y' || empty resultInfo.useYn}">checked</c:if> />노출
									<input type="radio" name="useYn" id="useYn" value="N" <c:if test="${resultInfo.useYn eq 'N'}">checked</c:if> />미노출
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="fileId">이미지</label></th>
								<td>
									<input type="hidden" name="fileDel1" />
									<input type="hidden" name="fileId1" value="${resultInfo.fileId1}" />
									<input type="file" name="file_1" id="egovComFileUploader"/><span class="f_color3 ml_20" id="sizeTxt1"></span>
									<c:import url="/cmm/fms/selectFileInfsForUpdate2.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${resultInfo.fileId1}" />
										<c:param name="param_delcheck" value="delck" />
									</c:import>
								</td>
							</tr>
							<tr style="display:none;">
								<th scope="row"><label for="fileId">이미지(모바일)</label></th>
								<td>
									<input type="hidden" name="fileDel2" />
									<input type="hidden" name="fileId2" value="${resultInfo.fileId2}" />
									<input type="file" name="file_2" id="egovComFileUploader"/><span class="f_color3 ml_20" id="sizeTxt2"></span>
									<c:import url="/cmm/fms/selectFileInfsForUpdate2.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${resultInfo.fileId2}" />
										<c:param name="param_delcheck" value="delck" />
									</c:import>
								</td>
							</tr>
							<tr style="display:none;">
								<th scope="row"><label for="fileId">이미지(타블렛)</label></th>
								<td>
									<input type="hidden" name="fileDel3" />
									<input type="hidden" name="fileId3" value="${resultInfo.fileId3}" />
									<input type="file" name="file_3" id="egovComFileUploader"/><span class="f_color3 ml_20" id="sizeTxt3"></span>
									<c:import url="/cmm/fms/selectFileInfsForUpdate2.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${resultInfo.fileId3}" />
										<c:param name="param_delcheck" value="delck" />
									</c:import>
								</td>
							</tr>
						</tbody>
					</table>

			</form>
			</div>
		</section>

	</section>


<%@include file="../include/footer.jsp"%>