<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="<%=request.getContextPath()%>"/>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adLeft.jsp</title>
  <%@ include file="/WEB-INF/views/include/bs4.jsp" %>
  <script>
    function logoutCheck() {
    	parent.location.href = "${ctp}/member/memLogout";
    }
  </script>
  <style>
    body {background-color: rgb(0,123,255);}
    hr {background-color: black;}
  </style>
</head>
<body>
<p><br></p>
<!-- <div class="container" style="font-size:0.8em;"> -->
<div class="text-center">
  <a href="${ctp}/admin/adContent" target="adContent"><button type="button" class="btn btn-primary btn-block"><font color="black">관리자메뉴</font></button></a>
  <hr/>
  <a href="${ctp}/admin/adBookList" target="adContent"><button type="button" class="btn btn-primary btn-block"><font color="black">책목록</font></button></a>
  <a href="${ctp}/admin/adMemberList" target="adContent"><button type="button" class="btn btn-primary btn-block"><font color="black">회원목록</font></button></a>
  <hr/>
  <a href="${ctp}/book/bookPart" target="adContent"><button type="button" class="btn btn-primary btn-block"><font color="black">상품분류등록</font></button></a>
  <a href="${ctp}/book/bookInput" target="adContent"><button type="button" class="btn btn-primary btn-block"><font color="black">상품등록관리</font></button></a>
  <hr/>
  <a href="${ctp}/" target="_top"><button type="button" class="btn btn-primary btn-block"><font color="black">홈으로</font></button></a>
  <a href="javascript:logoutCheck()"><button type="button" class="btn btn-primary btn-block"><font color="black">로그아웃</font></button></a>
</div>
<br/>
</body>
</html>