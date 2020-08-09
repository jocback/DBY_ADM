<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/header.jsp"%>
	<script type="text/javascript">
	function press(event) {
		if (event.keyCode==13) {
			fnActCollegeList('1');
		}
	}
	function fnActCollegeList(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/boffice/actLecture/actCollegeList.do'/>";
		document.frm.submit();
	}
	function fnActCollegeView(no) {
		 if(!no) return false;
		 document.frm.coIdx.value = no;
		 document.frm.action = "<c:url value='/boffice/actLecture/actCollegeView.do'/>";
		 document.frm.submit();
	}
	function fnActCollegeWrite() {
		 document.frm.coIdx.value = "";
		 document.frm.action = "<c:url value='/boffice/actLecture/actCollegeView.do'/>";
		 document.frm.submit();
	}
	function fnActCollegeDel(obj){
		if(!confirm("삭제하시겠습니까?")){
			return;
		}
		var url = "<c:url value='/boffice/actLecture/deleteActCollege.do' />";
		var param = {coIdx : obj}
		commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.');
		fnActCollegeList('1');
	}

	<c:if test="${!empty searchVO.searchOp1}">
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
		var url = "/boffice/actLecture/seqSwitchUpdate.do";
		var param = {
				coIdx : thisIdx,
				coSeq : thisSeq,
				preIdx : otherIdx
				}
		commonUtil.AjaxSynCall(url,param);
		fnActCollegeList(document.frm.pageIndex.value);
	});
	</c:if>
	$(document).on('change','#searchOp1',function(){
		fnActCollegeList('1');
	});
	</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>클래스 강의 리스트</h3>
				<div class="btnWrap">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onClick="javascript:fnActCollegeWrite();">등록</button>
				</div>
			</div>
			<div class="realCont">

				<form name="frm" method="post" class="SearchForm">
  					<fieldset>
						<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
						<input name="coIdx" type="hidden"/>
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
										<select name=searchOp1 id="searchOp1">
											<option value="">선택</option>
											<c:import url="/boffice/activity/actLecCdType.do" charEncoding="utf-8">
												<c:param name="codeGb" value="LE" />
												<c:param name="frmTypeValue" value="${searchVO.searchOp1}" />
												<c:param name="searchCnd" value="" />
											</c:import>
										</select>
										</p> (*카테고리 선택 시 순서 수정 가능)
										&nbsp; &nbsp; 
										/ 출력갯수
										<select name=pageUnit id="pageUnit" style="width:80px;" onChange="fnActCollegeList(1)">
											<option value="20" <c:if test="${searchVO.pageUnit eq '20'}">selected</c:if>>20</option>
											<option value="30" <c:if test="${searchVO.pageUnit eq '30'}">selected</c:if>>30</option>
											<option value="50" <c:if test="${searchVO.pageUnit eq '50'}">selected</c:if>>50</option>
											<option value="100" <c:if test="${searchVO.pageUnit eq '100'}">selected</c:if>>100</option>
											<option value="150" <c:if test="${searchVO.pageUnit eq '150'}">selected</c:if>>150</option>
										</select>
									</td>
								</tr>
								<tr>
									<th>검색어</th>
									<td colspan="3">
										<p>
											<select name="searchCnd" title="검색유형선력">
												<option value="0" <c:if test="${searchVO.searchCnd eq '0'}"> selected</c:if>>전체</option>
												<option value="1" <c:if test="${searchVO.searchCnd eq '1'}"> selected</c:if>>강좌명</option>
												<option value="2" <c:if test="${searchVO.searchCnd eq '2'}"> selected</c:if>>교수명</option>
											</select>
											<input  name="searchKeyword" type="text" size="35" class="shc_text" value='<c:out value="${searchVO.searchKeyword}" />' maxlength="35" onkeypress="press(event);" title="검색단어입력">
										</p>
									</td>
								</tr>
								<tr>
									<th>노출여부</th>
									<td colspan="3">
										<p class="radioStyle">
											<input type="radio" name="searchOp2" value="" id="searchOp20" <c:if test="${empty searchVO.searchOp2}"> checked</c:if>><label for="searchOp20"><span></span>전체</label>
											<input type="radio" name="searchOp2" value="Y" id="searchOp21" <c:if test="${searchVO.searchOp2 eq 'Y'}"> checked</c:if>><label for="searchOp21"><span></span>보임</label>
											<input type="radio" name="searchOp2" value="N" id="searchOp22" <c:if test="${searchVO.searchOp2 eq 'N'}"> checked</c:if>><label for="searchOp22"><span></span>숨김</label>
										</p>
									</td>
								</tr>
								<tr>
									<th>강좌금액</th>
									<td colspan="3">
  										<p><input type="text" placeholder="원" class="chknum" name="searchOp3" value="<c:out value="${searchVO.searchOp3}" />"></p>
  										~
  										<p><input type="text" placeholder="원" class="chknum" name="searchOp4" value="<c:out value="${searchVO.searchOp4}" />"></p>
									</td>
								</tr>
  								<tr>
  									<th>강좌등록일</th>
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
						<div class="btnsWrap">
							<button type="button" class="" onclick="javascript:fnActCollegeList('1'); return false;">검색</button>
						</div>
  					</fieldset>
				</form>

				<!--menuTable-->
				<table class="commonTable detailTable">
					<caption>클래스 강의 리스트</caption>
					<colgroup>
						<col style="width:40px">
						<col style="width:40px">
						<c:if test="${!empty searchVO.searchOp1}">
						<col style="width:40px">
						<col style="width:60px">
						</c:if>
						<col style="width:160px">
						<col style="width:230px">
						<col style="width:*">
						<col style="width:50px">
						<col style="width:90px">
						<col style="width:90px">
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
						<c:if test="${!empty searchVO.searchOp1}">
							<th>순서</th>
							<th>변경</th>
						</c:if>
							<th>직렬</th>
							<th>클래스명</th>
							<th>과목명</th>
							<th>노출</th>
							<th>등록일</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
	 <c:forEach var="result" items="${resultList}" varStatus="status">
						<tr data-no="${result.coIdx}">
							<td>
								<span class="checkBox">
									<input type="checkbox" class="no" name="no" value="<c:out value='${status.index}'/>" id="no<c:out value='${status.index}'/>">
									<label for="no<c:out value='${status.index}'/>"><span></span>선택</label>
								</span>
							</td>
							<td><c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/></td>
						<c:if test="${!empty searchVO.searchOp1}">
							<td><c:out value="${result.coSeq}"/></td>
							<td>
								<button type="button" class="commonBtn act_ord" data-dir="up" value="<c:out value='${result.coSeq}'/>"><i class="upBtn">위</i></button>
								<button type="button" class="commonBtn act_ord" data-dir="down" value="<c:out value='${result.coSeq}'/>"><i class="downBtn">아래</i>
							</td>
						</c:if>
							<td><c:out value="${result.leCodeNm}"/></td>
							<td><c:out value="${result.coSubject}"/></td>
							<td style="word-break:break-all;"><c:out value="${result.clCodeNms}"/></td>
							<td><c:if test="${result.coSta eq 'Y'}">보임</c:if><c:if test="${result.coSta ne 'Y'}">숨김</c:if></td>
							<td><c:out value="${fn:substring(result.regdt,0,10)}"/></td>
							<td>
						    	<button type="button" class="commonBtn" onclick="javascript:fnActCollegeView('<c:out value="${result.coIdx}"/>');">수정</button>
						    	<button type="button" class="commonBtn" onclick="javascript:fnActCollegeDel('<c:out value="${result.coIdx}"/>');">삭제</button>
							</td>
						</tr>
	</c:forEach>
					</tbody>
				</table>
				<!--//menuTable-->

				<!-- pagingType03 -->
				<div class="pageNation clear">
					<ul class="pagenation">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnActCollegeList" />
					</ul>
				</div>
				<!-- //pagingType03 -->

			</div>
		</section>

	</section>

<%@include file="../include/footer.jsp"%>