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
	<title>책 목록</title>
	<%@ include file="/WEB-INF/views/include/bs4.jsp" %>
	<style>
      p { margin:0px 0px; }
      .card-img {
      	height: 200px;
      	width: 100%;
      	background-size: cover;
      }
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
	  	.ellipsis {
			  width: 100%;
			  overflow: hidden;
			  text-overflow: ellipsis;
			  display: -webkit-box;
			  -webkit-line-clamp: 3;
			  -webkit-box-orient: vertical;
			}
}
  </style>
</head>
<body>
<div class="wrapper">
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
		<div class="container">
			<div class="row">
			<c:forEach var="vo" items="${vos}">
        <div class="col-12" style="margin: 10px 0px;">
          <p></p>
          <div class="card">
            <div class="row no-gutters">
              <div class="col-2">
                <a href="${ctp}/book/bookContent?idx=${vo.idx}"><img class="card-img" src="${ctp}/bookImg/${vo.bsname}"></a>
              </div>
              <div class="col-8">
                <div class="card-body">
                  <div class="card-text">
                  	<a href="${ctp}/book/bookContent?idx=${vo.idx}" style="color: black;">${vo.bookName}</a>
                  	<p>${vo.name} | ${vo.shop} | ${fn:substring(vo.bookDate,0,10)}</p>
                  	<p>${vo.bookPrice}원</p>
                  	<div class="ellipsis">${vo.content}</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </c:forEach>
      </div>
    </div>
    <div class="container">
			<ul class="pagination justify-content-center">
				<c:if test="${totPage == 0}"><p style="text-align:center"><b>자료가 없습니다.</b></p></c:if>
				<c:if test="${totPage != 0}">
				  <c:if test="${pag != 1}">
				    <li class="page-item"><a href="${ctp}/book/bookList?pag=1&pageSize=${pageSize}&lately=${lately}" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
				  </c:if>
				  <c:if test="${curBlock > 0}">
				    <li class="page-item"><a href="${ctp}/book/bookList?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}&lately=${lately}" title="이전블록" class="page-link text-secondary">◀</a></li>
				  </c:if>
				  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
				    <c:if test="${i == pag && i <= totPage}">
				      <li class="page-item active"><a href='${ctp}/book/bookList?pag=${i}&pageSize=${pageSize}&lately=${lately}' class="page-link text-light bg-secondary border-secondary">${i}</a></li>
				    </c:if>
				    <c:if test="${i != pag && i <= totPage}">
				      <li class="page-item"><a href='${ctp}/book/bookList?pag=${i}&pageSize=${pageSize}&lately=${lately}' class="page-link text-secondary">${i}</a></li>
				    </c:if>
				  </c:forEach>
				  <c:if test="${curBlock < lastBlock}">
				    <li class="page-item"><a href="${ctp}/book/bookList?pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}&lately=${lately}" title="다음블록" class="page-link text-secondary">▶</a>
				  </c:if>
				  <c:if test="${pag != totPage}">
				    <li class="page-item"><a href="${ctp}/book/bookList?pag=${totPage}&pageSize=${pageSize}&lately=${lately}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
				  </c:if>
				</c:if>
			</ul>
		</div>
    <br/><br/><br/><br/>
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>
</body>
</html>