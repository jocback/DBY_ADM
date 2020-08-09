<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/header.jsp"%>
<script type="text/javascript">

	function fn_egov_update_brdMstr(){
		var list = document.getElementsByName('fileYn');
		var fileAtchPosblAt_value;
		for (var i=0; i < list.length; i++) {
			if(list[i].checked == true) {
				fileAtchPosblAt_value = list[i].value;
			}
		}
		
		if (fileAtchPosblAt_value == "Y" && document.boardMaster.fileCnt.value == 0 ) {
			alert("첨부가능파일 숫자를 1개이상 선택하세요.");
			return;
		}
		
		if (fileAtchPosblAt_value == "N" && document.boardMaster.fileCnt.value != 0 ) {
			document.boardMaster.fileCnt.value = 0;
		}

		if($("#cateYn").prop("checked") && !$("#cateCd").val()){
			alert("카테고리 기능이 추가 되는 경우는 카테고리코드가 필요합니다.\n코드관리에서 카테고리코드를 생성 후에 입력하여 주세요.");
			$("#cateCd").focus();
			return;
		}

		if(confirm('저장하시겠습니까?')){
			document.boardMaster.action = "<c:url value='/boffice/bbs/insertBBSMasterInf.do'/>";
			if(document.boardMaster.bbsId.value){
				document.boardMaster.action = "<c:url value='/boffice/bbs/UpdateBBSMasterInf.do'/>";
			}
			document.boardMaster.submit();
		}
	}

	function fn_egov_select_brdMstrList(){
		document.boardMaster.action = "<c:url value='/boffice/bbs/actBbsMasterList.do'/>";
		document.boardMaster.submit();
	}

	function fn_egov_delete_brdMstr(){
		if(confirm('<spring:message code="common.delete.msg" />')){
			document.boardMaster.action = "<c:url value='/boffice/bbs/DeleteBBSMasterInf.do'/>";
			document.boardMaster.submit();
		}
	}

</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>게시판 마스터</h3>
				<div class="btnWrap">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fn_egov_update_brdMstr(); return false;">저장</button>
					<c:if test="${!empty result.bbsId}">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fn_egov_delete_brdMstr(); return false;">삭제</button>
					</c:if>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fn_egov_select_brdMstrList(); return false;">목록</button>
				</div>
			</div>
			<div class="realCont">

				<form name="boardMaster" action="/boffice/bbs/actBbsMasterList.do" method="post" >
				<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
				<input name="bbsId" type="hidden" value="<c:out value='${result.bbsId}'/>" />
				
				<table class="rowTable">
					<caption class="blind">카테고리 정보</caption>
					<colgroup>
						<col width="130px" />
						<col width="*" />
						<col width="130px" />
						<col width="*" />
					</colgroup>
					<tbody>	
					<tr>
						<th scope="row">게시판코드</th>
						<td colspan="3"><c:out value='${result.bbsId}'/></td>
					</tr>
					<tr>
						<th scope="row">게시판명</th>
						<td colspan="3"><input title="게시판명입력" name="bbsNm" type="text" size="60" value='<c:out value="${result.bbsNm}"/>' maxlength="60" class="req" title="게시판명을 입력해주세요." ></td>
					</tr>
					<tr>
						<th scope="row">게시판 설명</th>
						<td colspan="3"><input title="게시판소개입력" name="bbsCn" type="text" maxlength="250" style="width:760px" value='<c:out value="${result.bbsCn}"/>' ></td>
					</tr>
					<tr>
						<th scope="row">게시판사용여부</th>
						<td>
							<span class="checkBox">
								<input type="checkbox" name="useYn" id="useYn" value="Y" <c:if test="${result.useYn ne 'N'}"> checked</c:if>/>
								<label for="useYn"><span></span></label>
							</span>
						</td>
						<th scope="row">썸네일기능</th>
						<td>
							<span class="checkBox">
								<input type="checkbox" name="thumYn" id="thumYn" value="Y" <c:if test="${result.thumYn eq 'Y'}"> checked</c:if>/>
								<label for="thumYn"><span></span></label>
							</span>
						</td>
					</tr>
					<tr>
						<th scope="row">답장가능여부</th>
						<td>
							<span class="checkBox">
								<input type="checkbox" name="repYn" id="repYn" value="Y" <c:if test="${result.repYn eq 'Y'}"> checked</c:if>/>
								<label for="repYn"><span></span></label>
							</span>
						</td>
						<th scope="row">댓글가능여부</th>
						<td>
							<span class="checkBox">
								<input type="checkbox" name="cmtYn" id="cmtYn" value="Y" <c:if test="${result.cmtYn eq 'Y'}"> checked</c:if>/>
								<label for="cmtYn"><span></span></label>
							</span>
						</td>
					</tr>
					<tr>
						<th scope="row">파일첨부여부</th>
						<td>
							<span class="checkBox">
								<input type="checkbox" name="fileYn" id="fileYn" value="Y" <c:if test="${result.fileYn eq 'Y'}"> checked</c:if>/>
								<label for="fileYn"><span></span></label>
							</span>
						</td>
						<th scope="row">첨부파일 수</th>
						<td><input type="text" name="fileCnt" id="fileCnt" value="${result.fileCnt}<c:if test="${empty result.fileCnt}">0</c:if>"  maxlength="2" class="chknum" style="width:29px;ime-mode:disabled;"/></td>
					</tr>
					<tr>
						<th scope="row">메인공지기능</th>
						<td>
							<span class="checkBox">
								<input type="checkbox" name="mainYn" id="mainYn" value="Y" <c:if test="${result.mainYn eq 'Y'}"> checked</c:if>/>
								<label for="mainYn"><span></span></label>
							</span>
						</td>
						<th scope="row">공지기능</th>
						<td>
							<span class="checkBox">
								<input type="checkbox" name="topYn" id="topYn" value="Y" <c:if test="${result.topYn eq 'Y'}"> checked</c:if>/>
								<label for="topYn"><span></span></label>
							</span>
						</td>
					</tr>
					<tr>
						<th scope="row">링크기능</th>
						<td>
							<span class="checkBox">
								<input type="checkbox" name="linkYn" id="linkYn" value="Y" <c:if test="${result.linkYn eq 'Y'}"> checked</c:if>/>
								<label for="linkYn"><span></span></label>
							</span>
						</td>
						<th scope="row">노출여부</th>
						<td>
							<span class="checkBox">
								<input type="checkbox" name="hideYn" id="hideYn" value="Y" <c:if test="${result.hideYn eq 'Y'}"> checked</c:if>/>
								<label for="hideYn"><span></span></label>
							</span>
						</td>
					</tr>
					<tr>
						<th scope="row">순서기능</th>
						<td>
							<span class="checkBox">
								<input type="checkbox" name="seqYn" id="seqYn" value="Y" <c:if test="${result.seqYn eq 'Y'}"> checked</c:if>/>
								<label for="seqYn"><span></span></label>
							</span>
						</td>
						<th scope="row">비밀글여부</th>
						<td>
							<span class="checkBox">
								<input type="checkbox" name="lockYn" id="lockYn" value="Y" <c:if test="${result.lockYn eq 'Y'}"> checked</c:if>/>
								<label for="lockYn"><span></span></label>
							</span>
						</td>
					</tr>
					<tr>
						<th scope="row">카테고리기능</th>
						<td>
							<span class="checkBox">
								<input type="checkbox" name="cateYn" id="cateYn" value="Y" <c:if test="${result.cateYn eq 'Y'}"> checked</c:if>/>
								<label for="cateYn"><span></span></label>
							</span>
							<input type="text" name="cateCd" id="cateCd" size="30" maxlength="20" value="${result.cateCd}" style="width:120px;"/>(코드)
						</td>
						<th scope="row">이전/다음글</th>
						<td>
							<span class="checkBox">
								<input type="checkbox" name="twoYn" id="twoYn" value="Y" <c:if test="${result.twoYn eq 'Y'}"> checked</c:if>/>
								<label for="twoYn"><span></span></label>
							</span>
						</td>
					</tr>
					<tr>
						<th scope="row">새글</th>
						<td>
							<span class="checkBox">
								<input type="checkbox" name="newYn" id="newYn" value="Y" <c:if test="${result.newYn eq 'Y'}"> checked</c:if>/>
								<label for="newYn"><span></span></label>
							</span>
							<input type="text" name="newNo" id="newNo" size="30" class="chknum" maxlength="10" value="${result.newNo}" style="width:120px;"/>(기간)
						</td>
						<th scope="row">인기글</th>
						<td>
							<span class="checkBox">
								<input type="checkbox" name="hotYn" id="hotYn" value="Y" <c:if test="${result.hotYn eq 'Y'}"> checked</c:if>/>
								<label for="hotYn"><span></span></label>
							</span>
							<input type="text" name="hotNo" id="hotNo" size="30" class="chknum" maxlength="10" value="${result.hotNo}" style="width:120px;"/>(조회수)
						</td>
					</tr>
					<tr style="height:70px;">
						<th scope="row">확장필드</th>
						<td colspan="3">
							<span class="checkBox">
								<input type="checkbox" name="extYn" id="extYn" value="Y" <c:if test="${result.extYn eq 'Y'}"> checked</c:if>/>
								<label for="extYn"><span></span></label>
							</span>
							<input type="text" name="extFld" id="extFld" maxlength="250" style="width:760px" value="${result.extFld}"/><br/>
							*최대 10개까지 쉼표로 구분하여 명칭:폼타입 으로 입력 예) 기간:input,공연정보:input,장소:input,동의:radio
						</td>
					</tr>
					<tr>
						<th scope="row">리스트권한</th>
						<td colspan="3">
							<p class="radioStyle">
								<input id="posblList1" name="posblList" type="radio" value="1" <c:if test="${result.posblList eq '1' || empty result.posblList}"> checked</c:if>/><label for="posblList1"><span></span>비회원</label>
								<input id="posblList2" name="posblList" type="radio" value="2" <c:if test="${result.posblList eq '2'}"> checked</c:if>/><label for="posblList2"><span></span>회원</label>
								<input id="posblList3" name="posblList" type="radio" value="3" <c:if test="${result.posblList eq '3'}"> checked</c:if>/><label for="posblList3"><span></span>관리자</label>
							</p>
						</td>
					</tr>
					<tr>
						<th scope="row">뷰권한</th>
						<td colspan="3">
							<p class="radioStyle">
								<input id="posblView1" name="posblView" type="radio" value="1" <c:if test="${result.posblView eq '1' || empty result.posblView}"> checked</c:if>/><label for="posblView1"><span></span>비회원</label>
								<input id="posblView2" name="posblView" type="radio" value="2" <c:if test="${result.posblView eq '2'}"> checked</c:if>/><label for="posblView2"><span></span>회원</label>
								<input id="posblView3" name="posblView" type="radio" value="3" <c:if test="${result.posblView eq '3'}"> checked</c:if>/><label for="posblView3"><span></span>관리자</label>
							</p>
						</td>
					</tr>
					<tr>
						<th scope="row">쓰기권한</th>
						<td colspan="3">
							<p class="radioStyle">
								<input id="posblWrite1" name="posblWrite" type="radio" value="1" <c:if test="${result.posblWrite eq '1'}"> checked</c:if>/><label for="posblWrite1"><span></span>비회원</label>
								<input id="posblWrite2" name="posblWrite" type="radio" value="2" <c:if test="${result.posblWrite eq '2'}"> checked</c:if>/><label for="posblWrite2"><span></span>회원</label>
								<input id="posblWrite3" name="posblWrite" type="radio" value="3" <c:if test="${result.posblWrite eq '3' || empty result.posblWrite}"> checked</c:if>/><label for="posblWrite3"><span></span>관리자</label>
							</p>
						</td>
					</tr>
					</tbody>
				</table>
				</form>

			</div>
		</section>

	</section>

<%@include file="../include/footer.jsp"%>