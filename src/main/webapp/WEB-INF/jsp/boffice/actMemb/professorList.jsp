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
		document.frm.action = "<c:url value='/boffice/actMemb/actProfList.do'/>";
		document.frm.submit();
	}
	function fnActMembView(obl) {
		 if(!obl) return false;
		 document.frm.mIdx.value=obl;
		 document.frm.action = "<c:url value='/boffice/actMemb/actProfView.do'/>";
		 document.frm.submit();
	}
	function fnActMembWrite() {
		document.frm.mIdx.value="";
		 document.frm.action = "<c:url value='/boffice/actMemb/actProfView.do'/>";
		 document.frm.submit();
	}

	$(function(){
		$(".searchSelect").change(function(){
			fnActMembList('1');
		});
	});
	
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

	function fnActSeqUp(){
		if ($('#listFrm input[name=pSeq]').length <= 0) {
			alert('수정할 항목이 없습니다.');
			return false;
		}
		if (confirm('수정하시겠습니까?')) {
			var url = '/boffice/actMemb/updateProfSeq.do';
			var formData = $("#listFrm").serialize();
			var param = formData;
			if(commonUtil.AjaxSynCall(url,param,'text','수정되었습니다.') == "success"){
				fnActMembList(document.frm.pageIndex.value);
			}
		}
	}

	/*function fnActMembOldLoad(){
		if(!confirm("실행하시겠습니까?")){
			return;
		}
		var url = "<c:url value='/boffice/activity/oldProfLoad.do' />";
		var param = {}
		commonUtil.AjaxSynCall(url,param,'text','실행되었습니다.');
		fnActMembList('1');
	}*/
	
	</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>교수 리스트</h3>
				<div class="btnWrap">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onClick="javascript:fnActMembList('1');">검색</button>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onClick="javascript:document.frm.action='/boffice/actMemb/downloadActProfExcel.do';document.frm.submit();">엑셀다운</button>
				</div>
			</div>
			<div class="realCont">

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
								<th>노출여부</th>
								<td>
									<p class="radioStyle">
										<input type="radio" name="searchOp3" value="" id="searchOp30"><label for="searchOp30"><span></span>전체</label>
										<input type="radio" name="searchOp3" value="Y" id="searchOp31" <c:if test="${searchVO.searchOp3 eq 'Y'}"> checked</c:if>><label for="searchOp31"><span></span>보임</label>
										<input type="radio" name="searchOp3" value="N" id="searchOp32" <c:if test="${searchVO.searchOp3 eq 'N'}"> checked</c:if>><label for="searchOp32"><span></span>숨김</label>
									</p>
								</td>
							</tr>
							<tr>
								<th>아이디</th>
								<td>
									<p>
										<input type="text" class="sch_text" style="width:90px;" name="searchOp2" id="searchOp2" value='<c:out value="${searchVO.searchOp2}"/>' />
									</p>
								</td>
								<th>이메일</th>
								<td>
									<p>
										<input type="text" class="sch_text" style="width:90px;" name="searchOp4" id="searchOp4" value='<c:out value="${searchVO.searchOp4}"/>' />
									</p>
								</td>
							</tr>
							<tr>
								<th>연락처</th>
								<td>
									<p>
										<input type="text" class="sch_text" style="width:90px;" name="searchOp5" id="searchOp5" value='<c:out value="${searchVO.searchOp5}"/>' />
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
							<col width="40px" />
							<col width="210px" />
							<col width="120px" />
							<col width="150px" />
							<col width="40px" />							
							<col width="50px" />							
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
								<th>순서</th>
								<th>이름</th>
								<th>아이디</th>
								<th>성별</th>
								<th>이메일</th>
								<th>연락처</th>
								<th>전공과목</th>
								<th>노출</th>								
								<th>강의수</th>
								<th>관리</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr <c:if test="${result.pShow eq '숨김'}">style="background-color:#F4F4F4;"</c:if>>	
								<td>
									<span class="checkBox">
										<input type="hidden" name="mIdx" id="mIdx" value="<c:out value="${result.mIdx}"/>"/>
										<input type="checkbox" class="no" name="searchChk" value="${result.mIdx}" id="no${result.mIdx}">
										<label for="no<c:out value='${result.mIdx}'/>"><span></span>선택</label>
									</span>
								</td>
								<td><c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/></td>
								<td>
									<c:if test="${result.pShow ne '숨김'}">
									<input type="text" name="pSeq" id="pSeq" value="<c:out value="${result.pSeq}"/>" class="chknum" style="width:40px;" maxlength="3"/>
									</c:if>
									<c:if test="${result.pShow eq '숨김'}">
									<input type="hidden" name="pSeq" id="pSeq" value="<c:out value="${result.pSeq}"/>"/>숨김
									</c:if>
								</td>
								<td><c:out value="${result.mName}"/></td>
								<td><a href="javascript:void(0);" onclick="javascript:fnActMembView(${result.mIdx});"><c:out value="${result.mId}"/></a></td>
								<td><c:out value="${result.mSex}"/></td>
								<td><c:out value="${result.mEmail}"/></td>
								<td><c:out value="${result.mHp}"/></td>
								<td><c:out value="${result.pMajor}"/></td>
								<td><c:out value="${result.pShow}"/></td>
								<td><c:out value="${result.lecCnt}"/></td>
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
  					<button type="button" class="left act_list_del" onClick="javascript:fnActSeqUp(); return false;">순서변경</button> 
					<ul class="pagenation">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnActMembList" />
					</ul>
				</div>
				<!-- //pagingType03 -->

			</div>
		</section>

	</section>

<%@include file="../include/footer.jsp"%>