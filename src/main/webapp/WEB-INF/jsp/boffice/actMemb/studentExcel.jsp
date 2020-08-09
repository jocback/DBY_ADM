<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
pageContext.setAttribute("CR", "\r");
pageContext.setAttribute("LF", "\n");
pageContext.setAttribute("CRLF", "\r\n");
pageContext.setAttribute("SP", "&nbsp;");
pageContext.setAttribute("BR", "<br/>");
pageContext.setAttribute("newLineChar", "\n");
%> 
<style>
br {mso-data-placement:same-cell;}
</style>

<table border="1">
<tr height="34">
	<th bgcolor="#FBEBF1">번호</th>
	<th bgcolor="#FBEBF1">이름</th>
	<th bgcolor="#FBEBF1">성별</th>
	<th bgcolor="#FBEBF1">생년월일</th>
	<th bgcolor="#FBEBF1">전화번호</th>
	<th bgcolor="#FBEBF1">휴대폰번호</th>
	<th bgcolor="#FBEBF1">이메일</th>
	<th bgcolor="#FBEBF1">우편번호</th>
	<th bgcolor="#FBEBF1">주소</th>
	<th bgcolor="#FBEBF1">준비하는시험</th>
	<th bgcolor="#FBEBF1">응시지역1지망</th>
	<th bgcolor="#FBEBF1">응시지역2지망</th>
	<th bgcolor="#FBEBF1">응시지역3지망</th>
	<th bgcolor="#FBEBF1">학력</th>
	<th bgcolor="#FBEBF1">출신학교</th>
	<th bgcolor="#FBEBF1">현장강의 수강기간</th>
	<th bgcolor="#FBEBF1">시험준비기간</th>
	<th bgcolor="#FBEBF1">소지가산점</th>
	<th bgcolor="#FBEBF1">공무원 시험 응시경험</th>
	<th bgcolor="#FBEBF1">가장 어렵게 느끼는 과목</th>
	<th bgcolor="#FBEBF1">공무원 시험 계획 기간</th>
	<th bgcolor="#FBEBF1">공부하면서 가장 힘든점</th>
	<th bgcolor="#FBEBF1">나만의 스트레스 해소법</th>
	<th bgcolor="#FBEBF1">본원을 알게 된 경로</th>
	<th bgcolor="#FBEBF1">타강의 수강 경험</th>
	<th bgcolor="#FBEBF1">학원에 하고싶은 말</th>
	<th bgcolor="#FBEBF1">비고</th>
	<th bgcolor="#FBEBF1">등록일시</th>
</tr>
	<c:forEach var="result" items="${resultList}" varStatus="status">
<tr>
	<td><c:out value="${status.index+1}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.sName}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.sSexNm}"/></td>
	<td><c:out value="${result.sBirthday}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.sTel}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.sHand}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.sEmail}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.sZip}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.sAdd1}"/> <c:out value="${result.sAdd2}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.readyExamNm}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.takeArea1}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.takeArea2}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.takeArea3}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.sGrade}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.sSchool}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.lectureSdate}"/> ~ <c:out value="${result.lectureEdate}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.readyTime}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.sScore}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.examExp}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.diffSubject}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.planTime}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.sDifficulties}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.sStress}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.sPath}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${result.lectureExp}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${fn:replace(result.sOpinion,newLineChar,'<br/>')}"/></td>
	<td style="mso-number-format:'\@'"><c:out value="${fn:replace(result.sRemark,newLineChar,'<br/>')}"/></td>
	<td><c:out value="${result.regdt}"/></td>
</tr>
  	</c:forEach>
</table>
