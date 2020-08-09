var myeditor = [];
$(function() {
	$(document).on('click', '.act_list', function() {
		fnActList();
	});
	$(document).on('click', '.act_back', function() {
		history.back();
		return false;
	});
	$(document).on('click', 'a[href^="#nomenu"]', function() {
		alert('등록된 메뉴가 없습니다.');
		return false;
	});
	/*$(document).on('click', '.pn_paging,.pn_first,.pn_prev,.pn_next,.pn_last', function() {
		if (!$(this).closest('.page_navi').data('gofunc')) go_page($(this).data('page'));
		else eval($(this).closest('.page_navi').data('gofunc')+'('+$(this).data('page')+')');
		return false;
	});*/
	$(document).on('change', '.check_all', function() {
		$('.'+$(this).data('check')).prop('checked', $(this).prop('checked'));
	});
	$(document).on('change', '.check_all2', function() {
		$('.'+$(this).data('check')).prop('checked', $(this).prop('checked'));
	});
	$(document).on('keyup', 'input.chknum,input.chkmoney,input.chkeng,input.chkengnum,input.chkfloat', function() {
		var val = $(this).val();
		if ($(this).hasClass('chkeng')) $(this).val(val.replace(/[^a-z*^A-Z]/gi, ''));
		if ($(this).hasClass('chkengnum')) $(this).val(val.replace(/[^a-z*^A-Z*^0-9]/gi, ''));
		if ($(this).hasClass('chknum')) $(this).val(val.replace(/[^0-9]/gi, ''));
		if ($(this).hasClass('chkmoney')) $(this).val(val.replace(/[^$1,*^0-9]/gi, ''));
		if ($(this).hasClass('chkfloat')) $(this).val(val.replace(/[^.*^0-9]/gi, ''));
	});
	$(document).on('keydown', 'input.calendar', function(e) {
		if (e.keyCode == 46) $(this).val('');
	});
	$(document).on('change', 'select.femail', function() {
		$(this).prev('input:text').val($(this).val());
		if ($(this).val() == '') $(this).prev('input:text').focus();
	});
	$(document).on('click', '.search_address', function() {
		search_address($(this).closest('.addr'));
		return false;
	});
	$(document).on('change', '.btn_file input', function() {
		$(this).parent().prev('input').val($(this).val());
	});
	$(document).on('click', '.act_file_add', function() {
		if ($(this).parent().parent().find('.in_file').length + $(this).parent().parent().find('.filelist>div').length >= parseInt($(this).data('max'))) {
			alert('파일 등록은 '+$(this).data('max')+'개까지 가능합니다.');
			return false;
		}
		$obj = $(this).parent().clone();
		$obj.find('input').val('');
		$obj.find('.act_file_add').remove();
		$obj.find('.act_file_del').css('display','inline-block');
		$(this).parent().parent().append($obj);
		return false;
	});
	$(document).on('click', '.act_file_del', function() {
		$(this).parent().remove();
	});
	$(document).on('click', '.act_submit', function() {
		$(this).closest('form').trigger('submit');
		return false;
	});
	$(document).on('click', '.btn_file_delete', function() {
		var iname = $(this).closest('.filelist').parent().data('iname');
		if ($(this).siblings('[name*=idno]').length > 0) {
			$(this).closest('.filelist').append('<input type="hidden" name="'+iname+'[delete][]" value="'+$(this).siblings('[name*=idno]').val()+'" />');
		}
		$(this).parent().remove();
		return false;
	});
	$(document).on('change', '#frm_list_search input[name=ord]', function() {
		$('#frm_list_search').trigger('submit');
	});
	$(document).on('change', '#frm_list_search select[name=page_size]', function() {
		$('#frm_list_search').trigger('submit');
	});
	$(document).on('click', '.setdate', function() {
		var $date_s = $(this).closest('.daterange').find('.calendar:eq(0)');
		var $date_e = $(this).closest('.daterange').parent().find('.calendar:eq(1)');
		if ($date_s.length <= 0 || $date_e.length <= 0) return false;
		if ($(this).hasClass('clear')) {
			$date_s.val('');
			$date_e.val('');
			return false;
		}
		var sdate = new Date();
		var edate = new Date();
		if ($(this).hasClass('week')) {
			sdate.setDate(sdate.getDate() -7);
		}
		if ($(this).hasClass('month')) {
			sdate.setMonth(sdate.getMonth() -1);
		}
		$date_s.val(sdate.getFullYear()+'-'+(sdate.getMonth()+101).toString().substr(1)+'-'+(sdate.getDate()+100).toString().substr(1));
		$date_e.val(edate.getFullYear()+'-'+(edate.getMonth()+101).toString().substr(1)+'-'+(edate.getDate()+100).toString().substr(1));
		return false;
	});
	$(document).on('change', '.SearchForm input:checkbox', function() {
		var obj_name = $(this).attr('name');
		if ($(this).hasClass('check-all') && $(this).prop('checked')) $('.SearchForm input:checkbox[name="'+obj_name+'"]').not(this).prop('checked',false);
		if (!$(this).hasClass('check-all') && $('.SearchForm input:checkbox[name="'+obj_name+'"].check-all').length > 0) $('.SearchForm input:checkbox[name="'+obj_name+'"].check-all').prop('checked',false);
	});
	$(document).on('click', '.act_print', function() {
		window.print();
		return false;
	});
	$(document).on('click', '#btn_ext', function() {
		if ($(this).hasClass('on')) {
			$('#cont-search').addClass('search_min');
			$(this).removeClass().text('▼ 확장');
		}
		else {
			$('#cont-search').removeClass('search_min');
			$(this).addClass('on').text('▲ 축소');
		}
		return false;
	});
	$(document).ready(function() {
		$.each($('input.calendar'), function() {
			set_datepicker($(this));
		});
		$.each($('textarea.editor'), function() {
			if ($(this).attr('id')) {
				id = $(this).attr('id');
				nhn.husky.EZCreator.createInIFrame({
					oAppRef: myeditor,
					elPlaceHolder: id,
					sSkinURI: "/editor/se2/SmartEditor2Skin.html",	
					htParams : {
						bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
						bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
						bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
						//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
						fOnBeforeUnload : function(){
							//myeditor.getById[id].setDefaultFont('굴림', 9);
						}
					}, //boolean
					fOnAppLoad : function(){
						myeditor.getById[id].exec("PASTE_HTML", [""]);
					},
					fCreator: "createSEditor2"
				});
			}
		});
		$.each($('.for-mailform'), function() {
			set_email_form($(this));
		});
		$.each($('.for-phoneform'), function() {
			set_phone_form($(this));
		});
		$.each($('tr.allmerge'), function() {
			if ($(this).closest('table').find('th').length > 0) {
				$(this).find('>td').attr('colspan', $(this).closest('table').find('th').length);
			}
		});
		$.each($('input.calendar'), function() {
			set_datepicker($(this));
		});
		$.each($('img.fullfix'), function() {
			image_size_fix($(this));
		});
		/*$.each($('.page_navi'), function() {
			set_page_navi($(this), $(this).data('count'), $(this).data('size'), $(this).data('page'), parseInt($(this).data('block')));
		});*/
	});
});

function set_datepicker($cont) {
	if (!$cont.hasClass('edit')) $cont.prop('readonly', true);
	$cont.datepicker({
		closeText: '닫기',
		prevText: '',
		nextText: '',
		currentText: '오늘',
		monthNames: ['1월(JAN)','2월(FEB)','3월(MAR)','4월(APR)','5월(MAY)','6월(JUN)','7월(JUL)','8월(AUG)','9월(SEP)','10월(OCT)','11월(NOV)','12월(DEC)'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		weekHeader: 'Wk',
		dateFormat: 'yy-mm-dd',
		defaultDate: '+1w',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: true,
		yearSuffix: '년 ',
		changeMonth: true,
		changeYear: true
	});
}

function get_editor_contents() {
	$.each(myeditor.getById, function(idx, obj) {
		myeditor.getById[idx].exec("UPDATE_CONTENTS_FIELD", []);
	});
}

//콤마풀기
function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}
function cf_getNumberOnly (str) {
    var len      = str.length;
    var sReturn  = "";
        for (var i=0; i<len; i++){
            if ( (str.charAt(i) >= "0") && (str.charAt(i) <= "9") ){
            sReturn += str.charAt(i);
        }
    }
    return sReturn;
}    
function form_val_chk($frm) {
	var ok = true;
	$.each($frm.find('input, select, textarea'), function() {
		if ($(this).hasClass('req')) {
			switch ($(this).prop('tagName').toLowerCase()) {
			case 'select':
				if ($(this).find('option:selected').length < 1 || $(this).find('option:selected').val() == '') {
					ok = false;
					alert($(this).attr('title') ? $(this).attr('title') : '모든 항목을 선택해주세요.');
					$(this).focus();
					return false;
				}
				break;
			case 'textarea':
				if ($(this).val().replace(/ /g,'') == '') {
					ok = false;
					alert($(this).attr('title') ? $(this).attr('title') : '모든 항목을 입력해주세요.');
					$(this).focus();
					return false;
				}
				break;
			default:
				if ($(this).attr('type').toLowerCase() == 'radio' || $(this).attr('type').toLowerCase() == 'checkbox') {
					if ($(this).attr('name').indexOf('[') > 0) obj_name_cond = 'input[name*="'+$(this).attr('name').substr(0, $(this).attr('name').indexOf('['))+'["]:checked';
					else obj_name_cond = 'input[name="'+$(this).attr('name')+'"]:checked';
					if ($frm.find(obj_name_cond).length < 1) {
						ok = false;
						alert($(this).attr('title') ? $(this).attr('title') : '모든 항목을 선택해주세요.');
						return false;
					}
				}
				else if ($(this).val().replace(/ /g,'') == '') {
					ok = false;
					alert($(this).attr('title') ? $(this).attr('title') : '모든 항목을 입력해주세요.');
					if ($(this).attr('type').toLowerCase() != 'hidden') $(this).focus();
					return false;
				}
				break;
			}
		}
		if ($(this).data('pattern') && $(this).val().replace(/ /g,'') != '') {
			if (!pattern_check($(this).data('pattern'), $(this).val())) {
				$(this).focus();
				ok = false;
				return false;
			}
		}
		if ($(this).data('minlen') && $(this).val().replace(/ /g,'') != '') {
			if ($(this).val().length < $(this).data('minlen')) {
				alert($(this).data('minlen')+'자 이상 입력해주세요.');
				$(this).focus();
				ok = false;
				return false;
			}
		}
	});
	if ($frm.find('.date_range').length > 0) {
		$.each($frm.find('.date_range'), function() {
			if ($(this).find('input.calendar:eq(0)').val() != '' && $(this).find('input.calendar:eq(1)').val() && $(this).find('input.calendar:eq(0)').val() > $(this).find('input.calendar:eq(1)').val()) {
				alert('시작일은 종료일보다 클 수 없습니다.');
				$(this).find('input.calendar:eq(0)').focus();
				ok = false;
				return false;
			}
		});
	}
	if (ok && $('input.agreeY').length > 0 && !$('input.agreeY').prop('checked')) {
		alert($('input.agreeY').attr('title')+'해주셔야 등록이 가능합니다.');
		ok = false;
	}
	if (ok){
		$(".chkmoney").each(function(index){
			$(this).val(uncomma($(this).val()));
		});
	}
	return ok;
}

function pattern_check(pattern, str) {
	var type = {
		'eng' : {'reg':/^[a-z|A-Z]+$/ , 'msg':'영문만 입력 가능합니다.'},
		'engnum' : {'reg':/^[(a-z|A-Z)0-9]+$/ , 'msg':'영문과 숫자만 입력 가능합니다.'},
		'id' : {'reg':/^[(a-z|A-Z)0-9]+[_]*[(a-z|A-Z)0-9]+$/ , 'msg':'영문, 숫자, _(언더바)만 입력 가능합니다.'},
		'phone' : {'reg':/^\d{2,4}-\d{3,4}-\d{4}$/ , 'msg':'전화번호 형식이 맞지 않습니다.'},
		'num' : {'reg':/^[0-9]+$/ , 'msg':'숫자만 입력 가능합니다'},
		'wordnum' : {'reg':/^([0-9]+[a-z|A-Z]+)|([a-z|A-Z]+[0-9]+)$/ , 'msg':'영문과 숫자를 혼합하여 입력해야 합니다.'},
		'email' : {'reg':/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/ , 'msg':'메일 형식이 맞지 않습니다.'}
	}
	if (type[pattern]['reg'].test(str)) return true;
	else { alert(type[pattern]['msg']); return false; }
}

function set_page_navi($cont, count, page_size, page, block_size, gofunc) {

	if (count == 0) {
		$cont.hide();
		return false;
	}

	if (!block_size || block_size == 0) block_size = 10;
	if (gofunc) $cont.data('gofunc', gofunc);
	
	var block = Math.ceil(page / block_size);
	var total_page = (Math.ceil(count / page_size) ? Math.ceil(count / page_size) : 1); 
	var total_block = (Math.ceil(total_page / block_size) ? Math.ceil(total_page / block_size) : 1);
	
	var start_page = (block - 1) * block_size + 1;
	var end_page = block * block_size;
	
	var prev_block_page = start_page - 1;
	var next_block_page = end_page + 1;
	
	// first
	if ($cont.find('.pn_first').length > 0) $cont.find('.pn_first').data('page', 1);
	// previous
	if ($cont.find('.pn_prev').length > 0) $cont.find('.pn_prev').data('page', prev_block_page < 1 ? 1 : prev_block_page);
	// loop
	if ($cont.find('.pn_paging_set').length > 0) {
		$cont.find('.pn_paging_set:gt(0)').remove();
		var paging_html = $cont.find('.pn_paging_set').html();
		for(var i = start_page; i <= end_page && i <= total_page; i++) {
			if (i > start_page) $cont.find('.pn_paging_set:last').after($cont.find('.pn_paging_set:last').clone());
			$temp = $cont.find('.pn_paging_set:last');
			$temp = $temp.find('.pn_paging').length > 0 ? $temp.find('.pn_paging') : $temp;
			$temp.data('page', i);
			if (i == page) $temp.addClass('on'); else $temp.removeClass('on');
			$temp = $temp.find('.pn_page').length > 0 ? $temp.find('.pn_page') : $temp;
			$temp.empty().append(i);
		}
	}
	// next
	if ($cont.find('.pn_next').length > 0) $cont.find('.pn_next').data('page', next_block_page > total_page ? total_page : next_block_page);
	// last
	if ($cont.find('.pn_last').length > 0) $cont.find('.pn_last').data('page', total_page);
}

function go_page(page) {
	var curr_loc = location.href.replace(/\?page=[0-9]+|\&page=[0-9]+|\&page=/g,'');
	location.href = curr_loc+(curr_loc.indexOf('?') >= 0 ? '&' : '?')+'page='+page;
}

function set_file_list($cont, file, part) {
	var iname = $cont.data('iname');
	$cont.find('.filelist').append('<div>'+
		'<a href="#" class="file-download" data-part="'+part+'" data-encname="'+file.saved+'" data-filename="'+file.name+'">'+file.name+' ('+get_file_size(file.size)+')</a>'+
		(file.idno 
		?
		'<input type="hidden" name="'+iname+'[idno][]" value="'+file.idno+'" />'
		:
		'<input type="hidden" name="'+iname+'[name][]" value="'+file.name+'" />'+
		'<input type="hidden" name="'+iname+'[size][]" value="'+file.size+'" />'+
		'<input type="hidden" name="'+iname+'[type][]" value="'+file.type+'" />'+
		'<input type="hidden" name="'+iname+'[saved][]" value="'+file.saved+'" />')+
		'<a href="#" class="btn_file_delete" title="파일을 삭제합니다.">x</a>'+
		'</div>');
}

function get_file_size(size) {
	var str = '';
	if (size > Math.pow(1024,2)) str = Math.round((size / Math.pow(1024,2)) *100) / 100+' MB';
	if (size > 1024) str = Math.round((size / 1024) *100) /100+' KB';
	else str = size+' Byte';
	return str;
}

function set_email_form($cont) {
	var arr_domain = new Array('gmail.com','hanmail.net','hotmail.com','nate.com','naver.com','paran.com','yahoo.co.kr');
	var email = $cont.text();
	var input_name = $cont.data('name');
	var class_name = ($cont.data('class')).split(',');
	if (class_name.length != 3) class_name = new Array('','','');
	var attr_name = ($cont.data('attr')).split(',');
	if (attr_name.length != 3) attr_name = new Array('','','');
	var email_id = email.indexOf('@') > 0 ? (email.split('@'))[0] : '';
	var email_domain = email.indexOf('@') > 0 ? (email.split('@'))[1] : '';
	$cont.after('<input type="text" class="femail '+class_name[0]+'" name="'+input_name+'" value="'+email_id+'" maxlength="100" title="이메일주소를 입력해주세요." '+attr_name[0]+' />');
	$cont.next('input').after('<span>@</span><input type="text" class="femail '+class_name[1]+'" name="'+input_name+'" value="'+email_domain+'" maxlength="100" title="이메일주소를 입력해주세요." '+attr_name[1]+' />'
	+' <select class="femail '+class_name[2]+'" name="'+input_name+'_select_domain" title="이메일주소를 입력해주세요." '+attr_name[2]+' />');
	$cont.siblings('select').append('<option value="">직접입력</option>');
	$.each(arr_domain, function(idx, domain) {
		$cont.siblings('select').append('<option value="'+domain+'">'+domain+'</option>');
	});
	$cont.hide();
}

function set_phone_form($cont) {
	var arr_tel_head = new Array('02','051','053','032','062','042','052','044','031','033','043','041','063','061','054','055','064','060','070','080');
	var arr_mobile_head = new Array('010','011','016','017','018','019');
	var phone = $cont.text();
	var input_name = $cont.data('name');
	var class_name = ($cont.data('class')).split(',');
	if (class_name.length != 3) class_name = new Array('','','');
	var attr_name = ($cont.data('attr')).split(',');
	if (attr_name.length != 3) attr_name = new Array('','','');
	var phone_arr = phone.split('-');
	if (phone_arr.length != 3) phone_arr = new Array('','','');
	if ($cont.hasClass('tel') && $cont.hasClass('mobile')) el_name = '연락처';
	else if ($cont.hasClass('tel')) el_name = '전화번호';
	else if ($cont.hasClass('mobile')) el_name = '휴대폰번호';
	$cont.after('<select class="fphone '+class_name[0]+'" name="'+input_name+'" title="'+el_name+'를 입력해주세요." '+attr_name[0]+' />');
	if ($cont.hasClass('tel')) {
		$.each(arr_tel_head, function(idx, head) {
			$cont.siblings('select').append('<option value="'+head+'">'+head+'</option>');
		});
	}
	if ($cont.hasClass('mobile')) {
		$.each(arr_mobile_head, function(idx, head) {
			$cont.siblings('select').append('<option value="'+head+'">'+head+'</option>');
		});
	}
	$cont.next('select').after('<span>-</span><input type="text" class="fphone '+class_name[1]+'" name="'+input_name+'" value="'+phone_arr[1]+'" maxlength="4" title="'+el_name+'를 입력해주세요." '+attr_name[1]+' />'
	+'<span>-</span><input type="text" class="fphone '+class_name[2]+'" name="'+input_name+'" value="'+phone_arr[2]+'" maxlength="4" title="'+el_name+'를 입력해주세요." '+attr_name[2]+' />');
	$cont.hide();
}

function search_address($cont) {
	$lyr_addr = $('<div id="lyr_addr" title="우편번호 찾기" />').appendTo('body');
	$lyr_addr.dialog({
		resizable:false,
		modal:true,
		height:560,
		width:520,
		close: function() {
			$('#lyr_addr').remove();
		}
	});
    daum.postcode.load(function(){
        new daum.Postcode({
            oncomplete: function(data) {
                $('#lyr_addr').dialog('close');
				$cont.find('.postcode').val(data.zonecode);
				$cont.find('.addr1').val(data.roadAddress);
				$cont.find('.addr2').val('').focus();
            }
        }).embed($('#lyr_addr')[0]);
    });	
}

var d_dialog
function dialog_doc(d_title, d_path, d_width, d_height) {
	//if ($('#lyr_doc_popup').length > 0) $('#lyr_doc_popup').remove();
	$('<div class="dialog" id="lyr_doc_popup" title="'+d_title+'" />').appendTo('body').append('<iframe />');
	d_dialog = $('#lyr_doc_popup').dialog({
		autoOpen: true,
		resizable:false,
		modal:true,
		height:d_height,
		width:d_width,
		buttons: {
			"닫기": function() {
				d_dialog.dialog( "close" );
			}
		},
		open: function() {
			$('#lyr_doc_popup iframe').attr('src', d_path);
		},
		close: function() {
			$('#lyr_doc_popup').remove();
		}
	});
}
function dialog_doc_close() {
	d_dialog.dialog('close');
}

String.prototype.toMask=function(mask) {
	var data = this;
	data = data.replace(/[^a-z|^A-Z|^\d]/g,'');
	var len = data.length;
	var result = '';
	var j = 0;

	for(var i = 0; i < len; i++){
	  result += data.charAt(i);
	  j++;
	  if (j < mask.length && '-:|/'.indexOf(mask.charAt(j)) != -1 ) result += mask.charAt(j++);
	}
	return result;
}

String.prototype.toMoney=function() {

	var data = this;

	if(isNaN(data))
        return 0;

    data = data+"";

	data = Number(data);
	data = data.toString();

    var minus = false;

    if(data.indexOf("-") > -1)
        minus = true;

    var sMoney = data.replace(/(,|-)/g,"");
    var tMoney = "";
    var rMoney = "";
    var len = sMoney.length;

    if(sMoney.indexOf(".") >= 0) {	// 소숫점이 있을 경우
		var cMoney = sMoney.substr(0, sMoney.indexOf("."));
		var eMoney = sMoney.substr(sMoney.indexOf("."), sMoney.length);

		if(cMoney.length <= 3) {
			if(minus) cMoney = "-" + cMoney + eMoney;
			else cMoney = cMoney + eMoney;

			return cMoney;
		}
		for(i=0; i<cMoney.length; i++) {
			if(i != 0 && ( i % 3 == cMoney.length % 3) ) rMoney += ",";
			if(i < cMoney.length ) rMoney += cMoney.charAt(i);
		}
		if(minus) rMoney = "-" + rMoney + eMoney;
		else rMoney = rMoney + eMoney;

		return rMoney;
	}
    if ( sMoney.length <= 3 ) {
        if(minus) sMoney = "-"+sMoney;
        return sMoney;
    }
    for(i = 0; i < len; i++){
        if(i != 0 && ( i % 3 == len % 3) ) tMoney += ",";
        if(i < len ) tMoney += sMoney.charAt(i);
    }
    if(minus) tMoney = "-" + tMoney;

    return tMoney;

}

String.prototype.toTel=function() {
    var data = this;

    if(data == null)
        return "";
    var sTel = data.replace(/(\(|\)|-)/g,"");

    if(sTel.length <= 2) return sTel;

    var seoul = false;
    if(sTel.substr(0,2) == "02")
        seoul = true;

    var mask = "";
    var len = sTel.length;

    if(len <= 8) {
        if(len == 8)
            mask = "9999-9999";
        else
            mask = "999-9999";
    } else {
        if(seoul) {
            if(sTel.length == 9)
                mask = "99-999-9999";
            else
                mask = "99-9999-9999";
        } else {
            if(sTel.length == 10)
                mask = "999-999-9999";
            else if(sTel.length == 11)
                mask = "999-9999-9999";
            else
              mask = "9999-9999-9999";
        }
    }

    return sTel.toMask(mask).substr(0,14);
};

function setCookie( name, value, expiredays ){ 
	var exDate = new Date();
	exDate.setDate( exDate.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + exDate.toGMTString() + ";";
}    
