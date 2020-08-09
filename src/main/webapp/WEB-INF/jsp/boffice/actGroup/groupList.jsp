<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/header.jsp"%>
	<script type="text/javascript">
	function press(event) {
		if (event.keyCode==13) {
			fnActGroupList('1');
		}
	}
	function fnActGroupList(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/boffice/actGroup/actGroupList.do'/>";
		document.frm.submit();
	}
	function fnActGroupView(idx) {
		 //if(idx == "") return;
		 document.frm.groupId.value = idx;
		 document.frm.action = "<c:url value='/boffice/actGroup/actGroupView.do'/>";
		 document.frm.submit();
	}
	function fnActGroupAuth(idx){
		 document.frm.groupId.value = idx;
		 document.frm.action = "<c:url value='/boffice/actGroup/actGroupAuth.do'/>";
		 document.frm.submit();
	}
	</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>권한그룹 관리</h3>
				<div class="btnWrap">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onClick="javascript:fnActGroupView();">등록</button>
				</div>
			</div>
			<div class="realCont">

				<form name="frm" method="post" class="SearchForm">
  					<fieldset>
					<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
					<input name="groupId" type="hidden"/>
						<table class="rowTable">
							<colgroup>
								<col style="width:9%">
								<col style="width:350px">
								<col style="width:9%">
								<col style="width:*">
							</colgroup>
							<tbody>
								<tr>
									<th>권한그룹명검색</th>
									<td colspan="3">
										<p>
											<input type="hidden" name="searchCnd" id="searchCnd" value="groupNm"/>
											<input type="text" class="sch_text" name="searchKeyword" id="searchKeyword" value='<c:out value="${searchVO.searchKeyword}"/>' maxlength="35" onkeypress="press(event);" />
										</p>
									</td>
								</tr>
							</tbody>
						</table>
						<div class="btnsWrap">
							<button type="button" class="" onclick="javascript:fnActGroupList('1'); return false;">검색</button>
						</div>
  					</fieldset>
				</form>
				<!-- //sch_list -->

				<div class="total">총 <span><c:out value="${paginationInfo.totalRecordCount}"/></span>건</div>

				<!-- listType05 -->
					<table class="commonTable detailTable">
						<caption class="blind">권한그룹 목록</caption>
						<colgroup>
							<col width="60px" />
							<col width="150px" />
							<col width="160px" />
							<col width="*" />
							<col width="100px" />
							<col width="100px" />
							<col width="100px" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col" class="first_line">번호</th>
								<th scope="col" class="first_line">ID</th>
								<th scope="col" class="first_line">그룹명</th>
								<th scope="col" class="first_line">설명</th>
								<th scope="col" class="first_line">레벨</th>
								<th scope="col" class="first_line">생성일</th>
								<th scope="col" class="first_line">권한관리</th>
							</tr>
						</thead>
						<tbody>
	 <c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
								<td><c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/></td>
								<td>
									<a href="javascript:void(0);" onclick="javascript:fnActGroupView('<c:out value="${result.groupId}"/>');">
										<c:out value="${result.groupId}"/>
									</a>
								</td>
								<td>
									<a href="javascript:void(0);" onclick="javascript:fnActGroupView('<c:out value="${result.groupId}"/>');">
										<c:out value="${result.groupNm}"/>
									</a>
								</td>
								<td><c:out value="${result.groupDc}"/></td>
								<td><c:out value="${result.groupLevelNm}"/></td>
								<td><c:out value="${result.regdt}"/></td>
								<td>
									<c:if test="${result.groupLevel ne '20'}">
									<a href="javascript:void(0);" class="button_v2" onClick="javascript:fnActGroupAuth('<c:out value="${result.groupId}"/>');"><span>권한관리</span></a>
									</c:if>
								</td>
							</tr>
	</c:forEach>
						</tbody>
					</table>
				<!-- //listType05 -->

				<!-- pagingType03 -->
				<div class="pageNation clear">
					<ul class="pagenation">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnActGroupList" />
					</ul>
				</div>
				<!-- //pagingType03 -->

			</div>
		</section>

	</section>


<%@include file="../include/footer.jsp"%>