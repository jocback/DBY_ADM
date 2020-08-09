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
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************* */
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
	vFrom.action = "<c:url value='/boffice/actPopup/updtPopup.do' />";
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
 * 삭제처리
 ******************************************************** */
function fn_egov_delete_PopupManage(id){
	var vFrom = document.listForm;
	if(confirm("삭제 하시겠습니까?")){
		vFrom.cmd.value = 'del';
		vFrom.popupId.value = id;
		vFrom.action = "<c:url value='/boffice/actPopup/detailPopup.do' />";
		vFrom.submit();
	}
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

	if( FLength == 1){
		if(document.getElementById("checkList").checked == true){
			fn_egov_ajaxPopupInfo_PopupManage( document.getElementById("checkList").value );
		}
	}{
		for(var i=0; i < FLength; i++)
		{
			if(document.getElementsByName("checkList")[i].checked == true){
				fn_egov_ajaxPopupInfo_PopupManage( document.getElementsByName("checkList")[i].value );
			}
		}
	}
	return;

}
/* ********************************************************
* 팝업창 정보 Ajax통신으로 정보 획득
******************************************************** */
function fn_egov_ajaxPopupInfo_PopupManage(popupIds){
	var url = "<c:url value='/boffice/actPopup/ajaxPopupManageInfo.do' />";

	var param = {
			popupId: popupIds
	};

	new $.ajax(url,
			   {
			     asynchronous:true,
			     method:"post",
			     data: param ,
			     evalJSON:     false,
			     evalJS:       false,
			    onLoading  : function() {/*로딩중*/ },
			    success  : function(returnValue)
			    {
			    	var returnValueArr = returnValue.split("||");

			    	//if(fnGetCookie(popupIds) == null ){
			    	   	fn_egov_popupOpen_PopupManage(popupIds,
			        	    	returnValueArr[0],
			        	    	returnValueArr[1],
			        	    	returnValueArr[2],
			        	    	returnValueArr[3],
			        	    	returnValueArr[4],
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
function fn_egov_popupOpen_PopupManage(popupId,fileUrl,width,height,top,left,stopVewAt){
	var url = "<c:url value='/boffice/actPopup/openPopupManage.do' />?";
	url = url + "fileUrl=" + fileUrl;
	url = url + "&stopVewAt=" + stopVewAt;
	url = url + "&popupId=" + popupId;
	var name = popupId;
	var openWindows = window.open(url,name,"width="+width+",height="+height+",top="+top+",left="+left+",toolbar=no,status=no,location=no,scrollbars=auto,menubar=no,resizable=yes");

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
					<div class="schWrap mt_20 fl_r">
					<form name="listForm" action="<c:url value='/boffice/actPopup/listPopup.do'/>" method="post">
						<input type="hidden" name="cmd" id="cmd"/>
						<select name="searchCondition">
							<option value='POPUP_SJ_NM' <c:if test="${searchCondition == 'POPUP_SJ_NM'}">selected</c:if>>팝업창명</option>
							<option value='FILE_URL' <c:if test="${searchCondition == 'FILE_URL'}">selected</c:if>>팝업창URL</option>
						</select>
						<input type="text" name="searchKeyword" id="searchKeyword" class="sch_text" value='<c:out value="${searchVO.searchKeyword}"/>' maxlength="35" onkeypress="press(event);">
						<a href="javascript:void(0);" class="btn_css" onclick="fnListFaq(); return false;">
							<img src="/images/boffice/board/btn_search.jpg" alt="검색" />
						</a>
						<input name="popupId" type="hidden" value="">
						<input name="pageIndex" type="hidden" value="<c:out value='${popupManageVO.pageIndex}'/>"/>
					</form>
					</div>
					<div class="ask fl_l">총 <span><c:out value='${resultCnt}'/></span> 건의 게시글</div>
				</div>

				<!-- listType05 -->
				<div class="listType05 mt_10 accordion">
					<table>
						<caption class="blind">팝업 목록</caption>
						<colgroup>
							<col width="60px" />
							<col width="50px" />
							<col width="50px" />
							<col width="*" />
							<col width="180px" />
							<col width="80px" />
							<col width="120px" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col" class="first_line">번호</th>
								<th scope="col" class="first_line"><input type="checkbox" name="checkAll" id="checkAll" class="check2" value="1" onClick="fn_egov_checkAll_PopupManage();"></th>
								<th scope="col" class="first_line">구분</th>
								<th scope="col" class="first_line">제목</th>
								<th scope="col" class="first_line">게시 기간</th>
								<th scope="col" class="first_line">게시상태</th>
								<th scope="col" class="first_line">관리</th>
							</tr>

							<c:set var="listCount" value="0"/>
							<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
							<c:set var="listCount" value="${listCount+1}"/>
							<tr>
								<td class="lt_text3" nowrap><c:out value="${(popupManageVO.pageIndex-1) * popupManageVO.pageSize + status.count}"/></td>
								<td class="lt_text3">
									<input type="checkbox" name="checkList" id="checkList" class="check2" value="${resultInfo.popupId}">
								</td>
								<td class="lt_text3L"><c:if test="${resultInfo.siteGb eq '11'}">본관</c:if><c:if test="${resultInfo.siteGb eq '12'}">어린이</c:if></td>
								<td class="lt_text3L"><c:out value="${resultInfo.popupTitleNm}"/></td>
								<td class="lt_text3">
									<c:out value="${fn:substring(resultInfo.ntceBgnde, 0, 4)}"/>-<c:out value="${fn:substring(resultInfo.ntceBgnde, 4, 6)}"/>-<c:out value="${fn:substring(resultInfo.ntceBgnde, 6, 8)}"/>
									~
									<c:out value="${fn:substring(resultInfo.ntceEndde, 0, 4)}"/>-<c:out value="${fn:substring(resultInfo.ntceEndde, 4, 6)}"/>-<c:out value="${fn:substring(resultInfo.ntceEndde, 6, 8)}"/>
								<td class="lt_text3"><c:out value="${resultInfo.ntceAt}"/></td>
								<td style="width:120px;">
									<a href="javascript:void(0);" class="button_v2" onclick="javascript:fn_egov_detail_PopupManage('${resultInfo.popupId}'); return false;"><span>수정</span></a>
									<a href="javascript:void(0);" class="button_v2" onclick="javascript:fn_egov_delete_PopupManage('<c:out value="${resultInfo.popupId}"/>');"><span>삭제</span></a>
								</td>
							</tr>
							</c:forEach>
														
						</tbody>
					</table>
				</div>
				<!-- //listType05 -->

				<!-- pagingType03 -->
				<div class="basePaging pagingType03">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnSelectLinkPage" />
				</div>
				<!-- //pagingType03 -->

				<div class="ta_r">
					<a href="javascript:void(0);" class="btn_reg" onclick="JavaScript:fn_egov_view_PopupManage();">미리보기</a>
					<a href="<c:url value='/boffice/actPopup/registPopup.do'/>" class="btn_reg">신규등록</a>
				</div>

			</div>
			<!-- //cont -->
		</div>
		<!-- //Container -->

<%@include file="../include/footer.jsp"%>