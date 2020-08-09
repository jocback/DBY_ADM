<%@page contentType="text/html;charset=utf-8"%>
<%@include file="../include/header.jsp"%>
<%
pageContext.setAttribute("CR", "\r");
pageContext.setAttribute("LF", "\n");
pageContext.setAttribute("CRLF", "\r\n");
pageContext.setAttribute("SP", " ");
pageContext.setAttribute("BR", "<br/>");
%> 
<style type="text/css">
.itemUl {border-bottom:1px solid #CCC;padding:5px;float:left;display:inline;}
.itemUl li {padding:3px;min-height:35px;float:left;display:inline;}
.itemUl li div {width:60px;padding:7px;float:left;}
</style>
<script type="text/javascript">

function fnActMembWrite(op){

	if(!confirm("수정하시겠습니까?")){
		return;
	}		

	var aFrm = document.actEmpModifyForm;
    var target_name = 'iframe_upload';
    var iframe = $('<iframe src="javascript:false;" name="'+target_name+'" style="display:none;"></iframe>');
	aFrm.action = "<c:url value='/boffice/actMemb/modifyActMemb.do'/>";
    $('body').append(iframe);
    iframe.load(function(){
        var doc = this.contentWindow ? this.contentWindow.document : (this.contentDocument ? this.contentDocument : this.document);
        var root = doc.documentElement ? doc.documentElement : doc.body;
        var retStr = root.textContent ? root.textContent : root.innerText;
        iframe.remove();
    	if(retStr == "success"){
    		alert("수정되었습니다.");
			document.actEmpModifyForm.action = "/boffice/actMemb/actMembView.do";
			document.actEmpModifyForm.target = "_parent";
			document.actEmpModifyForm.submit();
    	}else if(retStr == "ERR_PIC"){
    		alert("사진파일 형식이 잘못되었습니다.");
    		return;
    	}else{
    		alert("오류입니다. 다시 시도하여 주세요.");
    		return;
    	}
    });
    aFrm.target = target_name;
    aFrm.submit();

}


function fnActMembDelete(idx){
	if(!confirm("삭제하시겠습니까?")){
		return;
	}
	var url = "<c:url value='/boffice/actMemb/deleteActMemb.do' />";
	var param = {
			mIdx : document.actEmpModifyForm.mIdx.value
	}
	if(commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.') == "success"){
		fnActMembList();
	}
}
function fnActMembList(){
	document.frm.action = "<c:url value='/boffice/actMemb/actMembList.do'/>";
	document.frm.submit();
}

function fnActEquipDelete(seq,mid,eid,sno){
	if(!confirm("등록기기를 삭제하시겠습니까?")){
		return;
	}
	var url = "<c:url value='/boffice/actMemb/deleteActEquip.do' />";
	var param = {
			searchCnd : seq,
			searchOp1 : mid,
			searchOp2 : eid,
			searchOp3 : sno
	}
	if(commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.') == "success"){
		document.actEmpModifyForm.action = "/boffice/actMemb/actMembView.do";
		document.actEmpModifyForm.target = "_parent";
		document.actEmpModifyForm.submit();
	}
}

</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>회원 관리</h3>
				<div class="btnWrap">
					<c:if test="${empty resultInfo.mIdx}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActMembWrite('new');">등록</button>
					</c:if>
					<c:if test="${!empty resultInfo.mIdx}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActMembWrite('edit');">수정</button>
					</c:if>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActMembList();">목록</button>
				</div>
			</div>
			<div class="realCont">

			<form name="frm" method="post">
				<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
				<input name="searchCnd2" type="hidden" value="<c:out value='${searchVO.searchCnd2}'/>"/>
				<input name="searchCnd3" type="hidden" value="<c:out value='${searchVO.searchCnd3}'/>"/>
				<input name="searchOp1" type="hidden" value="<c:out value='${searchVO.searchOp1}'/>"/>
				<input name="searchOp2" type="hidden" value="<c:out value='${searchVO.searchOp2}'/>"/>
				<input name="searchOp3" type="hidden" value="<c:out value='${searchVO.searchOp3}'/>"/>
				<input name="searchOp4" type="hidden" value="<c:out value='${searchVO.searchOp4}'/>"/>
				<input name="searchOp5" type="hidden" value="<c:out value='${searchVO.searchOp5}'/>"/>
				<input name="searchOp6" type="hidden" value="<c:out value='${searchVO.searchOp6}'/>"/>
				<input name="searchOp7" type="hidden" value="<c:out value='${searchVO.searchOp7}'/>"/>
				<input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>">
				<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>">
				<input type="hidden" name="searchSdt" value="<c:out value='${searchVO.searchSdt}'/>">
				<input type="hidden" name="searchEdt" value="<c:out value='${searchVO.searchEdt}'/>">
			</form>
			<form name="actEmpModifyForm" id="actEmpModifyForm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
				<input name="searchCnd2" type="hidden" value="<c:out value='${searchVO.searchCnd2}'/>"/>
				<input name="searchCnd3" type="hidden" value="<c:out value='${searchVO.searchCnd3}'/>"/>
				<input name="searchOp1" type="hidden" value="<c:out value='${searchVO.searchOp1}'/>"/>
				<input name="searchOp2" type="hidden" value="<c:out value='${searchVO.searchOp2}'/>"/>
				<input name="searchOp3" type="hidden" value="<c:out value='${searchVO.searchOp3}'/>"/>
				<input name="searchOp4" type="hidden" value="<c:out value='${searchVO.searchOp4}'/>"/>
				<input name="searchOp5" type="hidden" value="<c:out value='${searchVO.searchOp5}'/>"/>
				<input name="searchOp6" type="hidden" value="<c:out value='${searchVO.searchOp6}'/>"/>
				<input name="searchOp7" type="hidden" value="<c:out value='${searchVO.searchOp7}'/>"/>
				<input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>">
				<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>">
				<input type="hidden" name="searchSdt" value="<c:out value='${searchVO.searchSdt}'/>">
				<input type="hidden" name="searchEdt" value="<c:out value='${searchVO.searchEdt}'/>">
				<input type="hidden" name="mIdx" id ="mIdx" value="<c:out value="${resultInfo.mIdx}"/>">
				<div class="writeType03 mt_50">
					<table class="rowTable">
						<caption class="blind">회원정보 수정</caption>
						<colgroup>
								<col style="width:130px;">
								<col style="width:230px;">
								<col style="width:130px;">
								<col style="width:*">
								<col style="width:130px;">
								<col style="width:*">
						</colgroup>
						<tbody>	
							<tr>
								<th scope="row">이름</th>
								<td>
									<input type="text" name="mName" id="mName" style="width:150px;" value="<c:out value="${resultInfo.mName}"/>" maxlength="10" />
								</td>
								<th scope="row">아이디</th>
								<td>
									<c:if test="${empty resultInfo.mId}">					
										<input type="text" name="mId" id="mId" style="width:150px;"  maxlength="10" />
									</c:if>
									<c:if test="${not empty resultInfo.mId}">					
										<input type="hidden" name="mId" id="mId" style="width:150px;"  maxlength="10" value="<c:out value="${resultInfo.mId}"/>" />
										<c:out value="${resultInfo.mId}"/>
									</c:if>
								</td>
								<th scope="row">회원구분</th>
								<td>
									<select name="mGubun" id="mGubun">
										<option value="">선택</option>
										<c:import url="/boffice/activity/actFrmType.do" charEncoding="utf-8">
											<c:param name="frmTypeCode" value="COM044" />
											<c:param name="frmTypeValue" value="${resultInfo.mGubun}" />
										</c:import>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row">휴대폰번호</th>
								<td>
									<input type="text" name="mHp" id="mHp" style="width:150px;" value="<c:out value="${resultInfo.mHp}"/>" maxlength="13" />
								</td>
								<th scope="row">전화번호</th>
								<td>
									<input type="text" name="mTel" id="mTel" style="width:150px;" value="<c:out value="${resultInfo.mTel}"/>" maxlength="13" />
								</td>
								<th scope="row">성별</th>
								<td>
									<input type="radio" name="mSex" id="mSex1" value="M" <c:if test="${resultInfo.mSex eq 'M'}">checked</c:if> />
									<label for="mSex1">남</label>
									<input type="radio" name="mSex" id="mSex2" value="W" class="mls15" <c:if test="${resultInfo.mSex eq 'W'}">checked</c:if> />
									<label for="mSex2">여</label>
								</td>
							</tr>
							<tr>
								<th scope="row">이메일</th>
								<td>
									<input type="text" name="mEmail" id="mEmail" style="width:150px;" value="<c:out value="${resultInfo.mEmail}"/>"maxlength="25" />
								</td>
								<th scope="row">생년월일</th>
								<td>
									<input type="text" name="mBirth" id="mBirth" maxlength="8" class="textNumOnly" value="<c:out value="${resultInfo.mBirth}"/>">
								</td>
								<th scope="row">비밀번호</th>
								<td>
									<input type="password" name="mPass" class="" title="비밀번호를 입력해주세요." maxlength="50" style="width:100px">
								</td>
							</tr>
							<tr>
								<th scope="row">주소</th>
								<td>
									<a href="javascript:void(0);" class="button_v2" onclick="execDaumPostcode('mZip','mAddr1')"><span>우편번호</span></a>
									<input type="text" name="mZip" id="mZip" style="text-align:center;width:80px;" value="<c:out value="${resultInfo.mZip}"/>" maxlength="5" class="chknum"  />
								</td>
								<td colspan="4" style="height:70px;">
									<input type="text" name="mAddr1" id="mAddr1" style="width:500px;margin-bottom:5px;" value="<c:out value="${resultInfo.mAddr1}"/>" maxlength="150" /><br/>
									<input type="text" name="mAddr2" id="mAddr2" style="width:500px;" value="<c:out value="${resultInfo.mAddr2}"/>" maxlength="150"/>
									<span id="guide" style="color:#999"></span>									
								</td>
							</tr>
							<tr>
								<th scope="row">가입경로</th>
								<td>
									<select name="mWay" id="mWay">
										<option value="">선택</option>
										<c:import url="/boffice/activity/actFrmType.do" charEncoding="utf-8">
											<c:param name="frmTypeCode" value="COM122" />
											<c:param name="frmTypeValue" value="${resultInfo.mWay}" />
										</c:import>
									</select>
								</td>
								<th scope="row">이메일수신여부</th>
								<td>
									<input type="radio" name="emailYn" id="emailY" value="Y" <c:if test="${resultInfo.emailYn eq 'Y'}"> checked</c:if>><label for="emailY">동의</label>
									<input type="radio" name="emailYn" id="emailN" value="N" <c:if test="${resultInfo.emailYn eq 'N'}"> checked</c:if> style="margin-left:5px;"><label for="emailN">동의안함</label>
								</td>
								<th scope="row">SMS수신여부</th>
								<td>
									<input type="radio" name="smsYn" id="smsY" value="Y" <c:if test="${resultInfo.smsYn eq 'Y'}"> checked</c:if>><label for="smsY">동의</label>
									<input type="radio" name="smsYn" id="smsN" value="N" <c:if test="${resultInfo.smsYn eq 'N'}"> checked</c:if> style="margin-left:5px;"><label for="smsN">동의안함</label>
								</td>
							</tr>
							<tr>
								<th scope="row">준비하는 시험</th>
								<td>
									<select name=mExam id="mExam">
										<option value="">선택</option>
										<c:import url="/boffice/activity/actLecCdType.do" charEncoding="utf-8">
											<c:param name="codeGb" value="LE" />
											<c:param name="frmTypeValue" value="${resultInfo.mExam}" />
										</c:import>
									</select>
								</td>
								<th scope="row">응시지역1지망</th>
								<td>
									<input type="text" size="10" maxlength="10" name="mHope1" id="mHope1" value="<c:out value="${resultInfo.mHope1}"/>" />
								</td>
								<th scope="row">응시지역2지망</th>
								<td>
									<input type="text" size="10" maxlength="10" name="mHope2" id="mHope2" value="<c:out value="${resultInfo.mHope2}"/>" />
								</td>
							</tr>
							<tr>
								<th scope="row">학원을 알게된 동기</th>
								<td>
									<select name="mPath" id="mPath">
										<option value="">선택</option>
										<c:import url="/boffice/activity/actFrmType.do" charEncoding="utf-8">
											<c:param name="frmTypeCode" value="COM128" />
											<c:param name="frmTypeValue" value="${resultInfo.mPath}" />
										</c:import>
									</select>
								</td>
								<th scope="row">최근 접속 일시</th>
								<td><c:out value="${resultInfo.lastLogin}"/></td>
								<th scope="row">방문 횟수</th>
								<td><c:out value="${resultInfo.loginCnt}"/></td>
							</tr>
							<tr>
								<th scope="row">가입일시</th>
								<td colspan="5"><c:out value="${resultInfo.regdt}"/></td>
							</tr>
							<tr>
								<th scope="row">특이사항</th>
								<td colspan="5">
									<textarea name="mEtc" style="height:80px;"><c:out value="${resultInfo.mEtc}"/></textarea>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- //writeType03 -->

			</form>

				  <!--등록기기-->
				  <fieldset style="margin-top:20px;">
					<p>등록기기</p>
					<table class="commonTable detailTable">
						<colgroup>
							<col style="width:*">
							<col style="width:*">
							<col style="width:*">
							<col style="width:*">
							<col style="width:70px">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">PID</th>
								<th scope="col">SSN</th>
								<th scope="col">별칭</th>
								<th scope="col">등록일시</th>
								<th scope="col">관리</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${equipList}" varStatus="status">
							<tr data-device="pc" data-no="">
								<td><c:out value="${result.pid}"/></td>
								<td><c:out value="${result.ssn}"/></td>
								<td><c:out value="${result.alias}"/></td>
								<td><c:out value="${fn:substring(result.rdat,0,16)}"/></td>
								<td><button type="button" class="commonBtn" onClick="javascript:fnActEquipDelete('<c:out value="${result.seq}"/>','<c:out value="${result.mId}"/>','<c:out value="${result.pid}"/>','<c:out value="${result.sno}"/>');">삭제</button></td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				  </fieldset>
				  <!--//등록기기-->

			</div>
		</section>

	</section>

<%@include file="../include/footer.jsp"%>