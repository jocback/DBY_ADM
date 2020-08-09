<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javaScript">
/* ********************************************************
 * 조회 처리
 ******************************************************** */
function fnSearch(){
	document.listForm.pageIndex.value = 1;
   	document.listForm.submit();
}
function fnCodenEdit(no){
	$("#codenZ"+no).text()=="수정" ? fnCodenModify(no) : fnCodenCancel(no);
}
function fnCodenSave(no){
	$("#codenX"+no).text()=="저장" ? fnCodenModifySave(no) : fnCodenDelete(no);
}
function fnCodenModify(no){
	fnCodenCancel($("#codenAA").val());
	var codenC = $("#codenC"+no).text();
	var codenD = $("#codenD"+no).text();
	var codenE = $("#codenE"+no).text();
	var codenF = $("#codenF"+no).text();
	var codenH = $("#codenH"+no).text();
	var codenG = $("#codenG"+no).text();
	$("#codenC"+no).empty();
	$("#codenC"+no).append("<input type='text' id='ncodename"+no+"' value='"+codenC+"' style='width:110px;'><input type='hidden' id='codenCOr"+no+"' value='"+codenC+"'>");
	$("#codenD"+no).empty();
	$("#codenD"+no).append("<select id='nuseAt"+no+"' style='width:56px;'><option value='Y'>사용</option><option value='N'>미사용</option></select><input type='hidden' id='codenDOr"+no+"' value='"+codenD+"'>");
	JqSelectTextOption("#nuseAt"+no,codenD);
	$("#codenE"+no).empty();
	$("#codenE"+no).append("<input type='text' id='ncodeetc1"+no+"' value='"+codenE+"' style='width:100px;'><input type='hidden' id='codenEOr"+no+"' value='"+codenE+"'>");
	$("#codenF"+no).empty();
	$("#codenF"+no).append("<input type='text' id='ncodeetc2"+no+"' value='"+codenF+"' style='width:100px;'><input type='hidden' id='codenFOr"+no+"' value='"+codenF+"'>");
	$("#codenH"+no).empty();
	$("#codenH"+no).append("<input type='text' id='ncodeetc3"+no+"' value='"+codenH+"' style='width:100px;'><input type='hidden' id='codenHOr"+no+"' value='"+codenH+"'>");
	$("#codenG"+no).empty();
	$("#codenG"+no).append("<input type='text' id='nseq"+no+"' value='"+codenG+"' style='width:40px;'><input type='hidden' id='codenGOr"+no+"' value='"+codenG+"'>");
	$("#codenZ"+no).text("취소");
	$("#codenX"+no).text("저장");
	$("#codenAA").val(no);
}
function fnCodenCancel(no){
	var codenC = $("#codenCOr"+no).val();
	var codenD = $("#codenDOr"+no).val();
	var codenE = $("#codenEOr"+no).val();
	var codenF = $("#codenFOr"+no).val();
	var codenH = $("#codenHOr"+no).val();
	var codenG = $("#codenGOr"+no).val();
	$("#codenC"+no).empty();
	$("#codenC"+no).text(codenC);
	$("#codenD"+no).empty();
	$("#codenD"+no).text(codenD);
	$("#codenE"+no).empty();
	$("#codenE"+no).text(codenE);
	$("#codenF"+no).empty();
	$("#codenF"+no).text(codenF);
	$("#codenH"+no).empty();
	$("#codenH"+no).text(codenH);
	$("#codenG"+no).empty();
	$("#codenG"+no).text(codenG);
	$("#codenZ"+no).text("수정");
	$("#codenX"+no).text("삭제");
	$("#codenAA").val("");
}
function fnCodeAdd(){
	if($("#newCode").size()>0){
		return;
	}
	var str = '<tr><td class="lt_text3" nowrap></td>' +
		'<td class="lt_text" nowrap>'+cmmnDetailCode.codeId.value+'</td>' +
		'<td class="lt_text" nowrap><input type="text" id="newCode" value="<c:out value="${newCode}"/>" style="width:40px;"></td>' +
		'<td class="lt_text" nowrap><input type="text" id="newCodeNm" value="" style="width:110px;"></td>' +
		'<td class="lt_text" nowrap><input type="text" id="newSeq" value="" style="width:40px;"></td>' +
		'<td class="lt_text3" nowrap><select id="newCodeUseYn" style="width:56px;"><option value="Y">사용</option><option value="N">미사용</option></select></td>' +
		'<td class="lt_text" nowrap><input type="text" id="newCodeEtc1" value="" style="width:100px;"></td>' +
		'<td class="lt_text" nowrap><input type="text" id="newCodeEtc2" value="" style="width:100px;"></td>' +
		'<td class="lt_text" nowrap><input type="text" id="newCodeEtc3" value="" style="width:100px;"></td>' +
		'<td class="lt_text3" nowrap onclick="javascript:fnCodenAddSave();" style="cursor:pointer;">저장</td>' +
		'<td class="lt_text3" nowrap onclick="javascript:fnCodenAddCancel(this);" style="cursor:pointer;">취소</td>' +
		'</tr>';
	$("#addRowPoint").prepend(str);
}
function fnCodenAddCancel(obj){
	$(obj).parent('tr').remove();
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fnCodenDelete(no){
	var codenB = $("#codenB"+no).text();
	if(confirm("삭제하시겠습니까?")){
		var url = "<c:url value='/boffice/actCode/cmdCodeSave.do' />";
		var param = {
			cmd: "Del",
			codeId: cmmnDetailCode.codeId.value,
			code: codenB
		};
		commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.');
		fnCmcodelist(cmmnDetailCode.codeId.value);
	}
}
function fnCodenAddSave(no){
	if(!cmmnDetailCode.codeId.value){
		alert("상위코드값이 없습니다. 상위코드를 먼저 선택하여 주세요.");
		return;
	}
	if(!$("#newCode").val()){
		alert("코드를 입력하여 주세요");
		return;
	}
	if(!$("#newCodeNm").val()){
		alert("코드명을 입력하여 주세요");
		return;
	}
	if(confirm("<spring:message code='common.save.msg'/>")){
		var url = "<c:url value='/boffice/actCode/cmdCodeSave.do' />";
		var param = {
			cmd: "Add",
			codeId: cmmnDetailCode.codeId.value,
			code: $("#newCode").val(),
			codeNm: $("#newCodeNm").val(),
			codeDc: $("#newCodeNm").val(),
			seq: $("#newSeq").val(),
			codeEtc1: $("#newCodeEtc1").val(),
			codeEtc2: $("#newCodeEtc2").val(),
			codeEtc3: $("#newCodeEtc3").val(),
			useAt: $("#newCodeUseYn option:selected").val()
		};
		commonUtil.AjaxSynCall(url,param,'text','등록되었습니다.');
		fnCmcodelist(cmmnDetailCode.codeId.value);
	}
}
function fnCodenModifySave(no){
	//var frm = document.cmmnDetailCode;
	if(!$("#ncodename"+no).val()){
		alert("코드명을 입력하여 주세요");
		return;
	}
	if(confirm("<spring:message code='common.save.msg'/>")){
		var url = "<c:url value='/boffice/actCode/cmdCodeSave.do' />";
		var param = {
			cmd: "Modify",
			codeId: $("#codenA"+no).text(),
			code: $("#codenB"+no).text(),
			codeNm: $("#ncodename"+no).val(),
			codeDc: $("#ncodename"+no).val(),
			seq: $("#nseq"+no).val(),
			codeEtc1: $("#ncodeetc1"+no).val(),
			codeEtc2: $("#ncodeetc2"+no).val(),
			codeEtc3: $("#ncodeetc3"+no).val(),
			useAt: $("#nuseAt"+no+" option:selected").val()
		};
		commonUtil.AjaxSynCall(url,param,'text','수정되었습니다.');
		fnCmcodelist($("#codenA"+no).text());
	}
}
</script>
	<form id="cmmnDetailCode" name="cmmnDetailCode" method="post">
		<input name="cmd" type="hidden" value="Modify">
		<input name="codeId" type="hidden">
		<input name="code" type="hidden">
		<input name="codeNm" type="hidden">
		<input name="codeDc" type="hidden">
		<input name="seq" type="hidden">
		<input name="codeEtc1" type="hidden">
		<input name="codeEtc2" type="hidden">
		<input name="codeEtc3" type="hidden">
		<input name="useAt" type="hidden">
	</form>
	<div class="btnWrap" style="float:right;margin-bottom:5px;">
		<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onClick="javascript:fnCodeAdd();">등록</button>
	</div>
	<table style="table-layout:fixed;width:820px;" class="commonTable detailTable" summary="코드ID, 코드, 코드명, 사용여부를 나타내는 공통상세코드 목록 테이블이다.">
	<CAPTION style="display: none;">공통상세코드 목록</CAPTION>
	<thead>
	<tr>
		<th class="title" width="4%" scope="col" nowrap>순번</th>
		<th class="title" width="8%" scope="col" nowrap>코드ID</th>
		<th class="title" width="5%" scope="col" nowrap>코드</th>
		<th class="title" width="*" scope="col" nowrap>코드명</th>
		<th class="title" width="7%" scope="col" nowrap>순서</th>
		<th class="title" width="9%" scope="col" nowrap>사용여부</th>
		<th class="title" width="14%" scope="col" nowrap>ETC1</th>
		<th class="title" width="14%" scope="col" nowrap>ETC2</th>
		<th class="title" width="14%" scope="col" nowrap>ETC3</th>
		<th class="title" width="5%" scope="col" nowrap>수정</th>
		<th class="title" width="5%" scope="col" nowrap>삭제</th>
	</tr>
	</thead>
	<tbody id="addRowPoint">
	<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
	<tr>
		<c:set var="trNo" value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/>
		<td class="lt_text3" nowrap><input type="hidden" id="codenAA"><c:out value="${trNo}"/></td>
		<td class="lt_text" nowrap id="codenA${trNo}">${resultInfo.codeId}</td>
		<td class="lt_text" nowrap id="codenB${trNo}">${resultInfo.code}</td>
		<td class="lt_text" nowrap id="codenC${trNo}">${resultInfo.codeNm}</td>
		<td class="lt_text" nowrap id="codenG${trNo}">${resultInfo.seq}</td>
		<td class="lt_text3" nowrap id="codenD${trNo}"><c:if test="${resultInfo.useAt == 'Y'}">사용</c:if><c:if test="${resultInfo.useAt == 'N'}">미사용</c:if></td>
		<td class="lt_text" nowrap id="codenE${trNo}" style="overflow:hidden;">${resultInfo.codeEtc1}</td>
		<td class="lt_text" nowrap id="codenF${trNo}" style="overflow:hidden;">${resultInfo.codeEtc2}</td>
		<td class="lt_text" nowrap id="codenH${trNo}" style="overflow:hidden;">${resultInfo.codeEtc3}</td>
		<td class="lt_text3" nowrap id="codenZ${trNo}" onclick="javascript:fnCodenEdit('${trNo}');" style="cursor:pointer;">수정</td>
		<td class="lt_text3" nowrap id="codenX${trNo}" onclick="javascript:fnCodenSave('${trNo}');" style="cursor:pointer;">삭제</td>
	</tr>
	</c:forEach>
	<c:if test="${fn:length(resultList) == 0}">
		<tr>
			<td class="lt_text3" colspan=11>
				<spring:message code="common.nodata.msg" />
			</td>
		</tr>
	</c:if>
	</tbody>
	</table>
