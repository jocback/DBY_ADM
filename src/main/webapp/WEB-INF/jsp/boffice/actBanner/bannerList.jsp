<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/header.jsp"%>
<style type="text/css">

#sortWrap div {
	margin: 5px;
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
}
</style>
<script type="text/javascript">
function press(event) {
	if (event.keyCode==13) {
		fnActBannerList('1');
	}
}
function fnActBannerList(pageNo) {
	document.frm.pageIndex.value = pageNo;
	document.frm.action = "<c:url value='/boffice/actBanner/actBannerList.do'/>";
	document.frm.submit();
}
function fnActBannerView(idx) {
	 if(!idx) return false;
	 document.frm.idx.value = idx;
	 document.frm.action = "<c:url value='/boffice/actBanner/actBannerView.do'/>";
	 document.frm.submit();
}
function fnActBannerWrite() {
	 document.frm.idx.value = "";
	 document.frm.action = "<c:url value='/boffice/actBanner/actBannerView.do'/>";
	 document.frm.submit();
}
function fnActBannerModify(idx){
	if(!confirm("삭제하시겠습니까?")){
		return;
	}
	var url = "<c:url value='/boffice/actBanner/deleteActBanner.do' />";
	var param = {
			frmMode : "del",
			idx : idx,
	}
	commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.');
	fnActBannerList(document.frm.pageIndex.value);
}
$(function(){
	$(".searchSelect").change(function(){
		fnActBannerList('1');
	});
});

//순서변경 기능--------------------------------------------------------------------------
function fnTranSeqAuto(){
	$("input[name=tSeq]").each(function(idx,elem){
		$(this).val(idx+1);
	});
}
function fnTranSeqSave(){
	if(confirm("순서변경을 적용하시겠습니까?")){
		var formData = $("#frmEquip").serialize();
		var url = "<c:url value='/boffice/actBanner/updateActBannerSeq.do'/>";
		var param = formData;
		if(commonUtil.AjaxSynCall(url,param)=="success"){
			alert("수정되었습니다.");
			fnActBannerList('1');
		}
	}
}

$(function() {
	$("#sortWrap").sortable({
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

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>메인 관리</h3>
				<div class="btnWrap">
					<button type="button" class="colorBtn rightbluebtn" onClick="javascript:fnActBannerList('1');">검색</button>
					<button type="button" class="colorBtn rightbluebtn plusIcon" onClick="javascript:fnActBannerWrite();">신규등록</button>
					<button type="button" class="colorBtn rightbluebtn" onClick="javascript:fnTranSeqAuto();">순서자동입력</button>
					<button type="button" class="colorBtn rightbluebtn" onClick="javascript:fnTranSeqSave();">순서변경적용</button>
				</div>
			</div>
			<div class="realCont">

				<form name="frm" method="post" class="SearchForm">
  					<fieldset>
						<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
						<input name="idx" type="hidden"/>
						<table class="rowTable">
							<colgroup>
								<col style="width:9%">
								<col style="width:350px">
								<col style="width:9%">
								<col style="width:*">
							</colgroup>
							<tbody>
								<tr>
									<th>분류</th>
									<td colspan="3">
										<p>
							<select name="searchOp1" id="searchOp1" class="searchSelect">
								<option value="">분류선택</option>
								<c:forEach var="codeResult56" items="${codeResult56}" varStatus="status">
								<option value='<c:out value="${codeResult56.code}"/>' <c:if test="${searchVO.searchOp1 eq codeResult56.code}"> selected</c:if>><c:out value="${codeResult56.codeNm}"/></option>
								</c:forEach>
							</select>
										</p>
									</td>
								</tr>
								<tr>
									<th>검색어</th>
									<td colspan="3">
										<p>
							<select name="searchCnd" id="searchCnd">
								<option value="actName" <c:if test="${searchVO.searchCnd eq 'actName'}"> selected</c:if>>배너명</option>
								<option value="actUrl" <c:if test="${searchVO.searchCnd eq 'actUrl'}"> selected</c:if>>링크URL</option>
							</select>
											<input  name="searchKeyword" type="text" size="35" class="shc_text" value='<c:out value="${searchVO.searchKeyword}" />' maxlength="35" onkeypress="press(event);" title="검색단어입력">
										</p>
									</td>
								</tr>
								<tr>
									<th>노출여부</th>
									<td colspan="3">
										<p class="radioStyle">
											<input type="radio" name="searchOp3" value="" id="searchOp30"><label for="searchOp30"><span></span>전체</label>
											<input type="radio" name="searchOp3" value="Y" id="searchOp31" <c:if test="${searchVO.searchOp3 eq 'Y'}"> checked</c:if>><label for="searchOp31"><span></span>보임</label>
											<input type="radio" name="searchOp3" value="N" id="searchOp32" <c:if test="${searchVO.searchOp3 eq 'N'}"> checked</c:if>><label for="searchOp32"><span></span>숨김</label>
										</p>
									</td>
								</tr>
							</tbody>
						</table>
  					</fieldset>
				</form>
				<!-- //sch_list -->

				<div class="ask mt_50">총 <span><c:out value="${fn:length(resultList)}"/></span>건</div>

				<!-- listType05 -->
				<div id="sortWrapHead">
					<table class="commonTable" style="border:0;">
							<tr>
								<th scope="col" class="first_line" style="width:50px;">번호</th>
								<th scope="col" class="first_line" style="width:160px;">분류</th>
								<th scope="col" class="first_line" style="width:140px;">배너</th>
								<th scope="col" class="first_line" style="width:140px;">제목</th>
								<th scope="col" class="first_line" style="width:auto;">링크URL</th>
								<th scope="col" class="first_line" style="width:100px;">순서</th>
								<th scope="col" class="first_line" style="width:40px;">클릭수</th>
								<th scope="col" class="first_line" style="width:60px;">노출여부</th>
								<th scope="col" class="first_line" style="width:120px;">관리</th>
							</tr>
					</table>
				</div>
				<form name="frmEquip" id="frmEquip" method="post">
				<div id="sortWrap">
					<c:forEach var="result" items="${resultList}" varStatus="status">
					<div data-order=<c:out value="${status.index+1}"/>>
						<table class="commonTable" style="border:0;">
							<tr>
								<td style="width:50px;border:none;"><input type="hidden" name="idx" value="<c:out value="${result.idx}"/>" /><c:out value="${status.index+1}"/></td>
								<td style="width:160px;border:none;"><c:out value="${result.tPartNm}"/></td>
								<td style="width:140px;border:none;"><img src="/cmm/fms/getImage.do?atchFileId=<c:out value='${result.fileId1}'/>&fileSn=0" style="width:140px;height:40px;"></td>
								<td style="width:140px;border:none;"><c:out value="${result.tName}"/></td>
								<td style="width:auto;border:none;"><c:out value="${fn:substring(result.tUrl,0,40)}"/>...</td>
								<td style="width:100px;border:none;"><input type="text" name="tSeq" value="<c:out value="${result.tSeq}"/>" style="width:50px;text-align:center;ime-mode:disabled;" maxlength="4" class="chknum" /></td>
								<td style="width:40px;border:none;"><c:out value="${result.tRcnt}"/></td>
								<td style="width:60px;border:none;"><c:if test="${result.useYn eq 'Y'}">노출</c:if><c:if test="${result.useYn ne 'Y'}">미노출</c:if></td>
								<td style="width:120px;border:none;">
									<a href="javascript:void(0);" class="button_v2" onclick="javascript:fnActBannerView('<c:out value="${result.idx}"/>');"><span>수정</span></a>
									<a href="javascript:void(0);" class="button_v2" onclick="javascript:fnActBannerModify('<c:out value="${result.idx}"/>');"><span>삭제</span></a>
								</td>
							</tr>
						</table>
					</div>
					</c:forEach>
				</div>
				</form>
				<!-- //listType05 -->

			</div>
		</section>

	</section>

<%@include file="../include/footer.jsp"%>