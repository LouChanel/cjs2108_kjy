<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<meta charset="UTF-8">
	<title>아이디 찾기</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
	@import url("http://fonts.googleapis.com/earlyaccess/nanumgothic.css");
	
	html {
		height: 100%;
	}
	
	body {
	    width:100%;
	    height:100%;
	    margin: 0;
  		/* padding-top: 80px; */
  		padding-bottom: 40px;
  		font-family: "Nanum Gothic", arial, helvetica, sans-serif;
  		background-repeat: no-repeat;
  		/* background:linear-gradient(to bottom right, #0098FF, #6BA8D1); */
	}
	
    .card {
        margin: 0 auto; /* Added */
        float: none; /* Added */
        margin-bottom: 10px; /* Added */
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	}
	
	.form-signin .form-control {
  		position: relative;
  		height: auto;
  		-webkit-box-sizing: border-box;
     	-moz-box-sizing: border-box;
        	 box-sizing: border-box;
  		padding: 10px;
  		font-size: 16px;
	}
	</style>
	<script>
	$("idCheck").prop("checked",true);
	</script>
</head>
<body style="cellpadding:0; cellspacing:0; marginleft:0; margintop:0; width:100%; height:100%; align:center;">
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<br/><br/>
	<div class="card align-middle" style="width:22rem; border-radius:20px;">
		<div class="card-title" style="margin-top:30px;">
			<h2 class="card-title text-center" style="color:#113366;">아이디 찾기</h2>
		</div>
		<div class="card-body">
      <form name="myform" class="was-validated" method="post">
        <h5 class="form-signin-heading">검색된 아이디 리스트</h5>
        <div class="form-group">
        <c:forEach var="vo" items="${vos}" varStatus="st">
		      <c:set var="mid1" value="${fn:substring(vo.mid,0,2)}"/>
		      <c:set var="mid2" value="${fn:substring(vo.mid,4,fn:length(vo.mid))}"/>
		      <p>${st.count}. <font color="blue">${mid1}**${mid2}</font></p>
		    </c:forEach>
				</div>
        <button id="btn-Back" class="btn btn-lg btn-primary btn-block" type="button" onclick="location.href='${ctp}/member/memLogin';">돌아가기</button>
      </form>
      
		</div>
	</div>

	<div class="modal">
	</div>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <!-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script> -->
    <br/><br/> 
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
  </body>
</html>