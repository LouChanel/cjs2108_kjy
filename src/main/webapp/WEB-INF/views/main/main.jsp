<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
  <title>Book Store</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <style>
  	.carousel{
  		height: 480px;
  		width: 100%;
  	}
  	.image-thumbnail{
      left: 0;
      margin-top: 30px;
      width: 21%;
      height: 380px;
      background-size: cover;
    }
    .carousel-control-prev-icon, .carousel-control-next-icon {
	    height: 50px;
	    width: 50px;
	    background-color: rgba(0, 0, 0, 0.3);
	    background-size: 50%, 50%;
	    border-radius: 50%;
	    border: 1px solid black;
		}
  </style>
  <script>
  	$(document).ready(function() {
			$('#myCarousel').carousel({
			interval: 10000
			})
		});
  </script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp"/>
	<br/>
	<div class="container" align="center" style="height:50%; width:100%; background-color: gray;">
		<div id="demo" class="carousel slide" data-ride="carousel">
		
		  <ul class="carousel-indicators">
		    <li data-target="#demo" data-slide-to="0" class="active"></li>
		    <li data-target="#demo" data-slide-to="1"></li>
		    <li data-target="#demo" data-slide-to="2"></li>
		  </ul>
		  <div  class="carousel-inner image-box">
		    <div class="carousel-item active">
		    	<c:forEach var="vo" items="${vos}">
		      <a href="${ctp}/book/bookContent?idx=${vo.idx}"><img class="image-thumbnail" src="${ctp}/bookImg/${vo.bsname}" alt=""></a> &nbsp;&nbsp;
		      </c:forEach>
		    </div>
		    <div class="carousel-item">
		    	<c:forEach var="vo2" items="${vos2}">
		      <a href="${ctp}/book/bookContent?idx=${vo2.idx}"><img class="image-thumbnail" src="${ctp}/bookImg/${vo2.bsname}" alt=""></a> &nbsp;&nbsp;
		      </c:forEach>
		    </div>
		    <div class="carousel-item">
		      <c:forEach var="vo3" items="${vos3}">
		      <a href="${ctp}/book/bookContent?idx=${vo3.idx}"><img class="image-thumbnail" src="${ctp}/bookImg/${vo3.bsname}" alt=""></a> &nbsp;&nbsp;
		      </c:forEach>
		    </div>
		  </div>
		
		  <!-- Left and right controls -->
		  <a class="carousel-control-prev" href="#demo" data-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		  </a>
		  <a class="carousel-control-next" href="#demo" data-slide="next">
		    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		  </a>
		</div>
		<div class="container" style="clear:both;"></div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>