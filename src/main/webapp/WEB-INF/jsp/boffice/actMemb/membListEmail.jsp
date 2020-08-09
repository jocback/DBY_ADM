<%@ page language="java" contentType="text/html; charset=utf-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:forEach var="result" items="${resultList}" varStatus="status">
<c:out value="${result.mEmail}"/><c:if test="${status.index+1<fn:length(resultList)}">,</c:if></c:forEach>
