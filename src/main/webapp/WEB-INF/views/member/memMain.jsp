<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/nav.jsp"%>
<meta charset="UTF-8">
<title>내정보</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<p>
			<br>
	</p>
	<div class="container">
		<h2>회원정보</h2>
		<hr/>
		<p>
			<font color="blue">${sNickName}</font>님 로그인 중이십니다.
		</p>
		<p>
			현재 <font color="red">${sStrLevel}</font> 이십니다.
		</p>
		<p>
			최종 접속일 : <font color="blue">${sLastDate}</font>
		</p>
		<p>
			총 방문횟수 : <font color="blue">${vo.visitCnt}</font> 회
		</p>
		<p>
			오늘 방문횟수 : <font color="blue">${vo.todayCnt}</font> 회
		</p>
		<hr/>
	</div>
	<br/>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>