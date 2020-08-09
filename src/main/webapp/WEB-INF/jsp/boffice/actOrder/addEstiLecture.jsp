<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

			<c:set var="price" value="0"/>
			<c:if test="${movingVO.searchOp1 eq 'P'}"><c:set var="price" value="${resultInfo.mvPrice1}"/></c:if>
			<c:if test="${movingVO.searchOp1 eq 'M'}"><c:set var="price" value="${resultInfo.mvPrice2}"/></c:if>
			<c:if test="${movingVO.searchOp1 eq 'A'}"><c:set var="price" value="${resultInfo.mvPrice3}"/></c:if>
			<tr>
				<td style="height:1px;" colspan="7"></td>
			</tr>
			<tr>
				<td style="height:32px;">
				단과
				<input type="hidden" name="mvIdx" value="<c:out value="${resultInfo.mvIdx}"/>"/>
				<input type="hidden" name="ocPidx" value="0"/>
				<input type="hidden" name="ocBooidx" value="0"/>
				<input type="hidden" name="ocGubun" value="11"/>
				<input type="hidden" name="ocLecidx" value="<c:out value="${resultInfo.mvIdx}"/>"/>
				<input type="hidden" name="ocLecmod" value="<c:out value='${movingVO.searchOp1}'/>"/>
				<input type="hidden" name="ocQnt" value="1"/>
				<input type="hidden" name="ocPrice" value="<c:out value="${price}"/>"/>
				</td>
				<td>
					<c:if test="${movingVO.searchOp1 eq 'P'}">PC</c:if>
					<c:if test="${movingVO.searchOp1 eq 'M'}">Mobile</c:if>
					<c:if test="${movingVO.searchOp1 eq 'A'}">PC+Mobile</c:if>
				</td>
				<td><input type="text" name="ocLecday" value="<c:out value="${resultInfo.mvPeriod}"/>" style="width:80px;"/></td>
				<td class="chkmoney"><c:out value="${price}"/></td>
				<td><c:out value="${resultInfo.mvSubject}"/></td>
				<td><input type="text" name="ocEstiPrice" value="<c:out value="${price}"/>" class="chkmoney" style="width:120px;"/></td>
				<td><button type="button" class="commonBtn act_del">삭제</button></td>
			</tr>
		 <c:forEach var="lectureBookList" items="${lectureBookList}" varStatus="status">
			<tr id="trBook<c:out value="${lectureBookList.bmIdx}"/>">
				<td style="height:32px;">
				교재
				<c:if test="${resultInfo.mvBook ne 'Y'}">
				<input type="hidden" name="ocPidx" value="0"/>
				<input type="hidden" name="ocBooidx" value="<c:out value="${lectureBookList.bmIdx}"/>"/>
				<input type="hidden" name="ocGubun" value="13"/>
				<input type="hidden" name="ocLecidx" value="<c:out value="${resultInfo.mvIdx}"/>"/>
				<input type="hidden" name="ocLecmod" value=""/>
				<input type="hidden" name="ocLecday" value="0"/>
				<input type="hidden" name="ocQnt" value="1"/>
				<input type="hidden" name="ocPrice" value="<c:out value="${lectureBookList.bmPrice2}"/>"/>
				</c:if>
				</td>
				<td>&nbsp;</td>
				<td>&nbsp;<c:if test="${resultInfo.mvBook eq 'Y'}">교재무료</c:if></td>
				<td class="chkmoney"><c:out value="${lectureBookList.bmPrice2}"/></td>
				<td><c:out value="${lectureBookList.bmSubject}"/></td>
				<td>
					<c:if test="${resultInfo.mvBook ne 'Y'}">
					<input type="text" name="ocEstiPrice" value="<c:out value="${lectureBookList.bmPrice2}"/>" class="chkmoney" style="width:120px;"/>
					</c:if>
				</td>
				<td><button type="button" class="commonBtn act_del">삭제</button></td>
			</tr>
		</c:forEach>
	


	