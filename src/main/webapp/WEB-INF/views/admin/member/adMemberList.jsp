<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adMemberList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
    // 회원 등급변경을 ajax로 처리해본다.
    function levelCheck(obj) {
    	var ans = confirm("회원등급을 변경하시겠습니까?");
    	if(!ans) {
    		location.reload();
    		return false;
    	}
    	var str = $(obj).val();
    	var query = {
    			idx : str.substring(1),
    			level : str.substring(0,1)
    	}
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/admin/adMemberLevel",
    		data : query,
    		error:function() {
    			alert("처리 실패!!");
    		}
    	});
    }
    
    // 회원등급별 검색
    function levelSearch() {
    	var level = adminForm.level.value;
    	location.href = "${ctp}/admin/adMemberList?level="+level;
    }
    
    // 개별회원 검색
    function midSearch() {
    	var mid = adminForm.mid.value;
    	if(mid == "") {
    		alert("아이디를 입력하세요?");
    		adminForm.mid.focus();
    	}
    	else {
    		location.href = "${ctp}/admin/adMemberList?mid="+mid;
    	}
    }
  </script>
</head>
<body>
<p><br></p>
<div class="container">
  <form name="adminForm">      
	  <table class="table table-borderless m-0">
	    <tr>
	      <td colspan="2">
	        <c:choose>
	          <c:when test="${level==99}"><c:set var="title" value="전체"/></c:when>
	          <c:when test="${level==4}"><c:set var="title" value="준"/></c:when>
	          <c:when test="${level==3}"><c:set var="title" value="정"/></c:when>
	          <c:when test="${level==2}"><c:set var="title" value="우수"/></c:when>
	          <c:when test="${level==1}"><c:set var="title" value="특별"/></c:when>
	        </c:choose>
	        <c:if test="${!empty mid}"><c:set var="title" value="${mid}"/></c:if>
	        <h2 style="text-align:center;"><font color="blue">${title} 회원</font> 리스트 (총 : <font color="red">${totRecCnt}</font>건)</h2>
	      </td>
	    </tr>
	    <tr>
	      <td style="text-align:left">
	        <input type="text" name="mid" value="${mid}" placeholder="검색할아이디입력"/>
	        <input type="button" value="개별검색" onclick="midSearch()"/>
	        <input type="button" value="전체보기" onclick="location.href='${ctp}/admin/adMemberList';" class="btn btn-secondary btn-sm"/>
	      </td>
	      <td style="text-align:right">회원등급  
	        <select name="level" onchange="levelSearch()">
	          <option value="99" <c:if test="${level==99}">selected</c:if>>전체회원</option>
	          <option value="4" <c:if test="${level==4}">selected</c:if>>준회원</option>
	          <option value="3" <c:if test="${level==3}">selected</c:if>>정회원</option>
	          <option value="2" <c:if test="${level==2}">selected</c:if>>우수회원</option>
	          <option value="1" <c:if test="${level==1}">selected</c:if>>특별회원</option>
	        </select>
	      </td>
	    </tr>
	  </table>
  </form>
  <table class="table table-hover">
    <tr class="table-dark text-dark text-center">
      <th>번호</th>
      <th>아이디</th>
      <th>별명</th>
      <th>성명</th>
      <th>성별</th>
      <th>방문횟수</th>
      <th>최종접속일</th>
      <th>등급</th>
    </tr>
    <c:forEach var="vo" items="${vos}">
    	<tr class="text-center">
    	  <td>${curScrStrarNo}</td>
    	  <td>${vo.mid}</td>
    	  <td>${vo.nickName}</td>
    	  <td>
    	    ${vo.name}
    	  </td>
    	  <td>${vo.gender}</td>
    	  <td>${vo.visitCnt}</td>
    	  <td>${fn:substring(vo.lastDate,0,10)}</td>
    	  <td>
  	      <select name="level" onchange="levelCheck(this)">
  	        <option value="1${vo.idx}" <c:if test="${vo.level==1}">selected</c:if>>특별회원</option>
  	        <option value="2${vo.idx}" <c:if test="${vo.level==2}">selected</c:if>>우수회원</option>
  	        <option value="3${vo.idx}" <c:if test="${vo.level==3}">selected</c:if>>정회원</option>
  	        <option value="4${vo.idx}" <c:if test="${vo.level==4}">selected</c:if>>준회원</option>
  	        <option value="0${vo.idx}" <c:if test="${vo.level==0}">selected</c:if>>관리자</option>
  	      </select>
    	  </td>
    	</tr>
    	<c:set var="curScrStrarNo" value="${curScrStrarNo - 1}"/>
    </c:forEach>
  </table>
  <br/>
  
  <div class="container">
	<ul class="pagination justify-content-center">
		<c:if test="${totPage == 0}"><p style="text-align:center"><b>자료가 없습니다.</b></p></c:if>
		<c:if test="${totPage != 0}">
		  <c:if test="${pag != 1}">
		    <li class="page-item"><a href="${ctp}/admin/adMemberList?pag=1&pageSize=${pageSize}&lately=${lately}" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
		  </c:if>
		  <c:if test="${curBlock > 0}">
		    <li class="page-item"><a href="${ctp}/admin/adMemberList?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}&lately=${lately}" title="이전블록" class="page-link text-secondary">◀</a></li>
		  </c:if>
		  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
		    <c:if test="${i == pag && i <= totPage}">
		      <li class="page-item active"><a href='${ctp}/admin/adMemberList?pag=${i}&pageSize=${pageSize}&lately=${lately}' class="page-link text-light bg-secondary border-secondary">${i}</a></li>
		    </c:if>
		    <c:if test="${i != pag && i <= totPage}">
		      <li class="page-item"><a href='${ctp}/admin/adMemberList?pag=${i}&pageSize=${pageSize}&lately=${lately}' class="page-link text-secondary">${i}</a></li>
		    </c:if>
		  </c:forEach>
		  <c:if test="${curBlock < lastBlock}">
		    <li class="page-item"><a href="${ctp}/admin/adMemberList?pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}&lately=${lately}" title="다음블록" class="page-link text-secondary">▶</a>
		  </c:if>
		  <c:if test="${pag != totPage}">
		    <li class="page-item"><a href="${ctp}/admin/adMemberList?pag=${totPage}&pageSize=${pageSize}&lately=${lately}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
		  </c:if>
		</c:if>
	</ul>
</div>

</div>
<br/>
</body>
</html>