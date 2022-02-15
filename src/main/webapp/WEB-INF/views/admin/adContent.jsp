<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>관리자메뉴</title>
  <%@ include file="/WEB-INF/views/include/bs4.jsp" %>
</head>
<body>
<p><br></p>
<div class="container">
  <h2>작업상황</h2>
  <hr/>
  <p><a href="${ctp}/admin/adMemberList?level=4">새로운 가입자(<font color="red"><b>${newMember}</b></font> 건)</a></p>  <!-- 준회원이 있을경우 인원출력 -->
  <hr/>
  <p>
   <a href="${ctp}/admin/adBookList">등록된 책 리스트(<font color="red"><b>${bookCount}</b></font> 건)</a>	<!-- 최근 게시글 보기 -->
  </p>
</div>
<br/>
</body>
</html>