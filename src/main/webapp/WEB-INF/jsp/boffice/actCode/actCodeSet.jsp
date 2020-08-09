<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/header.jsp"%>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="cmmnCode" staticJavascript="false" xhtml="true" cdata="false"/>
<style type="text/css">
.writeType03 table th {padding-left:10px;}
.writeType03 table td {padding-left:10px;}
</style>
<script type="text/javaScript">
/* ********************************************************
 * 조회 처리
 ******************************************************** */
function fnSearch(){
	document.listForm.pageIndex.value = 1;
   	document.listForm.submit();
}
/* ********************************************************
* 세부리스트 Ajax통신으로 정보 획득
******************************************************** */
function fnCmcodelist(codeId){
	var url = "<c:url value='/boffice/actCode/cmdCodeView.do' />";
	var param = {
		searchKeyword: codeId
	};
	$.ajax({
		url: url,
		data:  param,
		type: 'post',
        dataType: 'html',
        async: false,
        success: function(result){
        	if(result){
        		$("#divCodeList").empty();
        		$("#divCodeList").html(result);
        	}else{
        		alert("server error");
        	}
        	
        },
        error: function(xhr, status, error){ 
        	alert(error);
        }
	});
	cmmnDetailCode.codeId.value=codeId;
}
function fnCodeIdEdit(no){
	$("#codeZ"+no).text()=="수정" ? fnCodeIdModify(no) : fnCodeIdCancel(no);
}
function fnCodeIdSave(no){
	$("#codeX"+no).text()=="저장" ? fnCodeIdModifySave(no) : fnCodeIdDelete(no);
}
function fnCodeIdModify(no){
	fnCodeIdCancel($("#codeAA").val());
	var codeC = $("#codeC"+no).text();
	var codeD = $("#codeD"+no).text();
	$("#codeC"+no).empty();
	$("#codeC"+no).append("<input type='text' id='codename"+no+"' value='"+codeC+"' style='width:100px;'><input type='hidden' id='codeCOr"+no+"' value='"+codeC+"'>");
	$("#codeD"+no).empty();
	$("#codeD"+no).append("<select id='useAt"+no+"' style='width:20px;'><option value='Y'>사용</option><option value='N'>미사용</option></select><input type='hidden' id='codeDOr"+no+"' value='"+codeD+"'>");
	JqSelectTextOption("#useAt"+no,codeD);
	$("#codeZ"+no).text("취소");
	$("#codeX"+no).text("저장");
	$("#codeAA").val(no);
}
function fnCodeIdCancel(no){
	var codeC = $("#codeCOr"+no).val();
	var codeD = $("#codeDOr"+no).val();
	$("#codeC"+no).empty();
	$("#codeC"+no).text(codeC);
	$("#codeD"+no).empty();
	$("#codeD"+no).text(codeD);
	$("#codeZ"+no).text("수정");
	$("#codeX"+no).text("삭제");
	$("#codeAA").val("");
}
function fnCodeIdAdd(){
	if($("#newCodeId").size()>0){
		return;
	}
	var str = '<tr><td class="lt_text3" nowrap></td>' +
		'<td class="lt_text" nowrap><input type="text" id="newCodeId" value="" style="width:54px;"></td>' +
		'<td class="lt_text" nowrap><input type="text" id="newCodeIdNm" value="" style="width:100px;"></td>' +
		'<td class="lt_text3" nowrap><select id="newCodeIdUseYn" style="width:30px;"><option value="Y">사용</option><option value="N">미사용</option></select></td>' +
		'<td class="lt_text3" nowrap onclick="javascript:fnCodeIdAddSave();" style="cursor:pointer;">저장</td>' +
		'<td class="lt_text3" nowrap onclick="javascript:fnCodeIdAddCancel(this);" style="cursor:pointer;">취소</td>' +
		'</tr>';
	$("#codeIdAddRowPoint").prepend(str);
}
function fnCodeIdAddCancel(obj){
	$(obj).parent('tr').remove();
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fnCodeIdDelete(no){
	var codeIdB = $("#codeB"+no).text();
	if(confirm("삭제하시겠습니까?")){
		var url = "<c:url value='/boffice/actCode/cmmCodeSave.do' />";
		var param = {
			cmd: "Del",
			clCode: cmmnCode.clCode.value,
			codeId: codeIdB
		};
		commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.');
		location.href="/boffice/actCode/actCodeSet.do";
	}
}
function fnCodeIdAddSave(no){
	if(!cmmnCode.clCode.value){
		alert("상위코드값이 없습니다. 상위코드를 먼저 선택하여 주세요.");
		return;
	}
	if(!$("#newCodeId").val()){
		alert("코드ID를 입력하여 주세요");
		return;
	}
	if(!$("#newCodeIdNm").val()){
		alert("코드ID명을 입력하여 주세요");
		return;
	}
	if(confirm("<spring:message code='common.save.msg'/>")){
		var url = "<c:url value='/boffice/actCode/cmmCodeSave.do' />";
		var param = {
			cmd: "Add",
			clCode: cmmnCode.clCode.value,
			codeId: $("#newCodeId").val(),
			codeIdNm: $("#newCodeIdNm").val(),
			codeIdDc: $("#newCodeIdNm").val(),
			useAt: $("#newCodeIdUseYn option:selected").val()
		};
		commonUtil.AjaxSynCall(url,param,'text','등록되었습니다.');
		location.href="/boffice/actCode/actCodeSet.do";
	}
}
function fnCodeIdModifySave(no){
	if(!$("#codename"+no).val()){
		alert("코드ID명을 입력하여 주세요");
		return;
	}
	if(confirm("<spring:message code='common.save.msg'/>")){
		var url = "<c:url value='/boffice/actCode/cmmCodeSave.do' />";
		var param = {
			cmd: "Modify",
			clCode: cmmnCode.clCode.value,
			codeId: $("#codeB"+no).text(),
			codeIdNm: $("#codename"+no).val(),
			codeIdDc: $("#codename"+no).val(),
			useAt: $("#useAt"+no+" option:selected").val()
		};
		commonUtil.AjaxSynCall(url,param,'text','수정되었습니다.');
		location.href="/boffice/actCode/actCodeSet.do";
	}
}
</script>
<form:form commandName="cmmnCode" name="cmmnCode" method="post">
	<input name="cmd" type="hidden" value="Modify">
	<input id="clCode" name="clCode" value="LET" type="hidden"/>
	<input id="codeId" name="codeId" type="hidden"/>
	<input id="codeIdNm" name="codeIdNm" type="hidden"/>
	<input id="codeIdDc" name="codeIdDc" type="hidden"/>
	<input id="useAt" name="useAt" type="hidden"/>
</form:form>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>코드 관리</h3>
				<div class="btnWrap">
				</div>
			</div>
			<div class="realCont">
<div class="contents_zone" style="width:1250px;">
	
	<div style="width:1250px;text-align:left;overflow:hidden;">
		<!-- 코드 리스트 S -->
		<div style="float:left;width:370px;">
			<div class="btnWrap" style="float:right;margin-bottom:5px;">
				<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onClick="javascript:fnCodeIdAdd(); return false;">등록</button>
			</div>
			<table style="width:370px;" class="commonTable detailTable">
			<CAPTION style="display: none;">공통코드 목록</CAPTION>
			<thead>
			<tr>
				<th class="title" width="5%" scope="col" nowrap>순번</th>
				<th class="title" width="18%" scope="col" nowrap>코드ID</th>
				<th class="title" width="*" scope="col" nowrap>코드ID명</th>
				<th class="title" width="10%" scope="col" nowrap>사용여부</th>
				<th class="title" width="10%" scope="col" nowrap>수정</th>
				<th class="title" width="10%" scope="col" nowrap>삭제</th>
			</tr>
			</thead>
			<tbody id="codeIdAddRowPoint">
			<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
			<tr>
				<c:set var="trNo" value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/>
				<td class="lt_text3" nowrap><input type="hidden" id="codeAA"><c:out value="${trNo}"/></td>
				<td class="lt_text3" nowrap id="codeB${trNo}" style="cursor:pointer;cursor:hand;" onclick="javascript:fnCmcodelist('${resultInfo.codeId}');">${resultInfo.codeId}</td>
				<td class="lt_text" nowrap id="codeC${trNo}">${fn:substring(resultInfo.codeIdNm,0,8)}</td>
				<td class="lt_text3" nowrap id="codeD${trNo}"><c:if test="${resultInfo.useAt == 'Y'}">사용</c:if><c:if test="${resultInfo.useAt == 'N'}">미사용</c:if></td>
				<td class="lt_text3" nowrap id="codeZ${trNo}" onclick="javascript:fnCodeIdEdit('${trNo}');">수정</td>
				<td class="lt_text3" nowrap id="codeX${trNo}" onclick="javascript:fnCodeIdSave('${trNo}');">삭제</td>
			</tr>
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}">
				<tr>
					<td class="lt_text3" colspan=5>
						<spring:message code="common.nodata.msg" />
					</td>
				</tr>
			</c:if>
			</tbody>
			</table>
		</div>
		<!-- 코드 리스트 E -->
		<!-- 상세코드 리스트 S -->
		<div style="float:left;width:830px;margin-left:20px;">
			<div id="divCodeList"></div>
		</div>
		<!-- 상세코드 리스트 E -->
	</div>
	
</div>
			</div>
		</section>

	</section>

<%@include file="../include/footer.jsp"%>