<%@page contentType="text/html;charset=utf-8"%>
<%@include file="../include/header.jsp"%>
<script type="text/javascript">

function fnActStudentModify(op){
	if(!form_val_chk($("#frmForm"))){
		return;
	}
	if(!confirm("저장 하시겠습니까?")){
		return;
	}

	var url = "<c:url value='/boffice/actMemb/modifyActStudent.do' />";
	if(!document.frmForm.sIdx.value){
		url = "<c:url value='/boffice/actMemb/insertActStudent.do' />";
	}

    var aFrm = document.frmForm;
    var target_name = 'iframe_upload';
    var iframe = $('<iframe src="javascript:false;" name="'+target_name+'" style="display:none;"></iframe>');
	aFrm.action = url;
    $('body').append(iframe);
    iframe.load(function(){
        var doc = this.contentWindow ? this.contentWindow.document : (this.contentDocument ? this.contentDocument : this.document);
        var root = doc.documentElement ? doc.documentElement : doc.body;
        var retStr = root.textContent ? root.textContent : root.innerText;
        iframe.remove();
    	if(retStr == "success"){
    		alert("저장되었습니다.");
    		if(!document.frmForm.sIdx.value){
    			location.href="<c:url value='/boffice/actMemb/actStudentList.do' />";
    		}else{
    			document.searchForm.action = "/boffice/actMemb/actStudentView.do";
    			document.searchForm.target = "_parent";
    			document.searchForm.submit();
    		}
    	}else{
    		alert("오류입니다. 다시 시도하여 주세요.");
    		return;
    	}
    });
    aFrm.target = target_name;
    aFrm.submit();
}

function fnActStudentDel(obj){
	if(!confirm("삭제하시겠습니까?")){
		return;
	}
	var url = "<c:url value='/boffice/actMemb/deleteActStudent.do' />";
	var param = {sIdx : obj}
	commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.');
	location.href="<c:url value='/boffice/actMemb/actStudentList.do' />";
}

function fnActStudentList(){
	document.searchForm.action = "<c:url value='/boffice/actMemb/actStudentList.do'/>";
	document.searchForm.submit();
}

function fnActFileReset(obj){
	$("input[name='fileThum']").val("");
}
function fnIThumDelCk(obj){
	if($(obj).prop("checked")){
		$("input[name='thumDel']").val("Y");
	}else{
		$("input[name='thumDel']").val("");
	}
	//alert($("input[name='thumDel']").val());
}
</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>현강생 관리</h3>
				<div class="btnWrap">
					<c:if test="${empty resultInfo.sIdx}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActStudentModify('new');">등록</button>
					</c:if>
					<c:if test="${!empty resultInfo.sIdx}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActStudentModify('edit');">수정</button>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActStudentDel('<c:out value='${resultInfo.sIdx}'/>');">삭제</button>
					</c:if>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActStudentList();">목록</button>
				</div>
			</div>
			<div class="realCont">

				<form name="searchForm" method="post">
					<input type="hidden" name="pageIndex" value="<c:out value='${freeVO.pageIndex}'/>">
					<input type="hidden" name="sName" value="<c:out value='${freeVO.sName}'/>">
					<input type="hidden" name="sAge" value="<c:out value='${freeVO.sAge}'/>">
					<input type="hidden" name="sSex" value="<c:out value='${freeVO.sSex}'/>">
					<input type="hidden" name="birthdayM" value="<c:out value='${freeVO.birthdayM}'/>">
					<input type="hidden" name="birthdayD" value="<c:out value='${freeVO.birthdayD}'/>">
					<input type="hidden" name="sEmail" value="<c:out value='${freeVO.sEmail}'/>">
					<input type="hidden" name="sTel" value="<c:out value='${freeVO.sTel}'/>">
					<input type="hidden" name="sHand" value="<c:out value='${freeVO.sHand}'/>">
					<input type="hidden" name="sAdd" value="<c:out value='${freeVO.sAdd}'/>">
					<input type="hidden" name="readyExam" value="<c:out value='${freeVO.readyExam}'/>">
					<input type="hidden" name="takeArea1" value="<c:out value='${freeVO.takeArea1}'/>">
					<input type="hidden" name="takeArea2" value="<c:out value='${freeVO.takeArea2}'/>">
					<input type="hidden" name="takeArea3" value="<c:out value='${freeVO.takeArea3}'/>">
					<input type="hidden" name="sGrade" value="<c:out value='${freeVO.sGrade}'/>">
					<input type="hidden" name="sSchool" value="<c:out value='${freeVO.sSchool}'/>">
					<input type="hidden" name="lectureSdate" value="<c:out value='${freeVO.lectureSdate}'/>">
					<input type="hidden" name="lectureEdate" value="<c:out value='${freeVO.lectureEdate}'/>">
					<input type="hidden" name="readyTime" value="<c:out value='${freeVO.readyTime}'/>">
					<input type="hidden" name="sScore" value="<c:out value='${freeVO.sScore}'/>">
					<input type="hidden" name="eScore" value="<c:out value='${freeVO.eScore}'/>">
					<input type="hidden" name="examExp" value="<c:out value='${freeVO.examExp}'/>">
					<input type="hidden" name="diffSubject" value="<c:out value='${freeVO.diffSubject}'/>">
					<input type="hidden" name="planTime" value="<c:out value='${freeVO.planTime}'/>">
					<input type="hidden" name="sDifficulties" value="<c:out value='${freeVO.sDifficulties}'/>">
					<input type="hidden" name="sStress" value="<c:out value='${freeVO.sStress}'/>">
					<input type="hidden" name="sPath" value="<c:out value='${freeVO.sPath}'/>">
					<input type="hidden" name="lectureExp" value="<c:out value='${freeVO.lectureExp}'/>">
					<input type="hidden" name="sOpinion" value="<c:out value='${freeVO.sOpinion}'/>">
					<input type="hidden" name="sRemark" value="<c:out value='${freeVO.sRemark}'/>">
					<input type="hidden" name="searchSdt" value="<c:out value='${freeVO.searchSdt}'/>">
					<input type="hidden" name="searchEdt" value="<c:out value='${freeVO.searchEdt}'/>">
					<input type="hidden" name="sIdx" id="sIdx" value='<c:out value="${resultInfo.sIdx}"/>' />
				</form>
				<form name="frmForm" id="frmForm" method="post" enctype="multipart/form-data" class="articleWrite">
					<input type="hidden" name="sIdx" id="sIdx" value='<c:out value="${resultInfo.sIdx}"/>' />

			         <!--기본정보-->
					<fieldset>
						<table class="rowTable">
							<colgroup>
								<col style="width:170px">
								<col style="width:*">
								<col style="width:170px">
								<col style="width:*">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">이름</th>
 									<td>
										<input type="text" name="sName" value="<c:out value='${resultInfo.sName}'/>" class="req" title="이름을 입력해주세요." maxlength="10">
  									</td>
									<th scope="row" rowspan="6">사진</th>
 									<td rowspan="6">
								<c:if test="${empty resultInfo.thumId}">
										<div>
											<input type="file" name="fileThum" />
											<a href="javascript:void(0);" class="button_v2" onclick="javascript:fnActFileReset(this);"><span>취소</span></a>
										</div>
								</c:if>
								<c:if test="${!empty resultInfo.thumId}">
											<c:import url="/cmm/fms/selectThumFileInfsForUpdate2.do" charEncoding="utf-8">
												<c:param name="param_atchFileId" value="${resultInfo.thumId}" />
												<c:param name="param_delcheck" value="delck" />
											</c:import>
											<input type="hidden" name="thumDel" />
											<input type="hidden" name="thumId" value="${resultInfo.thumId}" />							
								</c:if>
  									</td>
								</tr>
								<tr>
									<th scope="row">성별</th>
 									<td>
										<p class="radioStyle">
											<input type="radio"  name="sSex" id="sex_m" value="M" <c:if test="${resultInfo.sSex eq 'M'}">checked</c:if>><label for="sex_m"><span></span>남</label>
											<input type="radio"  name="sSex" id="sex_w" value="W" <c:if test="${resultInfo.sSex eq 'W'}">checked</c:if>><label for="sex_w"><span></span>여</label>
										</p>
  									</td>
								</tr>
								<tr>
									<th scope="row">생년월일</th>
 									<td>
										<input type="text" name="sBirthday" value="<c:out value='${resultInfo.sBirthday}'/>" class="calendar edit" title="생년월일을 입력해주세요." >
  									</td>
								</tr>
								<tr>
									<th scope="row">이메일</th>
									<td>
										<input type="text" name="sEmail" value="<c:out value='${resultInfo.sEmail}'/>" class="" title="이메일 주소를 입력해주세요." maxlength="50" style="width:230px;" >
									</td>
								</tr>
								<tr>
									<th scope="row">전화번호</th>
 									<td>
										<div class="for-phoneform tel" data-name="sTel" data-class="" data-attr=" title='전화번호를 입력해주세요.', title='전화번호를 입력해주세요.', title='전화번호를 입력해주세요.'" ><c:out value='${resultInfo.sTel}'/></div>
  									</td>
								</tr>
								<tr>
									<th scope="row">휴대폰</th>
									<td>
										<div class="for-phoneform mobile" data-name="sHand" data-class="" data-attr=" title='휴대폰번호를 입력해주세요.', title='휴대폰번호를 입력해주세요.', title='휴대폰번호를 입력해주세요.'" ><c:out value='${resultInfo.sHand}'/></div>
									</td>
								</tr>
								<tr>
									<th scope="row">주소</th>
 									<td class="addr" colspan="3">
										<button type="button" class="commonBtn search_address">우편번호찾기</button> <input type="text" class="postcode" style="width:70px" name="sZip" value="<c:out value='${resultInfo.sZip}'/>" title="주소를 입력해주세요." readonly="readonly" /> 
										<input type="text" class="addr1" name="sAdd1" value="<c:out value='${resultInfo.sAdd1}'/>" title="주소를 입력해주세요." readonly="readonly" style="width:500px" /> 
										<input type="text" class="addr2" name="sAdd2" value="<c:out value='${resultInfo.sAdd2}'/>" title="주소를 입력해주세요." maxlength="100" />
  									</td>
								</tr>
								<tr>
									<th scope="row">준비하는 시험</th>
 									<td colspan="3">
										<select name="readyExam" style="width:180px;" >
											<option value="">- 선택 -</option>
										<c:import url="/boffice/activity/actLecCdType.do" charEncoding="utf-8">
											<c:param name="codeGb" value="LE" />
											<c:param name="frmTypeValue" value="${resultInfo.readyExam}" />
										</c:import>
										</select>
  									</td>
								</tr>
								<tr>
									<th scope="row">응시지역</th>
									<td colspan="3">
										1지망 <input type="text" name="takeArea1" value="<c:out value='${resultInfo.takeArea1}'/>" class="" title="1지망 응시지역을 입력해주세요." maxlength="50" > 
										2지망 <input type="text" name="takeArea2" value="<c:out value='${resultInfo.takeArea2}'/>" class="" title="2지망 응시지역을 입력해주세요." maxlength="50" > 
										3지망 <input type="text" name="takeArea3" value="<c:out value='${resultInfo.takeArea3}'/>" class="" title="3지망 응시지역을 입력해주세요." maxlength="50" > 
									</td>
								</tr>
								<tr>
									<th scope="row">학력</th>
 									<td>
										<select name="sGrade" style="width:180px;"> 
											<option value="">- 선택 -</option>
											<option value="11" <c:if test="${resultInfo.sGrade eq '11'}">selected</c:if>>고졸</option> 
											<option value="12" <c:if test="${resultInfo.sGrade eq '12'}">selected</c:if>>전문대 재학중</option> 
											<option value="13" <c:if test="${resultInfo.sGrade eq '13'}">selected</c:if>>전문대졸</option> 
											<option value="14" <c:if test="${resultInfo.sGrade eq '14'}">selected</c:if>>대학 재학 중</option> 
											<option value="15" <c:if test="${resultInfo.sGrade eq '15'}">selected</c:if>>대졸</option> 
											<option value="16" <c:if test="${resultInfo.sGrade eq '16'}">selected</c:if>>대학원 재학 중</option> 
											<option value="17" <c:if test="${resultInfo.sGrade eq '17'}">selected</c:if>>대학원 졸업</option> 
										</select>
  									</td>
									<th scope="row">출신학교</th>
									<td>
										<input type="text" name="sSchool" value="<c:out value='${resultInfo.sSchool}'/>" class="" title="출신학교를 입력해주세요." maxlength="50" >
									</td>
								</tr>
								<tr>
									<th scope="row">현장강의 수강기간</th>
 									<td>
										<input type="text" name="lectureSdate" value="<c:out value='${resultInfo.lectureSdate}'/>" class="calendar" title="시험준비기간 시작일을 입력해주세요." > ~ 
										<input type="text" name="lectureEdate" value="<c:out value='${resultInfo.lectureEdate}'/>" class="calendar" title="시험준비기간 종료일을 입력해주세요." >
  									</td>
									<th scope="row">시험준비기간</th>
 									<td>
										<input type="text" name="readyTime" value="<c:out value='${resultInfo.readyTime}'/>" class="" title="시험준비기간을 입력해주세요." maxlength="50" >
  									</td>
								</tr>
								<tr>
									<th scope="row">소지가산점</th>
									<td>
										<input type="text" name="sScore" value="<c:out value='${resultInfo.sScore}'/>" class="" title="소지가산점을 입력해주세요." maxlength="50" >
									</td>
									<th scope="row">공무원 시험 응시경험</th>
 									<td>
										<input type="text" name="examExp" value="<c:out value='${resultInfo.examExp}'/>" class="" title="공무원 시험 응시경험을 입력해주세요." maxlength="50" >
  									</td>
								</tr>
								<tr>
									<th scope="row">가장 어렵게 느끼는 과목</th>
									<td>
										<input type="text" name="diffSubject" value="<c:out value='${resultInfo.diffSubject}'/>" class="" title="가장 어렵게 느끼는 과목을 입력해주세요." maxlength="50" >
									</td>
									<th scope="row">공무원 시험 계획 기간</th>
 									<td>
										<input type="text" name="planTime" value="<c:out value='${resultInfo.planTime}'/>" class="" title="공무원 시험 계획 기간을 입력해주세요." maxlength="50" >
  									</td>
								</tr>
								<tr>
									<th scope="row">공부하면서 가장 힘든점</th>
									<td>
										<input type="text" name="sDifficulties" value="<c:out value='${resultInfo.sDifficulties}'/>" class="" title="공부하면서 가장 힘든점을 입력해주세요." maxlength="50" >
									</td>
									<th scope="row">나만의 스트레스 해소법</th>
 									<td>
										<input type="text" name="sStress" value="<c:out value='${resultInfo.sStress}'/>" class="" title="나만의 스트레스 해소법을 입력해주세요." maxlength="50" >
  									</td>
								</tr>
								<tr>
									<th scope="row">본원을 알게 된 경로</th>
									<td>
										<input type="text" name="sPath" value="<c:out value='${resultInfo.sPath}'/>" class="" title="본원을 알게 된 경로를 입력해주세요." maxlength="50" >
									</td>
									<th scope="row">타강의 수강 경험</th>
 									<td>
										<input type="text" name="lectureExp" value="<c:out value='${resultInfo.lectureExp}'/>" class="" title="타강의 수강 경험을 입력해주세요." maxlength="50" >
  									</td>
								</tr>
								<tr>
									<th scope="row">학원에 하고싶은 말</th>
 									<td colspan="3">
										<textarea name="sOpinion" style="height:80px;"><c:out value='${resultInfo.sOpinion}'/></textarea>
									</td>
								</tr>
								<tr>
									<th scope="row">비고</th>
 									<td colspan="3">
										<textarea name="sRemark" style="height:80px;"><c:out value='${resultInfo.sRemark}'/></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</fieldset>
				  <!--//기본정보-->

				<!-- //writeType03 -->
				</form>

			</div>
		</section>

	</section>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

	<%@include file="../include/footer.jsp"%>