<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/header.jsp"%>
<%
pageContext.setAttribute("CR", "\r");
pageContext.setAttribute("LF", "\n");
pageContext.setAttribute("CRLF", "\r\n");
pageContext.setAttribute("SP", "&nbsp;");
pageContext.setAttribute("BR", "<br/>");
%> 
<script type="text/javaScript">
$(document).ready(function(){
	fn_egov_init_PopupManage();
});
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/boffice/actPopup/listPopup.do'/>";
   	document.listForm.submit();
}
/* ********************************************************
 * 등록 처리 함수
 ******************************************************** */
function fn_egov_regist_PopupManage(){
	location.href = "<c:url value='/boffice/actPopup/registPopup.do' />";
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_detail_PopupManage(popupId){
	var vFrom = document.listForm;
	vFrom.popupId.value = popupId;
	vFrom.action = "<c:url value='/boffice/actPopup/detailPopup.do' />";
	vFrom.submit();
}

/* ********************************************************
 * 검색 함수
 ******************************************************** */
function fn_egov_search_PopupManage(){
	var vFrom = document.listForm;

	vFrom.action = "<c:url value='/boffice/actPopup/listPopup.do' />";
	vFrom.submit();

}
/* ********************************************************
* 체크 박스 선택 함수
******************************************************** */
function fn_egov_checkAll_PopupManage(){

	var FLength = document.getElementsByName("checkList").length;
	var checkAllValue = document.getElementById('checkAll').checked;
	//undefined
	if( FLength == 1){
		document.getElementById("checkList").checked = checkAllValue;
	}{
			for(var i=0; i < FLength; i++)
			{
				document.getElementsByName("checkList")[i].checked = checkAllValue;
			}
		}

}
/* ********************************************************
* 팝업창 미리보기
******************************************************** */
function fn_egov_view_PopupManage(){


	var FLength = document.getElementsByName("checkList").length;

	for(var i=0; i < FLength; i++)
	{
		if(document.getElementsByName("checkList")[i].checked == true){
			fn_egov_ajaxPopupInfo_PopupManage( document.getElementsByName("checkList")[i].value );
		}
	}

	return;

}
/* ********************************************************
* 팝업창 정보 Ajax통신으로 정보 획득
******************************************************** */
function fn_egov_ajaxPopupInfo_PopupManage(popupIds){
	var url = "<c:url value='/uss/ion/pwn/ajaxPopupManageInfo.do' />";

	var param = {
			popupId: popupIds
	};

	new Ajax.Request(url,
   {
     asynchronous:true,
     method:"post",
     parameters: param ,
     evalJSON:     false,
     evalJS:       false,
    onLoading  : function() {/*로딩중*/ },
    onSuccess  : function(returnValue)
    {
    	var returnValueArr = returnValue.responseText.split("||");


    	//if(fnGetCookie(popupIds) == null ){
    	   	fn_egov_popupOpen_PopupManage(popupIds,
        	    	returnValueArr[0],
        	    	returnValueArr[1],
        	    	returnValueArr[2],
        	    	returnValueArr[4],
        	    	returnValueArr[3],
        	    	returnValueArr[5]);
    	//}

    },
    onFailure: function() {/*불러오기 실패*/},
    onComplete : function() {/*모든 것을 완료*/}
   });
}
/* ********************************************************
* 팝업창  오픈
******************************************************** */
function fn_egov_init_PopupManage(){
	<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
	<c:if test="${resultInfo.ntceAt eq 'Y'}">
	if(fnGetCookie('${resultInfo.popupId}') == null ){
	 	fn_egov_popupOpen_PopupManage('${resultInfo.popupId}',
	 			'${resultInfo.fileUrl}',
	 			'${resultInfo.popupWidthSize}',
    	    	'${resultInfo.popupVrticlSize}',
    	    	'${resultInfo.popupVrticlLc}',
    	    	'${resultInfo.popupWidthLc}',
    	    	'${resultInfo.stopvewSetupAt}');
	}
	</c:if>
	</c:forEach>
}
/* ********************************************************
* 팝업창  오픈
******************************************************** */
function fn_egov_popupOpen_PopupManage(popupId,fileUrl,width,height,top,left,stopVewAt){

	var url = "<c:url value='/boffice/actPopup/openPopupManage.do' />?";
	url = url + "fileUrl=" + fileUrl;
	url = url + "&stopVewAt=" + stopVewAt;
	url = url + "&popupId=" + popupId;
	var name = popupId;
	var openWindows = window.open(url,name,"width="+width+",height="+height+",top="+top+",left="+left+",toolbar=no,status=no,location=no,scrollbars=yes,menubar=no,resizable=yes");

	if (window.focus) {openWindows.focus()}
}

/* ********************************************************
* 팝업창  오픈 쿠키 정보 OPEN
******************************************************** */
function fnGetCookie(name) {
	  var prefix = name + "=";

	  var cookieStartIndex = document.cookie.indexOf(prefix);
	  if (cookieStartIndex == -1) return null;
	  var cookieEndIndex = document.cookie.indexOf(";", cookieStartIndex + prefix.length);
	  if (cookieEndIndex == -1) cookieEndIndex = document.cookie.length;


	  return unescape(document.cookie.substring(cookieStartIndex + prefix.length, cookieEndIndex));
}

</script>
</head>

	<h2 class="blind">본문</h2>
		<!-- Container -->
		<div class="container sub" id="container">
			<div class="cont">
				<h3 class="tit2 mt_60">팝업 관리</h3>

				<div class="clear">
					<div class="ask fl_l">총 <span><c:out value='${resultCnt}'/></span> 건의 게시글</div>
				</div>

				<!-- listType05 -->
				<div class="listType05 mt_10 accordion">
					<table>
						<caption class="blind">팝업 목록</caption>
						<colgroup>
							<col width="60px" />
							<col width="*" />
							<col width="180px" />
							<col width="210px" />
							<col width="80px" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col" class="first_line">번호</th>
								<th scope="col" class="first_line">제목</th>
								<th scope="col" class="first_line">게시일</th>
								<th scope="col" class="first_line">파일URL</th>
								<th scope="col" class="first_line">게시상태</th>
							</tr>

							<c:set var="listCount" value="0"/>
							<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
							<c:set var="listCount" value="${listCount+1}"/>
							<tr>
								<td class="lt_text3" nowrap><c:out value="${(popupManageVO.pageIndex-1) * popupManageVO.pageSize + status.count}"/></td>
								<td class="lt_text3L">
									<div class="divDotText" style="width:200px; border:solid 0px;">
									<c:out value="${resultInfo.popupTitleNm}"/>
									</div>
								</td>
								<td class="lt_text3">
									<c:out value="${fn:substring(resultInfo.ntceBgnde, 0, 4)}"/>-<c:out value="${fn:substring(resultInfo.ntceBgnde, 4, 6)}"/>-<c:out value="${fn:substring(resultInfo.ntceBgnde, 6, 8)}"/> <c:out value="${fn:substring(resultInfo.ntceBgnde, 8, 10)}"/>H <c:out value="${fn:substring(resultInfo.ntceBgnde, 10, 12)}"/>M
									~
									<c:out value="${fn:substring(resultInfo.ntceEndde, 0, 4)}"/>-<c:out value="${fn:substring(resultInfo.ntceEndde, 4, 6)}"/>-<c:out value="${fn:substring(resultInfo.ntceEndde, 6, 8)}"/> <c:out value="${fn:substring(resultInfo.ntceEndde, 8, 10)}"/>H <c:out value="${fn:substring(resultInfo.ntceEndde, 10, 12)}"/>M
								<td class="lt_text3L" nowrap>
									<c:out value="${resultInfo.fileUrl}"/>
								</td>
								<td class="lt_text3">
									<c:out value="${resultInfo.ntceAt}"/>
								</td>
							</tr>
							</c:forEach>
														
						</tbody>
					</table>
				</div>
				<!-- //listType05 -->

			</div>
			<!-- //cont -->
		</div>
		<!-- //Container -->

<%@include file="../include/footer.jsp"%>