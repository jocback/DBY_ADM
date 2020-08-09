<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

			<option value="">선택</option>
			<c:forEach var="codeResult" items="${resultList}" varStatus="status">
			<option value="<c:out value="${codeResult.bmIdx}"/>"><c:out value="${codeResult.bmSubject}"/></option>
			</c:forEach>
	


	