<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

			<tr>
				<td style="height:1px;" colspan="7"></td>
			</tr>
			<tr>
				<td style="height:32px;">
				교재
				<input type="hidden" name="bmIdx" value="<c:out value="${resultInfo.bmIdx}"/>"/>
				<input type="hidden" name="ocPidx" value="0"/>
				<input type="hidden" name="ocBooidx" value="<c:out value="${resultInfo.bmIdx}"/>"/>
				<input type="hidden" name="ocGubun" value="13"/>
				<input type="hidden" name="ocLecidx" value=""/>
				<input type="hidden" name="ocLecmod" value=""/>
				<input type="hidden" name="ocLecday" value="0"/>
				<input type="hidden" name="ocQnt" value="1"/>
				<input type="hidden" name="ocPrice" value="<c:out value="${resultInfo.bmPrice2}"/>"/>
				</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td class="chkmoney"><c:out value="${resultInfo.bmPrice2}"/></td>
				<td><c:out value="${resultInfo.bmSubject}"/></td>
				<td><input type="text" name="ocEstiPrice" value="<c:out value="${resultInfo.bmPrice2}"/>" class="chkmoney" style="width:120px;"/></td>
				<td><button type="button" class="commonBtn act_del">삭제</button></td>
			</tr>
	


	