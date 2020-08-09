<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/header.jsp"%>
<script type="text/javascript">
	function press(event) {
		if (event.keyCode==13) {
			fn_egov_select_brdMstr('1');
		}
	}

	function fn_egov_insert_addBrdMstr(){
		document.frm.action = "<c:url value='/boffice/bbs/addBBSMaster.do'/>";
		document.frm.submit();
	}

	function fn_egov_select_brdMstr(pageNo){
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/boffice/bbs/actBbsMasterList.do'/>";
		document.frm.submit();
	}

	function fn_egov_inqire_brdMstr(bbsId){
		document.frm.bbsId.value = bbsId;
		document.frm.action = "<c:url value='/boffice/bbs/actBbsMasterView.do'/>";
		document.frm.submit();
	}
</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>게시판 마스터</h3>
				<div class="btnWrap">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fn_egov_insert_addBrdMstr(); return false;">등록</button>
				</div>
			</div>
			<div class="realCont">

				<form name="frm" action="<c:url value='/boffice/bbs/actBbsMasterList.do'/>" method="post" class="SearchForm">
  					<fieldset>
						<input type="hidden" name="pageIndex" value="<c:out value="${searchVO.pageIndex}" />">
						<input type="hidden" name="bbsId">
						<input type="hidden" name="trgetId">
						<table class="rowTable">
							<colgroup>
								<col style="width:9%">
								<col style="width:350px">
								<col style="width:9%">
								<col style="width:*">
							</colgroup>
							<tbody>
								<tr>
									<th>검색어</th>
									<td colspan="3" class="category_select" data-part="moving">
										<p>
											<select name="searchCnd" title="검색유형선력">
												<option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >전체</option>
												<option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >게시판명</option>
												<option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if> >게시판코드</option>
											</select>
											<input  name="searchWrd" type="text" size="35" class="shc_text" value='<c:out value="${searchVO.searchWrd}" />' maxlength="35" onkeypress="press(event);" title="검색단어입력">
										</p>
									</td>
								</tr>
							</tbody>
						</table>
						<div class="btnsWrap">
							<button type="button" class="" onclick="fn_egov_select_brdMstr('1'); return false;">검색</button>
						</div>
  					</fieldset>
				</form>

				<div class="total">총 <span><c:out value='${resultCnt}'/></span> 건의 게시글</div>
				<form name="submitParam" method="post">
					<input type="hidden" name="bbsId"  />
					<input type="hidden" name="nttId"  />
				</form>
				<table class="commonTable detailTable">
					<thead>
						<tr>
						    <th scope="col" class="first_line" width="5%" nowrap>번호</th>
						    <th scope="col" class="first_line" width="10%" nowrap>게시판코드</th>
						    <th scope="col" class="first_line" width="*" nowrap>게시판명</th>
						    <th scope="col" class="first_line" width="10%" nowrap>게시판유형</th>
						    <th scope="col" class="first_line" width="8%" nowrap>사용여부</th>
						    <th scope="col" class="first_line" width="5%" nowrap>관리</th>
						</tr>
					</thead>
					<tbody>
	<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td><c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/></td>
						    <td><c:out value="${result.bbsId}"/></td>
							<td class="tal">
								<a href="<c:url value='/boffice/bbs/actBbsMasterView.do'/>?bbsId=<c:out value='${result.bbsId}'/>">
									<c:out value="${result.bbsNm}"/>
								</a>
							</td>
						    <td>
						    	<c:if test="${result.thumYn ne 'Y'}">일반</c:if>
						    	<c:if test="${result.thumYn eq 'Y'}">썸네일</c:if>
							</td>
						    <td>
						    	<c:if test="${result.useYn eq 'N'}"><spring:message code="button.notUsed" /></c:if>
						    	<c:if test="${result.useYn eq 'Y'}"><spring:message code="button.use" /></c:if>
						    </td>
						    <td>
						    	<button type="button" class="commonBtn" onclick="javascript:location.href='<c:url value='/boffice/bbs/actBbsMasterView.do'/>?bbsId=<c:out value='${result.bbsId}'/>'">수정</button>
						    </td>
						</tr>
	</c:forEach>
					</tbody>
				</table>
	
				<!-- pagingType03 -->
				<div class="pageNation clear">
					<ul class="pagenation">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_brdMstr" />
					</ul>
				</div>
				<!-- //pagingType03 -->
	
			</div>
		</section>

	</section>

<%@include file="../include/footer.jsp"%>