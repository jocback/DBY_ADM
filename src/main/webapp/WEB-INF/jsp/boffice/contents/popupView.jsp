<%@page contentType="text/html;charset=utf-8"%>
<%@include file="../include/header.jsp"%>
<%@ taglib prefix="ckeditor" uri="http://ckeditor.com" %>
<%pageContext.setAttribute("crlf", "\r\n"); %>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="popupManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript">
/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init_PopupManage(){

}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_save_PopupManage(){

	var varFrom = document.popupManageVO;

	if(confirm("<spring:message code="common.save.msg" />")){
		varFrom.action =  "<c:url value='/boffice/actPopup/updtPopup.do' />";
		if(!varFrom.popupId.value){
			varFrom.action =  "<c:url value='/boffice/actPopup/registPopup.do' />";
		}
		if(!validatePopupManageVO(varFrom)){
			return;
		}else{

			var ntceBgndeYYYMMDD = document.getElementById('ntceBgndeYYYMMDD').value;
			var ntceEnddeYYYMMDD = document.getElementById('ntceEnddeYYYMMDD').value;

			var iChkBeginDe = Number( ntceBgndeYYYMMDD.replaceAll("-","") );
			var iChkEndDe = Number( ntceEnddeYYYMMDD.replaceAll("-","") );

			if(iChkBeginDe > iChkEndDe || iChkEndDe < iChkBeginDe ){
				alert("게시시작일자는 게시종료일자 보다 클수 없고,\n게시종료일자는 게시시작일자 보다 작을수 없습니다. ");
				return;
			}

			varFrom.ntceBgnde.value = ntceBgndeYYYMMDD.replaceAll('-','') + document.getElementById('ntceBgndeHH').value +  document.getElementById('ntceBgndeMM').value;
			varFrom.ntceEndde.value = ntceEnddeYYYMMDD.replaceAll('-','') + document.getElementById('ntceEnddeHH').value +  document.getElementById('ntceEnddeMM').value;

			varFrom.submit();
		}
	}
}
/* ********************************************************
 * 삭제처리
 ******************************************************** */
function fn_egov_delete_PopupManage(){
	var vFrom = document.popupManageVO;
	if(confirm("삭제 하시겠습니까?")){
		vFrom.cmd.value = 'del';
		vFrom.action = "<c:url value='/boffice/actPopup/detailPopup.do' />";
		vFrom.submit();
	}else{
		vFrom.cmd.value = '';
	}
}
/* ********************************************************
* RADIO BOX VALUE FUNCTION
******************************************************** */
function fn_egov_RadioBoxValue(sbName)
{
	var FLength = document.getElementsByName(sbName).length;
	var FValue = "";
	for(var i=0; i < FLength; i++)
	{
		if(document.getElementsByName(sbName)[i].checked == true){
			FValue = document.getElementsByName(sbName)[i].value;
		}
	}
	return FValue;
}
/* ********************************************************
* SELECT BOX VALUE FUNCTION
******************************************************** */
function fn_egov_SelectBoxValue(sbName)
{
	var FValue = "";
	for(var i=0; i < document.getElementById(sbName).length; i++)
	{
		if(document.getElementById(sbName).options[i].selected == true){

			FValue=document.getElementById(sbName).options[i].value;
		}
	}

	return  FValue;
}
/* ********************************************************
* PROTOTYPE JS FUNCTION
******************************************************** */
String.prototype.trim = function(){
	return this.replace(/^\s+|\s+$/g, "");
}

String.prototype.replaceAll = function(src, repl){
	 var str = this;
	 if(src == repl){return str;}
	 while(str.indexOf(src) != -1) {
	 	str = str.replace(src, repl);
	 }
	 return str;
}
</script>

	<h2 class="blind">본문</h2>
		<!-- Container -->
		<div class="container sub" id="container">
			<form:form commandName="popupManageVO" name="popupManageVO" method="post" >
			<input name="searchCondition" type="hidden" value="<c:out value='${searchVO.searchCondition}'/>"/>
			<input name="searchKeyword" type="hidden" value="<c:out value='${searchVO.searchKeyword}'/>"/>
			<input name="pageIndex" type="hidden" value="1"/>
			<form:hidden path="ntceBgnde" />
			<form:hidden path="ntceEndde" />
			<input name="popupId" type="hidden" value="${popupManageVO.popupId}">
			<input name="cmd" type="hidden" value="<c:out value='save'/>"/>
			<input name="fileUrl" id="fileUrl" type="hidden" value="popup/popup"/>
			<div class="cont">
				<h3 class="tit2 mt_60">팝업관리</h3>
				
				<div class="writeType03 mt_50">
					<table>
						<caption class="blind">팝업 등록</caption>
						<colgroup>
							<col width="100px" />
							<col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th><label id="IdSiteGb">사이트구분</label></th>
							<td class="v3">
								<select name="siteGb" id="siteGb">
									<option value="">선택</option>
									<option value="11" <c:if test="${popupManageVO.siteGb eq '11'}">selected</c:if>>본관</option>
									<option value="12" <c:if test="${popupManageVO.siteGb eq '12'}">selected</c:if>>어린이기념관</option>
								</select>
							</td>
						</tr>
						<tr>
							<th><label id="IdPopupTitleNm">팝업창명</label></th>
							<td class="v3">
								<form:input path="popupTitleNm" size="73" cssClass="txaIpt" maxlength="255"/>
								<form:errors path="popupTitleNm" cssClass="error"/>
							</td>
						</tr>
						
						<tr>
							<th><label id="IdPopupWlc">팝업창위치</label></th>
							<td class="v3">
								   가로 : <form:input path="popupWlc" size="5" maxlength="10"/>&nbsp;&nbsp;&nbsp;
								   세로 : <form:input path="popupHlc" size="5" maxlength="10"/>
								<form:errors path="popupWlc" cssClass="error"/>
								<form:errors path="popupHlc" cssClass="error"/>
								
							</td>
						</tr>
						
						<tr>
							<th><label id="IdNtceBgndeYYYMMDD">팝업창사이즈</label></th>
							<td class="v3">
								WIDTH : <form:input path="popupWSize" size="5" maxlength="10"/>&nbsp;&nbsp;&nbsp;
								HEIGHT : <form:input path="popupHSize" size="5" maxlength="10"/>
								<form:errors path="popupWSize" cssClass="error"/>
								<form:errors path="popupHSize" cssClass="error"/>
								
							</td>
						</tr>
						
						<tr>
							<th><label id="IdNtceBgndeYYYMMDD1">게시 기간</label></th>
							<td class="v3">
								
								<input type="hidden" name="cal_url" id="cal_url" value="<c:url value='/sym/cal/EgovNormalCalPopup.do'/>" >
								<input type="text" name="ntceBgndeYYYMMDD" id="ntceBgndeYYYMMDD" value="<c:if test="${!empty popupManageVO.popupId}"><c:out value="${fn:substring(popupManageVO.ntceBgnde, 0, 4)}"/>-<c:out value="${fn:substring(popupManageVO.ntceBgnde, 4, 6)}"/>-<c:out value="${fn:substring(popupManageVO.ntceBgnde, 6, 8)}"/></c:if>" class="datePickerDate" style="width:108px;" maxlength="10" pattern="yyyy-mm-dd" readonly>
								<input type="hidden" name="ntceBgndeHH" id="ntceBgndeHH" value="00"/>
								<input type="hidden" name="ntceBgndeMM" id="ntceBgndeMM" value="00"/>
								~ 
								<input type="text" name="ntceEnddeYYYMMDD" id="ntceEnddeYYYMMDD" value="<c:if test="${!empty popupManageVO.popupId}"><c:out value="${fn:substring(popupManageVO.ntceEndde, 0, 4)}"/>-<c:out value="${fn:substring(popupManageVO.ntceEndde, 4, 6)}"/>-<c:out value="${fn:substring(popupManageVO.ntceEndde, 6, 8)}"/></c:if>" class="datePickerDate" style="width:108px;" maxlength="10" pattern="yyyy-mm-dd" readonly>
								<input type="hidden" name="ntceEnddeHH" id="ntceEnddeHH" value="24"/>
								<input type="hidden" name="ntceEnddeMM" id="ntceEnddeMM" value="60"/>
							</td>
						</tr>
						<tr>
							<th><label id="IdStopVewAt">그만보기 설정 여부</label></th>
							<td class="v3">
								<input type="radio" name="stopVewAt" value="Y" <c:if test="${popupManageVO.stopVewAt eq 'Y'}">checked</c:if>>Y
								<input type="radio" name="stopVewAt" value="N" <c:if test="${popupManageVO.stopVewAt eq 'N'}">checked</c:if>>N
							</td>
						</tr>
						<tr>
							<th><label id="IdStceAt">게시 상태</label></th>
							<td class="v3">
								<input type="radio" name="ntceAt" value="Y" <c:if test="${popupManageVO.ntceAt eq 'Y'}">checked</c:if>>Y
								<input type="radio" name="ntceAt" value="N" <c:if test="${popupManageVO.ntceAt eq 'N'}">checked</c:if>>N
							</td>
						</tr>
						<tr>
							<th><label id="IdPopupType">팝업형태</label></th>
							<td class="v3">
								<input type="radio" name="popupType" value="L" <c:if test="${popupManageVO.popupType eq 'L'}">checked</c:if>>레이어
								<input type="radio" name="popupType" value="W" <c:if test="${popupManageVO.popupType eq 'W'}">checked</c:if>>윈도우
							</td>
						</tr>
						<tr>
							<th><label id="IdPopupCn">내용</label></th>
							<td class="v3">
								<textarea name="popupCn" id="popupCn" cols="90" rows="10" style="width:578px;height:68px;"><c:out value="${popupManageVO.popupCn}" escapeXml="false" /></textarea>
							</td>
						</tr>
						</tbody>
					</table>

					<br/>
					<div class="ta_c">
						<a href="javascript:void(0);" class="btn_reg v2" onclick="fn_egov_save_PopupManage(); return false;">저장</a>
						<c:if test="${!empty popupManageVO.popupId}">
						<a href="javascript:void(0);" class="btn_reg v2" onclick="fn_egov_delete_PopupManage(); return false;">삭제</a>
						</c:if>
						<a href="/boffice/actPopup/listPopup.do" class="btn_reg v2">목록</a>
					</div>
				</div>

								

			</div>
			<!-- //cont -->
</form:form>
<ckeditor:replace replace="popupCn" basePath="${pageContext.request.contextPath}/html/egovframework/com/cmm/utl/ckeditor/" />
		</div>
		<!-- //Container -->

<%@include file="../include/footer.jsp"%>