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
	function onloading() {
		if ("<c:out value='${msg}'/>" != "") {
			alert("<c:out value='${msg}'/>");
		}
	}

	function fnListArticle() {
		document.frm.action = "<c:url value='/boffice/bbs/bbsList.do'/>";
		document.frm.submit();
	}

	function fnDeleteArticle() {
		if ("<c:out value='${anonymous}'/>" == "true" && document.frm.password.value == '') {
			alert('등록시 사용한 패스워드를 입력해 주세요.');
			document.frm.password.focus();
			return;
		}
		if (confirm('<spring:message code="common.delete.msg" />')) {
			var url = '/boffice/bbs/deleteBoardArticle.do';
			var formData = $("#frm").serialize();
			var param = formData;
			
			if(commonUtil.AjaxSynCall(url,param,'text','삭제되었습니다.') == "success"){
				fnListArticle();
			}
			//document.frm.action = "<c:url value='/boffice/bbs/deleteBoardArticle.do'/>";
			//document.frm.submit();
		}
	}

	function fnUpdateArticle() {
		if ("<c:out value='${anonymous}'/>" == "true" && document.frm.password.value == '') {
			alert('등록시 사용한 패스워드를 입력해 주세요.');
			document.frm.password.focus();
			return;
		}

		document.frm.action = "<c:url value='/boffice/bbs/forUpdateArticle.do'/>";
		document.frm.submit();
	}

	function fnWriteReply() {
		document.frm.action = "<c:url value='/boffice/bbs/writeReplyArticle.do'/>";
		document.frm.submit();
	}

	function fnViewArticle(nttId, bbsId) {
		 if(bbsId == "") return false;
		 document.frm.nttId.value = nttId;
		 document.frm.bbsId.value = bbsId;
		 document.frm.action = "<c:url value='/boffice/bbs/viewAritcle.do'/>";
		 document.frm.submit();
	}

	/*$(function(){
		$('img').error(function(){
			$(this).attr('src', '/cmm/fms/getImage.do?atchFileId=&fileSn=0');
		});
	});*/
</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3><c:out value='${brdMstrVO.bbsNm}'/></h3>
				<div class="btnWrap">
				     <c:if test="${brdMstrVO.repYn eq 'Y'}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnWriteReply();">답변작성</button>
			          </c:if>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnUpdateArticle();">수정</button>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnDeleteArticle();">삭제</button>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnListArticle();return false;">목록</button>
				</div>
			</div>
			<div class="realCont">

			<form id="frm" name="frm" method="post" action="">
				<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
				<input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>">
				<input type="hidden" name="searchWrd" value="<c:out value='${searchVO.searchWrd}'/>" >
				<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" >
				<input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" >
				<input type="hidden" name="replyNo" value="<c:out value='${result.replyNo}'/>" >
				<input type="hidden" name="sortOrdr" value="<c:out value='${result.sortOrdr}'/>" >
				<input type="hidden" name="replyLc" value="<c:out value='${result.replyLc}'/>" >
				<input type="hidden" name="nttSj" value="<c:out value='${result.nttSj}'/>" >
				<table class="commonTable writeTable">
					<caption class="blind"><c:out value="${brdMstrVO.bbsNm}"/> 상세보기</caption>
					<colgroup>
						<col style="width:10%">
						<col style="width:40%">
						<col style="width:10%">
						<col style="width:40%">
					</colgroup>
					<tbody>
						<tr>	
							<th scope="col" class="first_line">제목</th>
							<td colspan="3" style="word-wrap: break-word;word-break:break-all;padding:20px;">
							<c:if test="${brdMstrVO.bbsId eq 'BBS_0010' && !empty result.bmPic}">
								<div class="board-book-info">
								<c:if test="${fn:substring(result.bmPic,0,8) ne 'FILE_000'}">
								<img src="/images/bookbm/<c:out value="${result.bmPic}"/>" class="img" style="float:left;width:30px;height:40px;margin-right:4px;">
								</c:if>
								<c:if test="${fn:substring(result.bmPic,0,8) eq 'FILE_000'}">
								<img src='/cmm/fms/getImage.do?atchFileId=<c:out value='${result.bmPic}'/>&fileSn=0' class="img" style="float:left;width:30px;height:40px;margin-right:4px;">
								</c:if>
								 <c:out value='${result.bmSubject}'/>
								 </div>
							</c:if>
							<c:out value="${result.nttSj}" escapeXml="false" />
							</td>
						</tr>
						<c:if test="${brdMstrVO.bbsId eq 'BBS_0007' || brdMstrVO.bbsId eq 'BBS_0013'}">
						<tr>
							<th>강의명</th>
							<td colspan="3"><c:out value="${result.nttLecNm}"/></td>
						</tr>
						</c:if>
						<c:if test="${brdMstrVO.bbsId eq 'BBS_0018'}">
						<tr>
							<th>직렬</th>
							<td><c:out value="${result.nttLecCdNm}"/></td>
							<th>직렬범위</th>
							<td>
								<c:if test="${result.nttLock ne 'Y'}"> 전체</c:if>
								<c:if test="${result.nttLock eq 'Y'}"> 수강중인회원</c:if>
							</td>
						</tr>
						</c:if>
						<c:if test="${brdMstrVO.cateYn eq 'Y'}">
						<tr>
							<th>카테고리</th>
							<td colspan="3"><c:out value="${result.nttCatNm}"/><c:out value="${result.nttLecCdNm}"/></td>
						</tr>
						</c:if>
						<tr>
							<th scope="row">작성자(ID)</th>
							<td><c:out value="${result.ntcrNm}" /> (<c:out value="${result.ntcrId}" />)</td>
							<th scope="row">작성일</th>
							<td><c:out value="${result.nttRegdt}" /></td>
						</tr>
						<tr>	
							<th scope="col" class="first_line">조회수</th>
							<td><c:out value="${result.inqireCo}" /></td>
							<th scope="row">아이피</th>
							<td><c:out value="${result.regip}" /></td>
						</tr>
						<c:if test="${brdMstrVO.linkYn eq 'Y'}">
						<tr>							
							<th scope="col">링크URL</th>
							<td colspan="3"><c:out value="${result.nttLink}" /></td>
						</tr>
						</c:if>
						<c:if test="${brdMstrVO.seqYn eq 'Y'}">
						<tr>
							<th scope="row">순서</th>
							<td colspan="3">
								<c:out value="${result.nttSeq}" />
							</td>
						</tr>
						</c:if>
						<c:if test="${brdMstrVO.hideYn eq 'Y'}">
						<tr>
							<th scope="row">노출여부</th>
							<td colspan="3">
								<c:if test="${result.nttHidden eq 'Y'}"> 숨김</c:if>
								<c:if test="${result.nttHidden ne 'Y'}"> 보임</c:if>
							</td>
						</tr>
						</c:if>
						<c:if test="${brdMstrVO.thumYn eq 'Y'}">
						<tr>							
							<th scope="col">썸네일</th>
							<td colspan="3">
								<div style="position:relative;">
								<img src="/cmm/fms/getImage.do?atchFileId=<c:out value='${result.thumFileId}'/>&fileSn=0" style="max-width:800px; max-height:600px;width:auto; height:auto;margin:auto;top:0; bottom:0; left:0; right:0;"><br/>
								</div>
								<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
									<c:param name="param_atchFileId" value="${result.thumFileId}" />
								</c:import>
							</td>
						</tr>
						</c:if>
						<c:if test="${brdMstrVO.extYn eq 'Y'}">
						<c:forEach var="extMapList" items="${extMapList}" varStatus="extStatus">
						<c:set var="tempVal" value="bExt${extStatus.index+1}"/>
						<tr>
							<th scope="row" class="title_th bdtop"><strong><c:out value="${extMapList.key}"/></strong></th>
							<td colspan="3"><c:out value='${resultExt[tempVal]}'/></td>
						</tr>
						</c:forEach>
						</c:if>

						<c:if test="${brdMstrVO.fileYn eq 'Y'}">
						<tr>							
							<th scope="col">첨부파일</th>
							<td colspan="3">
								<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
									<c:param name="param_atchFileId" value="${result.atchFileId}" />
								</c:import>
							</td>
						</tr>
						</c:if>
						<tr>
							<td colspan="4">
								<div class="View_in" style="word-wrap: break-word;word-break:break-all;padding:20px;">
									<c:out value="${fn:replace(result.nttCn,newLineChar,'<br/>')}" escapeXml="false"/>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
<!-- 모의고사 다운로드 카운트 S-->
				<br/>
				<table class="commonTable detailTable">
					<thead>
						<tr>
						    <th scope="col" class="first_line" width="5%" nowrap>번호</th>
						    <th scope="col" class="first_line" width="*" nowrap>아이디</th>
						    <th scope="col" class="first_line" width="20%" nowrap>이름</th>
						    <th scope="col" class="first_line" width="10%" nowrap>다운횟수</th>
						</tr>
					</thead>
					<tbody>
	<c:forEach var="result" items="${downList}" varStatus="status">
						<tr>
							<td><c:out value="${status.index+1}"/></td>
						    <td><c:out value="${result.mId}"/></td>
						    <td><c:out value="${result.mName}"/></td>
						    <td><c:out value="${result.dCntSum}"/></td>
						</tr>
	</c:forEach>
					</tbody>
				</table>
<!-- 모의고사 다운로드 카운트 E -->

				</div>

        <!--viewBtns-->
        <div class="viewBtns">
		</div>
        <!--//viewBtns-->

        <!--viewPagenation-->
        <div class="viewPagenation">
			<ol>
				<li data-no="<c:out value='${resultTwo.preNum}'/>" class="data-list"><span>이전글</span>
					<c:if test='${empty resultTwo.preNum}'>
					이전글이 없습니다.
					</c:if>
					<c:if test='${!empty resultTwo.preNum}'>
					<c:if test='${resultTwo.preReplyAt eq "Y"}'>
					<img src="/images/icon/re.gif" align="absmiddle">
					</c:if>
					<a href="javascript:void(0);" class="act_view" onClick="javascript:fnViewArticle('<c:out value='${resultTwo.preNum}'/>','<c:out value='${result.bbsId}'/>');">
					<c:out value="${fn:substring(resultTwo.preTitle,0,50)}"/><c:if test="${fn:length(resultTwo.preTitle)>50}">...</c:if>
					</a>
					</c:if>
				</li>
				<li data-no="<c:out value='${resultTwo.nextNum}'/>" class="data-list"><span>다음글</span>
					<c:if test='${empty resultTwo.nextNum}'>
					다음글이 없습니다.
					</c:if>
					<c:if test='${!empty resultTwo.nextNum}'>
					<c:if test='${resultTwo.nextReplyAt eq "Y"}'>
					<img src="/images/icon/re.gif" align="absmiddle">
					</c:if>
					<a href="javascript:void(0);" onClick="javascript:fnViewArticle('<c:out value='${resultTwo.nextNum}'/>','<c:out value='${result.bbsId}'/>');">
					<c:out value="${fn:substring(resultTwo.nextTitle,0,50)}"/><c:if test="${fn:length(resultTwo.nextTitle)>50}">...</c:if></a>
					</c:if>
				</li>
			</ol>
		</div>
        <!--//viewPagenation-->
				<!-- //viewType05 -->

			</form>

			</div>
		</section>

	</section>

<%@include file="../include/footer.jsp"%>