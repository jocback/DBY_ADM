<%@page contentType="text/html;charset=utf-8"%>
<%@include file="../include/header.jsp"%>
<script type="text/javascript">

function press(event) {
	if (event.keyCode==13) {
		fnAjaxEmpCall();
	}
}
function fnActEmpModify(op){
	if(!document.frm.empId.value){
		alert("필수값이 없습니다. 다시 선택하여 주세요");
		return;
	}
	if(document.frm.password.value && document.frm.password.value != document.frm.password2.value){
		alert("비밀번호 확인값이 일치하지 않습니다.");
		return;
	}
	if(op=="new"){
		if(!confirm($("#groupIdSel option:selected").text()+"를(을) 신규로 등록하시겠습니까?")){
			return;
		}
	}
	document.frm.groupId.value = $("#groupIdSel").val();
	if(op=="edit" && !confirm("수정하시겠습니까?")){
		return;
	}
	var formData = $("#actEmpModifyForm").serialize();
	var url = "<c:url value='/boffice/actEmp/modifyActEmp.do' />";
	if(!document.frm.statusCode.value){
		url = "<c:url value='/boffice/actEmp/insertActEmp.do' />";
	}
	var param = formData;
	commonUtil.AjaxSynCall(url,param,'text','저장되었습니다.');
	if(op=="new"){
		location.href="<c:url value='/boffice/actEmp/actEmpList.do' />";
	}
}

function fnActEmpDel(obj){
	if(!confirm("삭제하시겠습니까?")){
		return;
	}
	var url = "<c:url value='/boffice/actEmp/deleteActEmp.do' />";
	var param = {empId : obj}
	commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.');
	location.href="<c:url value='/boffice/actEmp/actEmpList.do' />";
}

function fnActEmpList(){
	document.frm.action = "<c:url value='/boffice/actEmp/actEmpList.do'/>";
	document.frm.submit();
}

var ajaxCodeId = "";
function fnAjaxCodeListCall(cd,va){
	ajaxCodeId = cd;
	var url = '/boffice/actTeams/ajaxActTeamsList.do';
	var param = {
			searchCnd: cd,
			searchKeyword: va,
	};
	commonUtil.AjaxSynCall(url,param,'json','',fnAjaxCodeListCallBack);
}
function fnAjaxCodeListCallBack(result){
	var infoCodeList = result.ajaxListResult;
	var str = "";
	$("."+ajaxCodeId).empty();
	str = str + '<option value="">선택</option>';
	for(var i=0; i<infoCodeList.length; i++){
		str = str + '<option value="'+infoCodeList[i].aId+'">'+infoCodeList[i].aName+'</option>';
	}
	$("."+ajaxCodeId).append(str);
}

$(function(){
	$(".d2").change(function(){
		var codeId = "d3";
		fnAjaxCodeListCall(codeId,$(this).val());
	});
});

function fnAjaxEmpCall(){
	if(!$("#ajaxKeyword").val()){
		alert("검색할 이름을 입력하여 주세요");
		return;
	}
	var url = '/boffice/actEmp/searchInfoEmpList.do';
	var param = {
		searchCnd: "1",
		searchKeyword: $("#ajaxKeyword").val(),
	};
	commonUtil.AjaxSynCall(url,param,'json','',fnAjaxEmpCallBack);
}
function fnAjaxEmpCallBack(result){
	var infoGrEmpList = result.infoEmpList;
	var str = "";
	$("#infoGrEmpListBody").empty();
	for(var i=0; i<infoGrEmpList.length; i++){
		str = str + '<tr>';
		str = str + '	<td>';
		str = str + '		<a href="javascript:void(0);" onclick=\'javascript:fnAuthEmpInput("'+infoGrEmpList[i].empNo+'","'+infoGrEmpList[i].empNm+'","'+infoGrEmpList[i].orgCd+'","'+infoGrEmpList[i].foreCd+'","'+infoGrEmpList[i].psnCd+'","'+infoGrEmpList[i].telNo+'");\'>'+infoGrEmpList[i].empNm+'</a>';
		str = str + '	</td>';
		str = str + '	<td>'+infoGrEmpList[i].orgCdNm1+' '+infoGrEmpList[i].orgCdNm2+'</td>';
		str = str + '	<td class="pl">'+infoGrEmpList[i].psnCdNm+'</td>';
		str = str + '</tr>';
	}
	$("#infoGrEmpListBody").append(str);
}
function fnAuthEmpInput(no,emp,org,fore,psn,tel){
	$(".d2").val(fore);
	fnAjaxCodeListCall("d3",fore);
	document.frm.empNo.value = no;
	document.frm.empNm.value = emp;
	document.frm.telNo.value = tel;
	document.frm.psnCd.value = psn;
	$(".d3").val(org);
	$("#poster2").hide();
}
</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>관리자 관리</h3>
				<div class="btnWrap">
					<c:if test="${empty resultInfo.empId}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActEmpModify('new');">수정</button>
					</c:if>
					<c:if test="${!empty resultInfo.empId}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActEmpModify('edit');">수정</button>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActEmpDel('<c:out value='${resultInfo.empId}'/>');">삭제</button>
					</c:if>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActEmpList();">목록</button>
				</div>
			</div>
			<div class="realCont">

				<form name="frm" id="actEmpModifyForm" method="post">
					<input type="hidden" name="pageIndex" value="<c:out value="${searchVO.pageIndex}"/>">
					<input type="hidden" name="searchCnd" value="<c:out value="${searchVO.searchCnd}"/>">
					<input type="hidden" name="searchKeyword" value="<c:out value="${searchVO.searchKeyword}"/>">
					<input type="hidden" name="searchActstt" value="<c:out value="${searchVO.searchActstt}"/>">
				
					<input type="hidden" name="statusCode" value="<c:out value="${resultInfo.statusCode}"/>" />
					<input type="hidden" name="groupId" />
					<input type="hidden" name="empNo" value='<c:out value="${resultInfo.empNo}"/>' />

					<table class="commonTable writeTable">
						<caption class="blind">권한관리 상세보기 및 수정</caption>
						<colgroup>
							<col width="153px" />
							<col width="*" />
						</colgroup>
						<tbody>	
							<tr>
								<th scope="row">관리자 권한 명칭</th>
								<td>
									<select name="groupIdSel" id="groupIdSel" style="width:230px;">
										<option value="">선택</option>
									<c:forEach var="resultGroup" items="${resultGroup}" varStatus="status">
										<option value='<c:out value="${resultGroup.groupId}"/>' <c:if test="${resultInfo.groupId eq resultGroup.groupId}"> selected</c:if>><c:out value="${resultGroup.groupNm}"/></option>
									</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row">아이디</th>
								<td id="empIdTd">
									<c:if test="${!empty resultInfo.empId}">
									<c:out value="${resultInfo.empId}"/>
									<input type="hidden" name="empId" id="empId" value="<c:out value="${resultInfo.empId}"/>" />
									</c:if>
									<c:if test="${empty resultInfo.empId}">
									<input type="text" name="empId" id="empId" style="width:188px;" value="<c:out value="${resultInfo.empId}"/>" maxlength="20" />
									</c:if>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="place">비밀번호</label></th>
								<td>
									<input type="password" name="password" id="password" style="width:188px;" maxlength="20" />
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="place">비밀번호 확인</label></th>
								<td>
									<input type="password" name="password2" id="password2" style="width:188px;" maxlength="20" />
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="place">성명</label></th>
								<td>
									<input type="text" name="empNm" id="empNm" style="width:188px;" value="<c:out value="${resultInfo.empNm}"/>" maxlength="10" />
									<!-- <c:if test="${empty resultInfo.empNo}">
									 <a href="" class="button_v2 ml_7" onclick="openLayer('poster2',{top:70});return false;"><span>선택</span></a>
									</c:if>-->
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="orgCd2">부서</label></th>
								<td>
									<select class="v2 d2" style="width:230px;">
									<option value='' >선택</option>
									<c:forEach var="teamsD2List" items="${teamsD2List}" varStatus="status">
										<option value='<c:out value="${teamsD2List.aId}"/>' <c:if test="${resultInfo.orgCdD2 eq teamsD2List.aId}"> selected</c:if>><c:out value="${teamsD2List.aName}"/></option>
									</c:forEach>
									</select>
									<select class="v2 d3" name="orgCd" id="orgCd" style="width:230px;">
									<c:forEach var="teamsD3List" items="${teamsD3List}" varStatus="status">
										<option value='<c:out value="${teamsD3List.aId}"/>' <c:if test="${resultInfo.orgCd eq teamsD3List.aId}"> selected</c:if>><c:out value="${teamsD3List.aName}"/></option>
									</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="psnCd">직위</label></th>
								<td>
									<select name="psnCd" id="psnCd" style="width:230px;">
										<option value="">선택</option>
									<c:forEach var="codeResult45" items="${codeResult45}" varStatus="status">
										<option value='<c:out value="${codeResult45.code}"/>' <c:if test="${resultInfo.psnCd eq codeResult45.code}"> selected</c:if>><c:out value="${codeResult45.codeNm}"/></option>
									</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="telNo">연락처</label></th>
								<td>
									<input type="text" name="telNo" id="telNo" style="width:188px;" value="<c:out value="${resultInfo.telNo}"/>" maxlength="20" />
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="email">이메일</label></th>
								<td>
									<input type="text" name="email" id="email" style="width:188px;" value="<c:out value="${resultInfo.email}"/>" maxlength="50" />
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="useyn">사용여부</label></th>
								<td>
									<p class="radioStyle">
										<input id="useyn1" name="useyn" type="radio" value="Y" <c:if test="${empty resultInfo.useyn || resultInfo.useyn eq 'Y'}"> checked</c:if>/><label for="useyn1"><span></span>사용</label>
										<input id="useyn2" name="useyn" type="radio" value="N" <c:if test="${resultInfo.useyn eq 'N'}"> checked</c:if>/><label for="useyn2"><span></span>미사용</label>
									</p>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="regdt">등록일</label></th>
								<td>
									<c:out value="${resultInfo.regdt}"/>
								</td>
							</tr>
						</tbody>
					</table>
				<!-- //writeType03 -->
				</form>

			<!-- //layer-popup -->
			<%@include file="searchEmp.jsp"%>
			<!-- //layer-popup -->

			</div>
		</section>

	</section>

	<%@include file="../include/footer.jsp"%>