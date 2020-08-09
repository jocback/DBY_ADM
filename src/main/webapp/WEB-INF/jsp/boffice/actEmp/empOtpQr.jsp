<%@page contentType="text/html;charset=utf-8"%>
<%@include file="../include/header.jsp"%>
<script type="text/javascript">

function fnAjaxOtpCall(){
	if(!confirm("기존 OTP코드는 사용이 불가합니다. 실행하시겠습니까?")){
		return;
	}
	var url = '/boffice/museAdmLoginOtpReg.do';
	var param = {};
	commonUtil.AjaxSynCall(url,param,'json','',fnAjaxOtpCallBack);
}
function fnAjaxOtpCallBack(result){
	$("#otpQrcode").prop("src",result.url);
	$("#otpQrcode").css("display","block");
	$("#otpImg").css("display","none");
	$("#otpKeycode").html("(제공된키입력시)<br/>계정이름 : manager@yulimgosi.com<br/>키 : "+result.encodedKey);
}
$(function(){
	//fnAjaxOtpCall();
});
</script>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>OTP신규등록</h3>
			</div>
			<div class="realCont">
              <div class="imgsection">
              	<img src="/img/loginImg.jpg" alt="" id="otpImg">
                <iframe src="<c:out value='${url}'/>" id="otpQrcode" height="320" width="320" style="border:0;padding:10px;display:none;"></iframe>
                <p style="margin-bottom:10px;"><span id="otpKeycode" style="margin-bottom:7px;"></span></p>
              </div>
			</div>
			<div class="btnWrap">
				<button type="button" class="colorBtn rightbluebtn plusIcon act_ins" onclick="javascript:fnAjaxOtpCall();">OTP신규등록</button>
			</div>
		</section>

	</section>

	<%@include file="../include/footer.jsp"%>