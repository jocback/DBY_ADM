<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/header.jsp"%>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="cmmnCode" staticJavascript="false" xhtml="true" cdata="false"/>
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
	var codeEtc1Clone = $("#codeEtc1Option").html();
	$("#codenC"+no).empty();
	$("#codenC"+no).append("<input type='text' id='ncodename"+no+"' value='"+codenC+"' style='width:110px;'><input type='hidden' id='codenCOr"+no+"' value='"+codenC+"'>");
	$("#codenD"+no).empty();
	$("#codenD"+no).append("<select id='nuseAt"+no+"' style='width:56px;'><option value='Y'>사용</option><option value='N'>미사용</option></select><input type='hidden' id='codenDOr"+no+"' value='"+codenD+"'>");
	JqSelectTextOption("#nuseAt"+no,codenD);
	$("#codenE"+no).empty();
	$("#codenE"+no).append("<select id='ncodeetc1"+no+"'>"+codeEtc1Clone+"</select><input type='hidden' id='codenEOr"+no+"' value='"+codenE+"'>");
	JqSelectTextOption("#ncodeetc1"+no,codenE);
	$("#codenF"+no).empty();
	$("#codenF"+no).append("<input type='text' id='ncodeetc2"+no+"' value='"+codenF+"' style='width:250px;'><input type='hidden' id='codenFOr"+no+"' value='"+codenF+"'>");
	$("#codenZ"+no).text("취소");
	$("#codenX"+no).text("저장");
	$("#codenAA").val(no);
}
function fnCodenCancel(no){
	var codenC = $("#codenCOr"+no).val();
	var codenD = $("#codenDOr"+no).val();
	var codenE = $("#codenEOr"+no).val();
	var codenF = $("#codenFOr"+no).val();
	$("#codenC"+no).empty();
	$("#codenC"+no).text(codenC);
	$("#codenD"+no).empty();
	$("#codenD"+no).text(codenD);
	$("#codenE"+no).empty();
	$("#codenE"+no).text(codenE);
	$("#codenF"+no).empty();
	$("#codenF"+no).text(codenF);
	$("#codenZ"+no).text("수정");
	$("#codenX"+no).text("삭제");
	$("#codenAA").val("");
}
function fnCodeAdd(){
	if($("#newCode").size()>0){
		return;
	}
	var codeEtc1Clone = $("#codeEtc1Option").html();
	var str = '<tr><td class="lt_text3" nowrap></td>' +
		'<td class="lt_text" nowrap>'+cmmnDetailCode.codeId.value+'</td>' +
		'<td class="lt_text" nowrap><input type="text" id="newCode" value="<c:out value="${newCode}"/>" style="width:70px;"></td>' +
		'<td class="lt_text" nowrap><input type="text" id="newCodeNm" value="" style="width:110px;"></td>' +
		'<td class="lt_text3" nowrap><select id="newCodeUseYn" style="width:56px;"><option value="Y">사용</option><option value="N">미사용</option></select></td>' +
		'<td class="lt_text" nowrap><select id="newCodeEtc1">'+codeEtc1Clone+'</select></td>' +
		'<td class="lt_text" nowrap><input type="text" id="newCodeEtc2" value="" style="width:250px;"></td>' +
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
		alert("일련번호를 입력하여 주세요");
		return;
	}
	if(!$("#newCodeNm").val()){
		alert("담당자명을 입력하여 주세요");
		return;
	}
	if(!$("#newCodeEtc2").val()){
		alert("담당자이메일을 입력하여 주세요");
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
			useAt: $("#nuseAt"+no+" option:selected").val()
		};
		commonUtil.AjaxSynCall(url,param,'text','수정되었습니다.');
		fnCmcodelist($("#codenA"+no).text());
	}
}
function fnCmcodelist(codeId){
	location.href="<c:url value='/boffice/actCode/actMailCodeSet.do' />";
}

</script>
	<form id="cmmnDetailCode" name="cmmnDetailCode" method="post">
		<input name="cmd" type="hidden" value="Modify">
		<input id="clCode" name="clCode" value="LET" type="hidden"/>
		<input name="codeId" type="hidden" value="<c:out value='${searchVO.searchKeyword}'/>">
		<input name="code" type="hidden">
		<input name="codeNm" type="hidden">
		<input name="codeDc" type="hidden">
		<input name="seq" type="hidden">
		<input name="codeEtc1" type="hidden">
		<input name="codeEtc2" type="hidden">
		<input name="useAt" type="hidden">
	</form>

	<h2 class="blind">본문</h2>
		<!-- Container -->
		<div class="container sub" id="container">
		
			<h3 class="cont tit2 mt_60">메일대상 관리</h3>

			<div class="cont">

				<div class="sch_list v2">
					<select name="codeEtc1Option" id="codeEtc1Option" style="visibility:hidden;">
						<c:forEach var="codeResult64" items="${codeResult64}" varStatus="status">
						<option value='<c:out value="${codeResult64.codeEtc1}"/>'><c:out value="${codeResult64.codeNm}"/></option>
						</c:forEach>
					</select>
					<a href="javascript:void(0);" class="button_v2" onClick="javascript:fnCodeAdd();"><span>신규등록</span></a>
				</div>

				<div class="ask mt_50">총 <span><c:out value="${resultList.size()}"/></span>건</div>

				<!-- listType05 -->
				<div class="listType05 mt_15">
					<table>
	<thead>
	<tr>
		<th class="title" width="4%" scope="col" nowrap>순번</th>
		<th class="title" width="9%" scope="col" nowrap>코드ID</th>
		<th class="title" width="10%" scope="col" nowrap>일련번호</th>
		<th class="title" width="15%" scope="col" nowrap>담당자명</th>
		<th class="title" width="10%" scope="col" nowrap>사용여부</th>
		<th class="title" width="10%" scope="col" nowrap>카테고리</th>
		<th class="title" width="*" scope="col" nowrap>담당자이메일</th>
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
		<td class="lt_text3" nowrap id="codenD${trNo}"><c:if test="${resultInfo.useAt == 'Y'}">사용</c:if><c:if test="${resultInfo.useAt == 'N'}">미사용</c:if></td>
		<td class="lt_text" nowrap id="codenE${trNo}" style="overflow:hidden;"></td>
		<td class="lt_text" nowrap id="codenF${trNo}" style="overflow:hidden;">${resultInfo.codeEtc2}</td>
		<td class="lt_text3" nowrap id="codenZ${trNo}" onclick="javascript:fnCodenEdit('${trNo}');" style="cursor:pointer;">수정</td>
		<td class="lt_text3" nowrap id="codenX${trNo}" onclick="javascript:fnCodenSave('${trNo}');" style="cursor:pointer;">삭제</td>
	</tr>
	<script type="text/javascript">$("#codenE<c:out value='${trNo}'/>").html($("#codeEtc1Option option[value='<c:out value="${resultInfo.codeEtc1}"/>']").text());</script>
	</c:forEach>
	<c:if test="${fn:length(resultList) == 0}">
		<tr>
			<td class="lt_text3" colspan=9>
				<spring:message code="common.nodata.msg" />
			</td>
		</tr>
	</c:if>
	</tbody>
					</table>
				</div>
				<!-- //listType05 -->

			</div>
			<!-- //cont -->

		</div>
		<!-- //Container -->

<%@include file="../include/footer.jsp"%>