<%@page contentType="text/html;charset=utf-8"%>
<%@include file="../include/header.jsp"%>
<%@ taglib prefix="ckeditor" uri="http://ckeditor.com" %>
<%
pageContext.setAttribute("CR", "\r");
pageContext.setAttribute("LF", "\n");
pageContext.setAttribute("CRLF", "\r\n");
pageContext.setAttribute("SP", "&nbsp;");
pageContext.setAttribute("BR", "<br/>");
%> 
<style type="text/css">
.itemUl {width:100%;}
.itemUl li {width:95%;height:28px;border:1px solid #CDCDCD;padding:0;margin:0;line-height:28px;text-align:center;margin-bottom:5px;cursor:pointer;}
.itemUl li div {width:60px;padding:7px;float:left;}
</style>
<script type="text/javascript">

$(function(){
	fnAjaxListCall("d1","");
});

function fnActTopAdd(dp,obj){
	var url = "<c:url value='/boffice/actTeams/insertActTeams.do' />";
	var param = {
			aDepth : dp,
			aName : document.depthTopFrm.aName.value
		};
	commonUtil.AjaxSynCall(url,param,'text','저장되었습니다.');
	document.depthTopFrm.aName.value = "";
	fnAjaxListCall(dp,"");
}
function fnActSubAdd(dp,obj){
	var dpNext = fnGetNextDepth(dp);
	var url = "<c:url value='/boffice/actTeams/insertActTeams.do' />";
	var param = {
			aDepth : dpNext,
			aFore : document.updateFrm.aId.value,
			aName : $("#aNameNe").val()
		};
	commonUtil.AjaxSynCall(url,param,'text','저장되었습니다.');
	$("#aNameNe").val("");
	fnAjaxListCall(dpNext,document.updateFrm.aId.value);
}
function fnAjaxListCall(dp,va){
	var url = '/boffice/actTeams/ajaxActTeamsList.do';
	var param = {
			searchCnd: dp,
			searchKeyword: va,
	};
	commonUtil.AjaxSynCall(url,param,'json','',fnAjaxListCallBack,dp);
}
function fnAjaxListCallBack(result,dp){
	var infoList = result.ajaxListResult;
	var str = "";
	$(".depthList"+dp).empty();
	$(".depthListd3").empty();
	for(var i=0; i<infoList.length; i++){
		str = str + '<li class="itemLi" id="'+infoList[i].aId+'" onclick="javascript:fnAjaxDetailCall(\''+infoList[i].aId+'\',\''+dp+'\')">'+infoList[i].aName;
		str = str + '<input type="hidden" name="aId" value="'+infoList[i].aId+'"/>';
		str = str + '</li>';
	}
	$(".depthList"+dp).append(str);
}
function fnAjaxDetailCall(cd,dp){
	document.updateFrm.aDepth.value = dp;
	var url = '/boffice/actTeams/ajaxActTeamsDetail.do';
	var param = {
			aId: cd
	};
	commonUtil.AjaxSynCall(url,param,'json','',fnAjaxDetailCallBack,dp);
}
function fnAjaxDetailCallBack(result,dp){
	var infoList = result.infoArtcDetail;
	document.updateFrm.aId.value = infoList.aId;
	document.updateFrm.aFore.value = infoList.aFore;
	$("#aNamePre").val(infoList.aName);
	CKEDITOR.instances.aText.setData(infoList.aText);
	$("input:radio[name='useYn']:input[value='"+ infoList.useYn+"']").prop("checked","checked");
	if(dp!="d3"){
		fnAjaxListCall(fnGetNextDepth(dp),infoList.aId);
	}
	$(".itemLi").css("background-color","#FFF");
	$("#"+infoList.aId).css("background-color","#EEE");
	$(".updateFrmDiv").show();
	$(".aNameNeTr,.moveD1,.moveD2,.moveD3,.updateFrmDivD3").hide();
	if(dp=="d1") $(".aNameNeTr,.moveD1").show();
	if(dp=="d2"){
		$(".aNameNeTr,.moveD2").show();
		$(".updateFrmDivD3").show();
		fnAjaxOrgEmpListCall();
	}
	if(dp=="d3"){
		$(".moveD3").show();
		$(".updateFrmDivD3").show();
		fnAjaxOrgEmpListCall();
	}
}

function fnGetNextDepth(d){
	d = d.replace("d","");
	d = parseInt(d,10);
	d = d+1;
	return "d"+d;
}

function fnAjaxEdit(md){
	if(!confirm("수정하시겠습니까?")){
		return;
	}
	var url = '/boffice/actTeams/modifyActTeams.do';
	var param = {
			frmMode: md,
			aName: $("#aNamePre").val(),
			useYn: $("input:radio[name='useYn']:checked").val(),
			aText: CKEDITOR.instances.aText.getData(),
			aId: document.updateFrm.aId.value
	};
	commonUtil.AjaxSynCall(url,param,'text','저장되었습니다.');
	fnAjaxListCall(document.updateFrm.aDepth.value,document.updateFrm.aFore.value);
}
function fnAjaxDel(){
	if(!confirm("삭제하시겠습니까?")){
		return;
	}
	var url = '/boffice/actTeams/deleteActTeams.do';
	var param = {
			aId: document.updateFrm.aId.value
	};
	var resultmsg = commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.');
	if(resultmsg=="success"){
		fnAjaxListCall(document.updateFrm.aDepth.value,document.updateFrm.aFore.value);
	}
	$(".updateFrmDiv").hide();
}

function moveup(om) {
	var obj = document.updateFrm.aId.value;
	if(om=="emp"){
		obj = $("input:radio[name='posNo']:checked").val();
	}
	if(!obj){
		alert("선택된 항목이 없습니다");
		return;
	}
	$('#'+obj).after($('#'+obj).prev());
}
function movedown(om) {
	var obj = document.updateFrm.aId.value;
	if(om=="emp"){
		obj = $("input:radio[name='posNo']:checked").val();
	}
	if(!obj){
		alert("선택된 항목이 없습니다");
		return;
	}
	$('#'+obj).before($('#'+obj).next());
}
function fnUpdateSeq(obj){
	if(confirm("순서변경을 적용하시겠습니까?")){
		var formData = $("#"+obj).serialize();
		var url = "<c:url value='/boffice/actTeams/updateActTeamsSeq.do'/>";
		var param = formData;
		if(commonUtil.AjaxSynCall(url,param)=="success"){
			alert("수정되었습니다.");
			fnAjaxListCall(document.updateFrm.aDepth.value,document.updateFrm.aFore.value);
		}
	}
}
//---------------------------------------------------  팀원 등록 -----------------------------------------------------------
function fnAddEmp(){
	$("#empAddTbody").append("<tr>"+$("#empAddTr").html()+"</tr>");
}
function fnRemoveEmp(obj){
	obj = $(obj).parent().parent();
	var empNo = $(obj).find("#empNo").val();
	if(!empNo){
		$(obj).remove();
		return;
	}
	if(empNo && !confirm("삭제하시겠습니까?")){
		return;
	}
	var url = "<c:url value='/boffice/actOrg/deleteActOrg.do' />";
	var param = {
			empNo : $(obj).find("#empNo").val()
	};
	commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.');
	fnAjaxOrgEmpListCall();
}
function fnActOrgModify(obj){
	obj = $(obj).parent().parent();
	var empNo = $(obj).find("#empNo").val();
	if(!$(obj).find("#psnCd").val() || !$(obj).find("#empNm").val() || !$(obj).find("#useyn").val()){
		alert("필수값이 없습니다. 직책, 성명, 노출여부를 선택 또는 입력하여 주세요.");
		return;
	}
	if(!empNo && !confirm("신규로 등록하시겠습니까?")){
		return;
	}
	if(empNo && !confirm("수정하시겠습니까?")){
		return;
	}
	var url = "<c:url value='/boffice/actOrg/modifyActOrg.do' />";
	if(!$(obj).find("#empNo").val()){
		url = "<c:url value='/boffice/actOrg/insertActOrg.do' />";
	}
	var param = {
			empNo : $(obj).find("#empNo").val(),
			orgCd : document.updateFrm.aId.value,
			psnCd : $(obj).find("#psnCd").val(),
			empNm : $(obj).find("#empNm").val(),
			telNo : $(obj).find("#telNo").val(),
			empWork : $(obj).find("#empWork").val(),
			useyn : $(obj).find("#useyn").prop("checked") == true ? "Y" : "N"
	};
	commonUtil.AjaxSynCall(url,param,'text','저장되었습니다.');
	fnAjaxOrgEmpListCall();
}
function fnAjaxOrgEmpListCall(){
	var url = '/boffice/actTeams/ajaxActTeamEmpList.do';
	var param = {
			searchKeyword: document.updateFrm.aId.value,
	};
	commonUtil.AjaxSynCall(url,param,'json','',fnAjaxOrgEmpListCallBack);
}
function fnAjaxOrgEmpListCallBack(result){
	var infoList = result.ajaxListResult;
	$("#empAddTbody").empty();
	var obj = "";
	for(var i=0; i<infoList.length; i++){
		$("#empAddTbody").append("<tr class='empInfoTr"+i+"' id='"+infoList[i].empNo+"'>"+$("#empAddTr").html()+"</tr>");
		obj = $(".empInfoTr"+i);
		$(obj).find("#empNo").val(infoList[i].empNo);
		$(obj).find("#psnCd").val(infoList[i].psnCd);
		$(obj).find("#empNm").val(infoList[i].empNm);
		$(obj).find("#telNo").val(infoList[i].telNo);
		$(obj).find("#empWork").val(infoList[i].empWork);
		$(obj).find("#useyn").prop("checked",infoList[i].useyn == "Y" ? "checked" : "");
		$(obj).find("#posNo").val(infoList[i].empNo);
	}
}
function fnUpdateEmpSeq(obj){
	if(confirm("순서변경을 적용하시겠습니까?")){
		var formData = $("#"+obj).serialize();
		var url = "<c:url value='/boffice/actOrg/modifyActOrgSeq.do'/>";
		var param = formData;
		if(commonUtil.AjaxSynCall(url,param)=="success"){
			alert("수정되었습니다.");
			fnAjaxListCall(document.updateFrm.aDepth.value,document.updateFrm.aFore.value);
		}
	}
}
//---------------------------------------------------  팀원 등록 -----------------------------------------------------------

$(function(){
	$("input[type=hidden]").bind("change", function() {
		alert($(this).val());
	});
});
</script>
	<h2 class="blind">본문</h2>
		<!-- Container -->
		<div class="container sub" id="container">
		
			<h3 class="cont tit2 mt_60">조직도 리스트 및 관리</h3>

			<div class="cont sch_view">

				<div class="listType06 mt_15">
				<form name="depthTopFrm" id="depthTopFrm" method="post">
					<table>
						<colgroup>
							<col width="153px" />
							<col width="*" />
						</colgroup>
						<tbody>	
							<tr>
								<th class="ta_c" scope="row"><label for="aName">최상위카테고리 등록</label></th>
								<td class="v3">
									<input type="text" name="aName" id="aName" style="width:188px;" maxlength="50" />
									<a href="javascript:void(0);" class="button_v2" onclick="javascript:fnActTopAdd('d1',this);"><span>추가</span></a>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				</div>
				<div class="listType05 mt_15">
					<table>
						<colgroup>
							<col width="33%" />
							<col width="33%" />
							<col width="33%" />
						</colgroup>
						<thead>	
							<tr>
								<th class="ta_c" scope="row"><label for="aName">1차 분류</label></th>
								<th class="ta_c" scope="row"><label for="aName">2차 분류</label></th>
								<th class="ta_c" scope="row"><label for="aName">3차 분류</label></th>
							</tr>
						</thead>
						<tbody>	
							<tr>
								<td class="v3" style="vertical-align:top;">
								<form name="updateSeqFrm1" id="updateSeqFrm1" method="post">
									<input type="hidden" name="aDepth" value="d1" />
									<ul class="itemUl depthListd1">
									 </ul>
								</form>
								</td>
								<td class="v3" style="vertical-align:top;">
								<form name="updateSeqFrm2" id="updateSeqFrm2" method="post">
									<input type="hidden" name="aDepth" value="d2" />
									<ul class="itemUl depthListd2">
									 </ul>
								</form>
								</td>
								<td class="v3" style="vertical-align:top;">
								<form name="updateSeqFrm3" id="updateSeqFrm3" method="post">
									<input type="hidden" name="aDepth" value="d3" />
									<ul class="itemUl depthListd3">
									 </ul>
								</form>
								</td>
							</tr>
							<tr class="updateFrmDiv" style="display:none;">
								<td class="v3">
									<div class="moveD1">
									<div style="width:40px;padding:3px;float:left;margin-left:190px;">
									<img src="/images/_adm/btn_align_bottom.gif" onclick="javascript:movedown();" style="cursor:pointer;">
									<img src="/images/_adm/btn_align_top.gif" onclick="javascript:moveup();" style="cursor:pointer;">
									</div>
									<img src="/images/_adm/btn_modify.png" style="float:left;" onclick="javascript:fnUpdateSeq('updateSeqFrm1');" style="cursor:pointer;">
									</div>
								</td>
								<td class="v3" style="align:right;">
									<div class="moveD2">
									<div style="width:40px;padding:3px;float:left;margin-left:190px;">
									<img src="/images/_adm/btn_align_bottom.gif" onclick="javascript:movedown();" style="cursor:pointer;">
									<img src="/images/_adm/btn_align_top.gif" onclick="javascript:moveup();" style="cursor:pointer;">
									</div>
									<img src="/images/_adm/btn_modify.png" style="float:left;" onclick="javascript:fnUpdateSeq('updateSeqFrm2');" style="cursor:pointer;">
									</div>
								</td>
								<td class="v3" style="align:right;">
									<div class="moveD3">
									<div style="width:40px;padding:3px;float:left;margin-left:190px;">
									<img src="/images/_adm/btn_align_bottom.gif" onclick="javascript:movedown();" style="cursor:pointer;">
									<img src="/images/_adm/btn_align_top.gif" onclick="javascript:moveup();" style="cursor:pointer;">
									</div>
									<img src="/images/_adm/btn_modify.png" style="float:left;" onclick="javascript:fnUpdateSeq('updateSeqFrm3');" style="cursor:pointer;">
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="listType06 mt_15 updateFrmDiv" style="display:none;">
				<form name="updateFrm" id="updateFrm" method="post">
					<input type="hidden" name="aDepth" />
					<input type="hidden" name="aId" />
					<input type="hidden" name="aFore" />
				</form>
					<table>
						<colgroup>
							<col width="153px" />
							<col width="*" />
						</colgroup>
						<tbody>	
							<tr>
								<th class="ta_c" scope="row"><label for="aNamePre">현재 카테고리</label></th>
								<td class="v3">
									<input type="text" name="aNamePre" id="aNamePre" style="width:188px;" maxlength="50" />
									<a href="javascript:void(0);" class="button_v2" onclick="javascript:fnAjaxEdit('name');"><span>수정</span></a>
									<a href="javascript:void(0);" class="button_v2" onclick="javascript:fnAjaxDel();"><span>삭제</span></a>
								</td>
							</tr>
							<tr class="aNameNeTr" style="display:none;">
								<th class="ta_c" scope="row"><label for="aNameNe">하위 카테고리 생성</label></th>
								<td class="v3">
									<input type="text" name="aNameNe" id="aNameNe" style="width:188px;" maxlength="50" />
									<a href="javascript:void(0);" class="button_v2" onclick="javascript:fnActSubAdd(document.updateFrm.aDepth.value,this);"><span>등록</span></a>
								</td>
							</tr>
							<tr>
								<th class="ta_c" scope="row"><label for="useYn">노출 여부</label></th>
								<td class="v3">
									<input type="radio" name="useYn" id="useYn" value="Y" />노출
									<input type="radio" name="useYn" id="useYn" value="N" />숨김
									<a href="javascript:void(0);" class="button_v2" onclick="javascript:fnAjaxEdit('useyn');"><span>수정</span></a>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- //writeType03 -->
				<div class="listType06 mt_15 updateFrmDivD3" style="display:none;">
					<table>
						<colgroup>
							<col width="153px" />
							<col width="*" />
						</colgroup>
						<tbody>	
							<tr>
								<th class="ta_c" scope="row">
									<label for="aNamePre">팀 소개</label><br/><br/>
									<a href="javascript:void(0);" class="button_v2" onclick="javascript:fnAjaxEdit('text');"><span>수정</span></a><br/><br/><br/>
									<a href="javascript:void(0);" class="button_v2" onclick="javascript:fnAddEmp();"><span>팀원추가</span></a>
								</th>
								<td class="v3">
									<textarea name="aText" id="aText" cols="90" rows="10" style="width:578px;height:68px;"></textarea>
									<ckeditor:replace replace="aText" basePath="${pageContext.request.contextPath}/html/egovframework/com/cmm/utl/ckeditor/" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- //writeType03 -->
				<div class="listType06 mt_15 updateFrmDivD3" style="display:none;">
					<form name="updateSeqEmpFrm" id="updateSeqEmpFrm" method="post">
					<table>
						<colgroup>
							<col width="80px" />
							<col width="90px" />
							<col width="160px" />
							<col width="*" />
							<col width="80px" />
							<col width="150px" />
							<col width="70px" />
						</colgroup>
						<thead>	
							<tr>
								<th class="ta_c" scope="row"><label for="aName">직책</label></th>
								<th class="ta_c" scope="row"><label for="aName">성명</label></th>
								<th class="ta_c" scope="row"><label for="aName">전화번호</label></th>
								<th class="ta_c" scope="row"><label for="aName">담당업무</label></th>
								<th class="ta_c" scope="row"><label for="aName">노출여부</label></th>
								<th class="ta_c" scope="row">관리</th>
								<th class="ta_c" scope="row">순서변경</th>
							</tr>
						</thead>
						<tbody id="empTempTbody">
							<tr id="empAddTr" style="display:none;">
								<td class="v2">
									<label for="act_type" class="blind">직위</label>
									<select class="v2" name="psnCd" id="psnCd">
										<option value="">선택</option>
										<c:forEach var="codeResult45" items="${codeResult45}" varStatus="status">
										<option value='<c:out value="${codeResult45.code}"/>'><c:out value="${codeResult45.codeNm}"/></option>
										</c:forEach>
									</select>
								</td>
								<td class="v2 ta_c">
									<input type="hidden" name="empNo" id="empNo" />
									<input type="text" name="empNm" id="empNm" style="width:80px;" maxlength="30" />
								</td>
								<td class="v2 ta_c">
									<input type="text" name="telNo" id="telNo" style="width:130px;" maxlength="15" />
								</td>
								<td class="v2 ta_c">
									<input type="text" name="empWork" id="empWork" style="width:380px;" maxlength="800" />
								</td>
								<td class="v3 ta_c">
									<input type="checkbox" name="useyn" id="useyn" value="Y"/>
								</td>
								<td class="ta_c">
									<a href="javascript:void(0);" class="button_v2" onclick="javascript:fnActOrgModify(this);"><span>저장</span></a>
									<a href="javascript:void(0);" class="button_v2" onclick="javascript:fnRemoveEmp(this);"><span>삭제</span></a>
								</td>
								<td>
									<input type="radio" name="posNo" id="posNo"/>
								</td>
							</tr>
						</tbody>
						<tbody id="empAddTbody">
						</tbody>
							<tr class="updateFrmDiv">
								<td class="v3" colspan="7" align="right">
									<div style="width:120px;float:right;">
									<div style="width:40px;padding:3px;float:left;">
									<img src="/images/_adm/btn_align_bottom.gif" onclick="javascript:movedown('emp');" style="cursor:pointer;">
									<img src="/images/_adm/btn_align_top.gif" onclick="javascript:moveup('emp');" style="cursor:pointer;">
									</div>
									<img src="/images/_adm/btn_modify.png" style="float:left;" onclick="javascript:fnUpdateEmpSeq('updateSeqEmpFrm');" style="cursor:pointer;">
									</div>
								</td>
							</tr>
					</table>
				</form>
				</div>
				<!-- //writeType03 -->

			</div>
			<!-- //cont -->

		</div>
		<!-- //Container -->

<%@include file="../include/footer.jsp"%>