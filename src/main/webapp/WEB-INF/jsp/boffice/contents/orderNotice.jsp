<%@page contentType="text/html;charset=utf-8"%>
<%@include file="../include/header.jsp"%>
<script type="text/javascript">

function fnActOrderNoticeModify(op){
	if(!confirm("저장 하시겠습니까?")){
		return;
	}
	$("input[name='fqCn']").val(DEXT5.getBodyValue('fqCn'));
	$("input[name='fqCn']").val(($("input[name='fqCn']").val()).replace(/\'/g,"&#39;"));
	$("input[name='fqCn2']").val(DEXT5.getBodyValue('fqCn2'));
	$("input[name='fqCn2']").val(($("input[name='fqCn2']").val()).replace(/\'/g,"&#39;"));
	var url = "<c:url value='/boffice/actOrderNotice/modifyActOrderNotice.do' />";
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
   			document.frmForm.action = "/boffice/actOrderNotice/actOrderNoticeView.do";
   			document.frmForm.target = "_parent";
   			document.frmForm.submit();
    	}else{
    		alert("오류입니다. 다시 시도하여 주세요.");
    		return;
    	}
    });
    aFrm.target = target_name;
    aFrm.submit();
}


</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>장바구니 공지 등록</h3>
				<div class="btnWrap">
					<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnActOrderNoticeModify('edit');">수정</button>
				</div>
			</div>
			<div class="realCont">

				<form name="frmForm" id="frmForm" method="post" class="articleWrite">
					<input type="hidden" name="fqSj" id="fqSj" value='장바구니공지' />
					<input type="hidden" name="fqSta" id="fqSta" value='Y' />
					<input type="hidden" name="fqGb" id="fqGb" value='11' />
					<input type="hidden" name="fqCn" />
					<input type="hidden" name="fqCn2" />

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
								<th scope="row"><strong>상세설명 (동영상)</strong></th>
								<td colspan="3">
								  <!--editor-->
									<script type="text/javascript">
										DEXT5.config.Width = "100%";
										DEXT5.config.Height = "300px";
										var editor = new Dext5editor("fqCn");
									</script>
								  <!--//editor-->
								</td>
							</tr>
							<tr>
								<th scope="row"><strong>상세설명 (서점)</strong></th>
								<td colspan="3">
								  <!--editor-->
									<script type="text/javascript">
										DEXT5.config.Width = "100%";
										DEXT5.config.Height = "300px";
										var editor = new Dext5editor("fqCn2");
									    function dext_editor_loaded_event(editor) {
									        DEXT5.setBodyValue('<c:out value="${resultInfo.fqCn}" escapeXml="false" />', "fqCn");
									        DEXT5.setBodyValue('<c:out value="${resultInfo.fqCn2}" escapeXml="false" />', "fqCn2");
									    }
									</script>
								  <!--//editor-->
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