<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%
  Date today = new Date();
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
  String sToday = sdf.format(today);
%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/include/nav.jsp" %>
	<meta charset="UTF-8">
	<title>회원가입</title>
	<%@ include file="/WEB-INF/views/include/bs4.jsp" %>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="<%=request.getContextPath()%>/js/woo.js"></script>
	<script>
		var idCheckOn = 0;
		var nickCheckOn = 0;
		
		function idReset() {
	  	idCheckOn = 0;
	  }
	  	
	  function nickReset() {
	  	nickCheckOn = 0;
	  }
	  	
		function idCheck() {
			var idJ = /^[a-z0-9]{4,12}$/;
			var mid = $('#mid').val();
			$.ajax({
				type : "post",
				url  : "${ctp}/member/idCheck",
				data : {mid : mid},
				success : function(data) {
					if (data == "0") {
						$("#memIdCheck").text("사용중인 아이디입니다.");
						$("#memIdCheck").css("color","red");
						idCheckOn = 0;
					}
					else {
						if(idJ.test(mid)) {
							$("#memIdCheck").text("사용가능한 아이디입니다.");
							$("#memIdCheck").css("color","green");
							idCheckOn = 1;
						}
						else if (mid == ""){
							$("#memIdCheck").text("아이디를 입력해주세요.");
							$("#memIdCheck").css("color","red");
							idCheckOn = 0;
						}
						else {
							$("#memIdCheck").text("아이디는 소문자와 숫자 4~12자리만 가능합니다.");
							$("#memIdCheck").css("color","red");
							idCheckOn = 0;
						}
					}
				}, error : function() {
					console.log("실패");
				}
			});
		}
		
		function nickCheck() {
			var nickName = $('#nickName').val();
			$.ajax({
				type : "post",
				url  : "${ctp}/member/nickNameCheck",
				data : {nickName : nickName},
				success : function(data) {
					if (data == "0") {
						$("#memNickCheck").text("사용중인 닉네임입니다.");
						$("#memNickCheck").css("color","red");
						nickCheckOn = 0;
					}
					else {
						if (nickName == ""){
							$("#memNickCheck").text("닉네임을 입력해주세요.");
							$("#memNickCheck").css("color","red");
							nickCheckOn = 0;
						}
						else {
							$("#memNickCheck").text("사용가능한 닉네임입니다.");
							$("#memNickCheck").css("color","green");
							nickCheckOn = 1;
						}
					}
				}, error : function() {
					console.log("실패");
				}
			});
		}
		
		function idReset() {
			idCheckOn = 0;
		}
		
		function nickReset() {
			nickCheckOn = 0;
		}
		
		function fCheck() {
			var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
			
			var mid = myform.mid.value;
			var pwd = myform.pwd.value;
			var nickName = myform.nickName.value;
			var name = myform.name.value;
			var email = myform.email1.value + "@" + myform.email2.value;
			var tel = myform.tel1.value + "-" + myform.tel2.value + "-" + myform.tel3.value;
			
			var fName = myform.fName.value;
			var ext = fName.substring(fName.lastIndexOf(".")+1);
			var uExt = ext.toUpperCase();
			var maxSize = 1024 * 1024 * 2;
			
			if(mid == "") {
				alert("아이디를 입력하세요");
				myform.mid.focus();
			}
			else if(pwd == "") {
				alert("비밀번호를 입력하세요");
				myform.pwd.focus();
			}
			else if(nickName == "") {
				alert("닉네임을 입력하세요");
				myform.nickName.focus();;
			}
			else if(name == "") {
				alert("성명을 입력하세요");
				myform.name.focus();
			}
			else if(!regExpEmail.test(email)) {
				alert("이메일을 확인하세요");
				myform.email1.focus();
			}
			else {
				if(idCheckOn == 1 && nickCheckOn == 1) {
	    			//alert("입력처리 되었습니다.!");
	    			var postcode = myform.postcode.value;
	    			var roadAddress = myform.roadAddress.value;
	    			var detailAddress = myform.detailAddress.value;
	    			var extraAddress = myform.extraAddress.value;
	    			var address = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress
	    			if(address == "///") address = "";
	    			myform.address.value = address;
	    			myform.email.value = email;
	    			myform.tel.value = tel;
	    			
	    			// 사진파일 업로드 체크
	    			if(fName.trim() == "") {
			    		myform.photo.value = "noimage.jpg";
			    	}
	    			else {
				    	var fileSize = document.getElementById("fName").files[0].size;
				    	
				    	if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG") {
				    		alert("업로드 가능한 파일은 'JPG/GIF/PNG");
				    		return false;
				    	}
				    	else if(fName.indexOf(" ") != -1) {
				    		alert("업로드할 파일명에는 공백을 포함하실수 없습니다.");
				    		return false;
				    	}
				    	else if(fileSize > maxSize) {
				    		alert("업로드할 파일의 크기는 2MByte 이하입니다.");
				    		return false;
				    	}
	    			}
			    	myform.submit();
	  			}
	    		else {
	    			if(idCheckOn == 0) {
	    				alert("아이디 중복체크버튼을 눌러주세요!");
	    			}
	    			else {
	    				alert("닉네임, 중복체크버튼을 눌러주세요!");
	    			}
	    		}
			}
		}
  </script>
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
	<br/>
	<div class="container card align-middle" style="width:30rem; border-radius:20px;">
	  <form name="myform" method="post" class="was-validated" enctype="Multipart/form-data">
	    <div style="text-align: center;"><h2>회 원 가 입</h2></div>
	    <br/>
	    <div class="form-group">
	      <label for="mid">아이디 :  &nbsp;<input type="button" value="중복체크" class="btn-sm btn-secondary" onclick="idCheck()"/> </label>
	      <input type="text" class="form-control" id="mid" onkeyup="idReset()" placeholder="아이디를 입력하세요." name="mid" required autofocus/>
	      <div class="memCheckFont" id="memIdCheck"></div>
	    </div>
	    <div class="form-group">
	      <label for="pwd">비밀번호 :</label>
	      <input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요." name="pwd" maxlength="9" required/>
	    </div>
	    <div class="form-group">
	      <label for="nickname">닉네임 : &nbsp;<input type="button" value="중복체크" class="btn-sm btn-secondary" onclick="nickCheck()"/></label>
	      <input type="text" class="form-control" id="nickName" onkeyup="nickReset()"  placeholder="별명을 입력하세요." name="nickName" required/>
	      <div class="memCheckFont" id="memNickCheck"></div>
	    </div>
	    <div class="form-group">
	      <label for="name">성명 :</label>
	      <input type="text" class="form-control" id="name" placeholder="성명을 입력하세요." name="name" required/>
	    </div>
	    <div class="form-group">
	      <label for="email">Email address:</label>
					<div class="input-group mb-3">
					  <input type="text" class="form-control" placeholder="Email" id="email1" name="email1" required/>
					  <div class="input-group-append">
					    <select name="email2" class="custom-select">
						    <option value="naver.com" selected>naver.com</option>
						    <option value="hanmail.net">hanmail.net</option>
						    <option value="gmail.com">gmail.com</option>
						    <option value="nate.com">nate.com</option>
						    <option value="yahoo.com">yahoo.com</option>
						  </select>
					  </div>
					</div>
		  </div>
	    <div class="form-group">
	      <div class="form-check-inline">
	        <span class="input-group-text">성별 :</span> &nbsp; &nbsp;
				  <label class="form-check-label">
				    <input type="radio" class="form-check-input" name="gender" value="남자" checked>남자
				  </label>
				</div>
				<div class="form-check-inline">
				  <label class="form-check-label">
				    <input type="radio" class="form-check-input" name="gender" value="여자">여자
				  </label>
				</div>
	    </div>
	    <div class="form-group">
	      <label for="birthday">생일</label>
				<input type="date" name="birthday" value="<%=sToday%>" class="form-control"/>
	    </div>
	    <div class="input-group mb-3">
	      <div class="input-group-prepend">
	        <span class="input-group-text">전화번호 :</span> &nbsp;&nbsp;
			      <select name="tel1" class="custom-select">
					    <option value="010" selected>010</option>
					    <option value="070">070</option>
					  </select>-
	      </div>
	      <input type="text" name="tel2" size=4 maxlength=4 class="form-control"/>-
	      <input type="text" name="tel3" size=4 maxlength=4 class="form-control"/>
	    </div> 
	    <div class="form-group">
	      <label for="address">주소</label>
	      <input type="hidden" class="form-control" name="address"/>
	      <input type="text" name="postcode" id="sample4_postcode" placeholder="우편번호">
				<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
				<input type="text" name="roadAddress" id="sample4_roadAddress" size="50" placeholder="도로명주소">
				<span id="guide" style="color:#999;display:none"></span>
				<input type="text" name="detailAddress" id="sample4_detailAddress" size="30" placeholder="상세주소">
				<input type="text" name="extraAddress" id="sample4_extraAddress" placeholder="참고항목">
	    </div>
	    <div class="form-group">
	    	회원 프로필사진(파일용량:2MByte이내) :
	    	<input type="file" name="fName" id="fName" class="form-control-file border"/>
	    </div>
	    <br/>
	    <button type="button" class="btn btn-secondary" onclick="fCheck()">회원가입</button>
	    <button type="reset" class="btn btn-secondary">다시작성</button>
	    <button type="button" class="btn btn-secondary" onclick="location.href='<%=request.getContextPath()%>/memLogin.mem';">돌아가기</button>
	    <input type="hidden" name="photo"/>
	    <input type="hidden" name="email"/>
	    <input type="hidden" name="tel"/>
	  </form>
	</div>
		<br/><br/><br/><br/>
		<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>
</body>
</html>