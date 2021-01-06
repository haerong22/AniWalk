<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>초기페이지</title>
</head>

<!-- css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/main.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">

<!-- js -->
<script src="/aniwalk/static/js/main.js"></script>


<body>
	<nav>
		<tiles:insertAttribute name="nav"></tiles:insertAttribute>
	</nav>
	<article>
		<tiles:insertAttribute name="content"></tiles:insertAttribute>
	</article>
	<footer class="footer"> 
		<img class="footer-logo" src="${pageContext.request.contextPath}/images/main_logo.png" alt="">
		<div class="footer-text">
			<h2 class="footer-text__title">About Us</h2>
			<div class="footer-text__contents">
				<div class="footer-text__contents-items">
					<h3 class="footer-text__contents-items__title">Our Team</h3>
					<ul class="footer-text__contents-items__list">
						<li><a href="https://github.com/haerong22">@haerong22</a></li>
						<li><a href="https://github.com/SejinCho">@SejinCho</a></li>
						<li><a href="https://github.com/YoungkeunAhn">@YoungkeunAhn</a></li>
						<li><a href="https://github.com/herryboro">@herryboro</a></li>
					</ul>
				</div>
				<div class="footer-text__contents-items">
					<h3 class="footer-text__contents-items__title">Development Place</h3>
					<a href="https://playdata.io/">encore playdata</a>
				</div>
			</div>
		</div>
	</footer>
	
</body>
</html>