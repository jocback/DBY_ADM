<%@page contentType="text/html;charset=utf-8"%>
<%@include file="../include/header.jsp"%>
<script type="text/javascript">

function press(event) {
	if (event.keyCode==13) {
		fnAjaxGroupCall();
	}
}
function fnActOrgModify(op){
	if(!document.frm.empNm.value){
		alert("필수값이 없습니다. 다시 선택하여 주세요");
		return;
	}
	if(op=="new"){
		if(!confirm("신규로 등록하시겠습니까?")){
			return;
		}
	}
	if(op=="del" && !confirm("삭제하시겠습니까?")){
		return;
	}
	var formData = $("#actEmpModifyForm").serialize();
	var url = "<c:url value='/boffice/actOrg/modifyActOrg.do' />";
	if(!document.frm.empNo.value){
		url = "<c:url value='/boffice/actOrg/insertActOrg.do' />";
	}
	var param = formData;
	commonUtil.AjaxSynCall(url,param,'text','저장되었습니다.');
	location.href="<c:url value='/boffice/actOrg/actOrgList.do' />";
}
function fnActOrgList(){
	document.frm.action = "<c:url value='/boffice/actOrg/actOrgList.do'/>";
	document.frm.submit();
}

var ajaxCodeId = "";
function fnAjaxCodeListCall(cd,va){
	ajaxCodeId = cd;
	var url = '/boffice/activity/actCodeList.do';
	var param = {
			codeId: cd,
			codeLike: va,
	};
	commonUtil.AjaxSynCall(url,param,'json','',fnAjaxCodeListCallBack);
}
function fnAjaxCodeListCallBack(result){
	var infoCodeList = result.ajaxCodeResult;
	var str = "";
	$("."+ajaxCodeId).empty();
	str = str + '<option value="">선택</option>';
	for(var i=0; i<infoCodeList.length; i++){
		str = str + '<option value="'+infoCodeList[i].code+'">'+infoCodeList[i].codeNm+'</option>';
	}
	$("."+ajaxCodeId).append(str);
}

$(function(){
	$(".COM051").change(function(){
		var codeId = "COM052";
		fnAjaxCodeListCall(codeId,$(this).val());
	});
	$(".COM052").change(function(){
		var codeId = "COM053";
		fnAjaxCodeListCall(codeId,$(this).val());
	});
});

</script>

	<h2 class="blind">본문</h2>
		<!-- Container -->
		<div class="container sub" id="container">
		
			<h3 class="cont tit2 mt_60">조직도 관리</h3>

			<div class="cont sch_view">
<form name="frm" id="actEmpModifyForm" method="post">
	<input type="hidden" name="pageIndex" value="<c:out value="${searchVO.pageIndex}"/>">
	<input type="hidden" name="searchCnd" value="<c:out value="${searchVO.searchCnd}"/>">
	<input type="hidden" name="searchKeyword" value="<c:out value="${searchVO.searchKeyword}"/>">
	<input type="hidden" name="searchActstt" value="<c:out value="${searchVO.searchActstt}"/>">

				<div class="writeType03 mt_50">
					<table>
						<caption class="blind">조직도 상세보기 및 수정</caption>
						<colgroup>
							<col width="153px" />
							<col width="*" />
						</colgroup>
						<tbody>	
							<tr>
								<th class="ta_l" scope="row">일련번호</th>
								<td class="v2" id="empNoTd">
									<c:out value="${resultInfo.empNo}"/>
									<input type="hidden" name="empNo" id="empNo" value="<c:out value="${resultInfo.empNo}"/>" />
								</td>
							</tr>
							<tr>
								<th class="ta_l" scope="row"><label for="place">조직도1차</label></th>
								<td class="v3">
									<label for="act_type" class="blind">조직도1차</label>
									<select class="v2 COM051">
										<option value="">선택</option>
									<c:forEach var="codeResult51" items="${codeResult51}" varStatus="status">
										<option value='<c:out value="${codeResult51.code}"/>' <c:if test="${fn:substring(resultInfo.orgCd,0,2) eq codeResult51.code}"> selected</c:if>><c:out value="${codeResult51.codeNm}"/></option>
									</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th class="ta_l" scope="row"><label for="place">조직도2차</label></th>
								<td class="v3">
									<label for="act_type" class="blind">조직도2차</label>
									<select class="v2 COM052">
									<c:forEach var="codeResult52" items="${codeResult52}" varStatus="status">
										<option value='<c:out value="${codeResult52.code}"/>' <c:if test="${fn:substring(resultInfo.orgCd,0,4) eq codeResult52.code}"> selected</c:if>><c:out value="${codeResult52.codeNm}"/></option>
									</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th class="ta_l" scope="row"><label for="place">조직도3차</label></th>
								<td class="v3">
									<label for="act_type" class="blind">조직도3차</label>
									<select class="v2 COM053" name="orgCd" id="orgCd">
									<c:forEach var="codeResult53" items="${codeResult53}" varStatus="status">
										<option value='<c:out value="${codeResult53.code}"/>' <c:if test="${resultInfo.orgCd eq codeResult53.code}"> selected</c:if>><c:out value="${codeResult53.codeNm}"/></option>
									</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th class="ta_l" scope="row"><label for="empNm">성명</label></th>
								<td class="v3">
									<input type="text" name="empNm" id="empNm" style="width:188px;" value="<c:out value="${resultInfo.empNm}"/>" />
								</td>
							</tr>
							<tr>
								<th class="ta_l" scope="row"><label for="psnCd">직위</label></th>
								<td class="v3">
									<label for="act_type" class="blind">직위</label>
									<select class="v2" name="psnCd" id="psnCd">
										<option value="">선택</option>
									<c:forEach var="codeResult45" items="${codeResult45}" varStatus="status">
										<option value='<c:out value="${codeResult45.code}"/>' <c:if test="${resultInfo.psnCd eq codeResult45.code}"> selected</c:if>><c:out value="${codeResult45.codeNm}"/></option>
									</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th class="ta_l" scope="row"><label for="telNo">전화번호</label></th>
								<td class="v3">
									<input type="text" name="telNo" id="telNo" style="width:188px;" value="<c:out value="${resultInfo.telNo}"/>" />
								</td>
							</tr>
							<tr>
								<th class="ta_l" scope="row"><label for="empWork">담당업무</label></th>
								<td class="v3">
									<input type="text" name="empWork" id="empWork" style="width:300px;" value="<c:out value="${resultInfo.empWork}"/>" />
								</td>
							</tr>
							<tr>
								<th class="ta_l" scope="row"><label for="posNo">노출순위</label></th>
								<td class="v3">
									<input type="text" name="posNo" id="posNo" style="width:188px;" value="<c:out value="${resultInfo.posNo}"/>" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- //writeType03 -->

				<div class="ta_c mt_50">
					<c:if test="${empty resultInfo.empNo}">
					<a href="javascript:void(0);" class="button_v1 mr_7" onclick="javascript:fnActOrgModify('new');"><span class="v7">등록</span></a>
					</c:if>
					<c:if test="${!empty resultInfo.empNo}">
					<a href="javascript:void(0);" class="button_v1 mr_7" onclick="javascript:fnActOrgModify('edit');"><span class="v7">수정</span></a>
					<a href="" class="button_v1 mr_7" onclick="javascript:fnActOrgModify('del');"><span class="v7">삭제</span></a>
					</c:if>
					<a href="javascript:void(0);" class="button_v1" onclick="javascript:fnActOrgList();"><span class="v3">목록으로</span></a>
				</div>

</form>
			</div>
			<!-- //cont -->

		</div>
		<!-- //Container -->

<%@include file="../include/footer.jsp"%>