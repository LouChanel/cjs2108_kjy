<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%
  Date today = new Date();
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
  String sToday = sdf.format(today);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>bookInput.jsp(상품등록)</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <script>
    function fCheck() {
    	var partMainCode = myform.partMainCode.value;
    	var partSubCode = myform.partSubCode.value;
    	var bookName = myform.bookName.value;
    	var name = myform.name.value;
    	var shop = myform.shop.value;
			var bookPrice = myform.bookPrice.value;
			var file = myform.file.value;												// 파일명
			var ext = file.substring(file.lastIndexOf(".")+1);  // 확장자 구하기
			var uExt = ext.toUpperCase();
			var regExpPrice = /^[0-9|_]*$/;   // 가격은 숫자로만 입력받음
			if(partSubCode == "") {
				alert("상품 소분류를 입력하세요!");
				return false;
			}
			else if(bookName == "") {
				alert("책제목을 입력하세요!");
				return false;
			}
			else if(name == "") {
				alert("글쓴이 입력하세요!");
				return false;
			}
			else if(shop == "") {
				alert("출판사를 입력하세요!");
				return false;
			}
			else if(file == "") {
				alert("상품 이미지를 등록하세요");
				return false;
			}
			else if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG") {
				alert("업로드 가능한 파일이 아닙니다.");
				return false;
			}
			else if(bookPrice == "" || !regExpPrice.test(bookPrice)) {
				alert("상품금액은 숫자로 입력하세요.");
				return false;
			}
			else if(document.getElementById("file").value != "") {
				var maxSize = 1024 * 1024 * 10;  // 10MByte까지 허용
				var fileSize = document.getElementById("file").files[0].size;
				if(fileSize > maxSize) {
					alert("첨부파일의 크기는 10MB 이내로 등록하세요");
					return false;
				}
				else {
					myform.submit();
				}
			}
    }
    
    // 상품 입력창에서 대분류 선택(Change)시 중분류가져와서 중분류 선택박스에 뿌리기
    function partMainChange() {
    	var partMainCode = myform.partMainCode.value;
			$.ajax({
				type : "post",
				url  : "${ctp}/book/partSubName",
				data : {partMainCode : partMainCode},
				success:function(data) {
					var str = "";
					str += "<option value=''>소분류</option>";
					for(var i=0; i<data.length; i++) {
						str += "<option value='"+data[i].partSubCode+"'>"+data[i].partSubName+"</option>";
					}
					$("#partSubCode").html(str);
				},
				error : function() {
					alert("전송오류!");
				}
			});
  	}
  </script>
</head>
<body>
<div class="container-lg p-3">
  <div id="bookInput">
    <h3>상품등록</h3>
    <form name="myform" method="post" enctype="multipart/form-data">
      <div class="form-group">
        <label for="partMainCode">대분류</label>
        <select id="partMainCode" name="partMainCode" class="form-control" onchange="partMainChange()">
          <option value="">대분류를 선택하세요</option>
          <c:forEach var="mainVo" items="${mainVos}">
          	<option value="${mainVo.partMainCode}">${mainVo.partMainName}</option>
          </c:forEach>
        </select>
      </div>
      <div class="form-group">
        <label for="partSubCode">소분류</label>
        <select id="partSubCode" name="partSubCode" class="form-control">
          <option value="">소분류</option>
		  	  <c:forEach var="subVo" items="${subVos}">
		  	    <option value="${subVo.partSubCode}">${SubVo.partSubName}</option>
		  	  </c:forEach>
        </select>
      </div>
      <div class="form-group">
        <label for="bookName">책제목</label>
        <input type="text" name="bookName" id="bookName" class="form-control" placeholder="책 제목을 입력하세요" required/>
      </div>
      <div class="form-group">
        <label for="name">글쓴이</label>
        <input type="text" name="name" id="name" class="form-control" placeholder="글쓴이를 입력하세요" required/>
      </div>
      <div class="form-group">
        <label for="shop">출판사</label>
        <input type="text" name="shop" id="shop" class="form-control" placeholder="출판사를 입력하세요" required/>
      </div>
      <div class="form-group">
	      <label for="bookDate">출판일</label>
				<input type="date" name="bookDate" value="<%=sToday%>" class="form-control"/>
	    </div>
      <div class="form-group">
      	<label for="bookPrice">가격</label>
      	<input type="text" name="bookPrice" id="bookPrice" class="form-control" required/>
      </div>
      <div class="form-group">
        <label for="file">책이미지</label>
        <input type="file" name="file" id="file" class="form-control-file border" accept=".jpg,.gif,.png,.jpeg" required/>
        (업로드 가능파일:jpg, jpeg, gif, png)
      </div>
      <div class="form-group">
      	<label for="content">내용</label>
      	<textarea rows="5" name="content" id="CKEDITOR" class="form-control" required></textarea>
      </div>
      <script>
		    CKEDITOR.replace("content",{
		    	uploadUrl:"${ctp}/book/imageUpload",     /* 그림파일 드래그&드롭 처리 */
		    	filebrowserUploadUrl: "${ctp}/book/imageUpload",  /* 이미지 업로드 */
		    	height:460
		    });
		  </script>
		  <input type="button" value="상품등록" onclick="fCheck()" class="btn btn-secondary"/> &nbsp;
    </form>
  </div>
</div>
<p><br/></p>
</body>
</html>