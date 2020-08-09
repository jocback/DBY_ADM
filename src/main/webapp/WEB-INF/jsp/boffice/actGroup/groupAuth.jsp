<%@page contentType="text/html;charset=utf-8"%>
<%@include file="../include/header.jsp"%>
<script type="text/javascript">

function fnActGroupModify(op){
	if(op=="edit" && !confirm("수정하시겠습니까?")){
		return false;
	}
	var formData = $("#actGroupModifyForm").serialize();
	var url = "<c:url value='/boffice/actGroup/modifyActGroupAuth.do' />";
	var param = formData;
	commonUtil.AjaxSynCall(url,param,'text','저장되었습니다.');
}
function fnActGroupList(){
	document.frm.action = "<c:url value='/boffice/actGroup/actGroupList.do'/>";
	document.frm.submit();
}
$(document).ready(function(){
	$(".check_all").click(function(){
		$(this).parent().next().find("input").prop("checked",$(this).prop("checked"));
	})
	<c:forEach var="resultAuth" items="${resultAuth}" varStatus="status">
	$("input[value='<c:out value="${resultAuth.menuCode}"/>']").prop("checked",true);
	</c:forEach>

});
</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>권한 설정</h3>
				<div class="btnWrap">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActGroupModify('edit');">저장</button>
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActGroupList();">목록</button>
				</div>
			</div>
			<div class="realCont">

			<form name="frm" id="actGroupModifyForm" method="post">
				<input type="hidden" name="pageIndex" value="<c:out value="${searchVO.pageIndex}"/>">
				<input type="hidden" name="searchCnd" value="<c:out value="${searchVO.searchCnd}"/>">
				<input type="hidden" name="searchKeyword" value="<c:out value="${searchVO.searchKeyword}"/>">
			
				<input type="hidden" name="groupId" value="<c:out value="${resultInfo.groupId}"/>" />
					<table class="commonTable writeTable">
						<caption class="blind">권한 설정</caption>
						<colgroup>
							<col width="170px" />
							<col width="*" />
						</colgroup>
						<tbody>	
							<tr>
								<th scope="row" style="border-right:1px solid #E7E7E7;"><label for="title">관리자 권한 명칭</label></th>
								<td class="v2"><c:out value="${resultInfo.groupNm}"/></td>
							</tr>
						</tbody>
					</table>
					<table class="commonTable writeTable">
						<caption class="blind">권한 설정</caption>
						<colgroup>
							<col width="170px" />
							<col width="230px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<c:set var="code42len" value="${fn:length(codeResult42)}"/>
							<c:forEach var="codeResult42" items="${codeResult42}" varStatus="status">
							<tr>
								<c:if test="${status.count==1}">
								<th scope="row" rowspan="<c:out value="${code42len}"/>" style="border-right:1px solid #E7E7E7;"><label for="title">권한 목록</label></th>
								</c:if>
								<td class="v2" style="border-right:1px solid #E7E7E7;">
									<input type="checkbox" class="check_all" style="width:25px;" /><c:out value="${codeResult42.codeNm}"/>
								</td>
								<td class="v2">
									<ul>
										<c:forEach var="codeResult41" items="${codeResult41}" varStatus="status">
										<c:if test="${fn:substring(codeResult41.seq,0,2) eq fn:substring(codeResult42.seq,0,2)}">
										<li><input type="checkbox" name="menuCode" style="width:30px;" value="<c:out value="${codeResult41.code}"/>"/><c:out value="${codeResult41.codeNm}"/></li>
										</c:if>
										</c:forEach>
									</ul>
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</form>
				<!-- //writeType03 -->

			</div>
		</section>

	</section>


<%@include file="../include/footer.jsp"%>