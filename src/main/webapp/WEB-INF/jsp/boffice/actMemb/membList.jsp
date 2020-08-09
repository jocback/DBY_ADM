<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/header.jsp"%>
	<script type="text/javascript">

	function press(event) {
		if (event.keyCode==13) {
			fnActMembList('1');
		}
	}
	function fnActMembList(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/boffice/actMemb/actMembList.do'/>";
		document.frm.submit();
	}
	function fnActMembView(obl) {
		 if(!obl) return false;
		 document.frm.mIdx.value=obl;
		 document.frm.action = "<c:url value='/boffice/actMemb/actMembView.do'/>";
		 document.frm.submit();
	}
	function fnActMembWrite() {
		document.frm.mIdx.value="";
		document.frm.action = "<c:url value='/boffice/actMemb/actMembView.do'/>";
		document.frm.submit();
	}
	function fnActExcellDown() {
		if(!$("input[name='searchSdt']").val() || !$("input[name='searchEdt']").val()){
			alert("가입일을 지정하여 주세요");
			return false;
		}
		document.frm.action = "<c:url value='/boffice/actMemb/downloadActMembExcel.do'/>";
		document.frm.submit();
	}

	function fnActDelChk(){
		if ($('#listFrm input[name=searchChk]:checked').length <= 0) {
			alert('선택된 회원이 없습니다.');
			return false;
		}
		if (confirm('선택한 회원을 탈퇴처리하시겠습니까?')) {
			var url = '/boffice/actMemb/deleteActMemb.do';
			var formData = $("#listFrm").serialize();
			var param = formData;
			if(commonUtil.AjaxSynCall(url,param,'text','처리되었습니다.') == "success"){
				fnActMembList(document.frm.pageIndex.value);
			}
		}
	}

	$(function(){
		$(".searchSelect").change(function(){
			fnActMembList('1');
		});
	});
	
	/*function fnActMembOldLoad(){
		if(!confirm("실행하시겠습니까?")){
			return;
		}
		var url = "<c:url value='/boffice/activity/oldMemberLoad.do' />";
		var param = {}
		commonUtil.AjaxSynCall(url,param,'text','실행되었습니다.');
		fnActMembList('1');
	}
	
	function fnActMembOldPass(){
		if(!confirm("실행하시겠습니까?")){
			return;
		}
		var url = "<c:url value='/boffice/activity/oldMemberPassTran.do' />";
		var param = {}
		commonUtil.AjaxSynCall(url,param,'text','실행되었습니다.');
		fnActMembList('1');
	}*/
	
	$(document).on("click",".act_excel",function(){
		document.frm.action = "/boffice/actMemb/selectMembListEmail.do";
		document.frm.submit();
	});
	</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>회원 리스트</h3>
				<div class="btnWrap">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onClick="javascript:fnActMembList('1');">검색</button>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onClick="javascript:fnActExcellDown();">엑셀다운</button>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_excel">이메일다운로드</button>
				</div>
			</div>
			<div class="realCont">

				<fieldset style="margin-bottom:4px">
					<table class="commonTable detailTable">
						<colgroup>
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:*">
						</colgroup>
						<thead>
							<tr>
								<th>전체가입수</th>
								<th>남자</th>
								<th>여자</th>
								<th>오늘접속수</th>
								<th>총접속수</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="chkmoney"><c:out value="${totCnt.total}"/></td>
								<td class="chkmoney"><c:out value="${totCnt.totalMan}"/></td>
								<td class="chkmoney"><c:out value="${totCnt.totalWoman}"/></td>
								<td class="chkmoney"><c:out value="${loginTotCnt.totalToday}"/></td>
								<td class="chkmoney"><c:out value="${loginTotCnt.totalLogin}"/></td>
							</tr>
						</tbody>
					</table>
				</fieldset>

				<form name="frm" method="post" class="SearchForm">
					<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
					<input name="mIdx" type="hidden" />
					<table class="rowTable">
						<colgroup>
							<col style="width:9%">
							<col style="width:350px">
							<col style="width:9%">
							<col style="width:*">
						</colgroup>
						<tbody>
							<tr>
								<th>이름</th>
								<td>
									<p>
										<input type="text" class="sch_text" style="width:90px;" name="searchOp1" id="searchOp1" value='<c:out value="${searchVO.searchOp1}"/>' />
									</p>
								</td>
								<th>아이디</th>
								<td>
									<p>
										<input type="text" class="sch_text" style="width:90px;" name="searchOp2" id="searchOp2" value='<c:out value="${searchVO.searchOp2}"/>' />
									</p>
								</td>
							</tr>
							<tr>
								<th>회원구분</th>
								<td>
									<p>
									<select name="searchActgubun" id="searchActgubun">
										<option value="">선택</option>
										<c:import url="/boffice/activity/actFrmType.do" charEncoding="utf-8">
											<c:param name="frmTypeCode" value="COM044" />
											<c:param name="frmTypeValue" value="${searchVO.searchActgubun}" />
										</c:import>
									</select>
									</p>
								</td>
								<th>이메일</th>
								<td>
									<p>
										<input type="text" class="sch_text" style="width:90px;" name="searchOp4" id="searchOp4" value='<c:out value="${searchVO.searchOp4}"/>' />
										<input type="checkbox" class="sch_text" name="searchCnd3" id="searchCnd3" value="Y" style="width:20px;" <c:if test="${searchVO.searchCnd3 eq 'Y'}">checked</c:if> />이메일수신동의
									</p>
								</td>
							</tr>
							<tr>
								<th>연락처</th>
								<td>
									<p>
										<input type="text" class="sch_text" style="width:90px;" name="searchOp5" id="searchOp5" value='<c:out value="${searchVO.searchOp5}"/>' />
										<input type="checkbox" class="sch_text" name="searchCnd2" id="searchCnd2" value="Y" style="width:20px;" <c:if test="${searchVO.searchCnd2 eq 'Y'}">checked</c:if> />SMS수신동의
									</p>
								</td>
								<th>주소</th>
								<td>
									<p>
										<input type="text" class="sch_text" style="width:90px;" name="searchOp6" id="searchOp6" value='<c:out value="${searchVO.searchOp6}"/>' />
									</p>
								</td>
							</tr>
							<tr>
								<th>특이사항</th>
								<td>
									<p>
										<input type="text" class="sch_text" style="width:90px;" name="searchOp7" id="searchOp7" value='<c:out value="${searchVO.searchOp7}"/>' />
									</p>
								</td>
								<th></th>
								<td>
									<p>
										
									</p>
								</td>
							</tr>
							<tr>
								<th>가입일</th>
								<td colspan="3" class="daterange">
									<input class="calendar" type="text" name="searchSdt" value="<c:out value="${searchVO.searchSdt}" />"> ~ 
									<input class="calendar" type="text" name="searchEdt" value="<c:out value="${searchVO.searchEdt}" />">
									<button type="button" class="grybtn setdate today">오늘</button>
									<button type="button" class="grybtn setdate week">일주일</button>
									<button type="button" class="grybtn setdate month">한달</button>
									<button type="button" class="grybtn setdate clear">전체</button>
								</td>
							</tr>
						</tbody>
					</table>
				</form>			
				
				<div style="margin:20px 0 5px 0;">검색결과 총 <span><c:out value="${paginationInfo.totalRecordCount}"/></span>건, <span><c:out value="${searchVO.pageIndex}"/></span>/<span><c:out value="${paginationInfo.lastPageNo}"/></span>pages</div>
				
				<fieldset>
					<table class="commonTable detailTable">
						<colgroup>
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:*">
						</colgroup>
						<thead>
							<tr>
								<th>가입수</th>
								<th>남자</th>
								<th>여자</th>
								<th>오늘접속수</th>
								<th>접속수</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="chkmoney"><c:out value="${condTotCnt.cond}"/></td>
								<td class="chkmoney"><c:out value="${condTotCnt.condMan}"/></td>
								<td class="chkmoney"><c:out value="${condTotCnt.condWoman}"/></td>
								<td class="chkmoney"><c:out value="${condTotCnt.condToday}"/></td>
								<td class="chkmoney"><c:out value="${condTotCnt.condLogin}"/></td>
							</tr>
						</tbody>
					</table>
				</fieldset>
				<!-- //sch_list -->
				<form name="listFrm" id="listFrm" method="post">
				<!-- listType05 -->
					<table class="commonTable detailTable">
						<caption class="blind">목록</caption>
						<colgroup>
							<col width="40px" />
							<col width="50px" />
							<col width="80px" />
							<col width="80px" />
							<col width="*" />
							<col width="210px" />
							<col width="120px" />
							<col width="50px" />
							<col width="90px" />
							<col width="50px" />							
						</colgroup>
						<thead>
							<tr>
								<th>
									<span class="checkBox">
										<input type="checkbox" class="check_all" data-check="no" id="check_all" name="check_all" value="Y">
		  								<label for="check_all"><span></span>선택</label>
									</span>
								</th>
								<th>번호</th>
								<th>구분</th>
								<th>이름</th>
								<th>아이디</th>
								<th>이메일</th>
								<th>연락처</th>
								<th>가입경로</th>
								<th>가입일</th>								
								<th>관리</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>	
								<td>
									<span class="checkBox">
										<input type="hidden" name="mIdx" id="mIdx" value="<c:out value="${result.mIdx}"/>"/>
										<input type="checkbox" class="no" name="searchChk" value="${result.mIdx}" id="no${result.mIdx}">
										<label for="no<c:out value='${result.mIdx}'/>"><span></span>선택</label>
									</span>
								</td>
								<td><c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/></td>
								<td><c:out value="${result.mGubun}"/></td>
								<td><c:out value="${result.mName}"/></td>
								<td><a href="javascript:void(0);" onclick="javascript:fnActMembView(${result.mIdx});"><c:out value="${result.mId}"/></a></td>
								<td><c:out value="${result.mEmail}"/></td>
								<td><c:out value="${result.mHp}"/></td>
								<td><c:out value="${result.mWay}"/></td>
								<td><c:out value="${result.regdtC}"/></td>
								<td>
							    	<button type="button" class="commonBtn" onclick="javascript:fnActMembView(${result.mIdx});">수정</button>
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</form>
				<!-- //listType05 -->

				<!-- pagingType03 -->
				<div class="pageNation clear">
  					<button type="button" class="left act_list_del" onClick="javascript:fnActDelChk(); return false;">선택탈퇴</button> 
  					<button class="left act_dialog" data-act="mail" style="margin-left:4px;">메일발송</button>
					<ul class="pagenation">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnActMembList" />
					</ul>
				</div>
				<!-- //pagingType03 -->

			</div>
		</section>

	</section>
	<div class="dialog" id="lyr_mail" title="메일 발송" data-width="540" data-height="420">
		<form method="post">
		<p>선택한 회원에게 메일을 발송합니다. </p>
		<input type="hidden" name="mIdx" value="" />
		<table class="rowTable">
			<colgroup>
				<col style="width:60px">
				<col style="width:*">
			</colgroup>
			<tbody>
				<tr>
					<th>제목</th>
					<td><input type="text" name="fileid" value="" class="req" title="메일 제목을 입력해주세요." style="width:420px" maxlength="100" /></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="fileCn" class="req" title="메일 내용을 입력해주세요." style="width:400px;height:190px;"></textarea></td>
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
		$obj_dialog.find('input[name=mIdx]').val(no);
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
						var url = '/boffice/actMemb/actMembSendMail.do';
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