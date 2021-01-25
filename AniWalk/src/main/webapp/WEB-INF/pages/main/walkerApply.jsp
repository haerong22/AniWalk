	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프렌즈신청</title>
</head>
	<!-- jquery -->
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

	<!-- js -->
	<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<body>
<div class="container" style="display: flex; flex-direction: column;">
	
	<form id="applyForm1" class="walkerApply__form" method="POST" onsubmit="return applyCheck()"
		enctype="multipart/form-data" name='walker' action="/aniwalk/apply.do">
		
		<h2 class="terms__title">서비스약관동의</h2>
		<ul class="terms__list">
			<li>
				<div class="all-agree">
					<i class="far fa-check-circle"></i>
					<label>전체동의</label>
				</div>
			</li>
			<li>
				<div class="essential-agree">
					<i class="far fa-check-circle"></i>
					<label>[필수] 개인정보 수집 및 이용 동의</label>
					<input id="essentialAgreeYn" type="hidden" required>
				</div>
				<span id="essential" class="glyphicon glyphicon-chevron-down"></span>
			</li>
			<li id="essential-content" class="hidden">
				1. 목적 : 지원자 개인 식별, 지원의사 확인, 입사전형의 진행, 고지사항 전달, 입사 지원자와의 원활한 의사소통, 지원이력 확인 및 면접 불합격자 재지원 제한
				2. 항목 : 아이디(이메일주소), 비밀번호, 이름, 생년월일, 휴대폰번호
				3. 보유기간 : 회원 탈퇴 시까지 보유 (단, 지원이력 정보는 일방향 암호화하여 탈퇴일로부터 1년간 보관 후 파기합니다.)
			</li>
			<li>
				<div class="choose-agree">
					<i class="far fa-check-circle"></i>
					<label>[선택] 이벤트 정보 수신 동의</label>
				</div>
				<span id="choose" class="glyphicon glyphicon-chevron-down"></span>
			</li>
			<li id="choose-content" class="hidden">
				이벤트/지원 프로모션 혜택 등 다양한 정보를 휴대전화로 받아보실 수 있습니다.
			</li>
		</ul>
		<input type="hidden" name='wk_event_agree' value='0'>
		

		<ul class="apply-list userinfo">
			<li>
				<label>이름</label>
				<label><input name='wk_name' class="form-control" type="text" placeholder="이름" required minlength="2" maxlength="5"></label>
			</li>
			<li>
				<label>휴대폰번호</label>
				<label>
					<input id='phoneNum' name='wk_phone' class="form-control" type="text"
							  placeholder="휴대폰번호 11자리를 입력해주세요(-빼고 입력해주세요)" required minlength="11" maxlength="11">
					<input id='auth-btn' type="button" class="btn btn-primary auth-btn" value="휴대폰 인증하기">
				</label>
			</li>
			<li>
				<input type="hidden" id="authResult" name="auth_pass">
				<div class="unuse"></div>
				<div class="auth-part">
				</div>
			</li>
			<li>
				<label>생년월일</label>
				<label><input name='wk_birth' class="form-control" type="text" placeholder="생년월일 8자리 ex)19990101" required minlength="8" maxlength="8"></label>
			</li>
			<li>
				<label>거주지 주소</label>
				<label><input name='wk_addr' class="form-control" type="text" placeholder="ex)서울시 서초구 00동 00호" required minlength="13"></label>
			</li>
			<li>
				<label>이메일 주소</label>
				<label>
					<input id="email" name='wk_email' class="form-control" type="text" placeholder="이메일 주소 입력" required>
					<button id="email-btn" class="btn btn-primary auth-btn" type="button">중복 확인</button><span id="emailCheck"></span>
				</label>
			</li>
			<li>
				<label>자기소개</label>
				<label><textarea name='wk_intro' class="form-control" rows="3" placeholder="ex) 안녕하세요? 애니워크입니다.&#13;&#10;저는 애견미용사 이고 강아지를 너무 좋아해요." required></textarea></label>
			</li>
		</ul>
		
		<ul class="apply-list">
			<li style="display: flex; justify-content: center; align-items: center;">
				<h3>[필수] 프로필사진을 등록해주세요</h3><span>(1장 이상)</span>
			</li>
			<li style="text-align: center">
				<i class="fas fa-angle-left"></i>
				<img id='wk_img' alt="" src="${pageContext.request.contextPath}/images/main_logo.png">
				<i class="fas fa-angle-right"></i>
				<input id='wk_profile' multiple="multiple" type="file" max="3" class="form-control" name="wk_profile_imgs" required>
			</li>
		</ul>

		<ul class="apply-list">
			<li>
				<h3>[필수] 활동하실 지역을 선택해 주세요</h3>
			</li>
			<li>
				<select id='area' class="form-control" name='wk_location1' required>
					<option value="">선택하세요</option>
				</select>
			</li>
			<li>
				<select id='city' name='wk_location2' class="form-control" required>
					<option value="">선택하세요</option>
				</select>
			</li>
		</ul>

		<ul class="apply-list">
			<li>
				<h3>[선택] 자격증 정보를 올려주세요</h3>
			</li>
			<li>
				<input name="files" class="form-control" type="file">
			</li>
			<li>
				<input name="files" class="form-control" type="file">
			</li>
			<li>
				<input name="files" class="form-control" type="file">
			</li>
			<li>
				<input name="files" class="form-control" type="file">
			</li>
		</ul>
		<input id='auth_num' type="hidden">
		<button type="submit" class="btn btn-success">신청</button>
	</form>
</div>
<script type="text/javascript">
	const emailCheck = document.getElementById("email");
	const emailCheckBtn = document.getElementById("email-btn");
	const emailCheckResult = document.getElementById("emailCheck");
	emailCheckBtn.addEventListener('click', () => {
		if(! check_email.test(emailCheck.value)) {
	        alert(emailError);
	    } else {
	    	$.get('/aniwalk/walker/emailCheck.do?email=' + emailCheck.value, data => {
				console.log(data);
				emailCheckResult.innerText = data == 'y' ? '사용 가능한 이메일 입니다.' : '이미 사용중인 이메일 입니다.';
			})
	    }
	});
	
	// profile 사진 
	$('#wk_profile').on('change', function(e){		
		
		var cnt = 0;
    	var maxSize = 209715200;
    	var files = e.target.files;  	
    	var filesArr = Array.prototype.slice.call(files);
    	console.log('안녕');
    	if(files.length == 0){
    		$('#wk_img').attr('src', '${pageContext.request.contextPath}/images/main_logo.png' );
    	} else if(files.length > 3) {
    		alert('최대 3개 까지 선택 가능합니다.');
    		$('#wk_profile').val('');
    	} else {
    		filesArr.forEach(function(f) {
        		if(f.size >= maxSize) {
        			alert("파일 사이즈 초과");
        			$('#wk_profile').val('');
        		} else if(!f.type.match("image.*")) {
        			alert("사진과 동영상만 업로드 가능합니다!");
        			
        		} else {
            		console.log(URL.createObjectURL(e.target.files[0]));
        			$('#wk_img').attr('src', URL.createObjectURL(e.target.files[0]));
        		}
        	});
        	$('.fa-angle-left').on('click', function(){
        		if(cnt > 0) {
        			cnt -= 1;
               		$('#wk_img').attr('src', URL.createObjectURL(e.target.files[cnt]));
        		}
        	});
        	$('.fa-angle-right').on('click', function(){
        		if(cnt < files.length-1) {
        			cnt += 1;
               		$('#wk_img').attr('src', URL.createObjectURL(e.target.files[cnt]));
               	}
        	});
    	}
	})

</script>

<script type="text/javascript">
	//주소관련 ajax
	$(document).ready(function(){
		var area = ["강원도", "경기도", "경상남도", "경상북도", "광주광역시", "대구광역시",
			"대전광역시", "부산광역시", "서울특별시", "세종특별자치시", "울산광역시", "인천광역시",
			"전라남도", "전라북도", "제주특별자치도", "충청남도", "충청북도"]
		console.log(area.length);
		for(var i=0; i<area.length; i++){
			$('#area').append("<option>" + area[i] + "</option>");
		}
	
		$('#area').on('change', function(){
			$.ajax({
				url:"/aniwalk/walker/regionCheck.do",
				type:"get",			
				data:{			
					"area" : $('#area').val()
				},
				success:function(data){
					console.log(data);
					$('#city').empty();
					$('#city').append("<option>선택하세요</option>");
					for(var i=0; i<data.length; i++){
						$('#city').append("<option>" + data[i] + "</option>");	
					}
				},
				error:function(a,b,c){
				}
			})
		})
	})

</script>
<script>
	//항목 동의 항목
	const essentialAgree = document.querySelector('.essential-agree');
	const essentialClick = document.getElementById('essential');
	const essentialContent = document.getElementById('essential-content');

	const chooseAgree = document.querySelector('.choose-agree');
	const chooseClick = document.getElementById('choose');
	const chooseContent = document.getElementById('choose-content');

	ynCheck = () =>{
		if($('.essential-agree').hasClass('agree')){
			$('#essentialAgreeYn').val('Yes');
		}else {
			$('#essentialAgreeYn').val('');
		}
	}

	essentialAgree.addEventListener('click',function(){
		essentialAgree.classList.toggle('agree');
		ynCheck();
	});
	chooseAgree.addEventListener('click',function(){
		chooseAgree.classList.toggle('agree');
		ynCheck();
	});

	essentialClick.addEventListener('click',function(){
		essentialContent.classList.toggle('hidden');
		essentialClick.classList.toggle('glyphicon-chevron-down');
		essentialClick.classList.toggle('glyphicon-chevron-up');
	});
	chooseClick.addEventListener('click',function(){
		chooseContent.classList.toggle('hidden');
		chooseContent.classList.toggle('glyphicon-chevron-down');
		chooseContent.classList.toggle('glyphicon-chevron-up');
	});

	const allAgree = document.querySelector('.all-agree');
	allAgree.addEventListener('click',function (){
		essentialAgree.classList.toggle('agree');
		chooseAgree.classList.toggle('agree');
		ynCheck();
	});

</script>


<script>
$(document).ready(function(){
	$('footer').removeClass('absolute-position');
});
</script>

<script>
	//인증번호 관련
	const authBtn = document.querySelector('.auth-btn');
	authBtn.addEventListener('click',function(){
		$.ajax({
			url:"/aniwalk/walker/phoneCheck.do",
			type:"get",
			data:{
				"phoneNum" : $('#phoneNum').val()
			},
			success:function(data){
				console.log('data: ' + data);
				if(data === ''){
					addPhoneAuthForm();
					if(addPhoneAuthForm()){
						$('#phoneNum').attr("readonly", "readonly");
						$('.auth-phone').empty();
						$('#auth-btn').val('인증번호 다시받기');
						$.ajax({
							url:"/aniwalk/walker/auth.do",
							type:"post",
							data:{
								"wk_phone" : $('#phoneNum').val()
							},
							success:function(data){
								console.log('data: ' + data);
								var auth_num = $('#auth_num').val(data);
								console.log('auth_num: ' + auth_num);
								$('.auth').val(data)
							},
							error:function(a,b,c){
							}
						})
					}
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
		$.ajax({
			url:"/aniwalk/walker/authNum.do",
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
</body>
<style>
	.agree{
		color: blue;
	}
</style>
</html>