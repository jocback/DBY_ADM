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

function fnActBookModify(op){
	if(!form_val_chk($("#actBookModifyForm"))){
		return;
	}

	if(!confirm("저장 하시겠습니까?")){
		return;
	}
	$("input[name='bmContent']").val(DEXT5.getBodyValue('bmContent'));
	$("input[name='bmContent']").val(($("input[name='bmContent']").val()).replace(/\'/g,"&#39;"));

	var url = "<c:url value='/boffice/actLecture/modifyActBook.do' />";
	if(!document.actBookModifyForm.bmIdx.value){
		url = "<c:url value='/boffice/actLecture/insertActBook.do' />";
	}

    var aFrm = document.actBookModifyForm;
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
    		if(!document.actBookModifyForm.bmIdx.value){
    			location.href="<c:url value='/boffice/actLecture/actBookList.do' />";
    		}else{
    			document.actBookModifyForm.action = "/boffice/actLecture/actBookView.do";
    			document.actBookModifyForm.target = "_parent";
    			document.actBookModifyForm.submit();
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

function fnActBookDel(obj){
	if(!confirm("삭제하시겠습니까?")){
		return;
	}
	var url = "<c:url value='/boffice/actLecture/deleteActBook.do' />";
	var param = {bmIdx : obj}
	commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.');
	location.href="<c:url value='/boffice/actLecture/actBookList.do' />";
}

function fnActBookList(){
	document.actBookModifyForm.action = "<c:url value='/boffice/actLecture/actBookList.do'/>";
	document.actBookModifyForm.submit();
}

function fnActAddCate(){
	var leCode = $("#leCodeSel option:selected").val();
	var clCode = $("#clCodeSel option:selected").val();
	if(!leCode){
		alert("카테고리를 선택하여 주세요");
		return;
	}
	var isExit = false;
	$("input[name=ctCode]").each(function(index){ if($(this).val()==(leCode+clCode)) isExit = true; });
	if(isExit){ alert("추가된 항목입니다."); return; }
	var addStr = '<tr id="tr'+leCode+clCode+'"><td>';
		addStr = addStr +	'<input type="hidden" name="ctCode" id="ctCode" value="'+leCode+clCode+'"/>';
		addStr = addStr +	'<input type="hidden" name="leCode" id="leCode" value="'+leCode+'"/>';
		addStr = addStr +	'<input type="hidden" name="clCode" id="clCode" value="'+clCode+'"/>';
		addStr = addStr +	'<span class="checkBox">';
		addStr = addStr +	'<input type="checkbox" class="no" name="noCateChk" id="no'+leCode+clCode+'">';
		addStr = addStr +	'<label for="no'+leCode+clCode+'"><span></span>선택</label></span></td>';
		addStr = addStr +	'<td>'+$("#leCodeSel option:selected").text()+'</td>';
		addStr = addStr +	'<td>'+$("#clCodeSel option:selected").text()+'</td>';
		addStr = addStr +	'<td><button type="button" class="commonBtn" onclick="javascript:fnActCateDel(\''+leCode+clCode+'\');">삭제</button>';
		addStr = addStr +	'</td></tr>';
	$("#cateListTbody").append(addStr);
}
function fnActCateDel(obj){
	$("#tr"+obj).remove();
}
function fnActCateALLDel(){
	$("input[name=noCateChk]:checked").each(function(index){ $(this).parent().parent().parent().remove(); });
}
function fnIFileDelCk(obj){
	if($(obj).prop("checked")){
		$(obj).parent().parent().parent().parent().parent().find("input[name='fileDel1']").val("Y");
	}else{
		$(obj).parent().parent().parent().parent().parent().find("input[name='fileDel']1").val("");
	}
}
</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>서적 등록</h3>
				<div class="btnWrap">
					<c:if test="${empty resultInfo.bmIdx}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActBookModify('new');">등록</button>
					</c:if>
					<c:if test="${!empty resultInfo.bmIdx}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActBookModify('edit');">수정</button>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActBookDel('<c:out value='${resultInfo.bmIdx}'/>');">삭제</button>
					</c:if>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActBookList();">목록</button>
				</div>
			</div>
			<div class="realCont">

				<form name="actBookModifyForm" id="actBookModifyForm" method="post" enctype="multipart/form-data">
					<input type="hidden" name="pageIndex" value="<c:out value="${searchVO.pageIndex}"/>">
					<input type="hidden" name="searchCnd" value="<c:out value="${searchVO.searchCnd}"/>">
					<input type="hidden" name="searchKeyword" value="<c:out value="${searchVO.searchKeyword}"/>">
					<input type="hidden" name="searchActstt" value="<c:out value="${searchVO.searchActstt}"/>">
				
					<input type="hidden" name="bmIdx" id="bmIdx" value='<c:out value="${resultInfo.bmIdx}"/>' />
					<input type="hidden" name="bmContent" />

					<table class="rowTable">
						<caption class="blind">카테고리 정보</caption>
						<colgroup>
							<col width="130px" />
							<col width="*" />
						</colgroup>
						<tbody>	
							<tr>
								<th scope="row">카테고리</th>
								<td>
									<select name="leCodeSel" id="leCodeSel" style="width:250px;padding-left:10px;">
										<option value="">직렬선택</option>
										<c:import url="/boffice/activity/actLecCdType.do" charEncoding="utf-8">
											<c:param name="codeGb" value="LE" />
											<c:param name="frmTypeValue" value="" />
										</c:import>
									</select>
									<select name="clCodeSel" id="clCodeSel" style="width:180px;padding-left:10px;">
										<option value="">과목선택(전체)</option>
										<c:import url="/boffice/activity/actLecCdType.do" charEncoding="utf-8">
											<c:param name="codeGb" value="CL" />
											<c:param name="frmTypeValue" value="" />
										</c:import>
									</select>
									<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActAddCate();">추가</button>
								</td>
							</tr>
						</tbody>
					</table>
					<table class="commonTable detailTable">
						<caption>카테고리 리스트 테이블</caption>
						<colgroup>
							<col style="width:130px">
							<col style="width:*">
							<col style="width:200px">
							<col style="width:130px">
						</colgroup>
						<thead>
							<tr>
								<th>
									<span class="checkBox">
										<input type="checkbox" class="check_all" data-check="no" id="check_all" name="check_all" value="Y">
		  								<label for="check_all"><span></span>선택</label>
									</span>
									<button type="button" class="commonBtn" onclick="javascript:fnActCateALLDel();">삭제</button>
								</th>
								<th>카테고리</th>
								<th>과목</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody id="cateListTbody">
		 <c:forEach var="categoryList" items="${categoryList}" varStatus="status">
							<tr id="tr<c:out value="${categoryList.leCode}"/><c:out value="${categoryList.clCode}"/>">
								<td>
									<input type="hidden" name="ctCode" id="ctCode" value="<c:out value="${categoryList.leCode}"/><c:out value="${categoryList.clCode}"/>"/>
									<input type="hidden" name="leCode" id="leCode" value="<c:out value="${categoryList.leCode}"/>"/>
									<input type="hidden" name="clCode" id="clCode" value="<c:out value="${categoryList.clCode}"/>"/>
									<span class="checkBox">
										<input type="checkbox" class="no" name="noCateChk" id="no<c:out value="${categoryList.leCode}"/><c:out value="${categoryList.clCode}"/>">
										<label for="no<c:out value="${categoryList.leCode}"/><c:out value="${categoryList.clCode}"/>"><span></span>선택</label>
									</span>
								</td>
								<td><c:out value="${categoryList.lecodeNm}"/></td>
								<td><c:out value="${categoryList.clcodeNm}"/></td>
								<td>
							    	<button type="button" class="commonBtn" onclick="javascript:fnActCateDel('<c:out value="${categoryList.leCode}"/><c:out value="${categoryList.clCode}"/>');">삭제</button>
								</td>
							</tr>
		</c:forEach>
						</tbody>
					</table>
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
								<th scope="row">상품명</th>
								<td colspan="3" id="bmIdxTd">
									<input type="text" name="bmSubject" id="bmSubject" value="<c:out value="${resultInfo.bmSubject}"/>" title="상품명을 입력하여 주세요" class="req" maxlength="100" style="width:350px" />
								</td>
							</tr>
							<tr>
								<th scope="row">상품이미지</th>
								<td colspan="3">
									<input type="hidden" name="fileDel1" />
									<input type="hidden" name="bmPic" value="${resultInfo.bmPic}" />
									<input type="file" name="file_1" id="egovComFileUploader"/><span class="f_color3 ml_20" id="sizeTxt1"></span>
									<c:import url="/cmm/fms/selectFileInfsForUpdate2.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${resultInfo.bmPic}" />
										<c:param name="param_delcheck" value="delck" />
									</c:import>
								</td>
							</tr>
							<tr>
								<th scope="row">저자</th>
								<td colspan="3">
									<input type="text" name="bmAuthor" value="<c:out value='${resultInfo.bmAuthor}'/>" class="" title="저자명을 입력해주세요." maxlength="50">
								</td>
							</tr>
							<tr>
								<th scope="row">출판사</th>
								<td>
									<input type="text" name="bmPress" value="<c:out value='${resultInfo.bmPress}'/>" class="" title="출판사를 입력해주세요." maxlength="50">
								</td>
								<th scope="row">노출여부</th>
								<td>
									<p class="radioStyle">
										<input type="radio" name="bmShow" value="Y" id="ck_view_y" <c:if test="${resultInfo.bmShow eq 'Y'}">checked</c:if>>
										<label for="ck_view_y"><span></span>보임</label>
									</p>
								   <p class="radioStyle">
										<input type="radio" name="bmShow" value="N" id="ck_view_n" <c:if test="${resultInfo.bmShow eq 'N'}">checked</c:if>>
										<label for="ck_view_n"><span></span>숨김</label>
									</p>
								</td>
							</tr>
							<tr>
								<th scope="row">정가(원)</th>
								<td>
									<input type="text" name="bmPrice1" class="chkmoney" value="<c:out value='${resultInfo.bmPrice1}'/>"> 원
									<p class="checkBox">
									<input type="checkbox" name="bmSold" value="Y" id="bmSold" <c:if test="${resultInfo.bmSold eq 'Y'}">checked</c:if>>
									<label for="bmSold"><span></span>품절</label>
									</p>
								</td>
								<th scope="row">판매가(원)</th>
								<td>
									<input type="text" name="bmPrice2" class="chkmoney" value="<c:out value='${resultInfo.bmPrice2}'/>"> 원
								</td>
							</tr>
							<tr>
								<th scope="row">등록옵션</th>
								<td>
									<p class="checkBox">
										<input type="checkbox" name="bmOp1" value="Y" id="bmOp1" <c:if test="${resultInfo.bmOp1 eq 'Y'}">checked</c:if>>
										<label for="bmOp1"><span></span><i class="tableIcon popular">인기</i></label>
									</p>
								   <p class="checkBox">
										<input type="checkbox" name="bmOp2" value="Y" id="bmOp2" <c:if test="${resultInfo.bmOp2 eq 'Y'}">checked</c:if>>
										<label for="bmOp2"><span></span><i class="tableIcon new">NEW</i></label>
									</p>
								   <p class="checkBox">
										<input type="checkbox" name="bmOp3" value="Y" id="bmOp3" <c:if test="${resultInfo.bmOp3 eq 'Y'}">checked</c:if>>
										<label for="bmOp3"><span></span><i class="tableIcon best">베스트</i></label>
									</p>
								   <p class="checkBox">
										<input type="checkbox" name="bmOp4" value="Y" id="bmOp4" <c:if test="${resultInfo.bmOp4 eq 'Y'}">checked</c:if>>
										<label for="bmOp4"><span></span><i class="tableIcon info">강좌설명</i></label>
									</p>
								   <p class="checkBox">
										<input type="checkbox" name="bmOp5" value="Y" id="bmOp5" <c:if test="${resultInfo.bmOp5 eq 'Y'}">checked</c:if>>
										<label for="bmOp5"><span></span><i class="tableIcon recommend">추천</i></label>
									</p>
								   <p class="checkBox">
										<input type="checkbox" name="bmOp6" value="Y" id="bmOp6" <c:if test="${resultInfo.bmOp6 eq 'Y'}">checked</c:if>>
										<label for="bmOp6"><span></span><i class="tableIcon event">이벤트</i></label>
									</p>
								</td>
								<th scope="row">노출위치</th>
								<td>
								   <p class="checkBox">
										<input type="checkbox" name="bmSite1" value="Y" id="ck_school" <c:if test="${resultInfo.bmSite1 eq 'Y'}">checked</c:if>>
										<label for="ck_school"><span></span>학원강의</label>
									</p>
								   <p class="checkBox">
										<input type="checkbox" name="bmSite2" value="Y" id="ck_movie" <c:if test="${resultInfo.bmSite2 eq 'Y'}">checked</c:if>>
										<label for="ck_movie"><span></span>동영상강의</label>
									</p>
								</td>
							</tr>
							<c:if test="${!empty resultInfo.bmIdx}">
							<tr>
								<th scope="row">등록일</th>
								<td colspan="3">
									<c:out value="${resultInfo.regdt}"/>
								</td>
							</tr>
							</c:if>
							<tr>
								<th scope="row">상품설명</th>
								<td colspan="3">
								<c:set var="nttCnVal" value="${fn:replace(resultInfo.bmContent,CRLF, '')}"/>
								<c:set var="nttCnVal" value="${fn:replace(nttCnVal,CR, '')}"/>
								<c:set var="nttCnVal" value="${fn:replace(nttCnVal,LF, '')}"/>
								  <!--editor-->
									<script type="text/javascript">
										DEXT5.config.Width = "100%";
										DEXT5.config.Height = "300px";
										var editor = new Dext5editor("bmContent");
									    function dext_editor_loaded_event(DEXT5Editor) {
									        DEXT5.setBodyValue('${nttCnVal}', DEXT5Editor.ID);
									    }
									</script>
								  <!--//editor-->
								</td>
							</tr>
						</tbody>
					</table>
				<!-- //writeType03 -->
				</form>

			</div>
		</section>

	</section>

	<%@include file="../include/footer.jsp"%>