<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
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
	$(document).ready(function(){
		document.frmBoard.nttSj.focus();
		$("#nttCat").val('${result.nttCat}');
		
		//학원 현장강의 제목, 직렬카테고리 입력 기능
		if($("#nttSjLecCd").length > 0) $("#nttSj").css("width","300px");
		$(document).on('change', '#nttSjLecCd', function() {
			$(this).prev('input:text').val($("#nttSjLecCd option:selected").text());
			if ($(this).val() == ''){
				$(this).prev('input:text').val("");
				$(this).prev('input:text').focus();
			}
		});
	});
	function fn_egov_validateForm(obj){
		return true;
	}

	function fnUpdateArticle(){
		if(!$("#ntcrNm").val()){
			alert("작성자명을 입력하여 주세요.");
			return;
		}
		if(!$("#nttRegdt").val()){
			alert("작성일을 입력하여 주세요.");
			return;
		}
		$("input[name='file_1']").each(function(index){
			$(this).prop("name","file_"+index);
		});
		if (confirm('저장하시겠습니까?')) {
			<c:if test="${brdMstrVO.bbsId eq 'BBS_0001'}">
			if($("select[name='nttCat']").val() == '13'){
				if(!$("select[name='nttCatLect']").val()){
					alert("직렬 카테고리를 선택하여 주세요");
					return;
				}
				$("select[name='nttCat']").prop('name','nttCatOrg');
				$("select[name='nttCatLect']").prop('name','nttCat');
			}
			</c:if>
			$("input[name='nttCn']").val(DEXT5.getBodyValue('nttCn'));
			$("input[name='nttCn']").val(($("input[name='nttCn']").val()).replace(/\'/g,"&#39;"));
			document.frmBoard.action = "<c:url value='/boffice/bbs/insertBoardArticle.do'/>";
			<c:if test="${!empty result.nttId}">
				document.frmBoard.action = "<c:url value='/boffice/bbs/updateBoardArticle.do'/>";
			</c:if>
			document.frmBoard.submit();
		}
	}

	function fnListArticle() {
		document.frmBoard.action = "<c:url value='/boffice/bbs/bbsList.do'/>";
		document.frmBoard.submit();
	}

	function fnActFileAdd(){
		var str = '<input type="file" name="file_1" style="width:500px;" /> ';
		str = str + '<a href="javascript:void(0);" class="button_v2" onclick="javascript:fnActFileCancel(this);"><span>취소</span></a>';
		$("#inputFileSpan").append(str);
	}
	function fnActFileCancel(obj){
		$(obj).prev().remove();
		$(obj).remove();
		if($("input[name='file_1']").size()<1){
			fnActFileAdd();
		}
	}
</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3><c:out value='${bdMstr.bbsNm}'/></h3>
				<div class="btnWrap">
					<c:if test="${empty result.nttId}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnUpdateArticle();return false;">등록</button>
					</c:if>
					<c:if test="${!empty result.nttId}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnUpdateArticle();return false;">수정</button>
					</c:if>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnListArticle();return false;">목록</button>
				</div>
			</div>
			<div class="realCont">

			<form name="frmBoard" method="post" enctype="multipart/form-data" >
			<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
			<input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>">
			<input type="hidden" name="searchWrd" value="<c:out value='${searchVO.searchWrd}'/>" >
			
			<input type="hidden" name="bbsId" value="<c:out value='${bdMstr.bbsId}'/>" />
			<c:if test="${!empty result.nttId}">
			<input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" />
			</c:if>
			
			<input type="hidden" name="repYn" value="<c:out value='${bdMstr.repYn}'/>" />
			<input type="hidden" name="fileYn" value="<c:out value='${bdMstr.fileYn}'/>" />
			<input type="hidden" name="fileCnt" value="<c:out value='${bdMstr.fileCnt}'/>" />
			<input type="hidden" name="fileSize" value="<c:out value='${bdMstr.fileSize}'/>" />
			<input type="hidden" name="extYn" value="<c:out value='${bdMstr.extYn}'/>" />
			<input type="hidden" name="nttCn" />

					<table class="rowTable">
						<caption class="blind"><c:out value="${brdMstrVO.bbsNm}"/> 신규 등록 및 수정</caption>
						<colgroup>
					          <col style="width:10%">
					          <col style="width:40%">
					          <col style="width:10%">
					          <col style="width:40%">
						</colgroup>
						<tbody>	
							<tr>
								<th scope="row"><strong>제목</strong></th>
								<td colspan="3">
									<input type="text" name="nttSj" id="nttSj" value="<c:out value="${result.nttSj}" />" style="width:70%;" maxlength="500">
									<c:if test="${brdMstrVO.bbsId eq 'BBS_0003'}">
									<select name=nttSjLecCd id="nttSjLecCd" style="width:180px;">
										<option value="">선택</option>
										<c:import url="/boffice/activity/actLecCdType.do" charEncoding="utf-8">
											<c:param name="codeGb" value="LE" />
											<c:param name="frmTypeValue" value="" />
										</c:import>
									</select>
									</c:if>
								</td>
							</tr>
							<c:if test="${bdMstr.mainYn eq 'Y'}">
							<tr>
								<th scope="row"><strong>메인공지여부</strong></th>
								<td colspan="3">
									<p class="radioStyle">
										<input type="radio" name="nttMain" id="nttMain1" value="Y" <c:if test="${result.nttMain eq 'Y'}"> checked</c:if> />
										<label for="nttMain1"><span></span>메인게시</label>
										<input type="radio" name="nttMain" id="nttMain2" value="N" <c:if test="${result.nttMain eq 'N' || empty result.nttMain}"> checked</c:if> />
										<label for="nttMain2"><span></span>아니오</label>
									</p>
								</td>
							</tr>
							</c:if>
							<c:if test="${bdMstr.topYn eq 'Y'}">
							<tr>
								<th scope="row"><strong>공지여부</strong></th>
								<td colspan="3">
									<p class="radioStyle">
										<input type="radio" name="nttTop" id="nttTop1" value="Y" <c:if test="${result.nttTop eq 'Y'}"> checked</c:if> />
										<label for="nttTop1"><span></span>공지</label>
										<input type="radio" name="nttTop" id="nttTop2" value="N" <c:if test="${result.nttTop eq 'N' || empty result.nttTop}"> checked</c:if> />
										<label for="nttTop2"><span></span>일반</label>
									</p>
								</td>
							</tr>
							</c:if>
							<c:if test="${bdMstr.cateYn eq 'Y'}">
							<tr>
								<th scope="row"><strong>카테고리</strong></th>
								<td colspan="3">
									<div style="width:250px;float:left;display:inline;">
									<select name=nttCat id="nttCat">
										<option value="">선택</option>
										<c:import url="/boffice/activity/actFrmType.do" charEncoding="utf-8">
										<c:param name="frmTypeCode" value="${bdMstr.cateCd}" />
										<c:param name="frmTypeValue" value="${result.nttCat}" />
										</c:import>
									</select>
									</div>
									<c:if test="${brdMstrVO.bbsId eq 'BBS_0001'}">
									<div style="width:250px;float:left;">
										<select name=nttCatLect id="nttCatLect">
											<option value="">선택</option>
											<c:import url="/boffice/activity/actLecCdType.do" charEncoding="utf-8">
												<c:param name="codeGb" value="LE" />
												<c:param name="frmTypeValue" value="${result.nttCat}" />
											</c:import>
										</select>
									</div>
									<script type="text/javascript">
									$(function(){
										$("select[name='nttCatLect']").hide();
										if($("select[name='nttCatLect']").val()){ $("select[name='nttCat']").val('13'); $("select[name='nttCatLect']").show(); }
										$("select[name='nttCat']").on('change',function(){
											if($(this).val() == '13'){
												$("select[name='nttCatLect']").show();
											}else{
												$("select[name='nttCatLect']").hide();
											}
										});
									});
									</script>
									</c:if>
								</td>
							</tr>
							</c:if>
							<c:if test="${brdMstrVO.bbsId eq 'BBS_0007' || brdMstrVO.bbsId eq 'BBS_0013'}">
							<tr>
								<th>강의명</th>
								<td colspan="3">
									<select name="nttCat" id="nttCat" style="width:50%;">
										<option value="">선택</option>
										<c:import url="/boffice/activity/actLecType.do" charEncoding="utf-8">
											<c:param name="searchOp5" value="" />
											<c:param name="frmTypeValue" value="${Tresult.nttCat}${boardVO.nttCat}" />
										</c:import>
									</select>
								</td>
							</tr>
							</c:if>
							<c:if test="${brdMstrVO.bbsId eq 'BBS_0018'}">
							<tr>
								<th>직렬</th>
								<td>
									<select name=nttCat id="nttCat" style="width:180px;">
										<option value="">선택</option>
										<c:import url="/boffice/activity/actLecCdType.do" charEncoding="utf-8">
											<c:param name="codeGb" value="LE" />
											<c:param name="frmTypeValue" value="${Tresult.nttCat}${boardVO.nttCat}" />
										</c:import>
									</select>
								</td>
								<th>직렬범위</th>
								<td>
									<p class="radioStyle">
										<input type="radio" name="nttLock" id="nttLock2" value="N" <c:if test="${result.nttLock eq 'N' || empty result.nttLock}"> checked</c:if> />
										<label for="nttLock2"><span></span>전체</label>
										<input type="radio" name="nttLock" id="nttLock1" value="Y" <c:if test="${result.nttLock eq 'Y'}"> checked</c:if> />
										<label for="nttLock1"><span></span>수강중인회원</label>
									</p>
								</td>
							</tr>
							</c:if>
							<c:if test="${bdMstr.seqYn eq 'Y'}">
							<tr>
								<th scope="row"><strong>순서</strong></th>
								<td colspan="3">
									<input type="text" name="nttSeq" id="nttSeq" value="<c:out value="${result.nttSeq}" />" class="chknum" maxlength="5">
								</td>
							</tr>
							</c:if>
							<c:if test="${bdMstr.hideYn eq 'Y'}">
							<tr>
								<th scope="row"><strong>노출여부</strong></th>
								<td colspan="3">
									<p class="radioStyle">
										<input type="radio" name="nttHidden" id="nttHidden2" value="N" <c:if test="${result.nttHidden eq 'N' || empty result.nttHidden}"> checked</c:if> />
										<label for="nttHidden2"><span></span>보임</label>
										<input type="radio" name="nttHidden" id="nttHidden1" value="Y" <c:if test="${result.nttHidden eq 'Y'}"> checked</c:if> />
										<label for="nttHidden1"><span></span>숨김</label>
									</p>
								</td>
							</tr>
							</c:if>
							<tr>
								<th scope="row"><strong>작성자</strong></th>
								<td>
									<input type="text" name="ntcrNm" id="ntcrNm" value="<c:if test="${empty result.ntcrNm}"><c:out value="${user.name}" /></c:if><c:out value="${result.ntcrNm}" />" maxlength="20">
								</td>
								<th scope="row"><strong>작성일</strong></th>
								<td>
									<input type="text" name="nttRegdt" id="nttRegdt" value="<c:if test="${empty result.nttRegdt}"><c:out value="${currDate}" /></c:if><c:out value="${result.nttRegdt}" />" class="calendar" readonly>
								</td>
							</tr>
							<c:if test="${bdMstr.linkYn eq 'Y'}">
							<tr>
								<th scope="row"><strong>링크URL</strong></th>
								<td>
									<input type="text" name="nttLink" id="nttLink" value="<c:out value='${result.nttLink}'/>" style="width:739px;" maxlength="500">
								</td>
							</tr>
							</c:if>

						  <c:if test="${not empty result.thumFileId}">
							<tr>
								<th scope="row">썸네일</th>
								<td>
									<c:import url="/cmm/fms/selectThumFileInfsForUpdate.do" charEncoding="utf-8">
									<c:param name="param_thumFileId" value="${result.thumFileId}" />
									</c:import>
								</td>
							</tr>
						  </c:if>
						  <c:if test="${bdMstr.thumYn == 'Y'}">
							<tr>
								<th scope="row"><strong>썸네일</strong></th>
								<td>
									<input type="file" name="fileThum" style="width:500px;" />
								</td>
							</tr>
						  </c:if>

							<c:if test="${bdMstr.extYn eq 'Y'}">
							<c:forEach var="extMapList" items="${extMapList}" varStatus="extStatus">
							<c:set var="tempVal" value="bExt${extStatus.index+1}"/>
							<tr>
								<th scope="row"><strong><c:out value="${extMapList.key}"/></strong></th>
								<td colspan="3">
									<input type="text" name="bExt<c:out value='${extStatus.index+1}'/>" id="bExt<c:out value='${extStatus.index+1}'/>" value="<c:out value='${resultExt[tempVal]}'/>" maxlength="500">
								</td>
							</tr>
							</c:forEach>
							</c:if>

						  <c:if test="${not empty result.atchFileId}">
							<tr>
								<th scope="row">첨부파일</th>
								<td colspan="3">
									<c:import url="/cmm/fms/selectFileInfsForUpdate.do" charEncoding="utf-8">
									<c:param name="param_atchFileId" value="${result.atchFileId}" />
									</c:import>
								</td>
							</tr>
						  </c:if>
						  <c:if test="${bdMstr.fileYn == 'Y'}">
							<tr>
								<th scope="row"><strong>첨부파일</strong></th>
								<td colspan="3">
									<span id="inputFileSpan">
										<input type="file" name="file_1" style="width:500px;" />
										<a href="javascript:void(0);" class="button_v2" onclick="javascript:fnActFileCancel(this);"><span>취소</span></a>
									</span>
									<c:if test="${bdMstr.fileCnt ne '1'}">
									<a href="javascript:void(0);" class="button_v2" onclick="javascript:fnActFileAdd();"><span>추가</span></a>
									</c:if>
								</td>
							</tr>
						  </c:if>

							<tr>
								<th scope="row"><strong>내 용</strong></th>
								<td colspan="3">
								<c:set var="nttCnVal" value="${fn:replace(result.nttCn,CRLF, '')}"/>
								<c:set var="nttCnVal" value="${fn:replace(nttCnVal,CR, '')}"/>
								<c:set var="nttCnVal" value="${fn:replace(nttCnVal,LF, '')}"/>
								  <!--editor-->
									<script type="text/javascript">
										DEXT5.config.Width = "100%";
										DEXT5.config.Height = "300px";
										var editor = new Dext5editor("nttCn");
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
			<div class="rightTitle" style="margin-top:20px;">
				<div class="btnWrap">
					<c:if test="${empty result.nttId}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnUpdateArticle();return false;">등록</button>
					</c:if>
					<c:if test="${!empty result.nttId}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnUpdateArticle();return false;">수정</button>
					</c:if>
				</div>
			</div>
		</section>

	</section>

<%@include file="../include/footer.jsp"%>