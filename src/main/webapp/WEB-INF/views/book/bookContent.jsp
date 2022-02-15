<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/include/nav.jsp" %>
	<meta charset="UTF-8">
	<title>책 정보</title>
	<%@ include file="/WEB-INF/views/include/bs4.jsp" %>
	<style>
  	html,
  	body {
  		margin: 0;
  		padding: 0;
  		height: 100%;
  	}
  	.wrapper {
  		position: relative;
  		min-height: 100%;
  	}
  	.container {
  		padding: 20px;
  	}
  </style>
</head>
<body>
<div class="wrapper">
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
		<div class="container" style="border: black;">
			<h2 style="margin-top: 10px;">${vo.bookName}</h2>
			<hr/>
			<table class="table table-bordered">
				<tr>
					<th rowspan="1" style="width: 150px"><a href="${ctp}/book/bookContent?idx=${vo.idx}"><img src="${ctp}/bookImg/${vo.bsname}"/></a></th>
					<td><h2>지은이 : ${vo.name} <br/> 출판사 : ${vo.shop} <br/> 출판일 : ${fn:substring(vo.bookDate,0,10)}
					<br/> 가&nbsp;&nbsp;&nbsp;격 : ${vo.bookPrice}원</h2>
					</td>
				</tr>
				<tr>
					<td colspan="2"><h2>책 내용</h2><br/>${vo.content}</td>
				</tr>
			</table>
		</div>
		<br/><br/><br/><br/>
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>
</body>
</html>