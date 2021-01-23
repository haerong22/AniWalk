<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인메뉴</title>
</head>
<body>
<div class="main-nav">
	
	<ul class="main-nav__list">
		<li class="main-nav__list-items"><a href="#">사용방법</a></li>
		<li class="main-nav__list-items"><a href="#">사용후기</a></li>
		<li class="main-nav__list-items">
			<a href="/aniwalk/index.do">
				<img class="main-nav__logo" src="${pageContext.request.contextPath}/images/main_logo.png" alt="애니워크로고">
			</a>
		</li>
		<li class="main-nav__list-items"><a href="/aniwalk/walker/index.do">프렌즈 로그인</a></li>
		<li class="main-nav__list-items"><a href="/aniwalk/walkerApply.do">프렌즈 신청</a></li>
	</ul>
</div>

</body>
</html>