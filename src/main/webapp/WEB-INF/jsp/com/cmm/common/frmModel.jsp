<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

		<c:forEach var="codeResult" items="${codeResult}" varStatus="status">
		<option value="<c:out value="${codeResult.code}"/>" <c:if test='${codeResult.code eq frmTypeVO.frmTypeValue}'>selected</c:if>><c:out value="${codeResult.codeNm}"/></option>
		</c:forEach>
	


	