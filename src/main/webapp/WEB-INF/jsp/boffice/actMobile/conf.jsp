<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../include/header.jsp"%>

	<section class="content">
		<%@include file="../include/lnb.jsp"%>

		<section class="rightCont">
			<div class="rightTitle">
				<h3>기본 설정 관리</h3>
				<div class="btnWrap">
					<button class="colorBtn rightbluebtn plusIcon act_ins">등록</button>
				</div>
			</div>
			<div class="realCont">


			  <!--listTable-->
				<table class="commonTable detailTable">
  					<caption>관리자 관리 테이블</caption>
  					<colgroup>
						<col style="width:10%">
						<col style="width:*">
						<col style="width:20%">
						<col style="width:20%">
						<col style="width:20%">
  					</colgroup>
  					<thead>
  						<tr>
 							<th scope="col">번호</th>
  							<th scope="col">아이디</th>
  							<th scope="col">단말기 제한 대수</th>
  							<th scope="col">다운로드 제한 횟수</th>
  							<th scope="col">관리</th>
  						</tr>
  					</thead>
  					<tbody>
  						<tr data-no="" class="row-add" style="display:none">
  							<td style="">추가</td>
   							<td><input type="text" class="" name="user_id" value="" maxlength="16" style="width:150px" /></td>
  							<td><input type="text" class="chknum" name="device_cnt" value="" maxlength="5" style="width:50px" /> 대</td>
  							<td><input type="text" class="chknum" name="down_cnt" value="" maxlength="5" style="width:50px" /> 회</td>
  							<td><button type="button" class="commonBtn act_save">등록</button> <button type="button" class="commonBtn act_cancel">취소</button></td>
  						</tr>
	 <c:forEach var="result" items="${resultList}" varStatus="status">
  						<tr data-no="<c:out value='${result.sno}'/>" class="<c:if test='${result.userId eq "yulim_all_user"}'>default</c:if>">
  							<td><c:out value='${status.index+1}'/></td>
   							<td><c:if test='${result.userId eq "yulim_all_user"}'>기본설정</c:if><c:if test='${result.userId ne "yulim_all_user"}'><c:out value='${result.userId}'/></c:if></td>
  							<td><input type="text" class="chknum" name="device_cnt" value="<c:out value='${result.deviceCnt}'/>" maxlength="5" style="width:50px" /> 대</td>
  							<td><input type="text" class="chknum" name="down_cnt" value="<c:out value='${result.downCnt}'/>" maxlength="5" style="width:50px" /> 회</td>
  							<td><button type="button" class="commonBtn act_save">수정</button><c:if test='${result.userId ne "yulim_all_user"}'> <button type="button" class="commonBtn act_del">삭제</button></c:if></td>
  						</tr>
	</c:forEach>
  					</tbody>
  				</table>
			  <!--//listTable-->

			</div>
		</section>

	</section>

<script>
$(function() {
	$(document).on('click', '.act_ins', function() {
		$(this).hide();
		$('.row-add').show(0, function() {
			$('.row-add input:text:eq(0)').focus();
		});
		return false;
	});
	$(document).on('click', '.act_cancel', function() {
		$('.row-add').hide(0, function() {
			$('.act_ins').show();
		});
		return false;
	});
	$(document).on('click', '.act_save', function() {
		//alert("testing....");
		//return;
		var no = $(this).closest('tr').data('no');
		var user_id = $.trim($(this).closest('tr').find('input[name=user_id]').length > 0 ? $(this).closest('tr').find('input[name=user_id]').val() : '');
		var device_cnt = $.trim($(this).closest('tr').find('input[name=device_cnt]').val());
		var down_cnt = $.trim($(this).closest('tr').find('input[name=down_cnt]').val());
		if (no == '' && user_id == '') {
			alert('사용자 아이디를 입력해주세요.');
			$(this).closest('tr').find('input[name=user_id]').focus();
			return false;
		}
		if (device_cnt == '') {
			alert('단말기 제한 대수를 입력해주세요.');
			$(this).closest('tr').find('input[name=device_cnt]').focus();
			return false;
		}
		if (down_cnt == '') {
			alert('다운로드 제한 횟수를 입력해주세요.');
			$(this).closest('tr').find('input[name=down_cnt]').focus();
			return false;
		}
		var param = {'sno':no, 'userId':user_id, 'deviceCnt':device_cnt, 'downCnt':down_cnt};
		var url = '/boffice/actMobile/insertActMobileConf.do'
		commonUtil.AjaxSynCall(url,param,'text','저장되었습니다.');
		location.reload();
	});
	$(document).on('click', '.act_del', function() {
		//alert("testing....");
		//return;
		var no = $(this).closest('tr').data('no');
		var param = {'sno':no};
		if (confirm('삭제하시겠습니까?')) {
			commonUtil.AjaxSynCall("/boffice/actMobile/deleteActMobileConf.do",param,'text','삭제되었습니다.');
			location.reload();
		}
	});
});
</script>


<%@include file="../include/footer.jsp"%>