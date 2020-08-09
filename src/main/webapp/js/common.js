var commonUtil = {
		AjaxSynCall : function (url, param, dtype, msg, callback, pa1){
			var chVal="";
			$.ajax({
				url: url,
				data: param,
				type: 'post',
	            dataType: dtype,
	            async: false,
	            success: function(result){
	            	if(result){
	            		chVal= result;
	            		switch(result){
		            		case 'success' :
		            			if(msg){
		            				alert(msg);
		            			}
		            			break;
		            		case 'dup' :
		            			alert("중복입니다");
		            			break;
		            		case 'fail' :
		            			alert("오류가 발생하였습니다.");
		            			break;
		            		case 'illegal' :
		            			alert("권한이 없습니다.");
		            			break;
		            		case 'sub' :
		            			alert("하위 코드가 존재합니다.");
		            			break;
		            		case 'itemExit' :
		            			alert("제품 목록이 있습니다. 제품 목록을 먼저 삭제하여 주세요.");
		            			break;
	            		}
	            		if(dtype == 'json' && !callback){
	            			commonUtil.jsonSelectResult(result,msg);
	            		}
	            		if(dtype == 'json' && callback == 'returnVal'){
	            			return result;
	            		}
	            		if(dtype == 'json' && callback){
	            			callback(result,pa1);
	            		}
	            	}else{
	            		alert("server error");
	            	}
	            },
	            error: function(xhr, status, error){ 
	            	alert("error "+error);
	            }
			});
			return chVal;
		},
		AjaxSynFileCall : function (url, param, dtype, msg, callback){
			//var chVal="";
			$.ajax({
				url: url,
				data: param,
			    cache: false,
			    contentType: 'multipart/form-data',
			    processData: false,
			    type: 'POST',
	            success: function(result){
	            	if(result){
	            		//chVal= result;
	            		switch(result){
		            		case 'success' :
		            			alert(msg);
		            			break;
	            		}
	            	}else{
	            		alert("server error");
	            	}
	            },
	            error: function(xhr, status, error){ 
	            	alert("error "+error);
	            }
			});
			//return chVal;
		},
		jsonSelectCodeDetail : function(cd,etc1,selid){
			if(!etc1 && etc1 != "etc1_all"){
				$("#"+selid).empty();
				$("#"+selid).append("<option value=''>전체</option>");
				return;
			}
			//etc1 : CODE_DT 테이블 code_etc1 필드값이 같은 값일 경우만 호출
			//etc1 = etc1_all : CODE_DT 테이블 code_etc1 필드값 상관 없이 호출  
			if(etc1 == "etc1_all"){ etc1 = ""; }
			var url = '/boffice/actCode/cmdCodeList.do';
			var param = {
				codeId: cd,
				codeEtc1: etc1
			};
			commonUtil.AjaxSynCall(url,param,'json',selid);
		},
		jsonSelectResult : function(result,msg){
			var codeList = result.codeList;
			$("#"+msg).empty();
			$("#"+msg).append("<option value=''>전체</option>");
			for(var i=0; i<codeList.length; i++){
				$("#"+msg).append("<option value='"+codeList[i].code+"'>"+codeList[i].codeNm+"</option>");
			}
		},
    /**
     * 두 날짜의 차이를 일자로 구한다.(조회 종료일 - 조회 시작일)
     *
     * @param val1 - 조회 시작일(날짜 ex.2002-01-01)
     * @param val2 - 조회 종료일(날짜 ex.2002-01-01)
     * @return 기간에 해당하는 일자
     */
	calDateRange : function(val1, val2){
		var FORMAT = "-";

        // FORMAT을 포함한 길이 체크
        if (val1.length != 10 || val2.length != 10) {
        	return;
        }

        // FORMAT이 있는지 체크
        if (val1.indexOf(FORMAT) < 0 || val2.indexOf(FORMAT) < 0) {
        	return;
        }
            

        // 년도, 월, 일로 분리
        var start_dt = val1.split(FORMAT);
        var end_dt = val2.split(FORMAT);

 

        // 월 - 1(자바스크립트는 월이 0부터 시작하기 때문에...)
        // Number()를 이용하여 08, 09월을 10진수로 인식하게 함.
        start_dt[1] = (Number(start_dt[1]) - 1) + "";
        end_dt[1] = (Number(end_dt[1]) - 1) + "";

 

        var from_dt = new Date(start_dt[0], start_dt[1], start_dt[2]);
        var to_dt = new Date(end_dt[0], end_dt[1], end_dt[2]);

 

        return (to_dt.getTime() - from_dt.getTime()) / 1000 / 60 / 60 / 24;
	},
	
	popup : function(target, param, height, width){
		var frm = document.frm;
	    frm.param.value = param;
	    
		var popup = window.open("", "customer", "width="+width+", height="+height+", scrollbars=no, toolbar=no menubar=no, location=no");

		frm.target = "customer";
		frm.method = "post";
		frm.action = target;
		frm.submit();
	},
	
	popupChild : function(target, param, height, width){
		var frm = document.frm;
	    frm.param.value = param;
	    
		var popup = window.open("", "customerAdd", "width="+width+", height="+height+", scrollbars=no, toolbar=no menubar=no, location=no");

		frm.target = "customerAdd";
		frm.method = "post";
		frm.action = target;
		frm.submit();
	},
	
	popup1 : function(target, height, width){

		window.open(target, "popup", "width="+width+", height="+height+", scrollbars=yes, toolbar=no menubar=no, location=no");
		
	},
	
	popup2 : function(target, height, width){

		 window.showModalDialog( target , "popup" , "dialogWidth:"+width+"px; dialogHeight:"+height+"px; center:yes; status:no;resizable:no;");
		
	},
	
	setPaging : function(page){
		var div = $('#div_paging');
		div.empty();
		
		var firstLink = $('<a name="1"></a>');
		firstLink.append('[처음]');
		firstLink.css('cursor','pointer');
		firstLink.click(function(){
			setLink($(this).attr('name'));
		});
		
		var beforeLink = $('<a name="' + ((parseInt(page.beginPage) - 10) <= 0 ? 1 : (parseInt(page.beginPage) - 10)) + '"></a>');
		beforeLink.append('[이전]');
		beforeLink.css('cursor','pointer');
		beforeLink.click(function(){
			setLink($(this).attr('name'));
		});
		
		div.append(firstLink,beforeLink);
		
		for(var i =page.beginPage ; i <= page.endPage; i++){
			var link = $('<a id="' + i + '"></a>');
			link.click(function(){
				setLink(this.id);
			});
			var linkPage = $('<label>[' + i + ']</label>');
			linkPage.css('cursor','pointer');
			link.append(linkPage);
			
			if(fam.current_page == i){
				link.css('color','red');
			}
			
			div.append(link);
		}
		
		var nextLink = $('<a name="' +((parseInt(page.beginPage) + 10) >= page.totalpage ? page.totalpage : (parseInt(page.beginPage) + 10))+ '"></a>');
		nextLink.append('[다음]');
		nextLink.css('cursor','pointer');
		nextLink.click(function(){
			setLink($(this).attr('name'));
		});
		
		var lastLink = $('<a name="'+ page.totalpage +'"></a>');
		lastLink.append('[마지막]');
		lastLink.css('cursor','pointer');
		lastLink.click(function(){
			setLink($(this).attr('name'));
		});
		 
		div.append(nextLink,lastLink);
		
		//$('#' + fam.current_page + '').css('color','red');
	},
	
	//// 필수 입력값 체크 /////
	necessaryInputData : function(){
		var args = arguments; 
		for(var i=0; i<args.length; i++){
			var obj = args[i];
			if($(obj).val() == ""){
				alert($(obj).attr('title') + " 은(는) 필수 입력입니다.");
				$(obj).attr('type') == "hidden" ? $(obj).parent().find('input[type=text]').focus() : $(obj).focus();
				//$(obj).focus()
				return false; 
			}
		}
		return true;
	},
	
	necessaryInputData2 : function(){
		var args = arguments; 
		for(var i=0; i<args.length; i++){
			var objs = (args[i]+":").split(":");
			var obj = objs[0];
			if($(obj).val() == ""){
				alert(objs[1] + " 은(는) 필수 입력입니다.");
				$(obj).attr('type') == "hidden" ? $(obj).parent().find('input[type=text]').focus() : $(obj).focus();
				//$(obj).focus()
				return false; 
			}
		}
		return true;
	},
	
	checkFilter : function(obj){
		var val = blankTrim($(obj).val());
		 
		var chkText = /[\&<>\"\']/gi;
		if(chkText.test(val)){
			alert("특수문자는 입력하실 수 없습니다. \n\n사용 불가능  & < > \" \'");
			$(obj).focus();
			return false;
		}
		return true; 
	}
};
$(document).ready(function(){
	$("#cboxContent").click(function() {
		$.colorbox.close();
	});
});

$(function() {
	$('.chkmoney').mask('000,000,000,000,000', {reverse: true});
	$(".textNumOnly").bind({
		blur: function(){
			if($(this).val()){
				numberRegCheck($(this),$(this).prop("maxlength"));
			}
		},
		keypress: function(){
			return numbersonly(event, false);
		}
	});
	$(".emailSelector").bind({
		change: function(){
			$(".emailSelected").val($(this).val());
		}
	});
});

$(function() {
	$(".datePickerDate").datepicker({
		changeMonth: true, 
		changeYear: true,
		nextText: '다음 달',
		prevText: '이전 달',
		dateFormat: $(".datePickerDate").prop('pattern')?($(".datePickerDate").prop('pattern')).replace('yyyy','yy'):"yy-mm-dd",
		showOn: 'button',
		buttonImage: '/images/boffice/board/btn_calendar.jpg'
	}).click(function(e) {
        //$.datepicker._clearDate(this);
    });
});

function fnCommonDownFile(atchFileId, fileSn){
	window.open("/cmm/fms/FileDown.do?atchFileId="+atchFileId+"&fileSn="+fileSn);
}
function fnCommonAjaxDeleteFile(atchFileId, fileSn) {
	if(!confirm("삭제하시겠습니까?")){
		return;
	}
	var target_name = 'iframe_upload';
    var iframe = $('<iframe id="fileDeleteIframe" src="javascript:false;" name="'+target_name+'" style="display:none;"></iframe>');
	var $form = $('<form></form>');
	$form.attr('action', '/boffice/activity/deleteActUpFile.do');
	$form.attr('method', 'post');
	$form.attr('target', target_name);
	$form.appendTo('body');
	var input1 = $('<input name="atchFileId" type="hidden" value="'+atchFileId+'"/>');
	var input2 = $('<input name="fileSn" type="hidden" value="'+fileSn+'"/>');
	$form.append(input1).append(input2);
	$("#fileDeleteIframe").append($form);
    $('body').append(iframe);
    iframe.load(function(){
        var doc = this.contentWindow ? this.contentWindow.document : (this.contentDocument ? this.contentDocument : this.document);
        var root = doc.documentElement ? doc.documentElement : doc.body;
        var result = root.textContent ? root.textContent : root.innerText;
        if(result=="success"){
        	alert("삭제되었습니다.");
        	$("#fileObj"+atchFileId+fileSn).remove();
        	$(".preViewImage").remove();
        }
        else{
        	alert("error.");
        }
        iframe.remove();
    });
	$form.submit();
}

function GetAbsPosition(object) {
	  var position = new Object;
	  position.x = 0;
	  position.y = 0;
	  
	  if( object ) {
	  position.x = object.offsetLeft;
	  position.y = object.offsetTop;
	  
	  if( object.offsetParent ) {
	  var parentpos = GetAbsPosition(object.offsetParent);
	  position.x += parentpos.x;
	  position.y += parentpos.y;
	  }
	  }
	  
	  position.cx = object.offsetWidth;
	  position.cy = object.offsetHeight;
	  
	  return position;
}

var thisGsDate = "";
var thisGdv = "";

function normalCalendarController(retVal) {    
	if(retVal) {
		thisGsDate.value = retVal.year+thisGdv+retVal.month+thisGdv+retVal.day;
		document.pForm.sDate.value = "";
		document.pForm.init.value = "";
	}
} 

function fnNormalCalendar(frm, sDate, dv) {
	var obj = $(sDate).position();
	var pos = GetAbsPosition(sDate);
	thisGsDate = sDate;
	thisGdv = dv;
	if(sDate.value){ document.pForm.sDate.value = sDate.value; }
	var url = "/sym/cal/EgovNormalCalPopup.do";
	window.open(url,"popwindow", "width=275, height=192, menubar=no,status=no,scrollbars=no,center=yes");

	/*if (retVal) {
		sDate.value = retVal.year+dv+retVal.month+dv+retVal.day;
		document.pForm.sDate.value = "";
		document.pForm.init.value = "";
	}*/
}

//숫자만 입력 (ime-mode:disabled 상태에서)
function only_num() {
	// 13 : 엔터
	// 48~57 : 숫자
	var keyID = event.keyCode;
	if( !(( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 )){
		event.returnValue = false;
	}
}
function only_num_m() {
	// 13 : 엔터
	// 48~57 : 숫자
	// 45 : -
	// 46 : .
	//189 : -
	//109 : -
	//alert(event.keyCode);
	var keyID = event.keyCode;
	if( !(( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39  || keyID == 189  || keyID == 109 )){
		event.returnValue = false;
	}
}
function only_num58() {
	// 13 : 엔터
	// 48~57 : 숫자 58: 세미콜론
	if (event.keyCode < 46 || event.keyCode > 58) {
		event.returnValue = false;
	}
}

function removeChar(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
		return;
	else
		event.target.value = event.target.value.replace(/[^0-9]/g, "");
}
//비교 숫자 2개를 입력받아 크기를 비교하고 숫자인지 및 자릿수 체크 
function fromToIntCheck(objf,objt,ln) {
	if(!numberRegCheck(objf,ln) || !numberRegCheck(objt,ln)){
		return false;
	}
	if(objt.val()*1 > objf.val()*1){
		return false;
	}
	return true;
}
function numberRegCheck(obj,ln){
	var num_check=/^[0-9]*$/;
	if(num_check.test(obj.val())){
		if((obj.val()).length>ln){
			alert(ln+"자까지만 입력 가능합니다.");
			obj.select();
			return false;
		}
	}else{
		alert("숫자만 입력해 주세요");
		obj.val("");
		obj.focus();
		return false;
	}
	return true;
}
function numbersonly(e, decimal) {
	var key;
    var keychar;

    if (window.event) {
        key = window.event.keyCode;
    } else if (e) {
        key = e.which;
    } else {
        return true;
    }
    keychar = String.fromCharCode(key);

    if ((key == null) || (key == 0) || (key == 8) || (key == 9) || (key == 13)
            || (key == 27)) {
        return true;
    } else if ((("0123456789").indexOf(keychar) > -1)) {
        return true;
    } else if (decimal && (keychar == ".")) {
        return true;
    } else
        return false;

}
function commify(n) {
	  var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
	  n += '';                          // 숫자를 문자열로 변환

	  while (reg.test(n))
	    n = n.replace(reg, '$1' + ',' + '$2');

	  return n;
}
function comdell(n) {
	//n = n.replaceAll(",","");
	while(n.indexOf(",") != -1 ){
		n = n.replace(",", "");
	}
	return n;
}
function trancommify(obj) {
	var va = obj.value;
	va = commify(comdell(va));
	obj.value = va;
}


function blankTrim(val){
	return val.replace(/(\s*)/g,"");
}

function dateOut(obj){
	var date = obj.value.split('.');
	var year = date[0];
	var month = date[1];
	var day = date[2];
	var chk = 0; 
	
	if(month > 12 || month == 0){
		alert("달을 다시 입력해 주십시오.");
		obj.value = "";
		obj.focus();
		chk++;
		return false;
	}
		
	var lDay = new Date(year ,month,0).getDate();
	if(day > lDay || day == 0){
		alert("일자를 다시 입력해 주십시오.");
		obj.value = "";
		obj.focus();
		chk++;
		return false;
	}

	return true;
}
function fromToDateCheck(from, to){
	var from_date = $('#'+from).val();
	var to_date = $('#'+to).val();
	
	if(!from_date || !to_date|| from_date.indexOf('_') != -1 || to_date.indexOf('_') != -1){
		alert("날짜를 선택해 주십시오.");
		if(from_date == ''){
			$('#'+from).focus();
		}
		if(to_date == ''){
			$('#'+to).focus();
		} 
		return false;
	}
	if(from_date.replace(/\./g,'') > to_date.replace(/\./g,'')){
		alert("From일자가 To일자보다 클 수 없습니다.");
		$('#'+from).focus();
		return false;
	}
	return true;
}
function JqSelectTextOption(se,vl){
	$(se).find("option").filter(function(index) {
		return vl === $(this).text();
	}).prop("selected", "selected");
}
//gnb
function gnb(){
	$(".nav .gnb > ul > li").mouseenter(function(){
		$(this).addClass('on');
		$(this).find(".twoDepth").stop().slideDown("fast");
	})

	$(".nav .gnb > ul > li").mouseleave(function(){
		$(this).removeClass('on');
		$(this).find(".twoDepth").stop().slideUp("fast");
	})
}


//lnb
function lnbMenu(depth1,depth2){
	$("#lnb .lnbList li a").bind('focusin mouseenter',function() {
			//$(this).parent().find("ul").css("display", "block");
			$(this).addClass('on');
			//$(this).parent().siblings().find("ul").css("display", "none");
			$(this).parent().siblings().find("a").removeClass('on');
	});
	$("#lnb .lnbList").bind('mouseleave',function() {
		$(this).children('li').find('ul').css("display", "none");
		$(this).children('li').find("a").removeClass('on');
		$('#lnb .lnbList > li:eq('+depth1+') > a').addClass("on")
		$('#lnb .lnbList > li:eq('+depth1+') > a').parent().find("ul").css("display", "block");
		$('#lnb .lnbList > li:eq('+depth1+') ul li:eq('+depth2+') > a').addClass("on")
	});
	if ( $('#lnb .lnbList > li').size() > depth1){
		$('#lnb .lnbList > li:eq('+depth1+') > a').addClass("on")
		$('#lnb .lnbList > li:eq('+depth1+') > a').parent().find("ul").css("display", "block");
		$('#lnb .lnbList > li:eq('+depth1+') ul li:eq('+depth2+') > a').addClass("on")
	}
	$("#lnb .lnbList li:last-child ul li:last-child a").bind('focusout',function() {
		$(this).parents('.lnbList ul').css("display", "none");
		$(this).parents('#lnb .lnbList li').find("a").removeClass('on');
		$('#lnb .lnbList > li:eq('+depth1+') > a').addClass("on")
		$('#lnb .lnbList > li:eq('+depth1+') > a').parent().find("ul").css("display", "block");
		$('#lnb .lnbList > li:eq('+depth1+') ul li:eq('+depth2+') > a').addClass("on")
	});
}

//tabMenu
function tabMenu(obj,index_01){
	if(obj.children("li").size() > index_01){
		obj.children("li").eq(index_01).addClass("on");
	};

	var current = index_01;
	var prev = null;
	obj.children("li").hover(function(e){
		if($(this).index() != index_01){
			$(this).addClass("on");
		};
	},function(e){
		if($(this).index() != index_01){
			$(this).removeClass("on");
		};
	});
};

function execDaumPostcode(pr_Zip,pr_Add) {
    new daum.Postcode({
        oncomplete: function(data) {
            var fullRoadAddr = data.roadAddress;
            var extraRoadAddr = '';
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }
            if(fullRoadAddr !== ''){
                fullRoadAddr += extraRoadAddr;
            }
            document.getElementById(pr_Zip).value = data.zonecode;
            document.getElementById(pr_Add).value = fullRoadAddr;
            document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + data.jibunAddress + ')';
            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
            } else {
            	if(!data.jibunAddress){
                	document.getElementById('guide').innerHTML = '';
            	}
            }
        }
    }).open();
}


