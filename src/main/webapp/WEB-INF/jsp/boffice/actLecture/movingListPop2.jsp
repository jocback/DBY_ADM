<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/headerPop.jsp"%>
	<script type="text/javascript">
	function press(event) {
		if (event.keyCode==13) {
			fnActBookList('1');
		}
	}
	function fnActMovingList(pageNo) {
		if(!form_val_chk($(".frmSearch"))){
			return;
		}
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/boffice/actLecture/actMovingListPop2.do'/>";
		document.frm.submit();
	}
	$(function() {
		$(document).on('click', '.act_select', function() {
			$cont = $(this).closest('tr');
			$("#frm_write input[name='proNew']").val($cont.data('no'));
			$("#selected_lecture").text($cont.find('.bname').text());
			$('#btn_submit').show();
			return false;
		});
		$(document).on('click', '.act_save', function() {
			$('#frm_write input[name=proNew]').removeClass().addClass('req');
			if (form_val_chk($('#frm_write'))) {
				var proVal = $('#frm_write input[name=jongLecture]').val();
				proVal = proVal.replace($('#frm_write select[name=lsno_org]').val(),$('#frm_write input[name=proNew]').val());
				$('#frm_write input[name=jongLecture]').val(proVal);
				var url = "/boffice/actOrder/transActOrderJongLect.do";
				var param = $("#frm_write").serialize();
				commonUtil.AjaxSynCall(url,param,'text','수정되었습니다.');
				parent.location.reload();
			}
			return false;
		});
		$(document).on('click', '.act_del', function() {
			$('#frm_write input[name=proNew]').removeClass();
			if (form_val_chk($('#frm_write'))) {
				var proVal = $('#frm_write input[name=jongLecture]').val();
				proVal = proVal.replace($('#frm_write select[name=lsno_org]').val()+",","");
				proVal = proVal.replace(","+$('#frm_write select[name=lsno_org]').val(),"");
				$('#frm_write input[name=jongLecture]').val(proVal);
				var url = "/boffice/actOrder/transActOrderJongLect.do";
				var param = $("#frm_write").serialize();
				commonUtil.AjaxSynCall(url,param,'text','수정되었습니다.');
				parent.location.reload();
			}
			return false;
		});
		//7854,7863,7845,7860
	});
	</script>
	<form id="frm_write" name="frm_write" class="SearchForm">
	<input type="hidden" name="sno" value="<c:out value="${orderMap.sno}"/>" />
	<input type="hidden" name="jongLecture" value="<c:out value='${mvIdxs}'/>" />
	<input type="hidden" name="proNew" class="req" title="목록에서 강좌를 선택해주세요." />
	<table class="rowTable">
		<colgroup>
			<col style="width:100px">
			<col style="width:*">
		</colgroup>
		<tbody>
			<tr>
				<th>종합강좌명</th>
				<th class="al"><c:out value="${orderMap.goods}"/></th>
			</tr>
			<tr>
				<th>변경할강좌</th>
				<td>
					<select name="lsno_org" class="req" title="변경할강좌를 선택해주세요." style="width:320px;">
						<option value="">- 선택 -</option>
					 <c:forEach var="lectList" items="${orderMap.lectList}" varStatus="status">
						<option value="<c:out value="${lectList.mvIdx}"/>"><c:out value="${lectList.mvSubject}"/></option>
					</c:forEach>
					</select> <button type="button" class="commonBtn act_del">삭제</button>
				</td>
			</tr>
			<tr>
				<th>선택한강좌</th>
				<td>
					<p id="selected_lecture"></p>
					<p id="btn_submit" style="margin-left:20px;display:none;">
						<span class="btnsWrap">
							<button type="button" class="act_save" style="height:28px">변경</button>
						</span>
					</p>
				</td>
			</tr>
		</tbody>
	</table>
	</form>

	<form name="frm" method="post" class="SearchForm frmSearch">
	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
	<input name="sapStatus" type="hidden" value="<c:out value='${searchVO.sapStatus}'/>"/>
	<input name="searchMyAct" type="hidden" value="<c:out value='${searchVO.searchMyAct}'/>"/>
	<table class="rowTable">
		<colgroup>
			<col style="width:100px">
			<col style="width:*">
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">카테고리</th>
				<td class="category_select" data-part="book">
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
				<th>노출여부</th>
				<td>
					<p>
						<select name="searchOp2" id="">
							<option value="" <c:if test='${empty searchVO.searchOp2}'>selected</c:if>>전체</option>
							<option value="Y" <c:if test='${searchVO.searchOp2 eq "Y"}'>selected</c:if>>보임</option>
							<option value="N" <c:if test='${searchVO.searchOp2 eq "N"}'>selected</c:if>>숨김</option>
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
							<option value="1" <c:if test="${searchVO.searchCnd eq '1'}"> selected</c:if>>강의명</option>
							<option value="2" <c:if test="${searchVO.searchCnd eq '2'}"> selected</c:if>>교수명</option>
							<option value="3" <c:if test="${searchVO.searchCnd eq '3'}"> selected</c:if>>수정일</option>
						</select>
					</p>
					<p>
						<input  name="searchKeyword" type="text" size="35" class="shc_text" value='<c:out value="${searchVO.searchKeyword}" />' maxlength="35" onkeypress="press(event);" title="검색단어입력">
					</p>
				</td>
			</tr>
			<tr>
				<th>강좌가격</th>
				<td colspan="3">
					<p><input type="text" placeholder="원" class="chkmoney" name="searchOp3" value="<c:out value="${searchVO.searchOp3}" />"></p>
					~
					<p><input type="text" placeholder="원" class="chkmoney" name="searchOp4" value="<c:out value="${searchVO.searchOp4}" />"></p>
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
					<p style="margin-left:50px">
						<span class="btnsWrap">
							<button type="button" class="" onclick="javascript:fnActMovingList('1'); return false;">검색</button>
						</span>
					</p>
				</td>
			</tr>
		</tbody>
	</table>
	</form>

  <!--listTable-->
  <p class="total" style="margin-top:4px;">
		<span class="total_left">총 <strong><c:out value="${paginationInfo.totalRecordCount}"/></strong>개, <c:out value="${searchVO.pageIndex}"/> of <c:out value="${paginationInfo.lastPageNo}"/> page</span>
	</p>
	<form id="frm_list" name="frm_list">
	<input type="hidden" name="act" value="" />
	<table class="commonTable">
		<caption>강의 검색 테이블</caption>
		<colgroup>
			<col width="40">
			<col width="60">
			<col>
			<col width="60">
			<col width="90">
			<col width="50">
			<col width="100">
			<col width="80">
			<col width="50">
			<col width="50">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">과목</th>
				<th scope="col">강의명</th>
				<th scope="col">교수</th>
				<th scope="col">가격</th>
				<th scope="col">강의 수</th>
				<th scope="col">상태</th>
				<th scope="col">등록일</th>
				<th scope="col">노출</th>
				<th scope="col">선택</th>
			</tr>
		</thead>
		<tbody>
	 <c:forEach var="result" items="${resultList}" varStatus="status">
			<tr data-no="<c:out value="${result.mvIdx}"/>" <c:if test="${result.mvSta eq 'N'}">style="background-color:#EFEFEF;"</c:if>>
				<td><c:out value="${(paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage)) - status.index}"/></td>
				<td class="bclcodenm"><c:out value="${result.clCodeNm}"/></td>
				<td><b class="bname"><c:out value="${result.mvSubject}"/></b></td>
				<td class="bprof"><c:out value="${result.mvProfNm}"/></td>
				<td class="bprice chkmoney"><c:out value="${result.mvPrice1}"/></td>
				<td class="bcount"><c:out value="${result.clipCnt}"/></td>
				<td class="bpress">
					<c:if test="${result.mvOpen eq '3'}">강의준비중</c:if>
					<c:if test="${result.mvOpen eq '2'}"><i class="tableIcon statuIng">업데이트중</i></c:if>
					<c:if test="${result.mvOpen eq '1'}"><i class="tableIcon statuDon">업데이트완료</i></c:if>
				</td>
				<td class="bdate"><c:out value="${fn:substring(result.regdt,0,10)}"/></td>
				<td><c:if test="${result.mvSta ne 'N'}">보임</c:if><c:if test="${result.mvSta eq 'N'}">숨김</c:if></td>
				<td>
					<input type="hidden" name="clCode" value="<c:out value="${result.clCode}"/>"/>
			    	<button type="button" class="commonBtn act_select">선택</button>
				</td>
			</tr>
	</c:forEach>
		</tbody>
	</table>
	</form>
  <!--//listTable-->

	<!-- pagingType03 -->
	<div class="pageNation clear">
		<ul class="pagenation">
			<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnActMovingList" />
		</ul>
	</div>
	<!-- //pagingType03 -->



<%@include file="../include/footer.jsp"%>