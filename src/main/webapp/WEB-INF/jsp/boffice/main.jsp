<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="./include/header.jsp"%>
	<section class="content">

		<section class="rightCont">
			<div class="rightTitle">
				<h3>MAIN</h3>
			</div>
			<div class="realCont">

			<h3>최근 1년간 동영상 결제 주문 건수</h3>
			<div id="chart1" style="margin:20px 0; width:1050px; height:200px;"></div>

			<h3>최근 1년간 동영상 주문 실결제 금액 (단위:만원)</h3>
			<div id="chart2" style="margin:20px 0; width:1050px; height:200px;"></div>

			  <!--listTable-->
			  <h3>최근 동영상 주문</h3>
				<table class="commonTable detailTable">
  					<caption>관리자 메뉴관리 테이블</caption>
  					<colgroup>
						<col width="120">
						<col width="80">
						<col width="80">
						<col >
						<col width="100">
						<col width="100">
						<col width="150">
						<col width="150">
						<col width="100">
						<col width="100">
						<col width="100">
  					</colgroup>
  					<thead>
  						<tr>
   							<th scope="col">주문일시</th>
   							<th scope="col">주문경로</th>
  							<th scope="col">수강구분</th>
  							<th scope="col">강좌명</th>
  							<th scope="col">주문자</th>
  							<th scope="col">입금자</th>
  							<th scope="col">전화번호</th>
  							<th scope="col">휴대폰번호</th>
  							<th scope="col">결제수단</th>
  							<th scope="col">결제금액</th>
  							<th scope="col">주문상태</th>
  						</tr>
  					</thead>
  					<tbody>
  						<c:forEach var="result" items="${statMain}" varStatus="status">
  						<tr data-no="<c:out value='${result.sno}'/>">
  							<td><div class="date"><c:out value='${result.oDate}'/></div></td>
  							<td>
  								<c:if test="${result.mobileOrderYn eq 'Y'}"><div class=ord-mobile>mobile</div></c:if>
  								<c:if test="${result.mobileOrderYn ne 'Y'}"><div class=ord-pc>PC</div></c:if>
  							</td>
  							<td>
  								<c:if test="${result.mobileYn eq 'Y'}"><div class=ord-mobile>mobile</div></c:if>
  								<c:if test="${result.mobileYn ne 'Y'}"><div class=ord-pc>PC</div></c:if>
  							</td>
  							<td class="al"><a class="goods"><c:out value='${result.pName}'/></a></td>
  							<td><div class="name"><c:out value='${result.oName}'/></div></td>
  							<td><div><c:out value='${result.bName}'/></div></td>
  							<td><div><c:out value='${result.oTel}'/></div></td>
  							<td><div><c:out value='${result.oHand}'/></div></td>
  							<td><div><c:out value='${result.method}'/></div><div><c:out value='${result.fname}'/></div></td>
  							<td class="ar chkmoney"><c:out value='${result.payPrice}'/></td>
  							<td><c:out value='${result.status}'/></td>
  						</tr>
  						</c:forEach>
  					</tbody>
  				</table>
			  <!--//listTable-->


			</div>
		</section>

	</section>

<script class="include" type="text/javascript" src="/js/chart/jquery.jqplot.min.js"></script>
<script class="include" type="text/javascript" src="/js/chart/plugins/jqplot.barRenderer.min.js"></script>
<script class="include" type="text/javascript" src="/js/chart/plugins/jqplot.pieRenderer.min.js"></script>
<script class="include" type="text/javascript" src="/js/chart/plugins/jqplot.categoryAxisRenderer.min.js"></script>
<script class="include" type="text/javascript" src="/js/chart/plugins/jqplot.pointLabels.min.js"></script>
<script class="code" type="text/javascript">
$(document).ready(function(){
	$.jqplot.config.enablePlugins = true;

	var dateArr = new Array();
	var priceArr = new Array();
	var cntArr = new Array();
	<c:forEach var="result" items="${statMain1}" varStatus="status">
	dateArr.push("<c:out value='${result.payDt}'/>");
	priceArr.push("<c:out value='${result.payPrice}'/>");
	cntArr.push("<c:out value='${result.payCnt}'/>");
	</c:forEach>

	plot1 = $.jqplot('chart1', [cntArr], {
		// Only animate if we're not using excanvas (not in IE 7 or IE 8)..
		animate: !$.jqplot.use_excanvas,
		seriesDefaults:{
			renderer:$.jqplot.BarRenderer,
			pointLabels: { show: true }
		},
		axes: {
			xaxis: {
				renderer: $.jqplot.CategoryAxisRenderer,
				ticks: dateArr
			}
		},
		highlighter: { show: false }
	});

	plot1 = $.jqplot('chart2', [priceArr], {
		// Only animate if we're not using excanvas (not in IE 7 or IE 8)..
		animate: !$.jqplot.use_excanvas,
		seriesDefaults:{
			renderer:$.jqplot.BarRenderer,
			pointLabels: { show: true }
		},
		axes: {
			xaxis: {
				renderer: $.jqplot.CategoryAxisRenderer,
				ticks: dateArr
			}
		},
		highlighter: { show: false }
	});

});
</script>

<%@include file="./include/footer.jsp"%>


