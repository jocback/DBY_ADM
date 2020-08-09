<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/header.jsp"%>
	<script type="text/javascript">
	function press(event) {
		if (event.keyCode==13) {
			fnActOrgList('1');
		}
	}
	function fnActOrgList(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/boffice/actOrg/actOrgList.do'/>";
		document.frm.submit();
	}
	function fnActOrgView(no) {
		 if(!no) return false;
		 document.frm.empNo.value = no;
		 document.frm.action = "<c:url value='/boffice/actOrg/actOrgView.do'/>";
		 document.frm.submit();
	}
	function fnActOrgWrite() {
		 document.frm.empNo.value = "";
		 document.frm.action = "<c:url value='/boffice/actOrg/actOrgView.do'/>";
		 document.frm.submit();
	}
	</script>

	<h2 class="blind">본문</h2>
		<!-- Container -->
		<div class="container sub" id="container">
		
			<h3 class="cont tit2 mt_60">조직도 관리</h3>

			<div class="cont">

				<div class="sch_list v2">
				<form name="frm" method="post">
					<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
					<input name="empNo" type="hidden"/>

					<ul class="clear">
						<li class="schWrap">
							<label class="blind" for="searchCnd">선택</label>
							<select name="searchCnd" id="searchCnd">
								<option value="all" <c:if test="${searchVO.searchCnd eq 'all'}"> selected</c:if>>전체</option>
								<option value="actEmpnm" <c:if test="${searchVO.searchCnd eq 'actEmpnm'}"> selected</c:if>>이름</option>
							</select>
						</li>	
						<li class="schWrap">
							<label class="blind" for="searchKeyword">제목 검색</label>
							<input type="text" class="sch_text" name="searchKeyword" id="searchKeyword" value='<c:out value="${searchVO.searchKeyword}"/>' maxlength="35" onkeypress="press(event);" placeholder="이름" />
							<a href="javascript:void(0);" class="btn_css" onClick="javascript:fnActOrgList('1'); return false;;">
								<img src="/images/boffice/board/btn_search.jpg" alt="검색" />
							</a>
						</li>
					</ul>

				</form>
				</div>
				<!-- //sch_list -->

				<div class="ask mt_50">총 <span><c:out value="${paginationInfo.totalRecordCount}"/></span>건</div>

				<!-- listType05 -->
				<div class="listType05 mt_15">
					<table>
						<caption class="blind">목록</caption>
						<colgroup>
							<col width="50px" />
							<col width="160px" />
							<col width="160px" />
							<col width="*" />
							<col width="120px" />
							<col width="80px" />
							<col width="100px" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col" class="first_line">번호</th>
								<th scope="col" class="first_line">일련번호</th>
								<th scope="col" class="first_line">성명</th>
								<th scope="col" class="first_line">부서</th>
								<th scope="col" class="first_line">직위</th>
								<th scope="col" class="first_line">노출순서</th>
								<th scope="col" class="first_line">등록일</th>
							</tr>
	 <c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
								<td><c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/></td>
								<td><c:out value="${result.empNo}"/></td>
								<td>
									<a href="javascript:void(0);" onclick="javascript:fnActOrgView('<c:out value="${result.empNo}"/>');">
										<u><c:out value="${result.empNm}"/></u>
									</a>
								</td>
								<td><c:out value="${result.orgCdNm1}"/> <c:out value="${result.orgCdNm2}"/></td>
								<td><c:out value="${result.psnCdNm}"/></td>
								<td><c:out value="${result.posNo}"/></td>
								<td><c:out value="${result.regdt}"/></td>
							</tr>
	</c:forEach>
						</tbody>
					</table>
				</div>
				<!-- //listType05 -->

				<!-- pagingType03 -->
				<div class="basePaging pagingType03">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnActOrgList" />
				</div>
				<!-- //pagingType03 -->
				
				<div class="ta_r">
					<a href="javascript:void(0);" class="button_v2" onClick="javascript:fnActOrgWrite();"><span>신규등록</span></a>
				</div>

			</div>
			<!-- //cont -->

		</div>
		<!-- //Container -->

<%@include file="../include/footer.jsp"%>