<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/header.jsp"%>
	<script type="text/javascript">
	function press(event) {
		if (event.keyCode==13) {
			fnListArticle('1');
		}
	}

	function fnListArticle(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/boffice/bbs/bbsList.do'/>";
		document.frm.submit();
	}

	function fnWriteArticle() {
		document.frm.action = "<c:url value='/boffice/bbs/writeArticle.do'/>";
		document.frm.submit();
	}

	function fnViewArticle(nttId) {
		 if(!document.frm.bbsId.value) return false;
		 document.frm.nttId.value = nttId;
		 document.frm.action = "<c:url value='/boffice/bbs/viewAritcle.do'/>";
		 document.frm.submit();
	}
	function fnActEdit(nttId) {
		 if(!document.frm.bbsId.value) return false;
		 document.frm.nttId.value = nttId;
		 document.frm.action = "<c:url value='/boffice/bbs/forUpdateArticle.do'/>";
		 document.frm.submit();
	}
	function fnActDel(nttId) {
		if(!document.frm.bbsId.value) return false;
		if (confirm('삭제하시겠습니까?')) {
			var url = '/boffice/bbs/deleteBoardArticle.do';
			var formData = {nttId:nttId, bbsId:document.frm.bbsId.value};
			var param = formData;
			if(commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.') == "success"){
				fnListArticle(document.frm.pageIndex.value);
			}
		}
	}
	function fnActDelChk(){
		if ($('#listFrm input[name=searchChk]:checked').length <= 0) {
			alert('선택된 게시물이 없습니다.');
			return false;
		}
		if(!document.listFrm.bbsId.value) return false;
		if (confirm('선택한 게시물을 삭제하시겠습니까?')) {
			var url = '/boffice/bbs/deleteBoardArticle.do';
			var formData = $("#listFrm").serialize();
			var param = formData;
			if(commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.') == "success"){
				fnListArticle(document.frm.pageIndex.value);
			}
		}
	}
	/*function fnActOtherLoad(obj,bId,rep){
		if(!confirm("실행하시겠습니까?")){
			return;
		}
		var url = "<c:url value='/boffice/activity/oldBbsLoad.do' />";
		if(obj.indexOf("_특수")>-1){
			url = "<c:url value='/boffice/activity/oldKidsBbsLoad.do' />";
			obj = obj.replace("_특수","");
		}
		var param = {
				preBoardId : obj,
				bbsId : bId,
				replyAt : rep
				}
		commonUtil.AjaxSynCall(url,param,'text','실행되었습니다.');
		fnListArticle('1');
	}
	function fnActDownCntLoad(){
		if(!confirm("실행하시겠습니까?")){
			return;
		}
		var url = "<c:url value='/boffice/activity/oldDownCntLoad.do' />";
		var param = {};
		commonUtil.AjaxSynCall(url,param,'text','실행되었습니다.');
		fnListArticle('1');
	}*/


	$(document).on('click', '.act_ord', function() {
		var thisIdx = $(this).closest('tr').data('no');
		var thisSeq = $(this).val();
		var otherIdx = $(this).closest('tr').next().data('no');
		if($(this).data('dir') == 'up'){
			otherIdx = $(this).closest('tr').prev().data('no');
		}
		if(otherIdx == undefined){
			alert($(this).data('dir')=='up'?"첫 게시물입니다.":"마지막 게시물입니다.");
			return;
		}
		var url = "<c:url value='/boffice/bbs/seqSwitchUpdate.do' />";
		var param = {
				bbsId : document.frm.bbsId.value,
				nttId : thisIdx,
				nttSeq : thisSeq,
				preBoardId : otherIdx
				}
		commonUtil.AjaxSynCall(url,param);
		fnListArticle(document.frm.pageIndex.value);
	});

	$(document).on('change', '.SearchForm select[name=searchOp6]', function() {
		fnListArticle(document.frm.pageIndex.value);
	});

	$(function(){
		$('img').error(function(){
			$(this).attr('src', '/cmm/fms/getImage.do?atchFileId=&fileSn=0');
		});
	});
	</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3><c:out value='${brdMstrVO.bbsNm}'/></h3>
				<div class="btnWrap">
					<button type="button" class="colorBtn rightbluebtn act_ins" onClick="fnListArticle('1'); return false;">검색</button>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onClick="javascript:fnWriteArticle(); return false;">등록</button>
				</div>
			</div>
			<div class="realCont">

				<form name="frm" method="post" class="SearchForm">
  					<fieldset>
						<input type="hidden" name="bbsId" value="<c:out value='${boardVO.bbsId}'/>" />
						<input type="hidden" name="nttId"  value="0" />
						<input type="hidden" name="authFlag" value="<c:out value='${brdMstrVO.authFlag}'/>" />
						<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
						<table class="rowTable">
							<colgroup>
								<col style="width:9%">
								<col style="width:350px">
								<col style="width:9%">
								<col style="width:*">
							</colgroup>
							<tbody>
								<c:if test="${brdMstrVO.cateYn eq 'Y'}">
								<tr>
									<th>분류</th>
									<td colspan="3">
										<p>
											<select name=searchOp6 id="searchOp6">
												<option value="">선택</option>
												<c:import url="/boffice/activity/actFrmType.do" charEncoding="utf-8">
												<c:param name="frmTypeCode" value="${brdMstrVO.cateCd}" />
												<c:param name="frmTypeValue" value="${searchVO.searchOp6}" />
												</c:import>
											</select>
										</p>
									</td>
								</tr>
								</c:if>
								<tr>
									<th>검색어</th>
									<td colspan="3">
										<p>
											<select name="searchCnd" title="검색유형선력">
												<option value='1' <c:if test="${searchVO.searchCnd eq '1'}"> selected</c:if>>제목</option>						
												<option value='2' <c:if test="${searchVO.searchCnd eq '2'}"> selected</c:if>>내용</option>
												<option value='3' <c:if test="${searchVO.searchCnd eq '3'}"> selected</c:if>>작성자</option>
												<option value='4' <c:if test="${searchVO.searchCnd eq '4'}"> selected</c:if>>작성일</option>
												<option value='0' <c:if test="${searchVO.searchCnd eq '0'}"> selected</c:if>>전체</option>
											</select>
											<input  name="searchWrd" type="text" size="35" class="shc_text" value='<c:out value="${searchVO.searchWrd}" />' maxlength="35" onkeypress="press(event);" title="검색단어입력">
										</p>
									</td>
								</tr>
								<c:if test="${brdMstrVO.bbsId eq 'BBS_0007' || brdMstrVO.bbsId eq 'BBS_0013'}">
								<tr>
									<th>강의명</th>
									<td colspan="3">
										<p>
											<input  name="nttCat" type="text" size="200" class="shc_text" value='<c:out value="${searchVO.nttCat}" />' maxlength="200" onkeypress="press(event);" title="검색단어입력">
										</p>
									</td>
								</tr>
								</c:if>
								<c:if test="${brdMstrVO.hideYn eq 'Y'}">
								<tr>
									<th>노출여부</th>
									<td colspan="3">
										<p class="radioStyle">
											<input type="radio" name="searchOp7" id="searchOp70" value="" <c:if test="${empty searchVO.searchOp7}"> checked</c:if> />
											<label for="searchOp70"><span></span>전체</label>
											<input type="radio" name="searchOp7" id="searchOp72" value="N" <c:if test="${searchVO.searchOp7 eq 'N'}"> checked</c:if> />
											<label for="searchOp72"><span></span>보임</label>
											<input type="radio" name="searchOp7" id="searchOp71" value="Y" <c:if test="${searchVO.searchOp7 eq 'Y'}"> checked</c:if> />
											<label for="searchOp71"><span></span>숨김</label>
										</p>
									</td>
								</tr>
								</c:if>
  								<tr>
  									<th>등록일</th>
  									<td colspan="3" class="daterange">
										<input class="calendar" type="text" name="searchSdt" value="<c:out value="${searchVO.searchSdt}" />">
										~
										<input class="calendar" type="text" name="searchEdt" value="<c:out value="${searchVO.searchEdt}" />">
										<button type="button" class="grybtn setdate today">오늘</button>
										<button type="button" class="grybtn setdate week">일주일</button>
										<button type="button" class="grybtn setdate month">한달</button>
										<button type="button" class="grybtn setdate clear">전체</button>
  									</td>
  								</tr>
							</tbody>
						</table>
  					</fieldset>
				</form>

				<div class="totalWrap clear">
				<p class="total">검색결과 총 <span><c:out value="${paginationInfo.totalRecordCount}"/></span>건, <span><c:out value="${searchVO.pageIndex}"/></span>/<span><c:out value="${paginationInfo.lastPageNo}"/></span>pages</p>
				</div>
				
				<!-- listType05 -->
					<form name="submitParam" method="post">
						<input type="hidden" name="bbsId" value="<c:out value='${boardVO.bbsId}'/>"  />
						<input type="hidden" name="nttId"  />
					</form>
					<form name="listFrm" id="listFrm" method="post">
					<input type="hidden" name="bbsId" value="<c:out value='${boardVO.bbsId}'/>" />
					<table class="commonTable detailTable">
						<caption class="blind"><c:out value="${brdMstrVO.bbsNm}"/> 목록</caption>
						<thead>
							<tr>
	  							<th scope="col" width="30px">
									<span class="checkBox">
										<input type="checkbox" class="check_all" data-check="no" id="check_all">
		  								<label for="check_all"><span></span>선택</label>
									</span>
	  							</th>
								<th scope="col" width="60px">번호</th>
								<th scope="col" width="70px">일련번호</th>
								<c:if test="${brdMstrVO.seqYn eq 'Y'}">
								<th scope="col" width="40px">순서</th>
								</c:if>
								<c:if test="${brdMstrVO.cateYn eq 'Y'}">
								<th scope="col" width="80px">분류</th>
								</c:if>
								<c:if test="${brdMstrVO.bbsId eq 'BBS_0017'}">
								<th scope="col" width="80px">지역</th>
								</c:if>
								<c:if test="${brdMstrVO.bbsId eq 'BBS_0007' || brdMstrVO.bbsId eq 'BBS_0013'}">
								<th scope="col" width="230px">강의명</th>
								</c:if>
								<c:if test="${brdMstrVO.bbsId eq 'BBS_0018'}">
								<th scope="col" width="160px">직렬</th>
								<th scope="col" width="60px">직렬범위</th>
								</c:if>
								<c:if test="${brdMstrVO.repYn eq 'Y'}">
								<th scope="col" width="40px">답변</th>
								</c:if>
								<c:if test="${brdMstrVO.thumYn eq 'Y'}">
								<th scope="col" width="60px">썸네일</th>
								</c:if>
								<th scope="col" width="*">제목</th>
								<c:if test="${brdMstrVO.fileYn eq 'Y'}">
								<th scope="col" width="60px">첨부파일</th>
								</c:if>
								<c:if test="${brdMstrVO.seqYn eq 'Y'}">
								<th scope="col" width="80px">순서변경</th>
								</c:if>
								<th scope="col" width="80px">작성자</th>
								<th scope="col" width="60px">조회수</th>
								<c:if test="${brdMstrVO.hideYn eq 'Y'}">
								<th scope="col" width="40px">노출</th>
								</c:if>
								<th scope="col" width="90px">작성일</th>
								<th scope="col" width="100px">관리</th>
							</tr>
						</thead>
						<tbody>
	 <c:forEach var="result" items="${resultList}" varStatus="status">
							<tr data-no="${result.nttIdOr}" class="view-<c:if test="${result.nttHidden eq 'Y'}">n</c:if><c:if test="${result.nttHidden ne 'Y'}">y</c:if>">
	  							<td>
									<span class="checkBox">
										<input type="checkbox" class="no" name="searchChk" value="${result.nttIdOr}" id="no${result.nttIdOr}">
										<label for="no${result.nttIdOr}"><span></span>선택</label>
									</span>
	  							</td>
								<td>
									<c:if test="${result.nttTop eq 'Y'}"><i class="notice">공지</i></c:if>
									<c:if test="${result.nttTop ne 'Y'}">
									<c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/>
									</c:if>
								</td>
								<td><c:out value="${result.nttId}"/></td>
								<c:if test="${brdMstrVO.seqYn eq 'Y'}">
								<td><c:out value="${result.nttSeq}"/></td>
								</c:if>
								<c:if test="${brdMstrVO.cateYn eq 'Y'}">
								<td><c:out value="${result.nttCatNm}"/><c:out value="${result.nttLecCdNm}"/></td>
								</c:if>
								<c:if test="${brdMstrVO.bbsId eq 'BBS_0017'}">
								<td><c:out value="${result.bExt1}"/></td>
								</c:if>
								<c:if test="${brdMstrVO.bbsId eq 'BBS_0007' || brdMstrVO.bbsId eq 'BBS_0013'}">
								<td><c:out value="${result.nttLecNm}"/></td>
								</c:if>
								<c:if test="${brdMstrVO.bbsId eq 'BBS_0018'}">
								<td><c:out value="${result.nttLecCdNm}"/></td>
								<td>
									<c:if test="${result.nttLock ne 'Y'}"> 전체</c:if>
									<c:if test="${result.nttLock eq 'Y'}"> 수강회원</c:if>
								</td>
								</c:if>
								<c:if test="${brdMstrVO.repYn eq 'Y'}">
								<td><c:if test="${!empty result.replyId && result.nttNo eq '1'}">완료</c:if><c:if test="${empty result.replyId && result.nttNo eq '1'}">대기</c:if></td>
								</c:if>
								<c:if test="${brdMstrVO.thumYn eq 'Y'}">
								<td><img src="/cmm/fms/getImage.do?atchFileId=<c:out value='${result.thumFileId}'/>&fileSn=0" style="width:160px;"></td>
								</c:if>
								<td class="al">
									<c:if test="${brdMstrVO.bbsId eq 'BBS_0010' && !empty result.bmPic}">
										<div class="board-book-info">
										<c:if test="${fn:substring(result.bmPic,0,8) ne 'FILE_000'}">
										<img src="/images/bookbm/<c:out value="${result.bmPic}"/>" class="img" style="float:left;width:30px;height:40px;margin-right:4px;">
										</c:if>
										<c:if test="${fn:substring(result.bmPic,0,8) eq 'FILE_000'}">
										<img src='/cmm/fms/getImage.do?atchFileId=<c:out value='${result.bmPic}'/>&fileSn=0' class="img" style="float:left;width:30px;height:40px;margin-right:4px;">
										</c:if>
										<c:out value="${fn:substring(result.bmSubject,0,50)}"/><c:if test="${fn:length(result.nttSj)>50}">...</c:if>
										 <c:out value='${result.bmSubject}'/>
										 </div>
									</c:if>
									<c:if test="${result.nttNo>1}">
									<i class="reply" style="margin-left:<c:out value='${6+(result.replyLc-1)*14}'/>px"></i>
									</c:if>
									<a href="javascript:void(0);"  onclick="javascript:fnViewArticle('${result.nttIdOr}', '${result.bbsId}');">
									<c:out value="${fn:substring(result.nttSj,0,50)}" escapeXml="false"/><c:if test="${fn:length(result.nttSj)>50}">...</c:if>
									<fmt:parseDate value="${newDate}" var="cnewDate" pattern="yyyy-MM-dd"/>
									<fmt:parseDate value="${result.nttRegdt}" var="cnttRegdt" pattern="yyyy-MM-dd"/>
									<c:if test="${brdMstrVO.newYn eq 'Y' && cnttRegdt >= cnewDate}">
									<font color="black"><i class="newText">NEW</i></font>
									</c:if>
									</a>
								</td>							
								<c:if test="${brdMstrVO.fileYn eq 'Y'}">
								<td align="center">
						<c:if test="${!empty result.atchFileId}">
									<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${result.atchFileId}" />
										<c:param name="param_atchFileMd" value="LIST" />
									</c:import>
						</c:if>
								</td>
								</c:if>
								<c:if test="${brdMstrVO.seqYn eq 'Y'}">
  								<td>
  									<button type="button" class="commonBtn act_ord" data-dir="up" value="<c:out value='${result.nttSeq}'/>"><i class="upBtn">위</i></button>
  									<button type="button" class="commonBtn act_ord" data-dir="down" value="<c:out value='${result.nttSeq}'/>"><i class="downBtn">아래</i>
  								</td>
								</c:if>
								<td><c:out value="${result.ntcrNm}"/></td>
								<td class="chkmoney"><c:out value="${result.rdcnt}"/></td>
								<c:if test="${brdMstrVO.hideYn eq 'Y'}">
								<td style="color:#FF0000;"><c:if test="${result.nttHidden ne 'Y'}">보임</c:if><c:if test="${result.nttHidden eq 'Y'}">숨김</c:if></td>
								</c:if>
								<td><c:out value="${result.nttRegdt}"/></td>
								<td>
							    	<button type="button" class="commonBtn" onclick="javascript:fnActEdit('${result.nttIdOr}');">수정</button>
							    	<button type="button" class="commonBtn" onclick="javascript:fnActDel('${result.nttIdOr}');">삭제</button>
								</td>
							</tr>
	 </c:forEach>										
							
						</tbody>
					</table>
					</form>

				<!-- pagingType03 -->
				<div class="pageNation clear">
  					<button type="button" class="left act_list_del" onClick="javascript:fnActDelChk(); return false;">선택삭제</button> 
					<ul class="pagenation">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnListArticle" />
					</ul>
					<button type="button" class="right act_write" onClick="javascript:fnWriteArticle(); return false;">글쓰기</button> 
				</div>
				<!-- //pagingType03 -->

			</div>
		</section>

	</section>

<%@include file="../include/footer.jsp"%>