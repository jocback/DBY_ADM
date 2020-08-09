<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/header.jsp"%>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<style type="text/css">
.writeType03 table th {padding-left:10px;}
.writeType03 table td {padding-left:10px;}

#sortWrap div {
	margin: 5px 0 5px 0;
	padding: 3px;
	background-color: #FFF;
	border: 1px solid #ddd;
	cursor: ns-resize;
}
#sortWrapHead {
	margin: 5px;
	padding: 3px;
	background-color: #EEE;
	border: 1px solid #ddd;
	color:#333;
}
#sortWrap td, #sortWrapHead td {
	text-align:center;
	font-size:14px;
	border-bottom:none;
}
</style>
<script type="text/javaScript">
/* ********************************************************
 * 조회 처리
 ******************************************************** */
function fnSearch(){
	document.listForm.pageIndex.value = 1;
   	document.listForm.submit();
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
	//var codeD = $("#codeD"+no).text();
	var codeE = $("#codeE"+no).text();
	$("#codeC"+no).empty();
	$("#codeC"+no).append("<input type='text' id='codename"+no+"' value='"+codeC+"' style='width:140px;'><input type='hidden' id='codeCOr"+no+"' value='"+codeC+"'>");
	//$("#codeD"+no).empty();
	//$("#codeD"+no).append("<input type='text' id='codeseq"+no+"' value='"+codeD+"' style='width:20px;'><input type='hidden' id='codeDOr"+no+"' value='"+codeD+"'>");
	$("#codeE"+no).empty();
	$("#codeE"+no).append("<select id='useYn"+no+"' style='width:60px;'><option value='Y'>사용</option><option value='N'>미사용</option></select><input type='hidden' id='codeEOr"+no+"' value='"+codeE+"'>");
	JqSelectTextOption("#useYn"+no,codeE);
	$("#codeZ"+no).text("취소");
	$("#codeX"+no).text("저장");
	$("#codeAA").val(no);
}
function fnCodeIdCancel(no){
	var codeC = $("#codeCOr"+no).val();
	//var codeD = $("#codeDOr"+no).val();
	var codeE = $("#codeEOr"+no).val();
	$("#codeC"+no).empty();
	$("#codeC"+no).text(codeC);
	//$("#codeD"+no).empty();
	//$("#codeD"+no).text(codeD);
	$("#codeE"+no).empty();
	$("#codeE"+no).text(codeE);
	$("#codeZ"+no).text("수정");
	$("#codeX"+no).text("삭제");
	$("#codeAA").val("");
}
function fnCodeIdAdd(codeGb){
	if($(".newCodeGb"+codeGb).size()>0){
		return;
	}
	var size1 = "<c:out value='${fn:length(resultList)}'/>";
	var size2 = "<c:out value='${fn:length(resultList2)}'/>";
	var sizeCnt = 0;
	if(codeGb == 'LE'){ sizeCnt = size1; }
	if(codeGb == 'CL'){ sizeCnt = size2; }
	sizeCnt = (sizeCnt*1)+1;
	var str = '<tr>' +
		'<td><input type="hidden" id="newCodeGb" class="newCodeGb'+codeGb+'" value="'+codeGb+'"><input type="text" id="newCodeNm" value="" style="width:140px;"></td>' +
		'<td><input type="text" id="newCodeSq" value="'+sizeCnt+'" style="width:30px;"></td>' +
		'<td><select id="newCodeUseYn" style="width:60px;"><option value="Y">사용</option><option value="N">미사용</option></select></td>' +
		'<td onclick="javascript:fnCodeIdAddSave(this);" style="cursor:pointer;" data-gb="'+codeGb+'">저장</td>' +
		'<td onclick="javascript:fnCodeIdAddCancel(this);" style="cursor:pointer;">취소</td>' +
		'</tr>';
	$("#codeIdAddRowPoint"+codeGb).prepend(str);
}
function fnCodeIdAddCancel(obj){
	$(obj).parent('tr').remove();
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fnCodeIdDelete(no){
	if(confirm("삭제하시겠습니까?")){
		var url = "<c:url value='/boffice/actLecture/actLecCodeSave.do' />";
		var param = {
			actListMode: "Del",
			codeId: $("#codeId"+no).val()
		};
		commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.');
		location.href="/boffice/actLecture/actLecCategory.do";
	}
}
function fnCodeIdAddSave(obj){
	var cdGb = $(obj).closest("tr").find("#newCodeGb").val();
	var cdGbNm = "직렬";
	if(cdGb=="CL") cdGbNm = "과목";
	if(!$(obj).closest("tr").find("#newCodeNm").val()){
		alert(cdGbNm+" 명을 입력하여 주세요");
		return;
	}
	if(confirm("저장하시겠습니까?")){
		var url = "<c:url value='/boffice/actLecture/actLecCodeSave.do' />";
		var param = {
			actListMode: "Add",
			codeGb: $(obj).closest("tr").find("#newCodeGb").val(),
			codeNm: $(obj).closest("tr").find("#newCodeNm").val(),
			codeDc: $(obj).closest("tr").find("#newCodeNm").val(),
			codeSq: $(obj).closest("tr").find("#newCodeSq").val(),
			useYn: $(obj).closest("tr").find("#newCodeUseYn option:selected").val()
		};
		commonUtil.AjaxSynCall(url,param,'text','등록되었습니다.');
		location.href="/boffice/actLecture/actLecCategory.do";
	}
}
function fnCodeIdModifySave(no){
	if(!$("#codename"+no).val()){
		alert("명칭을 입력하여 주세요");
		return;
	}
	if(confirm("저장하시겠습니까?")){
		var url = "<c:url value='/boffice/actLecture/actLecCodeSave.do' />";
		var param = {
			actListMode: "Modify",
			codeId: $("#codeId"+no).val(),
			codeNm: $("#codename"+no).val(),
			codeDc: $("#codename"+no).val(),
			codeSq: $("#codeseq"+no).val(),
			useYn: $("#useYn"+no+" option:selected").val()
		};
		commonUtil.AjaxSynCall(url,param,'text','수정되었습니다.');
		location.href="/boffice/actLecture/actLecCategory.do";
	}
}

//순서변경 기능--------------------------------------------------------------------------
function fnTranSeqAuto(cd){
	$("form[name='frmEquip"+cd+"'] input[name=codeSq]").each(function(idx,elem){
		$(this).val(idx+1);
	});
}
function fnTranSeqSave(cd){
	if(confirm("순서변경을 적용하시겠습니까?")){
		var formData = $("#frmEquip"+cd).serialize();
		var url = "<c:url value='/boffice/actLecture/updateActLecCodeSeq.do'/>";
		var param = formData;
		if(commonUtil.AjaxSynCall(url,param)=="success"){
			alert("수정되었습니다.");
			location.href="/boffice/actLecture/actLecCategory.do";
		}
	}
}

$(function() {
	$(".sortWrap").sortable({
		axis: "y",
		containment: "parent",
		update: function (event, ui) {
			var order = $(this).sortable('toArray', {
				attribute: 'data-order'
			});
			console.log(order);
		}
	});
});
</script>
<form name="cmmnCode" method="post">
	<input name="cmd" type="hidden" value="Modify">
	<input id="codeId" name="codeId" type="hidden"/>
	<input id="codeNm" name="codeNm" type="hidden"/>
	<input id="codeDc" name="codeDc" type="hidden"/>
	<input id="codeSq" name="codeSq" type="hidden"/>
	<input id="useYn" name="useYn" type="hidden"/>
</form>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>카테고리 관리</h3>
				<div class="btnWrap">
				</div>
			</div>
			<div class="realCont">
<div class="contents_zone" style="width:1250px;">
	
	<div style="width:1250px;text-align:left;overflow:hidden;">
		<!-- 직렬코드 리스트 S -->
		<div style="float:left;width:450px;">
			<div class="btnWrap" style="float:left;margin:0 0 5px 170px;font-size:16px;font-weight:bold;">
				직렬 카테고리
			</div>
			<div class="btnWrap" style="float:right;margin-bottom:5px;">
				<button type="button" class="colorBtn rightbluebtn" onClick="javascript:fnTranSeqAuto('LE');">순서자동입력</button>
				<button type="button" class="colorBtn rightbluebtn" onClick="javascript:fnTranSeqSave('LE');">순서변경적용</button>
				<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onClick="javascript:fnCodeIdAdd('LE'); return false;">등록</button>
			</div>
			<table style="width:450px;" class="commonTable detailTable">
			<CAPTION style="display: none;">카테고리 관리(직렬)</CAPTION>
			<thead>
			<tr>
				<th class="title" width="*" scope="col" nowrap>직렬 명</th>
				<th class="title" width="12%" scope="col" nowrap>순서</th>
				<th class="title" width="20%" scope="col" nowrap>사용여부</th>
				<th class="title" width="12%" scope="col" nowrap>수정</th>
				<th class="title" width="12%" scope="col" nowrap>삭제</th>
			</tr>
			</thead>
			<tbody id="codeIdAddRowPointLE">
			</tbody>
			</table>
			<form name="frmEquipLE" id="frmEquipLE" method="post">
			<div id="sortWrap" class="sortWrap">
			<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
				<div data-order=<c:out value="${status.index+1}"/>>
					<table class="commonTable" style="border:0;">
						<tr>
							<c:set var="trNo" value="${status.count}"/>
							<td style="display:none;"><input type="hidden" id="codeAA"><input type="hidden" name="codeId" id="codeId${trNo}" value="${resultInfo.codeId}"><c:out value="${trNo}"/></td>
							<td width="*" id="codeC${trNo}">${resultInfo.codeNm}</td>
							<td width="12%" id="codeD${trNo}"><input type="text" id="codeseq${trNo}" name="codeSq" value="<c:out value='${resultInfo.codeSq}'/>" style="width:20px;"></td>
							<td width="20%" id="codeE${trNo}"><c:if test="${resultInfo.useYn == 'Y'}">사용</c:if><c:if test="${resultInfo.useYn == 'N'}">미사용</c:if></td>
							<td width="12%" id="codeZ${trNo}" onclick="javascript:fnCodeIdEdit('${trNo}');" style="cursor:pointer;">수정</td>
							<td width="12%" id="codeX${trNo}" onclick="javascript:fnCodeIdSave('${trNo}');" style="cursor:pointer;">삭제</td>
						</tr>
					</table>
				</div>
			</c:forEach>
			</div>
			</form>
			<c:if test="${fn:length(resultList) == 0}">
			<table>
			<tbody>
				<tr>
					<td class="lt_text3" colspan=5>
						데이타가 없습니다.
					</td>
				</tr>
			</tbody>
			</table>
			</c:if>
		</div>
		<!-- 직렬코드 리스트 E -->
		<!-- 과목코드 리스트 S -->
		<div style="float:left;width:450px;margin-left:20px;">
			<div class="btnWrap" style="float:left;margin:0 0 5px 170px;font-size:16px;font-weight:bold;">
				과목 카테고리
			</div>
			<div class="btnWrap" style="float:right;margin-bottom:5px;">
				<button type="button" class="colorBtn rightbluebtn" onClick="javascript:fnTranSeqAuto('CL');">순서자동입력</button>
				<button type="button" class="colorBtn rightbluebtn" onClick="javascript:fnTranSeqSave('CL');">순서변경적용</button>
				<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onClick="javascript:fnCodeIdAdd('CL'); return false;">등록</button>
			</div>
			<table style="width:450px;" class="commonTable detailTable">
			<thead>
			<tr>
				<th class="title" width="*" scope="col" nowrap>과목 명</th>
				<th class="title" width="12%" scope="col" nowrap>순서</th>
				<th class="title" width="20%" scope="col" nowrap>사용여부</th>
				<th class="title" width="12%" scope="col" nowrap>수정</th>
				<th class="title" width="12%" scope="col" nowrap>삭제</th>
			</tr>
			</thead>
			<tbody id="codeIdAddRowPointCL">
			</tbody>
			</table>
			<form name="frmEquipCL" id="frmEquipCL" method="post">
			<div id="sortWrap" class="sortWrap">
			<c:forEach items="${resultList2}" var="resultInfo2" varStatus="status">
				<div data-order=<c:out value="${status.index+10000}"/>>
					<table class="commonTable" style="border:0;">
						<tr>
							<c:set var="trNo" value="${status.count+10000}"/>
							<td style="display:none;"><input type="hidden" id="codeAA"><input type="hidden" name="codeId" id="codeId${trNo}" value="${resultInfo2.codeId}"><c:out value="${trNo}"/></td>
							<td width="*" id="codeC${trNo}">${resultInfo2.codeNm}</td>
							<td width="12%" id="codeD${trNo}"><input type="text" id="codeseq${trNo}" name="codeSq" value="<c:out value='${resultInfo2.codeSq}'/>" style="width:20px;"></td>
							<td width="20%" id="codeE${trNo}"><c:if test="${resultInfo2.useYn == 'Y'}">사용</c:if><c:if test="${resultInfo2.useYn == 'N'}">미사용</c:if></td>
							<td width="12%" id="codeZ${trNo}" onclick="javascript:fnCodeIdEdit('${trNo}');" style="cursor:pointer;">수정</td>
							<td width="12%" id="codeX${trNo}" onclick="javascript:fnCodeIdSave('${trNo}');" style="cursor:pointer;">삭제</td>
						</tr>
					</table>
				</div>
			</c:forEach>
			</div>
			</form>
			<c:if test="${fn:length(resultList2) == 0}">
			<table>
			<tbody>
				<tr>
					<td class="lt_text3" colspan=5>
						데이타가 없습니다.
					</td>
				</tr>
			</tbody>
			</table>
			</c:if>
		</div>
		<!-- 과목코드 리스트 E -->
	</div>
	
</div>
			</div>
		</section>

	</section>

<%@include file="../include/footer.jsp"%>