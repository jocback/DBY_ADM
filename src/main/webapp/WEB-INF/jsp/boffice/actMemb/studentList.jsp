<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/header.jsp"%>
	<script type="text/javascript">
	function press(event) {
		if (event.keyCode==13) {
			fnActStudentList('1');
		}
	}
	function fnActStudentList(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/boffice/actMemb/actStudentList.do'/>";
		document.frm.submit();
	}
	function fnActStudentView(no) {
		 if(!no) return false;
		 document.frm.sIdx.value = no;
		 document.frm.action = "<c:url value='/boffice/actMemb/actStudentView.do'/>";
		 document.frm.submit();
	}
	function fnActStudentWrite() {
		 document.frm.sIdx.value = "";
		 document.frm.action = "<c:url value='/boffice/actMemb/actStudentView.do'/>";
		 document.frm.submit();
	}
	function fnActDelChk(){
		if ($('#listFrm input[name=searchChk]:checked').length <= 0) {
			alert('선택된 회원이 없습니다.');
			return false;
		}
		if (confirm('선택한 회원을 삭제하시겠습니까?(복구불가)')) {
			var url = '/boffice/actMemb/deleteActStudent.do';
			var formData = $("#listFrm").serialize();
			var param = formData;
			if(commonUtil.AjaxSynCall(url,param,'text','처리되었습니다.') == "success"){
				fnActStudentList(document.frm.pageIndex.value);
			}
		}
	}
	$(function(){
		$(document).on("click",".act_excel",function(){
			document.listFrm.action = "/boffice/actMemb/actStudentExcel.do";
			document.listFrm.submit();
		});
		$(document).on('click', '.act_modi', function() {
			var no = $(this).closest('tr').data('no');
			fnActStudentView(no);
			return false;
		});
		
		var search = "";
		search = search + "<c:out value='${freeVO.birthdayM}'/>";
		search = search + "<c:out value='${freeVO.birthdayD}'/>";
		search = search + "<c:out value='${freeVO.sEmail}'/>";
		search = search + "<c:out value='${freeVO.sTel}'/>";
		search = search + "<c:out value='${freeVO.sHand}'/>";
		search = search + "<c:out value='${freeVO.sAdd}'/>";
		search = search + "<c:out value='${freeVO.readyExam}'/>";
		search = search + "<c:out value='${freeVO.takeArea1}'/>";
		search = search + "<c:out value='${freeVO.takeArea2}'/>";
		search = search + "<c:out value='${freeVO.takeArea3}'/>";
		search = search + "<c:out value='${freeVO.sGrade}'/>";
		search = search + "<c:out value='${freeVO.sSchool}'/>";
		search = search + "<c:out value='${freeVO.lectureSdate}'/>";
		search = search + "<c:out value='${freeVO.lectureEdate}'/>";
		search = search + "<c:out value='${freeVO.readyTime}'/>";
		search = search + "<c:out value='${freeVO.sScore}'/>";
		search = search + "<c:out value='${freeVO.eScore}'/>";
		search = search + "<c:out value='${freeVO.examExp}'/>";
		search = search + "<c:out value='${freeVO.diffSubject}'/>";
		search = search + "<c:out value='${freeVO.planTime}'/>";
		search = search + "<c:out value='${freeVO.sDifficulties}'/>";
		search = search + "<c:out value='${freeVO.sStress}'/>";
		search = search + "<c:out value='${freeVO.sPath}'/>";
		search = search + "<c:out value='${freeVO.lectureExp}'/>";
		search = search + "<c:out value='${freeVO.sOpinion}'/>";
		search = search + "<c:out value='${freeVO.sRemark}'/>";
		search = search + "<c:out value='${freeVO.searchSdt}'/>";
		search = search + "<c:out value='${freeVO.searchEdt}'/>";
		if(search.length>0){
			$("#cont-search").removeClass();
		}
	});

	</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>현강생 관리</h3>
				<div class="btnWrap">
					<button type="button" class="colorBtn rightbluebtn plusIcon" onClick="javascript:fnActStudentWrite();">등록</button>
				</div>
			</div>
			<div class="realCont">

				<!--search-->
				<form name="frm" method="post" class="SearchForm">
  					<fieldset>
						<input name="pageIndex" type="hidden" value="<c:out value='${freeVO.pageIndex}'/>"/>
						<input name="sIdx" type="hidden"/>
						<div id="cont-search" class="search_min">
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
										<input type="text" name="sName" value="<c:out value="${freeVO.sName}" />">
  									</td>
									<th>연령/성별</th>
  									<td>
										<p>
											<select name="sAge" id="">
												<option value="">전체</option>
												<c:forEach var="ageList" begin="10" end="80" step="10" varStatus="status">
												<option value="<c:out value='${ageList}'/>" <c:if test="${freeVO.sAge eq ageList}">selected</c:if>><c:out value="${ageList}"/>대</option>
												</c:forEach>
											</select>
										</p>
										<p class="radioStyle">
											<input type="radio"  name="sSex" id="sex_" value="" ><label for="sex_"><span></span>전체</label>
											<input type="radio"  name="sSex" id="sex_m" value="M" <c:if test="${freeVO.sSex eq 'M'}">checked</c:if>><label for="sex_m"><span></span>남자</label>
											<input type="radio"  name="sSex" id="sex_w" value="W" <c:if test="${freeVO.sSex eq 'W'}">checked</c:if>><label for="sex_w"><span></span>여자</label>
										</p>
  									</td>
								</tr>
  								<tr>
									<th>생일</th>
  									<td>
										<p>
											<select name="birthdayM" id="" style="width:50px">
												<option value="" >전체</option>
												<c:forEach begin="1" end="12" var="idx" step="1">
												<c:set var="jmon" value="0${idx}"/>
												<c:set var="jmon" value="${fn:substring(jmon, fn:length(jmon)-2, fn:length(jmon) )}"/>
												<option value="<c:out value="${jmon}" />" <c:if test="${jmon eq freeVO.birthdayM}">selected</c:if>><c:out value="${jmon}" /></option>
												</c:forEach>
											</select> 월
										</p>
										<p>
											<select name="birthdayD" id="" style="width:50px">
												<option value="" >전체</option>
												<c:forEach begin="1" end="31" var="idx" step="1">
												<c:set var="jday" value="0${idx}"/>
												<c:set var="jday" value="${fn:substring(jday, fn:length(jday)-2, fn:length(jday) )}"/>
												<option value="<c:out value="${jday}" />" <c:if test="${jday eq freeVO.birthdayD}">selected</c:if>><c:out value="${jday}" /></option>
												</c:forEach>
											</select> 일
										</p>
  									</td>
  									<th scope="row">이메일</th>
									<td>
										<input type="text" name="sEmail" value="<c:out value="${freeVO.sEmail}" />" style="width:80%" >
									</td>
								</tr>
								<tr>
									<th scope="row">전화번호</th>
 									<td>
										<input type="text" name="sTel" value="<c:out value="${freeVO.sTel}" />" >
  									</td>
									<th scope="row">휴대폰</th>
									<td>
										<input type="text" name="sHand" value="<c:out value="${freeVO.sHand}" />">
									</td>
								</tr>
								<tr>
									<th scope="row">주소</th>
 									<td>
										<input type="text" name="sAdd" value="<c:out value="${freeVO.sAdd}" />" style="width:80%">
  									</td>
									<th scope="row">준비하는 시험</th>
 									<td>
										<select name="readyExam" style="width:180px">
											<option value="">전체</option>
										<c:import url="/boffice/activity/actLecCdType.do" charEncoding="utf-8">
											<c:param name="codeGb" value="LE" />
											<c:param name="frmTypeValue" value="${freeVO.readyExam}" />
										</c:import>
										</select>
  									</td>
								</tr>
								<tr>
									<th scope="row">응시지역</th>
									<td colspan="3">
										1지망 <input type="text" name="takeArea1" value="<c:out value="${freeVO.takeArea1}" />" > 
										2지망 <input type="text" name="takeArea2" value="<c:out value="${freeVO.takeArea2}" />" > 
										3지망 <input type="text" name="takeArea3" value="<c:out value="${freeVO.takeArea3}" />" > 
									</td>
								</tr>
								<tr>
									<th scope="row">학력</th>
 									<td>
										<select name="sGrade" style="width:180px" > 
											<option value="">전체</option>
											<option value="11" <c:if test="${freeVO.sGrade eq '11'}">selected</c:if>>고졸</option> 
											<option value="12" <c:if test="${freeVO.sGrade eq '12'}">selected</c:if>>전문대 재학중</option> 
											<option value="13" <c:if test="${freeVO.sGrade eq '13'}">selected</c:if>>전문대졸</option> 
											<option value="14" <c:if test="${freeVO.sGrade eq '14'}">selected</c:if>>대학 재학 중</option> 
											<option value="15" <c:if test="${freeVO.sGrade eq '15'}">selected</c:if>>대졸</option> 
											<option value="16" <c:if test="${freeVO.sGrade eq '16'}">selected</c:if>>대학원 재학 중</option> 
											<option value="17" <c:if test="${freeVO.sGrade eq '17'}">selected</c:if>>대학원 졸업</option> 
										</select>
  									</td>
									<th scope="row">출신학교</th>
									<td>
										<input type="text" name="sSchool" value="<c:out value="${freeVO.sSchool}" />" style="width:80%" >
									</td>
								</tr>
								<tr>
									<th scope="row">현장강의 수강기간</th>
 									<td>
										<input type="text" name="lectureSdate" class="calendar" value="<c:out value="${freeVO.lectureSdate}" />" > ~ 
										<input type="text" name="lectureEdate" class="calendar" value="<c:out value="${freeVO.lectureEdate}" />" >
  									</td>
									<th scope="row">시험준비기간</th>
 									<td>
										<input type="text" name="readyTime" value="<c:out value="${freeVO.readyTime}" />" style="width:80%" >
  									</td>
								</tr>
								<tr>
									<th scope="row">소지가산점</th>
									<td>
										<input type="text" name="sScore" value="<c:out value="${freeVO.sScore}" />" > ~ 
										<input type="text" name="eScore" value="<c:out value="${freeVO.eScore}" />" >
									</td>
									<th scope="row">공무원 시험 응시경험</th>
 									<td>
										<input type="text" name="examExp" value="<c:out value="${freeVO.examExp}" />" style="width:80%" >
  									</td>
								</tr>
								<tr>
									<th scope="row">가장 어렵게 느끼는 과목</th>
									<td>
										<input type="text" name="diffSubject" value="<c:out value="${freeVO.diffSubject}" />" style="width:80%" >
									</td>
									<th scope="row">공무원 시험 계획 기간</th>
 									<td>
										<input type="text" name="planTime" value="<c:out value="${freeVO.planTime}" />" style="width:80%" >
  									</td>
								</tr>
								<tr>
									<th scope="row">공부하면서 가장 힘든점</th>
									<td>
										<input type="text" name="sDifficulties" value="<c:out value="${freeVO.sDifficulties}" />" style="width:80%" >
									</td>
									<th scope="row">나만의 스트레스 해소법</th>
 									<td>
										<input type="text" name="sStress" value="<c:out value="${freeVO.sStress}" />" style="width:80%" >
  									</td>
								</tr>
								<tr>
									<th scope="row">본원을 알게 된 경로</th>
									<td>
										<input type="text" name="sPath" value="<c:out value="${freeVO.sPath}" />" style="width:80%" >
									</td>
									<th scope="row">타강의 수강 경험</th>
 									<td>
										<input type="text" name="lectureExp" value="<c:out value="${freeVO.lectureExp}" />" style="width:80%" >
  									</td>
								</tr>
								<tr>
									<th scope="row">학원에 하고싶은 말</th>
 									<td >
										<input type="text" name="sOpinion" value="<c:out value="${freeVO.sOpinion}" />" style="width:80%" >
									</td>
									<th scope="row">비고</th>
 									<td >
										<input type="text" name="sRemark" value="<c:out value="${freeVO.sRemark}" />" style="width:80%" >
									</td>
								</tr>
  								<tr>
  									<th>등록일</th>
  									<td colspan="3" class="daterange">
										<input class="calendar" type="text" name="searchSdt" value="<c:out value="${freeVO.searchSdt}" />">
										~
										<input class="calendar" type="text" name="searchEdt" value="<c:out value="${freeVO.searchEdt}" />">
										<button type="button" class="grybtn setdate today">오늘</button>
										<button type="button" class="grybtn setdate week">일주일</button>
										<button type="button" class="grybtn setdate month">한달</button>
										<button type="button" class="grybtn setdate clear">전체</button>
  									</td>
  								</tr>
  							</tbody>
  						</table>
						</div>
						<div id="btn_ext">▼ 확장</div>
		              <div class="btnsWrap">
      					<button class="">검색</button>
      				</div>
  					</fieldset>
  				</form>
			  <!--//search-->

			  <!--listTable-->
			  <p class="total">
  					<span class="total_left">검색결과 총 <span><c:out value="${paginationInfo.totalRecordCount}"/></span>건, <span><c:out value="${searchVO.pageIndex}"/></span>/<span><c:out value="${paginationInfo.lastPageNo}"/></span>pages</span>
  				</p>
				<form id="listFrm" name="listFrm">
				<input type="hidden" name="act" value="" />
				<table class="commonTable detailTable">
  					<caption>관리자 수강생관리 테이블</caption>
  					<colgroup>
						<col style="width:30px">
						<col style="width:60px">
  						<col style="width:100px">
  						<col style="width:60px">
  						<col style="width:150px">
  						<col style="width:150px">
  						<col >
  						<col style="width:250px">
  						<col style="width:120px">
  						<col style="width:60px">
  					</colgroup>
  					<thead>
  						<tr>
  							<th scope="col">
								<span class="checkBox">
									<input type="checkbox" class="check_all" data-check="no" id="check_all">
	  								<label for="check_all"><span></span>선택</label>
								</span>
  							</th>
							<th scope="col">번호</th>
  							<th scope="col">이름</th>
  							<th scope="col">성별</th>
  							<th scope="col">전화</th>
  							<th scope="col">휴대폰</th>
  							<th scope="col">이메일</th>
  							<th scope="col">준비하는시험</th>
  							<th scope="col">등록일</th>
  							<th scope="col">관리</th>
  						</tr>
  					</thead>
  					<tbody>
			 <c:forEach var="result" items="${resultList}" varStatus="status">
  						<tr data-no="<c:out value="${result.sIdx}"/>">
  							<td>
								<span class="checkBox">
									<input type="hidden" name="sIdx" id="sIdx" value="<c:out value="${result.sIdx}"/>"/>
									<input type="checkbox" class="no" name="searchChk" value="${result.sIdx}" id="no${result.sIdx}">
									<label for="no<c:out value='${result.sIdx}'/>"><span></span>선택</label>
								</span>
  							</td>
			                <td class="list-no"><c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/></td>
  							<td><a href="#" class="act_modi"><c:out value="${result.sName}"/></a></td>
  							<td><c:out value="${result.sSexNm}"/></td>
  							<td><c:out value="${result.sTel}"/></td>
  							<td><c:out value="${result.sHand}"/></td>
  							<td><c:out value="${result.sEmail}"/></td>
  							<td><c:out value="${result.readyExamNm}"/></td>
  							<td><c:out value="${fn:substring(result.regdt,0,10)}"/></td>
  							<td><button type="button" class="commonBtn act_modi">수정</button></td>
  						</tr>
  				</c:forEach>
  					<c:if test="${fn:length(resultList)<1}">
						<tr class="allmerge">
							<td>자료가 없습니다.</td>
						</tr>
					</c:if>
  					</tbody>
  				</table>
				</form>
			  <!--//listTable-->

				<!-- pagingType03 -->
				<div class="pageNation clear">
  					<button class="left act_list_del" onClick="javascript:fnActDelChk(); return false;">선택삭제</button> 
  					<button class="left act_dialog" data-act="mail" style="margin-left:4px;">메일발송</button>
					<ul class="pagenation">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnActStudentList" />
					</ul>
  					<button class="right act_excel">엑셀전환</button>
				</div>
				<!-- //pagingType03 -->

			</div>
		</section>

	</section>

	<div class="dialog" id="lyr_mail" title="메일 발송" data-width="540" data-height="420">
		<form method="post">
		<p>선택한 회원에게 메일을 발송합니다. </p>
		<input type="hidden" name="sIdx" value="" />
		<table class="rowTable">
			<colgroup>
				<col style="width:60px">
				<col style="width:*">
			</colgroup>
			<tbody>
				<tr>
					<th>제목</th>
					<td><input type="text" name="mailSubject" value="" class="req" title="메일 제목을 입력해주세요." style="width:420px" maxlength="100" /></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="mailCn" class="req" title="메일 내용을 입력해주세요." style="width:400px;height:190px;"></textarea></td>
				</tr>
			</tbody>
		</table>
		</form>
	</div>
<script type="text/javascript">
var dialog
var selected_no
$(function() {
	$(document).on('click', '.act_dialog', function() {
		if ($('#listFrm input[name=searchChk]:checked').length <= 0) {
			alert('선택된 회원이 없습니다.');
			return false;
		}
		var no = '';
		$.each($('#listFrm input[name=searchChk]:checked'), function() {
			no += (no == '' ? '' : ',')+$(this).val();
		});
		$obj_dialog = $('#lyr_'+$(this).data('act'));
		$obj_dialog.find('input[name=sIdx]').val(no);
		$obj_dialog.find('input:text').val('');
		$obj_dialog.find('textarea').val('');
		if ($obj_dialog.find('input:radio').length > 0) $obj_dialog.find('input:radio:first').prop('checked', true)
		if ($obj_dialog.find('select').length > 0) $obj_dialog.find('select>option:first').prop('selected', true)
		open_dialog($obj_dialog);
		return false;
	});
	function open_dialog($obj) {
		var d_width = $obj.data('width');
		var d_height = $obj.data('height');
		dialog = $obj.dialog({
			autoOpen: true,
			resizable:false,
			modal:true,
			height:d_height,
			width:d_width,
			buttons: {
				"적용": function() {
					if (form_val_chk($obj.find('form'))) {
						var url = '/boffice/actMemb/actStudentSendMail.do';
						var param = $obj.find('form').serialize();
						commonUtil.AjaxSynCall(url,param,'text','선택한 회원에게 메일이 발송되었습니다.');
						dialog.dialog( "destroy" );
					}
				},
				"취소": function() {
					dialog.dialog( "destroy" );
				}
			},
			close: function() {
				dialog.dialog( "destroy" );
			}
		});
	}
});

</script>

<%@include file="../include/footer.jsp"%>