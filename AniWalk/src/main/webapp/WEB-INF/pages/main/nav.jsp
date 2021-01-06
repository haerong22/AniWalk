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
	<a href="/aniwalk/index.do">
		<img class="main-nav__logo" src="${pageContext.request.contextPath}/images/main_logo.png" alt="">
	</a>
	<ul class="main-nav__list">
		<li class="main-nav__list-items"><a href="/aniwalk/index.do">Home</a></li>
		<li class="main-nav__list-items"><a href="#">사용방법</a></li>
		<li class="main-nav__list-items"><a href="#">사용후기</a></li>
		<li class="main-nav__list-items"><a href="/aniwalk/walker/index.do">프렌즈 Login</a></li>
		<li class="main-nav__list-items"><a href="/aniwalk/walkerApply.do">프렌즈 신청</a></li>
	</ul>
</div>

</body>
</html>