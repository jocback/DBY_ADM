<%@page contentType="text/html;charset=utf-8"%>
<%@include file="../include/header.jsp"%>
<%
pageContext.setAttribute("CR", "\r");
pageContext.setAttribute("LF", "\n");
pageContext.setAttribute("CRLF", "\r\n");
pageContext.setAttribute("SP", "&nbsp;");
pageContext.setAttribute("BR", "<br/>");
pageContext.setAttribute("newLineChar", "\n");
%> 
<script type="text/javascript">

function fnReturnFrm(obj,str){
	if(!$("#frmForm input[name='"+obj+"']").val()){
		alert(str);
		$("#frmForm input[name='"+obj+"']").focus();
		return;
	}
}
function fnActMovingModify(op){
	if(!form_val_chk($("#frmForm"))){
		return;
	}
	/*if($("#frmForm input[name='bmIdx']").length < 1){
		alert("교재를 추가하여 주세요");
		return;
	}*/
	
	if(!confirm("저장 하시겠습니까?")){
		return;
	}
	$("input[name='mvDesc']").val(DEXT5.getBodyValue('mvDesc'));
	$("input[name='mvDesc']").val(($("input[name='mvDesc']").val()).replace(/\'/g,"&#39;"));

	var url = "<c:url value='/boffice/actLecture/modifyActMoving.do' />";
	if(!document.frmForm.mvIdx.value){
		url = "<c:url value='/boffice/actLecture/insertActMoving.do' />";
	}

    var aFrm = document.frmForm;
    var target_name = 'iframe_upload';
    var iframe = $('<iframe src="javascript:false;" name="'+target_name+'" style="display:none;"></iframe>');
	aFrm.action = url;
    $('body').append(iframe);
    iframe.load(function(){
        var doc = this.contentWindow ? this.contentWindow.document : (this.contentDocument ? this.contentDocument : this.document);
        var root = doc.documentElement ? doc.documentElement : doc.body;
        var retStr = root.textContent ? root.textContent : root.innerText;
        iframe.remove();
    	if(retStr == "success"){
    		alert("저장되었습니다.");
    		if(!document.frmForm.mvIdx.value){
    			location.href="<c:url value='/boffice/actLecture/actMovingList.do' />";
    		}else{
    			document.frmForm.action = "/boffice/actLecture/actMovingView.do";
    			document.frmForm.target = "_parent";
    			document.frmForm.submit();
    		}
    	}else if(retStr == "ERR_PIC"){
    		alert("첨부파일 형식이 잘못되었습니다.");
    		return;
    	}else{
    		alert("오류입니다. 다시 시도하여 주세요.");
    		return;
    	}
    });
    aFrm.target = target_name;
    aFrm.submit();
}

function fnActMovingDel(obj){
	if(!confirm("삭제하시겠습니까?")){
		return;
	}
	var url = "<c:url value='/boffice/actLecture/deleteActMoving.do' />";
	var param = {mvIdx : obj}
	commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.');
	location.href="<c:url value='/boffice/actLecture/actMovingList.do' />";
}

function fnActMovingList(){
	document.frmForm.action = "<c:url value='/boffice/actLecture/actMovingList.do'/>";
	document.frmForm.submit();
}

function fnActAddBook(selVal,selName,selPress,selPrice,selDate){
	var isExit = false;
	$("input[name=bmIdx]").each(function(index){ if($(this).val()==selVal) isExit = true; });
	if(isExit){ alert("추가된 항목입니다."); return; }
	var addStr = '<tr id="trBook'+selVal+'"><td style="height:32px">';
		addStr = addStr +	'<input type="hidden" name="bmIdx" id="bmIdx" value="'+selVal+'"/>';
		addStr = addStr +	'<span class="checkBox">';
		addStr = addStr +	'<input type="checkbox" class="noBook" name="noBookChk" id="noBook'+selVal+'">';
		addStr = addStr +	'<label for="noBook'+selVal+'"><span></span>선택</label></span></td>';
		addStr = addStr +	'<td>'+selName+'</td>';
		addStr = addStr +	'<td>'+selPress+'</td>';
		addStr = addStr +	'<td class="chkmoney">'+selPrice+'</td>';
		addStr = addStr +	'<td>'+selDate+'</td>';
		addStr = addStr +	'<td><button type="button" class="commonBtn" onclick="javascript:fnActBookDel(\''+selVal+'\');">삭제</button>';
		addStr = addStr +	'</td></tr>';
	$("#bookListTbody").append(addStr);
}
function fnActBookDel(obj){
	$("#trBook"+obj).remove();
}
function fnActBookALLDel(){
	$("input[name=noBookChk]:checked").each(function(index){ $(this).parent().parent().parent().remove(); });
}

$(document).on('click', '.act_book_add', function() {
	dialog_doc('교재등록', '/boffice/actLecture/actBookListPop.do', 800, 780);
	return false;
});

</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>동영상강의 등록</h3>
				<div class="btnWrap">
					<c:if test="${empty resultInfo.mvIdx}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActMovingModify('new');">등록</button>
					</c:if>
					<c:if test="${!empty resultInfo.mvIdx}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActMovingModify('edit');">수정</button>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActMovingDel('<c:out value='${resultInfo.mvIdx}'/>');">삭제</button>
					</c:if>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActMovingList();">목록</button>
				</div>
			</div>
			<div class="realCont">

				<form name="frmForm" id="frmForm" method="post" class="articleWrite">
					<input type="hidden" name="pageIndex" value="<c:out value="${searchVO.pageIndex}"/>">
					<input type="hidden" name="searchCnd" value="<c:out value="${searchVO.searchCnd}"/>">
					<input type="hidden" name="searchKeyword" value="<c:out value="${searchVO.searchKeyword}"/>">
					<input type="hidden" name="searchActstt" value="<c:out value="${searchVO.searchActstt}"/>">
				
					<input type="hidden" name="mvIdx" id="mvIdx" value='<c:out value="${resultInfo.mvIdx}"/>' />
					<input type="hidden" name="mvDesc" />

				<fieldset>
					<p>기본 정보</p>
					<table class="rowTable">
						<caption class="blind">기본 정보</caption>
						<colgroup>
							<col style="width:130px">
							<col style="width:*">
							<col style="width:130px">
							<col style="width:*">
						</colgroup>
						<tbody>	
							<tr>
								<th scope="row">과목 카테고리</th>
								<td colspan="3">
									<select name="clCode" id="clCode" class="req" title="과목 카테고리를 선택하여 주세요" style="width:250px;padding-left:10px;">
										<option value="">선택</option>
										<c:import url="/boffice/activity/actLecCdType.do" charEncoding="utf-8">
											<c:param name="codeGb" value="CL" />
											<c:param name="frmTypeValue" value="${resultInfo.clCode}" />
										</c:import>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row">강좌명</th>
								<td colspan="3">
									<input type="text" name="mvSubject" id="mvSubject" title="강좌명을 입력하여 주세요" value="<c:out value="${resultInfo.mvSubject}"/>" class="req" maxlength="100" style="width:350px" />
									<p class="checkBox">
									<input type="checkbox" name="mvOp1" value="Y" id="mvOp1" <c:if test="${resultInfo.mvOp1 eq 'Y'}">checked</c:if>>
									<label for="mvOp1"><span></span>종합반 강의로만 사용함</label>
									</p>
								</td>
							</tr>
							<tr>
								<th scope="row">교수선택</th>
								<td colspan="3">
									<select name="mvProf" id="mvProf" title="교수선택을 하여 주세요" class="req" style="width:250px;padding-left:10px;">
										<option value="">선택</option>
									<c:forEach var="profList" items="${profList}" varStatus="status">
										<option value="<c:out value='${profList.mId}'/>" <c:if test="${resultInfo.mvProf eq profList.mId}">selected</c:if> ><c:out value="${profList.mName}"/>(<c:out value="${profList.mId}"/>)</option>
									</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row">등록옵션</th>
								<td>
									<p class="checkBox">
									<input type="checkbox" name="mvOp2" value="Y" id="mvOp2" <c:if test="${resultInfo.mvOp2 eq 'Y' || empty resultInfo.mvOp2}">checked</c:if>>
									<label for="mvOp2"><span></span>인기</label>
									<input type="checkbox" name="mvOp3" value="Y" id="mvOp3" <c:if test="${resultInfo.mvOp3 eq 'Y'}">checked</c:if>>
									<label for="mvOp3"><span></span>NEW</label>
									</p>
								</td>
								<th scope="row">강의 노출 여부</th>
								<td>
									<p class="radioStyle">
										<input type="radio" name="mvSta" value="Y" id="mvSta1" <c:if test="${resultInfo.mvSta eq 'Y' || empty resultInfo.mvSta}">checked</c:if>>
										<label for="mvSta1"><span></span>보임</label>
									</p>
								   <p class="radioStyle">
										<input type="radio" name="mvSta" value="N" id="mvSta2" <c:if test="${resultInfo.mvSta eq 'N'}">checked</c:if>>
										<label for="mvSta2"><span></span>숨김</label>
									</p>
								</td>
							</tr>
							<tr>
								<th scope="row">개강 여부</th>
								<td>
									<p class="radioStyle">
										<input type="radio" name="mvOpen" value="3" id="mvOpen3" <c:if test="${resultInfo.mvOpen eq '3' || empty resultInfo.mvOpen}">checked</c:if>>
										<label for="mvOpen3"><span></span>강의준비중</label>
										<input type="radio" name="mvOpen" value="2" id="mvOpen2" <c:if test="${resultInfo.mvOpen eq '2'}">checked</c:if>>
										<label for="mvOpen2"><span></span>업데이트중</label>
										<input type="radio" name="mvOpen" value="1" id="mvOpen1" <c:if test="${resultInfo.mvOpen eq '1'}">checked</c:if>>
										<label for="mvOpen1"><span></span>업데이트완료</label>
									</p>
								</td>
								<th scope="row">학습기간</th>
								<td>
									<input type="text" name="mvPeriod" id="mvPeriod" value="<c:out value="${resultInfo.mvPeriod}"/>" class="chknum req" title="학습기간을 입력하여주세요" maxlength="3" />일
								</td>
							</tr>
							<tr>
								<th scope="row">학습질문 게시판 사용</th>
								<td>
									<p class="radioStyle">
										<input type="radio" name="mvQna" value="Y" id="mvQna1" <c:if test="${resultInfo.mvQna eq 'Y' || empty resultInfo.mvQna}">checked</c:if>>
										<label for="mvQna1"><span></span>예</label>
										<input type="radio" name="mvQna" value="N" id="mvQna2" <c:if test="${resultInfo.mvQna eq 'N'}">checked</c:if>>
										<label for="mvQna2"><span></span>아니오</label>
									</p>
								</td>
								<th scope="row">학습게시판관리자</th>
								<td>
									<select name="mvMng" id="mvMng" title="학습게시판관리자를 선택하여 주세요" style="width:250px;padding-left:10px;">
										<option value="">선택</option>
									<c:forEach var="profList" items="${profList}" varStatus="status">
										<option value='<c:out value="${profList.mId}"/>' <c:if test="${resultInfo.mvMng eq profList.mId}">selected</c:if> ><c:out value="${profList.mName}"/>(<c:out value="${profList.mId}"/>)</option>
									</c:forEach>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
				</fieldset>

				<fieldset>
					<p>단과반 수강료 설정</p>
					<table class="rowTable">
						<caption class="blind">단과반 수강료 설정</caption>
						<colgroup>
							<col style="width:130px">
							<col style="width:*">
							<col style="width:130px">
							<col style="width:*">
							<col style="width:130px">
							<col style="width:*">
						</colgroup>
						<tbody>	
							<tr>
								<th scope="row">강의 노출</th>
								<td colspan="5">
									<p class="radioStyle">
										<input type="radio" name="mvPcmo" value="3" id="mvPcmo3" <c:if test="${resultInfo.mvPcmo eq '3' || empty resultInfo.mvPcmo}">checked</c:if>>
										<label for="mvPcmo3"><span></span>전체</label>
										<input type="radio" name="mvPcmo" value="1" id="mvPcmo1" <c:if test="${resultInfo.mvPcmo eq '1'}">checked</c:if>>
										<label for="mvPcmo1"><span></span>PC</label>
										<input type="radio" name="mvPcmo" value="2" id="mvPcmo2" <c:if test="${resultInfo.mvPcmo eq '2'}">checked</c:if>>
										<label for="mvPcmo2"><span></span>모바일</label>
									</p>
								</td>
							</tr>
							<tr>
								<th scope="row">강의 종료</th>
								<td colspan="5">
									<p class="checkBox">
									<input type="checkbox" name="mvClose" value="Y" id="mvClose" <c:if test="${resultInfo.mvClose eq 'Y'}">checked</c:if>>
									<label for="mvClose"><span></span>강의 종료</label>
									</p>
								</td>
							</tr>
							<tr>
								<th scope="row">PC 가격(원)</th>
								<td>
									<input type="text" name="mvPrice1" class="chkmoney req" value="<c:out value='${resultInfo.mvPrice1}'/>" title="PC가격을 입력하여주세요">
								</td>
								<th scope="row">모바일 가격(원)</th>
								<td>
									<input type="text" name="mvPrice2" class="chkmoney req" value="<c:out value='${resultInfo.mvPrice2}'/>" title="모바일가격을 입력하여주세요">
								</td>
								<th scope="row">PC+모바일 가격(원)</th>
								<td>
									<input type="text" name="mvPrice3" class="chkmoney req" value="<c:out value='${resultInfo.mvPrice3}'/>" title="PC+모바일가격을 입력하여주세요">
								</td>
							</tr>
							<tr>
								<th scope="row">단과 강의<br/>수수료 제외(원)</th>
								<td colspan="5">
									<input type="text" name="mvCharge" class="chkmoney" value="<c:out value='${resultInfo.mvCharge}'/>">
								</td>
							</tr>
						</tbody>
					</table>
				</fieldset>

				<fieldset>
					<p>교재 등록</p>
					<table class="rowTable">
						<caption class="blind">교재 등록</caption>
						<colgroup>
							<col width="130px" />
							<col width="*" />
						</colgroup>
						<tbody>	
							<tr>
								<th scope="row">교재 등록</th>
								<td>
									<button type="button" class="colorBtn rightbluebtn plusIcon act_ins act_book_add">검색</button>
									<p class="checkBox">
									<input type="checkbox" name="mvBook" value="Y" id="mvBook" <c:if test="${resultInfo.mvBook eq 'Y'}">checked</c:if>>
									<label for="mvBook"><span></span>교재 무료</label>
									<input type="checkbox" name="mvPrint" value="Y" id="mvPrint" <c:if test="${resultInfo.mvPrint eq 'Y'}">checked</c:if>>
									<label for="mvPrint"><span></span>프린트 출력</label>
									</p>
								</td>
							</tr>
						</tbody>
					</table>
					<table class="commonTable detailTable">
						<caption>교재등록 리스트 테이블</caption>
						<colgroup>
							<col style="width:130px">
							<col style="width:*">
							<col style="width:180px">
							<col style="width:130px">
							<col style="width:120px">
							<col style="width:120px">
						</colgroup>
						<thead>
							<tr>
								<th>
									<span class="checkBox">
										<input type="checkbox" class="check_all2" data-check="noBook" id="check_all2" name="check_all2" value="Y">
		  								<label for="check_all2"><span></span>선택</label>
									</span>
									<button type="button" class="commonBtn" onclick="javascript:fnActBookALLDel();">삭제</button>
								</th>
								<th>교재명</th>
								<th>출판사</th>
								<th>가격(원)</th>
								<th>등록일</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody id="bookListTbody">
		 <c:forEach var="lectureBookList" items="${lectureBookList}" varStatus="status">
							<tr id="trBook<c:out value="${lectureBookList.bmIdx}"/>">
								<td style="height:32px">
									<input type="hidden" name="bmIdx" id="bmIdx" value="<c:out value="${lectureBookList.bmIdx}"/>"/>
									<span class="checkBox">
										<input type="checkbox" class="noBook" name="noBookChk" id="noBook<c:out value='${lectureBookList.bmIdx}'/>">
										<label for="noBook<c:out value='${lectureBookList.bmIdx}'/>"><span></span>선택</label>
									</span>
								</td>
								<td><c:out value="${lectureBookList.bmSubject}"/></td>
								<td><c:out value="${lectureBookList.bmPress}"/></td>
								<td class="chkmoney"><c:out value="${lectureBookList.bmPrice2}"/></td>
								<td><c:out value="${fn:substring(lectureBookList.regdt,0,10)}"/></td>
								<td>
							    	<button type="button" class="commonBtn" onclick="javascript:fnActBookDel('<c:out value="${lectureBookList.bmIdx}"/>');">삭제</button>
								</td>
							</tr>
		</c:forEach>
						</tbody>
					</table>
				</fieldset>

				<fieldset>
					<p>강좌 설명</p>
					<table class="rowTable">
						<caption class="blind">강좌 설명</caption>
						<colgroup>
							<col style="width:130px">
							<col style="width:*">
							<col style="width:130px">
							<col style="width:*">
						</colgroup>
						<tbody>	
							<tr>
								<th scope="row">강좌 설명</th>
								<td colspan="3">
								<c:set var="nttCnVal" value="${fn:replace(resultInfo.mvDesc,CRLF, '')}"/>
								<c:set var="nttCnVal" value="${fn:replace(nttCnVal,CR, '')}"/>
								<c:set var="nttCnVal" value="${fn:replace(nttCnVal,LF, '')}"/>
								  <!--editor-->
									<script type="text/javascript">
										DEXT5.config.Width = "100%";
										DEXT5.config.Height = "300px";
										var editor = new Dext5editor("mvDesc");
									    function dext_editor_loaded_event(DEXT5Editor) {
									        DEXT5.setBodyValue('${nttCnVal}', DEXT5Editor.ID);
									    }
									</script>
								  <!--//editor-->
								</td>
							</tr>
						</tbody>
					</table>
				</fieldset>

				<fieldset>
					<p>강좌 리스트에 사용할 Alert메세지</p>
					<table class="rowTable">
						<caption class="blind">강좌 리스트에 사용할 Alert메세지</caption>
						<colgroup>
							<col style="width:130px">
							<col style="width:*">
						</colgroup>
						<tbody>	
							<tr>
								<th>
									<p class="radioStyle">
										<input type="radio" name="mvMsgyn1" value="N" id="mvMsgyn1n" <c:if test="${resultInfo.mvMsgyn1 eq 'N' || empty resultInfo.mvMsgyn1}">checked</c:if>>
										<label for="mvMsgyn1n"><span></span>사용안함</label>
										<br/>
										<input type="radio" name="mvMsgyn1" value="Y" id="mvMsgyn1y" <c:if test="${resultInfo.mvMsgyn1 eq 'Y'}">checked</c:if>>
										<label for="mvMsgyn1y"><span></span>사용함</label>
									</p>
								</th>
								<td>
									<textarea name="mvMsg1" style="height:80px;"><c:out value="${resultInfo.mvMsg1}"/></textarea>
								</td>
							</tr>
						</tbody>
					</table>
				</fieldset>

				<fieldset>
					<p>플레이어에 노출할 공지사항 메세지</p>
					<table class="rowTable">
						<caption class="blind">플레이어에 노출할 공지사항 메세지</caption>
						<colgroup>
							<col style="width:130px">
							<col style="width:*">
						</colgroup>
						<tbody>	
							<tr>
								<th>
									<p class="radioStyle">
										<input type="radio" name="mvMsgyn2" value="N" id="mvMsgyn2n" <c:if test="${resultInfo.mvMsgyn2 eq 'N' || empty resultInfo.mvMsgyn2}">checked</c:if>>
										<label for="mvMsgyn2n"><span></span>사용안함</label>
										<br/>
										<input type="radio" name="mvMsgyn2" value="Y" id="mvMsgyn2y" <c:if test="${resultInfo.mvMsgyn2 eq 'Y'}">checked</c:if>>
										<label for="mvMsgyn2y"><span></span>사용함</label>
									</p>
								</th>
								<td colspan="2">
									<textarea name="mvMsg2" style="height:80px;"><c:out value="${resultInfo.mvMsg2}"/></textarea>
								</td>
							</tr>
						</tbody>
					</table>
				</fieldset>

				<fieldset>
					<p>관리 메모</p>
					<table class="rowTable">
						<caption class="blind">관리 메모</caption>
						<colgroup>
							<col style="width:*">
						</colgroup>
						<tbody>	
							<tr>
								<td colspan="3">
									<textarea name="mvEtc" style="height:80px;"><c:out value="${resultInfo.mvEtc}"/></textarea>
								</td>
							</tr>
						</tbody>
					</table>
				</fieldset>
				<!-- //writeType03 -->
				</form>

			</div>
		</section>

	</section>

	<%@include file="../include/footer.jsp"%>