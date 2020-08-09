<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/header.jsp"%>
	<script type="text/javascript">
	function press(event) {
		if (event.keyCode==13) {
			fnActBookList('1');
		}
	}
	function fnActBookList(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/boffice/actLecture/actBookList.do'/>";
		document.frm.submit();
	}
	function fnActBookView(no) {
		 if(!no) return false;
		 document.frm.bmIdx.value = no;
		 document.frm.action = "<c:url value='/boffice/actLecture/actBookView.do'/>";
		 document.frm.submit();
	}
	function fnActBookWrite() {
		 document.frm.bmIdx.value = "";
		 document.frm.action = "<c:url value='/boffice/actLecture/actBookView.do'/>";
		 document.frm.submit();
	}
	function fnActBookDel(obj){
		if(!confirm("삭제하시겠습니까?")){
			return;
		}
		var url = "<c:url value='/boffice/actLecture/deleteActBook.do' />";
		var param = {bmIdx : obj}
		commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.');
		fnActBookList('1');
	}

	/*function fnActBookOldLoad(){
		if(!confirm("실행하시겠습니까?")){
			return;
		}
		var url = "<c:url value='/boffice/activity/oldBookLoad.do' />";
		var param = {}
		commonUtil.AjaxSynCall(url,param,'text','실행되었습니다.');
		fnActBookList('1');
	}*/
	
	</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>서점 리스트</h3>
				<div class="btnWrap">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onClick="javascript:fnActBookWrite();">등록</button>
				</div>
			</div>
			<div class="realCont">

				<form name="frm" method="post" class="SearchForm">
  					<fieldset>
						<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
						<input name="bmIdx" type="hidden"/>
						<table class="rowTable">
							<colgroup>
								<col style="width:9%">
								<col style="width:350px">
								<col style="width:9%">
								<col style="width:*">
							</colgroup>
							<tbody>
								<tr>
									<th>카테고리 선택</th>
									<td colspan="3">
										<p>
									<select name="searchOp1" id="searchOp1" style="width:250px;padding-left:10px;">
										<option value="">직렬선택</option>
										<c:import url="/boffice/activity/actLecCdType.do" charEncoding="utf-8">
											<c:param name="codeGb" value="LE" />
											<c:param name="frmTypeValue" value="${searchVO.searchOp1}" />
										</c:import>
									</select>
										</p>
										<p>
									<select name="searchOp2" id="searchOp2" style="width:250px;padding-left:10px;">
										<option value="">과목선택</option>
										<option value="ALL" <c:if test="${searchVO.searchOp2 eq 'ALL'}"> selected</c:if>>(전체과목)</option>
										<c:import url="/boffice/activity/actLecCdType.do" charEncoding="utf-8">
											<c:param name="codeGb" value="CL" />
											<c:param name="frmTypeValue" value="${searchVO.searchOp2}" />
										</c:import>
									</select>
										</p>
									</td>
								</tr>
								<tr>
									<th>검색어</th>
									<td colspan="3">
										<p>
											<select name="searchCnd" title="검색유형선력">
												<option value="0" <c:if test="${searchVO.searchCnd eq '0'}"> selected</c:if>>전체</option>
												<option value="1" <c:if test="${searchVO.searchCnd eq '1'}"> selected</c:if>>상품명</option>
												<option value="2" <c:if test="${searchVO.searchCnd eq '2'}"> selected</c:if>>저자</option>
												<option value="3" <c:if test="${searchVO.searchCnd eq '3'}"> selected</c:if>>출판사</option>
											</select>
											<input  name="searchKeyword" type="text" size="35" class="shc_text" value='<c:out value="${searchVO.searchKeyword}" />' maxlength="35" onkeypress="press(event);" title="검색단어입력">
										</p>
									</td>
								</tr>
								<tr>
									<th>노출여부</th>
									<td colspan="3">
										<p class="radioStyle">
											<input type="radio" name="searchOp3" value="" id="searchOp30" <c:if test="${empty searchVO.searchOp3}"> checked</c:if>><label for="searchOp30"><span></span>전체</label>
											<input type="radio" name="searchOp3" value="Y" id="searchOp31" <c:if test="${searchVO.searchOp3 eq 'Y'}"> checked</c:if>><label for="searchOp31"><span></span>보임</label>
											<input type="radio" name="searchOp3" value="N" id="searchOp32" <c:if test="${searchVO.searchOp3 eq 'N'}"> checked</c:if>><label for="searchOp32"><span></span>숨김</label>
										</p>
									</td>
								</tr>
							</tbody>
						</table>
						<div class="btnsWrap">
							<button type="button" class="" onclick="javascript:fnActBookList('1'); return false;">검색</button>
						</div>
  					</fieldset>
				</form>

				<!--menuTable-->
				<table class="commonTable detailTable">
					<caption>서적 관리 테이블</caption>
					<colgroup>
						<col style="width:50px">
						<col style="width:50px">
						<col style="width:*">
						<col style="width:220px">
						<col style="width:120px">
						<col style="width:120px">
						<col style="width:50px">
						<col style="width:100px">
						<col style="width:120px">
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
							<th>교재명</th>
							<th>출판사</th>
							<th>정가(원)</th>
							<th>판매가(원)</th>
							<th>상태</th>
							<th>등록일</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
	 <c:forEach var="result" items="${resultList}" varStatus="status">
						<tr <c:if test="${result.bmShow eq 'N'}">style="background-color:#EFEFEF;"</c:if>>
							<td>
								<span class="checkBox">
									<input type="checkbox" class="no" name="no" value="<c:out value='${status.index}'/>" id="no<c:out value='${status.index}'/>">
									<label for="no<c:out value='${status.index}'/>"><span></span>선택</label>
								</span>
							</td>
							<td><c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/></td>
  							<td class="al">
								<c:if test="${fn:substring(result.bmPic,0,8) ne 'FILE_000'}">
								<img src="/images/bookbm/<c:out value="${result.bmPic}"/>" class="img" style="float:left;width:30px;height:40px;margin-right:4px;">
								</c:if>
								<c:if test="${fn:substring(result.bmPic,0,8) eq 'FILE_000'}">
								<img src='/cmm/fms/getImage.do?atchFileId=<c:out value='${result.bmPic}'/>&fileSn=0' class="img" style="float:left;width:30px;height:40px;margin-right:4px;">
								</c:if>
  							<a href="javascript:void(0);" onclick="javascript:fnActBookView('<c:out value="${result.bmIdx}"/>');" class="act_modi">
  							<b class="goods title"><c:out value="${result.bmSubject}"/></b></a><br />
							<c:if test="${result.bmOp1 eq 'Y'}"> <i class="tableIcon popular">인기</i></c:if>
							<c:if test="${result.bmOp2 eq 'Y'}"> <i class="tableIcon new">NEW</i></c:if>
							<c:if test="${result.bmOp3 eq 'Y'}"> <i class="tableIcon best">베스트</i></c:if>
							<c:if test="${result.bmOp4 eq 'Y'}"> <i class="tableIcon info">강좌설명</i></c:if>
							<c:if test="${result.bmOp5 eq 'Y'}"> <i class="tableIcon recommend">추천</i></c:if>
							<c:if test="${result.bmOp6 eq 'Y'}"> <i class="tableIcon event">이벤트</i></c:if>
							</td>
							<td><c:out value="${result.bmPress}"/></td>
							<td class="chkmoney"><c:out value="${result.bmPrice1}"/></td>
							<td class="chkmoney"><c:out value="${result.bmPrice2}"/></td>
							<td><c:if test="${result.bmShow ne 'N'}">보임</c:if><c:if test="${result.bmShow eq 'N'}">숨김</c:if></td>
							<td><c:out value="${result.regdtC}"/></td>
							<td>
						    	<button type="button" class="commonBtn" onclick="javascript:fnActBookView('<c:out value="${result.bmIdx}"/>');">수정</button>
						    	<button type="button" class="commonBtn" onclick="javascript:fnActBookDel('<c:out value="${result.bmIdx}"/>');">삭제</button>
							</td>
						</tr>
	</c:forEach>
					</tbody>
				</table>
				<!--//menuTable-->

				<!-- pagingType03 -->
				<div class="pageNation clear">
					<ul class="pagenation">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnActBookList" />
					</ul>
				</div>
				<!-- //pagingType03 -->

			</div>
		</section>

	</section>

<%@include file="../include/footer.jsp"%>