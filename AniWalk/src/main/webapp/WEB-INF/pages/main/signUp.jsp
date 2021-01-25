<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
	.form-group ajax_nickname{
		display: flex;
		position: relative;
		left: 100%;
	}
</style>
</head>
	<!-- jquery -->
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<body>
<div class="register-screen">
	<div class="register-screen__left">
		<img src="${pageContext.request.contextPath}/images/main_logo.png" alt="">
		<p>
			Sign Up
		</p>
	</div>
	<div class="register-screen__right">
		<form name="signUpForm" method="post" action="/aniwalk/signIn.do" enctype="multipart/form-data" onsubmit="return signUpCheck()">
			<div class="register-screen__right-row">
				<label>닉네임</label>
				<label>																				<!-- get방식을 받으려면  ${param.xx}를 사용-->
					<input class="form-control" id="nickname" type="text" placeholder="닉네임 입력" name="mem_nickname" maxlength="10" required>
					<input id="duple" name="duple" type="hidden" value="0">
					<input class="form-control" type="hidden" name="kakao_id" value="${param.kakao_id}">
				</label>

				<div id="ajax_memnick_name"></div>
			</div>
			
			<div class="register-screen__right-row">
				<label>핸드폰번호</label>
				<label>
					<input id='phoneNum' name='mem_phone' class="form-control" type="text"
						   placeholder="휴대폰번호 11자리를 -빼고 입력해주세요" required minlength="11" maxlength="11">
				</label>
				<label>
					<input id='auth-btn' type="button" class="btn btn-primary btn-phone-auth" value="휴대폰 인증하기">
				</label>
			</div>
			<div>
				<!-- 핸드폰 인증 -->
				<input id='auth_num' type="hidden">
				<div>
					<input type="hidden" id="authResult" name="auth_pass">
					<div class="unuse"></div>
					<div class="auth-part">
					</div>
				</div>
			</div>

			<div class="register-screen__right-row">
				<label>반려견 정보 등록</label>
			</div>
			<div>
				<div>

					<div class="mydog-input" enctype="multipart/form-data" action="/aniwalk/owner/myPro.do" method="post">
						<div class="input-form">
							<div>
								<img id="clickImg" src="${pageContext.request.contextPath}/images/profile_test.png" alt="" class="img-rounded">
								<h5>&lt;대표사진설정&gt;</h5>
								<input id="uploadImg" type="file" class="hidden" name="files" required>
							</div>
							<div style="width: 40%">
								<ul>
									<li>
										<label>* 이름</label>
										<input type="text" class="form-control" name="dog_name" placeholder="강아지 이름을 입력해주세요" required>
									</li>
									<li>
										<label>* 견종</label>
										<select class="form-control" name="dog_type" required>
											<option value="" selected>견종</option>
											<option>포메라니안</option>
											<option>폼피츠</option>
											<option>사모예드</option>
											<option>진돗개</option>
											<option>푸들</option>
											<option>말티즈</option>
										</select>
									</li>
									<li>
										<label>생일</label>
										<input type="date" name="dog_birth" class="form-control" required>
									</li>
									<li>
										<label>특징</label>
									</li>
									<li>
										<label style="width: 100%">
											<textarea class="form-control" name="dog_info" cols="20" required></textarea>
										</label>
									</li>
								</ul>
							</div>
						</div>
					</div>

				</div>
			</div>
			<div class="register-screen__right-row">
				<div class="checkbox">
					<label>
						<input type="checkbox" required> 개인정보 수집에 대한 동의
					</label>
				</div>
			</div>
			<div class="register-screen__right-row">
				<div>
					<button type="submit" class="btn btn-primary">가입하기</button>
				</div>
			</div>
		</form>
	</div>
</div>

</body>
<script>
$(document).ready(function(){
	$('footer').removeClass('absolute-position');

});
</script>
<script>
	$(document).ready(function() {
		// 닉네임 입력창에 keyup을 하는 순간 => ①
		$("#nickname").on("keyup", function(e) {
			// 입력된 문자가 MemberController의 nicknameCheck 메소드를 거치며 DB에 해당 닉네임이 있는지 없는지 조회 => ②
			$.ajax({
				url: "/aniwalk/member/nicknameCheck.do",
				type: "post",
				data: {
					"mem_nickname" : $("#nickname").val()
				},
				success: function(data) {
					console.log(data);
					// 입력창에 아무것도 입력하지 않았을때 => 빨간 표시로 "닉네임을 입력해주세요." 라는 문구
					if($("#nickname").val() === null || $("#nickname").val() === "") {
						$("#ajax_memnick_name").text("닉네임을 입력해주세요.");
						$("#ajax_memnick_name").css("color", "red");
					// 중복된 닉네임이 없을시 => data에 쿼리에서 리턴된 0이 담기며 파란 표시로 "사용 가능한 닉네임입니다." 라는 문구
					} else if(data === 0) {
						$("#ajax_memnick_name").text("사용 가능한 닉네임입니다.");
						$("#ajax_memnick_name").css("color", "blue");
						// 유효성 처리를 위해 임의로 만든 hidden 태그의 value값으로 0을 준다.
						$("#duple").val(0);
					// 사용중인 닉네임이 있을시 => data에 쿼리에서 리턴된 1이 담기며 빨간 표시로 "이미 사용중인 닉네임입니다." 라는 문구
					} else if(data === 1) {
						$("#ajax_memnick_name").text("이미 사용중인 닉네임입니다.");
						$("#ajax_memnick_name").css("color", "red");
						// 유효성 처리를 위해 임의로 만든 hidden 태그의 value값으로 1을 준다.
						$("#duple").val(1);
					}
				},
				error: function(e) {}
			});
		});
	});
</script>

<script>
	const clickImg = document.getElementById('clickImg');
	const uploadImg = document.getElementById('uploadImg');

	clickImg.addEventListener('click',function (){
		uploadImg.click();
	});

	// 반려견 사진
	$('#uploadImg').on('change', function(e){
		var maxSize = 209715200;
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		filesArr.forEach(function(f) {
			if(f.size >= maxSize) {
				alert("파일 사이즈 초과");
				$('#uploadImg').val('');
			} else if(!f.type.match("image.*")) {
				alert("사진과 동영상만 업로드 가능합니다!");
			} else {
				$('#clickImg').attr('src', URL.createObjectURL(e.target.files[0]));
				console.log(uploadImg.value);
			}
		});
	});
</script>

<script>
	//인증번호 관련
	
	// input태그의 type=button, class값 auth-btn 으로 이루어진 속성을 가져와 click 이벤트를 걸어준다
	const authBtn = document.getElementById('auth-btn');
	authBtn.addEventListener('click',function(){
		// 입력한 휴대폰 번호를 컨트롤러의 phoneCheck메서드로 보내 DB에 이미 가입되어 있는 번호가 있는지 조회
		$.ajax({
			url:"/aniwalk/member/phoneCheck.do",
			type:"get",
			data:{
				"phoneNum" : $('#phoneNum').val()
			},
			success:function(data){
				// 조회된 휴대폰 번호가 없다면 정상 가입할 수 있는 기본 조건이 된다.
				if(data === ''){
					// 유효성을 처리하는 자바스크립트 함수
					addPhoneAuthForm();
					// 유효성을 만족하는 경우 addPhoneAuthForm() 리턴값이 true가 되어 아래 if문이 동작
					if(addPhoneAuthForm()){
						$('#phoneNum').attr("readonly", "readonly");					
						$('#auth-btn').val('인증번호 다시받기');
						// 컨트롤러의 auth메소드에서 Random함수를 이용해 무작위로 6자리의 숫자를 생성
						// 생성된 6자리 인증번호를 hash 코드를 생성하는 클래스에서 해쉬값으로 변경하여 리턴
						// 웹의 console 창에서 hash값이 보이므로 인해 보안성이 강화된다.
						
						// ( 해당 코드들은 실제 핸드폰 인증 대신에 자바 랜덤 함수로 임의로 인증번호를 생성하여
						//   휴대폰 인증 하도록 처리되었습니다. 회원가입을 진행하기 위해 입력해야 하는
						//   실제 인증번호는 sts console 창에 sysout으로 찍힌 번호를 입력합니다. )
						$.ajax({
							url:"/aniwalk/member/auth.do",
							type:"post",
							data:{
								"wk_phone" : $('#phoneNum').val()
							},
							success:function(data){
								var auth_num = $('#auth_num').val(data);
							},
							error:function(a,b,c){
							}
						})
					}
				// 이미 가입되어 있는 휴대전화 번호가 있을 경우 아래 phoneUnusable() 함수가 동작한다
				// "이미 사용중인 번호입니다" 라는 메세지가 화면에 출력되게 하는 유효성 처리 함수
				}else{
					phoneUnusable();
				}
			},
			error:function(a,b,c){
			}
		})
	})
</script>
<script>

	function auth(){
		alert($('.auth').val());
		$.ajax({
			url:"/aniwalk/member/authNum.do",
			type:"post",
			data:{
				"auth_num" : $('#auth_num').val(),
				"auth" : $('.auth').val()
			},
			success:function(data){
				if(data == 'pass'){
					$('#auth-btn').remove();
					$('.auth-part').empty();
					$('.auth-part').html('<input type="button" class="btn btn-primary" value="인증이 완료되었습니다."></label>');
					$('#authResult').val('auth-pass');
				} else {
					alert('인증번호가 틀렸습니다.');
				}
			},
			error:function(a,b,c){
			}
		})
	}
</script>
</html>