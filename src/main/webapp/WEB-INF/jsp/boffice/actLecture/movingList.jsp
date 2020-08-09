<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/header.jsp"%>
	<script type="text/javascript">
	function press(event) {
		if (event.keyCode==13) {
			fnActMovingList('1');
		}
	}
	function fnActMovingList(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/boffice/actLecture/actMovingList.do'/>";
		document.frm.submit();
	}
	function fnActMovingView(no) {
		 if(!no) return false;
		 document.frm.mvIdx.value = no;
		 document.frm.action = "<c:url value='/boffice/actLecture/actMovingView.do'/>";
		 document.frm.submit();
	}
	function fnActMovingWrite() {
		 document.frm.mvIdx.value = "";
		 document.frm.action = "<c:url value='/boffice/actLecture/actMovingView.do'/>";
		 document.frm.submit();
	}
	function fnActMovingClip(no) {
		 if(!no) return false;
		 document.frm.mvIdx.value = no;
		 document.frm.action = "<c:url value='/boffice/actLecture/actMovingClip.do'/>";
		 document.frm.submit();
	}
	function fnActMovingDel(obj){
		if(!confirm("삭제하시겠습니까?")){
			return;
		}
		var url = "<c:url value='/boffice/actLecture/deleteActMoving.do' />";
		var param = {mvIdx : obj}
		commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.');
		fnActMovingList('1');
	}

	/*function fnActLectureOldLoad(){
		if(!confirm("실행하시겠습니까?")){
			return;
		}
		var url = "<c:url value='/boffice/activity/oldLectureLoad.do' />";
		var param = {}
		commonUtil.AjaxSynCall(url,param,'text','실행되었습니다.');
		fnActMovingList('1');
	}*/
	
	</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>동영상 강의 리스트</h3>
				<div class="btnWrap">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onClick="javascript:fnActMovingWrite();">등록</button>
				</div>
			</div>
			<div class="realCont">

				<form name="frm" method="post" class="SearchForm">
  					<fieldset>
						<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
						<input name="mvIdx" type="hidden"/>
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
										<option value="">선택</option>
										<c:import url="/boffice/activity/actLecCdType.do" charEncoding="utf-8">
											<c:param name="codeGb" value="CL" />
											<c:param name="frmTypeValue" value="${searchVO.searchOp1}" />
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
							<button type="button" class="" onclick="javascript:fnActMovingList('1'); return false;">검색</button>
						</div>
  					</fieldset>
				</form>

				<!--menuTable-->
				<table class="commonTable detailTable">
					<caption>동영상 강의 리스트</caption>
					<colgroup>
						<col style="width:50px">
						<col style="width:50px">
						<col style="width:60px">
						<col style="width:*">
						<col style="width:50px">
						<col style="width:50px">
						<col style="width:50px">
						<col style="width:90px">
						<col style="width:100px">
						<col style="width:50px">
						<col style="width:90px">
						<col style="width:170px">
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
							<th>과목</th>
							<th>강좌명</th>
							<th>구분</th>
							<th>교수</th>
							<th>강의수</th>
							<th>가격(원)</th>
							<th>상태</th>
							<th>노출</th>
							<th>등록일</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
	 <c:forEach var="result" items="${resultList}" varStatus="status">
						<tr <c:if test="${result.mvSta eq 'N'}">style="background-color:#EFEFEF;"</c:if>>
							<td>
								<span class="checkBox">
									<input type="checkbox" class="no" name="no" value="<c:out value='${status.index}'/>" id="no<c:out value='${status.index}'/>">
									<label for="no<c:out value='${status.index}'/>"><span></span>선택</label>
								</span>
							</td>
							<td class="list-no"><c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/></td>
							<td><c:out value="${result.clCodeNm}"/></td>
							<td class="al">
								<a href="javascript:void(0);" onclick="javascript:fnActMovingView('<c:out value="${result.mvIdx}"/>');"><c:out value="${result.mvSubject}"/></a>
								<c:if test="${result.mvOp2 eq 'Y'}"><i class="tableIcon popular">인기</i></c:if>
								<c:if test="${result.mvOp3 eq 'Y'}"><i class="tableIcon new">NEW</i></c:if>
							</td>
							<td><c:out value="${result.mvPcmoNm}"/></td>
							<td><c:out value="${result.mvProfNm}"/></td>
							<td><c:out value="${result.clipCnt}"/></td>
							<td class="ar chkmoney"><c:out value="${result.mvPrice1}"/></td>
							<td>
								<c:if test="${result.mvOpen eq '1'}"><i class="tableIcon statuDon"></c:if>
								<c:if test="${result.mvOpen eq '2'}"><i class="tableIcon statuIng"></c:if>
								<c:if test="${result.mvOpen eq '3'}"><i></c:if>
								<c:out value="${result.mvOpenNm}"/></i>
							</td>
							<td><c:if test="${result.mvSta eq 'Y'}">보임</c:if><c:if test="${result.mvSta eq 'N'}">숨김</c:if></td>
							<td><c:out value="${fn:substring(result.regdt,0,10)}"/></td>
							<td>
						    	<button type="button" class="commonBtn" onclick="javascript:fnActMovingClip('<c:out value="${result.mvIdx}"/>');">강의등록</button>
						    	<button type="button" class="commonBtn" onclick="javascript:fnActMovingView('<c:out value="${result.mvIdx}"/>');">수정</button>
						    	<button type="button" class="commonBtn" onclick="javascript:fnActMovingDel('<c:out value="${result.mvIdx}"/>');">삭제</button>
							</td>
						</tr>
	</c:forEach>
					</tbody>
				</table>
				<!--//menuTable-->

				<!-- pagingType03 -->
				<div class="pageNation clear">
					<ul class="pagenation">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnActMovingList" />
					</ul>
				</div>
				<!-- //pagingType03 -->

			</div>
		</section>

	</section>

<%@include file="../include/footer.jsp"%>