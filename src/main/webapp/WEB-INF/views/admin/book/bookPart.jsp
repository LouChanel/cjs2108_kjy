<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 분류</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	// 대분류 등록하기 
	function partMainCheck() {
		var partMainCode = partMainForm.partMainCode.value;
		var partMainName = partMainForm.partMainName.value;
		if (partMainCode == "") {
			alert("대분류 코드를 입력하세요");
			partMainForm.partMainCode.focus();
			return false;
		}
		if (partMainName == "") {
			alert("대분류명을 입력하세요");
			partMainForm.partMainName.focus();
			return false;
		}
		$.ajax({
			type : "post",
			url : "${ctp}/book/partMainInput",
			data : {
				partMainCode : partMainCode,
				partMainName : partMainName
			},
			success : function(data) {
				if (data == "0")
					alert("같은 상품이 등록되어 있습니다.\n확인하시고 다시 입력하세요.");
				else
					location.reload();
			},
			error : function() {
				alert('전송오류!');
			}
		});
	}

	// 소분류 등록하기 
	function partSubCheck() {
		var partMainCode = partSubForm.partMainCode.value;
		var partSubCode = partSubForm.partSubCode.value;
		var partSubName = partSubForm.partSubName.value;
		if (partMainCode == "") {
			alert("대분류명을 선택하세요");
			return false;
		}
		if (partSubCode == "") {
			alert("소분류코드를 입력하세요");
			partSubForm.partSubCode.focus();
			return false;
		}
		if (partSubName == "") {
			alert("소분류명을 입력하세요");
			partSubForm.partSubName.focus();
			return false;
		}
		$.ajax({
			type : "post",
			url : "${ctp}/book/partSubInput",
			data : {
				partMainCode : partMainCode,
				partSubCode : partSubCode,
				partSubName : partSubName
			},
			success : function(data) {
				if (data == "0") {
					alert("같은 상품이 등록되어 있습니다.\n확인하시고 다시 입력하세요.");
				} else {
					location.reload();
				}
			},
			error : function() {
				alert('전송오류!');
			}
		});
	}

	// 대분류 삭제
	function delPartMain(partMainCode) {
		var ans = confirm("대분류항목을 삭제하시겠습니까?");
		if (!ans)	return false;
		$.ajax({
			type : "post",
			url : "${ctp}/book/delPartMain",
			data : {partMainCode : partMainCode},
			success : function(data) {
				if (data == 0) {
					alert("하위항목이 있기에 삭제할 수 없습니다.\n하위항목을 먼저 삭제하세요.");
				} else {
					alert("대분류 항목이 삭제 되었습니다.");
					location.reload();
				}
			}
		});
	}

	// 소분류 삭제
	function delPartSub(partSubCode) {
		var ans = confirm("중분류항목을 삭제하시겠습니까?");
		if (!ans)	return false;
		$.ajax({
			type : "post",
			url : "${ctp}/book/delPartSub",
			data : {partSubCode : partSubCode},
			success : function(data) {
				if (data == 0) {
					alert("하위항목이 있기에 삭제할 수 없습니다.\n하위항목을 먼저 삭제하세요.");
				} else {
					alert("소분류 항목이 삭제 되었습니다.");
					location.reload();
				}
			}
		});
	}
</script>
</head>
<body>
		<p>
				<br>
		</p>
		<div class="container">
				<h2>상품 분류 등록하기</h2>
				<hr />
				<form name="partMainForm">
						<h5>대분류 관리(코드는 영문대문자1자리)</h5>
						대분류코드(A,B,C,...)
						<input type="text" name="partMainCode" /> &nbsp; &nbsp;
						대분류명
						<input type="text" name="partMainName" />
						<input type="button" value="대분류등록" onclick="partMainCheck()" class="btn btn-secondary btn-sm" />
						<table class="table table-hover m-3">
								<tr class="table-dark text-dark text-center">
										<th>대분류코드</th>
										<th>대분류명</th>
										<th>삭제</th>
								</tr>
								<c:forEach var="mainVo" items="${mainVos}" varStatus="st">
										<tr class="text-center">
												<td>${mainVo.partMainCode}</td>
												<td>${mainVo.partMainName}</td>
												<td><input type="button" value="삭제"
														onclick="delPartMain('${mainVo.partMainCode}')" /></td>
										</tr>
								</c:forEach>
						</table>
				</form>
				<hr />
				<hr />
				<form name="partSubForm">
						<h5>소분류 관리(코드는 숫자 2자리)</h5>
						<select name="partMainCode">
								<option value="">대분류명</option>
								<c:forEach var="mainVo" items="${mainVos}">
										<option value="${mainVo.partMainCode}">${mainVo.partMainName}</option>
								</c:forEach>
						</select> &nbsp; &nbsp; 소분류코드(01,02,...) <input type="text"
								name="partSubCode" /> &nbsp; &nbsp; 소분류명 <input
								type="text" name="partSubName" /> <input type="button"
								value="소분류등록" onclick="partSubCheck()"
								class="btn btn-secondary btn-sm" />
						<table class="table table-hover m-3">
								<tr class="table-dark text-dark text-center">
										<th>소분류코드명</th>
										<th>소분류명</th>
										<th>대분류명</th>
										<th>삭제</th>
								</tr>
								<c:forEach var="subVo" items="${subVos}" varStatus="st">
										<tr class="text-center">
												<td>${subVo.partSubCode}</td>
												<td>${subVo.partSubName}</td>
												<td>${subVo.partMainName}</td>
												<td><input type="button" value="삭제"
														onclick="delPartSub('${subVo.partSubCode}')" /></td>
										</tr>
								</c:forEach>
						</table>
				</form>
				<hr />
				<hr />
		</div>
		<br />
</body>
</html>