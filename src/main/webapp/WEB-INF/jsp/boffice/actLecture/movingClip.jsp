<%@page contentType="text/html;charset=utf-8"%>
<%@include file="../include/header.jsp"%>
<script type="text/javascript">

function fnActMovingModify(op){
	if(!document.actMovingModifyForm.mvIdx.value){
		alert("필수값이 없습니다. 다시 선택하여 주세요");
		return;
	}
	if(!$("#"+op+" input[name='cpSeq']").val()){
		alert("순서를 입력하여 주세요.");
		$("#"+op+" input[name='cpSeq']").focus();
		return;
	}
	if(!$("#"+op+" input[name='cpTitle']").val()){
		alert("제목을 입력하여 주세요.");
		$("#"+op+" input[name='cpTitle']").focus();
		return;
	}
	/*if(!$("#"+op+" input[name='cpUrl']").val()){
		alert("동영상을 입력하여 주세요.");
		$("#"+op+" input[name='cpUrl']").focus();
		return;
	}*/
	var formData = $("#"+op).serialize();
	formData +='&mvIdx='+document.actMovingModifyForm.mvIdx.value;
	var url = "<c:url value='/boffice/actLecture/actMovingClipReg.do' />";
	commonUtil.AjaxSynCall(url,formData,'text','저장되었습니다.');
	document.actMovingModifyForm.action = "/boffice/actLecture/actMovingClip.do";
	document.actMovingModifyForm.submit();
}

function fnActMovingDel(op){
	if(!confirm("삭제하시겠습니까?")){
		return;
	}
	var url = "<c:url value='/boffice/actLecture/actMovingClipDel.do' />";
	var formData = $("#"+op).serialize();
	formData +='&mvIdx='+document.actMovingModifyForm.mvIdx.value;
	commonUtil.AjaxSynCall(url,formData,'text','삭제되었습니다.');
	document.actMovingModifyForm.action = "/boffice/actLecture/actMovingClip.do";
	document.actMovingModifyForm.submit();
}

function fnActMovingList(){
	document.actMovingModifyForm.action = "<c:url value='/boffice/actLecture/actMovingList.do'/>";
	document.actMovingModifyForm.submit();
}

$(function(){
	$('html, body').scrollTop($(document).height());
});

</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>강의 등록</h3>
				<div class="btnWrap">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActMovingList();">목록</button>
				</div>
			</div>
			<div class="realCont">

				<form name="actMovingModifyForm" id="actMovingModifyForm" method="post" class="articleWrite">
					<input type="hidden" name="pageIndex" value="<c:out value="${searchVO.pageIndex}"/>">
					<input type="hidden" name="searchCnd" value="<c:out value="${searchVO.searchCnd}"/>">
					<input type="hidden" name="searchKeyword" value="<c:out value="${searchVO.searchKeyword}"/>">
					<input type="hidden" name="searchActstt" value="<c:out value="${searchVO.searchActstt}"/>">
				
					<input type="hidden" name="mvIdx" id="mvIdx" value='<c:out value="${resultInfo.mvIdx}"/>' />
				</form>
				
				<fieldset class="categoryInfo">
					<table class="rowTable">
						<caption class="blind">강좌 정보</caption>
						<colgroup>
							<col width="130px" />
							<col width="*" />
						</colgroup>
						<tbody>	
							<tr>
								<th scope="row">강좌명</th>
								<td>
									<c:out value="${resultInfo.mvSubject}"/>
								</td>
							</tr>
						</tbody>
					</table>
				</fieldset>

				<fieldset>
					<p style="margin:10px 0 10px 0;">샘플 강의</p>
	 <c:forEach var="result" items="${resultSmpList}" varStatus="status">
				<form name="frmSmp<c:out value='${status.index}'/>" id="frmSmp<c:out value='${status.index}'/>" method="post">
					<input type="hidden" name="cpIdx" value="<c:out value='${result.cpIdx}'/>"/>
					<table class="rowTable">
					<caption>강의 등록 테이블</caption>
					<colgroup>
						<col width="130px"><col><col width="130px"><col><col width="200px">
					</colgroup>
					<tbody>
						<tr>
							<th scope="col">순서</th>
							<td class="al">
								<input type="text" class="chknum req" name="cpSeq" value="<c:out value='${result.cpSeq}'/>" title="순서 번호를 입력해주세요." maxlength="3" style="width:50px;color:red;font-weight:bolder;" />
								<p class="radioStyle">
									<input type="radio" name="cpSmp" value="T" id="cpSmp1<c:out value='${status.index}'/>" <c:if test="${result.cpSmp eq 'T' || empty result.cpSmp}">checked</c:if>>
									<label for="cpSmp1<c:out value='${status.index}'/>"><span></span>OT</label>
									<input type="radio" name="cpSmp" value="F" id="cpSmp2<c:out value='${status.index}'/>" <c:if test="${result.cpSmp eq 'F'}">checked</c:if>>
									<label for="cpSmp2<c:out value='${status.index}'/>"><span></span>1강</label>
								</p>
							</td>
							<th scope="col">시간</th>
							<td class="al"><input type="text" class="chknum" name="cpTime" value="<c:out value='${result.cpTime}'/>" title="시간을 입력해주세요." maxlength="3" style="width:50px;" /> 분</td>
							<th rowspan="4">
								<div class="btnsWrap" style="margin-top:0;">
									<button type="button" onclick="javascript:fnActMovingModify('frmSmp<c:out value='${status.index}'/>');">수정</button>
									<button type="button" class="cancle" style="margin:5px 0 0 0;" onclick="javascript:fnActMovingDel('frmSmp<c:out value='${status.index}'/>');">삭제</button>
								</div>
							</th>
						</tr>
						<tr>
							<th scope="col">제목</th>
							<td colspan="3" class="al"><input type="text" class="req" name="cpTitle" value="<c:out value='${result.cpTitle}'/>" title="제목을 입력해주세요." maxlength="100" style="width:75%" /> </td>
						</tr>
						<tr>
							<th scope="col">동영상</th>
							<td colspan="3" class="al"><input type="text" class="req" name="cpUrl" value="<c:out value='${result.cpUrl}'/>" title="동영상 경로를 입력해주세요." maxlength="200" style="width:75%" /></td>
						</tr>
						<tr>
							<th scope="col">youtube</th>
							<td colspan="3" class="al"><input type="text" class="" name="cpUtb" value="<c:out value='${result.cpUtb}'/>" title="youtube 경로를 입력해주세요." maxlength="200" style="width:75%" /></td>
						</tr>
					</tbody>
					</table>
				</form>
	</c:forEach>
				<c:if test="${fn:length(resultSmpList) < 2}">
				<form name="frmSmp" id="frmSmp" method="post">
					<table class="rowTable">
					<caption>강의 등록 테이블</caption>
					<colgroup>
						<col width="130px"><col><col width="130px"><col><col width="200px">
					</colgroup>
					<tbody>
						<tr>
							<th scope="col">순서</th>
							<td class="al">
								<input type="text" class="chknum req" name="cpSeq" value="<c:out value='${fn:length(resultSmpList)+1}'/>" title="순서 번호를 입력해주세요." maxlength="3" style="width:50px;color:red;font-weight:bolder;" />
								<p class="radioStyle">
									<input type="radio" name="cpSmp" value="T" id="cpSmp3">
									<label for="cpSmp3"><span></span>OT</label>
									<input type="radio" name="cpSmp" value="F" id="cpSmp4">
									<label for="cpSmp4"><span></span>1강</label>
								</p>
							</td>
							<th scope="col">시간</th>
							<td class="al"><input type="text" class="chknum" name="cpTime" value="" title="시간을 입력해주세요." maxlength="3" style="width:50px;" /> 분</td>
							<th rowspan="4">
								<div class="btnsWrap" style="margin-top:0;">
									<button type="button" onclick="javascript:fnActMovingModify('frmSmp');">등록</button>
								</div>
							</th>
						</tr>
						<tr>
							<th scope="col">제목</th>
							<td colspan="3" class="al"><input type="text" class="req" name="cpTitle" value="" title="제목을 입력해주세요." maxlength="100" style="width:75%" /> </td>
						</tr>
						<tr>
							<th scope="col">동영상</th>
							<td colspan="3" class="al"><input type="text" class="req" name="cpUrl" value="" title="동영상 경로를 입력해주세요." maxlength="200" style="width:75%" /></td>
						</tr>
						<tr>
							<th scope="col">youtube</th>
							<td colspan="3" class="al"><input type="text" class="" name="cpUtb" value="" title="youtube 경로를 입력해주세요." maxlength="200" style="width:75%" /></td>
						</tr>
					</tbody>
					</table>
				</form>
				</c:if>
				</fieldset>

				<fieldset>
					<p style="margin:10px 0 10px 0;">본 강의</p>
	 <c:forEach var="result" items="${resultList}" varStatus="status">
				<form name="frmClip<c:out value='${status.index}'/>" id="frmClip<c:out value='${status.index}'/>" method="post">
					<input type="hidden" name="cpIdx" value="<c:out value='${result.cpIdx}'/>"/>
					<table class="rowTable">
					<caption>강의 등록 테이블</caption>
					<colgroup>
						<col width="130px"><col><col width="130px"><col><col width="200px">
					</colgroup>
					<tbody>
						<tr>
							<th scope="col">순서</th>
							<td class="al"><input type="text" class="chknum req" name="cpSeq" value="<c:out value='${result.cpSeq}'/>" title="순서 번호를 입력해주세요." maxlength="3" style="width:50px;color:red;font-weight:bolder;" />
							</td>
							<th scope="col">시간</th>
							<td class="al"><input type="text" class="chknum" name="cpTime" value="<c:out value='${result.cpTime}'/>" title="시간을 입력해주세요." maxlength="3" style="width:50px;" /> 분</td>
							<th rowspan="4">
								<div class="btnsWrap" style="margin-top:0;">
									<button type="button" onclick="javascript:fnActMovingModify('frmClip<c:out value='${status.index}'/>');">수정</button>
									<button type="button" class="cancle" style="margin:5px 0 0 0;" onclick="javascript:fnActMovingDel('frmClip<c:out value='${status.index}'/>');">삭제</button>
								</div>
							</th>
						</tr>
						<tr>
							<th scope="col">제목</th>
							<td colspan="3" class="al"><input type="text" class="req" name="cpTitle" value="<c:out value='${result.cpTitle}'/>" title="제목을 입력해주세요." maxlength="100" style="width:75%" /> </td>
						</tr>
						<tr>
							<th scope="col">동영상</th>
							<td colspan="3" class="al"><input type="text" class="req" name="cpUrl" value="<c:out value='${result.cpUrl}'/>" title="동영상 경로를 입력해주세요." maxlength="200" style="width:75%" /></td>
						</tr>
					</tbody>
					</table>
				</form>
	</c:forEach>
				<form name="frmClip" id="frmClip" method="post">
					<table class="rowTable">
					<caption>강의 등록 테이블</caption>
					<colgroup>
						<col width="130px"><col><col width="130px"><col><col width="200px">
					</colgroup>
					<tbody>
						<tr>
							<th scope="col">순서</th>
							<td class="al"><input type="text" class="chknum req" name="cpSeq" value="<c:out value='${fn:length(resultList)+1}'/>" title="순서 번호를 입력해주세요." maxlength="3" style="width:50px;color:red;font-weight:bolder;" />
							</td>
							<th scope="col">시간</th>
							<td class="al"><input type="text" class="chknum" name="cpTime" value="" title="시간을 입력해주세요." maxlength="3" style="width:50px;" /> 분</td>
							<th rowspan="4">
								<div class="btnsWrap" style="margin-top:0;">
									<button type="button" onclick="javascript:fnActMovingModify('frmClip');">등록</button>
								</div>
							</th>
						</tr>
						<tr>
							<th scope="col">제목</th>
							<td colspan="3" class="al"><input type="text" class="req" name="cpTitle" value="" title="제목을 입력해주세요." maxlength="100" style="width:75%" /> </td>
						</tr>
						<tr>
							<th scope="col">동영상</th>
							<td colspan="3" class="al"><input type="text" class="req" name="cpUrl" value="" title="동영상 경로를 입력해주세요." maxlength="200" style="width:75%" /></td>
						</tr>
					</tbody>
					</table>
				</form>
				</fieldset>

				<!-- //writeType03 -->

			</div>
		</section>

	</section>

	<%@include file="../include/footer.jsp"%>