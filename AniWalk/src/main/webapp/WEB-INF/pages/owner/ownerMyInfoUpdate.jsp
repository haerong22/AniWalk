<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프렌즈 개인정보수정</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/walker.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<!-- jQuery -->
	<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
</head>
<body>
	<div class="myinfo-update">

		<form action="/aniwalk/owner/ownerMyInfoUpdatePro.do" method="post" enctype="multipart/form-data">
		
		<input type="hidden" name="owner_id" value="${mem_nickname}">
			<h3>개인정보수정</h3>
			<table class="table">
				<tr>
					<th colspan="2">
						<div class="img-part">
							<img style="width: 200px;" id="userImg"
								 src="/aniwalk/images/profile_test.png" alt="" class="img-rounded">
							<h5>&lt;대표사진설정&gt;</h5>
							<input id="userInputImg" type="file" class="hidden" name="files">
						</div>
					</th>
				</tr>
				<tr>
					<th>닉네임</th>
					<td><input type="text" class="form-control" value="${mem_nickname}" name="mem_nickname"></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input type="text" class="form-control" value="${phone}" name="mem_phone" readonly>
					</td>
				</tr>
				<tr>
					<th colspan="2">
						<button type="submit" class="btn btn-primary">수정완료</button>
					</th>
				</tr>

			</table>
		</form>

	</div>
</body>
<script>
	const userImg = document.getElementById('userImg');
	const userInputImg = document.getElementById('userInputImg');
	userImg.addEventListener('click',function (){
		userInputImg.click();
	});
	
	$(document).ready(function() {
		$('#userInputImg').on('change', function(e) {			
			$('#userImg').attr('src', URL.createObjectURL(e.target.files[0]));
		});	
		$("#userImg").attr('src', '/owner/'+ `${mem_profile}`);	
	});
		

</script>
</html>