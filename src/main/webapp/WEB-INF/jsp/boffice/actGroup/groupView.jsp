<%@page contentType="text/html;charset=utf-8"%>
<%@include file="../include/header.jsp"%>
<script type="text/javascript">

function fnActGroupModify(op){
	if(!document.frm.groupNm.value){
		alert("필수값이 없습니다.");
		return;
	}
	if(op=="new"){
		//중복 체크
		var url = '/boffice/actGroup/ActGroupDupCheck.do';
		var param = {
				groupId: document.frm.groupId.value,
				groupNm: document.frm.groupNm.value
		};
		if(commonUtil.AjaxSynCall(url,param)!="success"){
			document.frm.groupNm.select();
			return;
		}
		if(!confirm("신규로 등록하시겠습니까?")){
			return;
		}
		document.frm.action = "<c:url value='/boffice/actGroup/insertActGroup.do' />";
		document.frm.submit();
		return;
	}
	$("#deldt").val(op);
	if(op=="edit" && !confirm("수정하시겠습니까?")){
		return false;
	}
	if(op=="del" && !confirm("삭제하시겠습니까?")){
		return false;
	}
	var formData = $("#actGroupModifyForm").serialize();
	var url = "<c:url value='/boffice/actGroup/modifyActGroup.do' />";
	var param = formData;
	commonUtil.AjaxSynCall(url,param,'text','저장되었습니다.');
	if(op=="del"){
		fnActGroupList();
	}
}
function fnActGroupList(){
	document.frm.action = "<c:url value='/boffice/actGroup/actGroupList.do'/>";
	document.frm.submit();
}
function fnAjaxActGroupDupCheck(){
	if(!document.frm.groupNm.value){
		alert("그룹명을 입력하여 주세요.");
		return;
	}
	var url = '/boffice/actGroup/ActGroupDupCheck.do';
	var param = {
			groupId: document.frm.groupId.value,
			groupNm: document.frm.groupNm.value
	};
	//commonUtil.AjaxSynCall(url,param,'text','중복된 그룹명이 아닙니다.')
	var res=commonUtil.AjaxSynCall(url,param)
	if(res!="success"){
		document.frm.groupNm.select();
		return;
	}else{
		alert("중복된 그룹명이 아닙니다.")
	}
}
$(document).ready(function(){
});
</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>권한그룹 구성</h3>
				<div class="btnWrap">
					<c:if test="${empty resultInfo.groupId}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActGroupModify('new');">수정</button>
					</c:if>
					<c:if test="${!empty resultInfo.groupId}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActGroupModify('edit');">수정</button>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActGroupModify('del');">삭제</button>
					</c:if>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActGroupList();">목록</button>
				</div>
			</div>
			<div class="realCont">

				<form name="frm" id="actGroupModifyForm" method="post">
					<input type="hidden" name="pageIndex" value="<c:out value="${searchVO.pageIndex}"/>">
					<input type="hidden" name="searchCnd" value="<c:out value="${searchVO.searchCnd}"/>">
					<input type="hidden" name="searchKeyword" value="<c:out value="${searchVO.searchKeyword}"/>">
				
					<input type="hidden" name="groupId" value="<c:out value="${resultInfo.groupId}"/>" />
					<input type="hidden" name="deldt" id="deldt" />
					<table class="commonTable writeTable">
						<caption class="blind">그룹 정보</caption>
						<colgroup>
							<col width="153px" />
							<col width="*" />
						</colgroup>
						<tbody>	
							<tr>
								<th scope="row"><label for="title">그룹명</label></th>
								<td>
									<input type="text" name="groupNm" id="groupNm" style="width:200px;" value="<c:out value="${resultInfo.groupNm}"/>" maxlength="20" />
									<a href="javascript:void(0);" class="button_v2" onclick="javascript:fnAjaxActGroupDupCheck();"><span>중복 확인</span></a>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="title">설명</label></th>
								<td>
									<input type="text" name="groupDc" id="groupDc" style="width:300px;" value="<c:out value="${resultInfo.groupDc}"/>" maxlength="50" />
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="title">레벨</label></th>
								<td>
									<select name="groupLevel" id="groupLevel" style="width:120px;">
									<c:forEach var="codeResult43" items="${codeResult43}" varStatus="status">
										<option value='<c:out value="${codeResult43.code}"/>' <c:if test="${resultInfo.groupLevel eq codeResult43.code}"> selected</c:if>><c:out value="${codeResult43.codeNm}"/></option>
									</c:forEach>
									</select>
								</td>
							</tr>
							<c:if test="${!empty resultInfo.groupId}">
							<tr>
								<th scope="row">수정일</th>
								<td>
									<c:out value="${resultInfo.moddt}"/>
								</td>
							</tr>
							</c:if>
						</tbody>
					</table>
				</form>
				<!-- //writeType03 -->

			</div>
		</section>

	</section>

<%@include file="../include/footer.jsp"%>