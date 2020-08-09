<%@page contentType="text/html;charset=utf-8"%>
<!--  LOG corp Web Analitics & Live Chat  START -->
<script  type="text/javascript">
	//<![CDATA[
	function logCorpAScript_full(){
		HTTP_MSN_MEMBER_NAME="";/*member name*/
		//LOGSID = "<%=(session.getAttribute("logsid") != null ? session.getAttribute("logsid") : "")%>";/*logsid*/
		//LOGREF = "<%=(session.getAttribute("logref") != null ? session.getAttribute("logref") : "")%>";/*logref*/
		var prtc=(document.location.protocol=="https:")?"https://":"http://";
		var hst=prtc+"asp20.http.or.kr";
		var rnd="r"+(new Date().getTime()*Math.random()*9);
		this.ch=function(){
			if(document.getElementsByTagName("head")[0]){this.dls();}else{window.setTimeout(logCorpAnalysis_full.ch,30)}
		}
		this.dls=function(){
			var h=document.getElementsByTagName("head")[0];
			var s=document.createElement("script");s.type="text/jav"+"ascript";try{s.defer=true;}catch(e){};try{s.async=true;}catch(e){};
			if(h){s.src=hst+"/HTTP_MSN/UsrConfig/harimao850/js/ASP_Conf.js?s="+rnd;h.appendChild(s);}
		}
		this.init= function(){
			document.write('<img src="'+hst+'/sr.gif?d='+rnd+'" style="width:1px;height:1px;position:absolute;display:none" onload="logCorpAnalysis_full.ch()" alt="" />');
		}
	}
	if(typeof logCorpAnalysis_full=="undefined"){var logCorpAnalysis_full=new logCorpAScript_full();logCorpAnalysis_full.init();}
	//]]>
</script>
<noscript><img src="http://asp20.http.or.kr/HTTP_MSN/Messenger/Noscript.php?key=harimao850" style="display:none;width:0;height:0;" alt="" /></noscript>
<!-- LOG corp Web Analitics & Live Chat END -->

