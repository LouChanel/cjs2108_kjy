<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#collapsibleNavbar">
				<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="collapsibleNavbar">
				<ul class="navbar-nav">
						<li class="nav-item"><a class="nav-link"
								href="<%=request.getContextPath()%>">HOME</a></li>
				</ul>
				<ul class="navbar-nav">
						<li class="nav-item"><a class="nav-link"
								href="${ctp}/book/bookList">도서</a></li>
				</ul>
		</div>
		<c:if test="${sLevel == 0}">
				<div class="button" style="float: right;">
						<a class="nav-link" href="${ctp}/admin/adMenu">관리자메뉴</a>
				</div>
		</c:if>
		<c:if test="${empty sLevel}">
				<div class="button" style="float: right;">
						<a class="nav-link" href="${ctp}/member/memLogin">로그인</a>
				</div>
		</c:if>
		<c:if test="${!empty sLevel}">
				<div class="button" style="float: right;">
						<a class="nav-link" href="${ctp}/member/memMain">내정보</a>
				</div>
				<div class="button" style="float: right;">
						<a class="nav-link" href="${ctp}/member/memLogout">로그아웃</a>
				</div>
		</c:if>
</nav>