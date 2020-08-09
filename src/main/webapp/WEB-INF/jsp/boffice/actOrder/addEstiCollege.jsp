<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

			<tr style="background-color:#EEE;">
				<td style="height:32px;">
				종합반
				<input type="hidden" name="coIdx" value="<c:out value='${resultInfo.coIdx}'/>"/>
				<input type="hidden" name="ocPidx" value="<c:out value='${resultInfo.coIdx}'/>"/>
				<input type="hidden" name="ocBooidx" value="0"/>
				<input type="hidden" name="ocGubun" value="12"/>
				<input type="hidden" name="ocLecidx" value="" class="ocLecidx<c:out value="${resultInfo.coIdx}"/>"/>
				<input type="hidden" name="ocLecmod" value="<c:out value='${collegeVO.searchOp1}'/>"/>
				<input type="hidden" name="ocQnt" value="1"/>
				<input type="hidden" name="ocPrice" value="<c:out value="${collegePrice[0].cpPrice1}"/>"/>
				</td>
				<td>
					<c:if test="${collegeVO.searchOp1 eq 'P'}">PC</c:if>
					<c:if test="${collegeVO.searchOp1 eq 'M'}">Mobile</c:if>
					<c:if test="${collegeVO.searchOp1 eq 'A'}">PC+Mobile</c:if>
				</td>
				<td>
					<select name="ocLecdayCo" data-no="<c:out value="${resultInfo.coIdx}"/>" style="width:60px;">
					 <c:forEach var="priceList" items="${collegePrice}" varStatus="status">
						<c:set var="price" value="0"/>
						<c:if test="${collegeVO.searchOp1 eq 'P'}"><c:set var="price" value="${priceList.cpPrice1}"/></c:if>
						<c:if test="${collegeVO.searchOp1 eq 'M'}"><c:set var="price" value="${priceList.cpPrice2}"/></c:if>
						<c:if test="${collegeVO.searchOp1 eq 'A'}"><c:set var="price" value="${priceList.cpPrice3}"/></c:if>
		 				<option value="<c:out value="${priceList.cpDay}"/>" data-price="<c:out value='${price}'/>"><c:out value="${priceList.cpDay}"/></option>
					 </c:forEach>
		 			</select>
		 			<input type="text" name="ocLecday" id="lecday<c:out value="${resultInfo.coIdx}"/>" value="<c:out value="${collegePrice[0].cpDay}"/>" style="width:80px;"/>
				</td>
				<td class="chkmoney" id="priceTxt<c:out value="${resultInfo.coIdx}"/>"><c:out value="${collegePrice[0].cpPrice1}"/></td>
				<td><c:out value="${resultInfo.coSubject}"/></td>
				<td><input type="text" name="ocEstiPrice" id="price<c:out value="${resultInfo.coIdx}"/>" value="<c:out value="${collegePrice[0].cpPrice1}"/>" class="chkmoney" style="width:120px;"/></td>
				<td><button type="button" class="commonBtn act_del">삭제</button></td>
			</tr>
		 <c:forEach var="lectList" items="${collegeLect}" varStatus="status">
			<tr>
				<td style="height:1px;" colspan="7"></td>
			</tr>
			<tr>
				<td style="height:32px;">
					종합반 강좌
					<c:if test="${lectList.mvClose ne 'Y'}">
					<c:if test="${lectList.mvOpen eq '1' || lectList.mvOpen eq '2'}">
					<input type="hidden" name="ocLecidx<c:out value="${resultInfo.coIdx}"/>" value="<c:out value="${lectList.mvIdx}"/>">
					</c:if>
					</c:if>
				</td>
				<td>
					<c:out value="${lectList.clName}"/>
					<c:forEach var="collegeOpt" items="${collegeOpt}" varStatus="status">
					<c:if test="${collegeOpt.ctCode eq lectList.clCode && collegeOpt.ctOpt eq 'Y'}">(택일)</c:if>
					</c:forEach>
				</td>
				<td>
					<c:if test="${lectList.mvOpen eq '1'}">업데이트완료</c:if>
					<c:if test="${lectList.mvOpen eq '2'}">업데이트중</c:if>
					<c:if test="${lectList.mvOpen eq '3'}">업데이트준비중</c:if>
				</td>
				<td><c:if test="${lectList.mvClose eq 'Y'}">강의종료</c:if></td>
				<td><c:out value="${lectList.mvSubject}"/></td>
				<td>&nbsp;</td>
				<td><button type="button" class="commonBtn act_del">삭제</button></td>
			</tr>
		 <c:forEach var="bookList" items="${lectList.bookList}" varStatus="status">
			<tr>
				<td style="height:32px;">
				종합반 교재
				<c:if test="${lectList.mvBook ne 'Y'}">
				<input type="hidden" name="ocPidx" value="<c:out value="${resultInfo.coIdx}"/>"/>
				<input type="hidden" name="ocBooidx" value="<c:out value="${bookList.bmIdx}"/>"/>
				<input type="hidden" name="ocGubun" value="13"/>
				<input type="hidden" name="ocLecidx" value=""/>
				<input type="hidden" name="ocLecmod" value=""/>
				<input type="hidden" name="ocLecday" value="0"/>
				<input type="hidden" name="ocQnt" value="1"/>
				<input type="hidden" name="ocPrice" value="<c:out value="${bookList.bmPrice2}"/>"/>
				</c:if>
				</td>
				<td>&nbsp;</td>
				<td>&nbsp;<c:if test="${lectList.mvBook eq 'Y'}">교재무료</c:if></td>
				<td class="chkmoney"><c:out value="${bookList.bmPrice2}"/></td>
				<td><c:out value="${bookList.bmSubject}"/></td>
				<td>
					<c:if test="${lectList.mvBook ne 'Y'}">
					<input type="text" name="ocEstiPrice" value="<c:out value="${bookList.bmPrice2}"/>" class="chkmoney" style="width:120px;"/>
					</c:if>
				</td>
				<td><button type="button" class="commonBtn act_del">삭제</button></td>
			</tr>
		</c:forEach>
		</c:forEach>
	


	