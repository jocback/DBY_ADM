<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/header.jsp"%>
<%@ taglib prefix="ckeditor" uri="http://ckeditor.com" %>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="board" staticJavascript="false" xhtml="true" cdata="false"/>
<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript">

	function fn_egov_validateForm(obj) {
		return true;
	}

	function fnRegistApply() {
			$("input[name='nttCn']").val(DEXT5.getBodyValue('nttCn'));
			$("input[name='nttCn']").val(($("input[name='nttCn']").val()).replace(/\'/g,"&#39;"));
		if (confirm('<spring:message code="common.regist.msg" />')) {
			if(!$("#nttSj").val()){
				alert("제목을 입력하여 주세요.");
				return;
			}
			$("input[name='file_1']").each(function(index){
				$(this).prop("name","file_"+index);
			});
			document.board.action = "<c:url value='/boffice/bbs/insertReplyArticle.do'/>";
			document.board.submit();
		}
	}

	function makeFileAttachment(){
	<c:if test="${bdMstr.fileYn == 'Y'}">
		 var maxFileNum = document.board.posblAtchFileNumber.value;
	     if (maxFileNum==null || maxFileNum=="") {
	    	 maxFileNum = 3;
	     }
		 var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
		 multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
	</c:if>
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

	$(document).ready(function(){
		makeFileAttachment();
	});
</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3><c:out value='${bdMstr.bbsNm}'/></h3>
				<div class="btnWrap">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnRegistApply();return false;">등록</button>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:history.go(-1);">취소</button>
				</div>
			</div>
			<div class="realCont">

			<form name="board" method="post" enctype="multipart/form-data" >
				<input type="hidden" name="replyAt" value="Y" />
				<input type="hidden" name="pageIndex"  value="<c:out value='${searchVO.pageIndex}'/>"/>
				<input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>">
				<input type="hidden" name="searchWrd" value="<c:out value='${searchVO.searchWrd}'/>" >
				<input type="hidden" name="bbsId" value="<c:out value='${bdMstr.bbsId}'/>" />
				<input type="hidden" name="nttId" value="<c:out value='${searchVO.nttId}'/>" />
				<input type="hidden" name="replyNo" value="<c:out value='${searchVO.replyNo}'/>" />
				<input type="hidden" name="sortOrdr" value="<c:out value='${searchVO.sortOrdr}'/>" />
				<input type="hidden" name="replyLc" value="<c:out value='${searchVO.replyLc}'/>" />
	
				<input type="hidden" name="repYn" value="<c:out value='${bdMstr.repYn}'/>" />
				<input type="hidden" name="fileYn" value="<c:out value='${bdMstr.fileYn}'/>" />
				<input type="hidden" name="fileCnt" value="<c:out value='${bdMstr.fileCnt}'/>" />
				<input type="hidden" name="fileSize" value="<c:out value='${bdMstr.fileSize}'/>" />
				<input type="hidden" name="extYn" value="<c:out value='${bdMstr.extYn}'/>" />
				<input type="hidden" name="nttCn" />

				<table class="rowTable">
					<caption class="blind"><c:out value="${bdMstr.bbsNm}"/> 신규 등록 및 수정</caption>
					<colgroup>
				          <col style="width:10%">
				          <col style="width:40%">
				          <col style="width:10%">
				          <col style="width:40%">
					</colgroup>
					<tbody>	
						<tr>
							<th scope="row"><strong>제목</strong></th>
							<td colspan="3"><c:out value="${Tresult.nttSj}"/></td>
						</tr>
						<tr>
							<th scope="row"><strong>작성자</strong></th>
							<td>
								<c:out value="${Tresult.ntcrNm}" />
							</td>
							<th scope="row"><strong>작성일</strong></th>
							<td>
								<c:out value="${Tresult.regdt}" />
							</td>
						</tr>
						<tr>
							<th scope="row"><strong>내 용</strong></th>
							<td colspan="3" style="word-break:break-word;">
								<c:out value="${Tresult.nttCn}" escapeXml="false" />
							</td>
						</tr>
						<tr>
							<th scope="row"><strong>첨부파일</strong></th>
							<td colspan="3">
								<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
									<c:param name="param_atchFileId" value="${Tresult.atchFileId}" />
								</c:import>
							</td>
						</tr>
					</tbody>
				</table>

				<table class="rowTable">
					<caption class="blind"><c:out value="${bdMstr.bbsNm}"/> 신규 등록 및 수정</caption>
					<colgroup>
				          <col style="width:10%">
				          <col style="width:40%">
				          <col style="width:10%">
				          <col style="width:40%">
					</colgroup>
					<tbody>
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
						<c:if test="${brdMstrVO.bbsId eq 'BBS_0007' || brdMstrVO.bbsId eq 'BBS_0013'}">
						<tr>
							<th>강의명</th>
							<td style="padding-left: 15px;" colspan="3">
								<select name="nttCat" id="nttCat" style="width:300px;">
								<c:import url="/boffice/activity/actLecType.do" charEncoding="utf-8">
									<c:param name="frmTypeValue" value="${Tresult.nttCat}" />
								</c:import>
								</select>
							</td>
						</tr>
						</c:if>
						<c:if test="${brdMstrVO.bbsId eq 'BBS_0018'}">
						<tr>
							<th>직렬</th>
							<td style="padding-left: 15px;" colspan="3">
								<select name="nttCat" id="nttCat" style="width:300px;">
								<c:import url="/boffice/activity/actLecCdType.do" charEncoding="utf-8">
									<c:param name="codeGb" value="LE" />
									<c:param name="frmTypeValue" value="${Tresult.nttCat}${boardVO.nttCat}" />
								</c:import>
								</select>
							</td>
						</tr>
						</c:if>
						<c:if test="${brdMstrVO.cateYn eq 'Y'}">
						<tr>
							<th>분류</th>
							<td style="padding-left: 15px;" colspan="3">
								<select name="nttCat" id="nttCat" style="width:300px;">
								<c:import url="/boffice/activity/actFrmType.do" charEncoding="utf-8">
									<c:param name="frmTypeCode" value="${brdMstrVO.cateCd}" />
									<c:param name="frmTypeValue" value="${boardVO.nttCat}" />
								</c:import>
								</select>
							</td>
						</tr>
						</c:if>
						<tr>
							<th scope="row"><strong>답변 제목</strong></th>
							<td colspan="3">
								<input type="text" name="nttSj" id="nttSj" value="[RE]<c:out value="${Tresult.nttSj}"/>" style="width:739px;">
							</td>
						</tr>
						<tr>
							<th scope="row"><strong>답변 내용</strong></th>
							<td colspan="3">
							  <!--editor-->
								<script type="text/javascript">
									DEXT5.config.Width = "100%";
									DEXT5.config.Height = "300px";
									var editor = new Dext5editor("nttCn");
								    function dext_editor_loaded_event(DEXT5Editor) {
								        DEXT5.setBodyValue('<c:out value="${result.nttCn}" escapeXml="false" />', DEXT5Editor.ID);
								    }
								</script>
							  <!--//editor-->
							</td>
						</tr>
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
					</tbody>
				</table>

				<!-- //writeType03 -->
			</form>

			</div>
			<div class="rightTitle" style="margin-top:20px;">
				<div class="btnWrap">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnRegistApply();return false;">등록</button>
				</div>
			</div>
		</section>

	</section>
<%@include file="../include/footer.jsp"%>