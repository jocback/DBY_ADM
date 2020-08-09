<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/header.jsp"%>
	<script type="text/javascript">
	function press(event) {
		if (event.keyCode==13) {
			fnActEmpList('1');
		}
	}
	function fnActEmpList(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/boffice/actEmp/actEmpList.do'/>";
		document.frm.submit();
	}
	function fnActEmpView(no) {
		 if(!no) return false;
		 document.frm.empId.value = no;
		 document.frm.action = "<c:url value='/boffice/actEmp/actEmpView.do'/>";
		 document.frm.submit();
	}
	function fnActEmpWrite() {
		 document.frm.empId.value = "";
		 document.frm.action = "<c:url value='/boffice/actEmp/actEmpView.do'/>";
		 document.frm.submit();
	}
	function fnActEmpDel(obj){
		if(!confirm("삭제하시겠습니까?")){
			return;
		}
		var url = "<c:url value='/boffice/actEmp/deleteActEmp.do' />";
		var param = {empId : obj}
		commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.');
		fnActEmpList('1');
	}
	</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>관리자 관리</h3>
				<div class="btnWrap">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onClick="javascript:fnActEmpWrite();">등록</button>
				</div>
			</div>
			<div class="realCont">

				<form name="frm" method="post" class="SearchForm">
  					<fieldset>
						<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
						<input name="empId" type="hidden"/>
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
									<td colspan="3">
										<p>
											<select name="searchCnd" title="검색유형선력">
												<option value="all" <c:if test="${searchVO.searchCnd eq 'all'}"> selected</c:if>>전체</option>
												<option value="actEmpnm" <c:if test="${searchVO.searchCnd eq 'actEmpnm'}"> selected</c:if>>이름</option>
												<option value="actempId" <c:if test="${searchVO.searchCnd eq 'actempId'}"> selected</c:if>>ID</option>
											</select>
											<input  name="searchKeyword" type="text" size="35" class="shc_text" value='<c:out value="${searchVO.searchKeyword}" />' maxlength="35" onkeypress="press(event);" title="검색단어입력">
										</p>
									</td>
								</tr>
							</tbody>
						</table>
						<div class="btnsWrap">
							<button type="button" class="" onclick="javascript:fnActEmpList('1'); return false;">검색</button>
						</div>
  					</fieldset>
				</form>

				<!--menuTable-->
				<table class="commonTable detailTable">
					<caption>관리자 관리 테이블</caption>
					<colgroup>
							<col width="50px" />
							<col width="120px" />
							<col width="100px" />
							<col width="80px" />
							<col width="120px" />
							<col width="80px" />
							<col width="*" />
							<col width="80px" />
							<col width="60px" />
							<col width="120px" />
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>관리자권한</th>
							<th>ID</th>
							<th>이름</th>
							<th>부서</th>
							<th>직위</th>
							<th>이메일</th>
							<th>등록일</th>
							<th>상태</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
	 <c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td><c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/></td>
							<td><c:out value="${result.groupNm}"/></td>
							<td><c:out value="${result.empId}"/></td>
							<td>
								<a href="javascript:void(0);" onclick="javascript:fnActEmpView('<c:out value="${result.empId}"/>');">
									<c:out value="${result.empNm}"/>
								</a>
							</td>
							<td><c:out value="${result.orgCdNm2}"/></td>
							<td><c:out value="${result.psnCdNm}"/></td>
							<td><c:out value="${result.email}"/></td>
							<td><c:out value="${result.regdt}"/></td>
							<td><c:out value="${result.useyn}"/></td>
							<td>
						    	<button type="button" class="commonBtn" onclick="javascript:fnActEmpView('<c:out value="${result.empId}"/>');">수정</button>
						    	<button type="button" class="commonBtn" onclick="javascript:fnActEmpDel('<c:out value="${result.empId}"/>');">삭제</button>
							</td>
						</tr>
	</c:forEach>
					</tbody>
				</table>
				<!--//menuTable-->

			</div>
		</section>

	</section>

<%@include file="../include/footer.jsp"%>