<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
	<table>
		<c:forEach var="fileVO" items="${fileList}" varStatus="status">
		<tr id="fileObj<c:out value="${fileVO.atchFileId}"/><c:out value="${fileVO.fileSn}"/>">
			<td style="border:0;margin:0;padding:5px;">
			<c:choose>
				<c:when test="${updateFlag=='Y'}">
					<div style="max-width:300px; margin-right:10px; float:left;">
					<img class="preViewImage" src="/cmm/fms/getImage.do?atchFileId=<c:out value='${fileVO.atchFileId}'/>&fileSn=<c:out value='${fileVO.fileSn }'/>" style="max-width:300px;">																
					</div>
					<c:if test="${delCheck eq 'delck'}">
					<div style="float:left;">
					<input type="checkbox" name="iFileDelCk" value="Y" onClick="javascript:fnIThumDelCk(this);"/>첨부 이미지 삭제
					<br>
					<input type="file" name="fileThum" style="width:300px;" id="egovComFileUploader"/>
					</div>
					</c:if>
					<c:if test="${delCheck ne 'delck'}">
					<img style="padding-top:1px;" src="<c:url value='/images/egovframework/com/cmm/icon/bu_icon_delete.gif' />" 
						width="19" height="18" onClick="fnCommonAjaxDeleteFile('<c:out value="${fileVO.atchFileId}"/>','<c:out value="${fileVO.fileSn}"/>');" alt="파일삭제">					
					</c:if>
				</c:when>
				<c:otherwise>
					<a href="javascript:fnCommonDownFile('<c:out value="${fileVO.atchFileId}"/>','<c:out value="${fileVO.fileSn}"/>')">
					<c:if test="${atchFileMd=='LIST'}">
						<img src="/images/boffice/board/file2.jpg" alt="첨부파일" />
					</c:if>
					<c:if test="${atchFileMd!='LIST'}">
						<c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte]
					</c:if>
					</a>
				</c:otherwise>
			</c:choose>
			</td>
		</tr>
		</c:forEach>
		<c:if test="${fn:length(fileList) == 0}">
			<tr>
				<td style="border:0;margin:0;padding:0;"></td>
			</tr>
	    </c:if>
	</table>
