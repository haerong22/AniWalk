<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/owner.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	
	<!-- jquery -->
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
	
	<!-- 스와이퍼 -->
	<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.css">	
	<script src="https://unpkg.com/swiper/swiper-bundle.js"></script>
</head>
<body>
<div class="my-page">
	<section class="my-part">
		<div class="subtitle">
			<h4>My</h4>
		</div>
		<div class="my-part-info">
			<div class="img-part">
				<img id="userImg" src="/owner/${filename}" alt="" class="img-rounded"
					 onerror="this.src='/aniwalk/images/profile_test.png'">
				<label>대표 프로필사진</label>
			</div>

			<ul>
				<li>
					<label>포인트 : </label>
					<span>${joinDtos.get(0).getMem_point()} point</span>
				</li>
				<li>
					<button class="btn btn-success" type="button">포인트 충전</button>
				</li>
				<li>
					<label>가입날짜 : </label>
					<span><fmt:formatDate value="${joinDtos.get(0).getMem_join_date()}" pattern="yyyy-MM-dd"/></span>
				</li>
				<li>
					<button class="btn btn-primary" type="button" onclick="location.href='/aniwalk/owner/ownerMyInfoUpdate.do'">개인정보수정</button>
				</li>
			</ul>
		</div>
	</section>


	<section class="mydogs">
		<div class="subtitle">
			<h4>반려견 정보</h4>
		</div>
		<div class="mydogs-slider">
			<!-- Slider main container -->
			<div class="swiper-container">
				<!-- Additional required wrapper -->
				<div class="swiper-wrapper">
					<!-- Slides -->
					<c:forEach items="${joinDtos}" var="joinDto">
					<div class="swiper-slide">
						<div class="mydog-item">
							<div class="mydog-name">${joinDto.dog_name}</div>
							<div class="mydog-info-part">
								<img class="img-thumbnail" src="/owner/${joinDto.dog_image}" alt="">
								<ul>
									<li class="first">
										<label>견종</label>
										<span>${joinDto.dog_type}</span>
									</li>
									<li>
										<label>생일</label>
										<span class="dog-birth">${joinDto.dog_birth}</span>
									</li>
									<li>
										<label>정보</label>
										<span class="text-area">
											${joinDto.dog_info}
										</span>
									</li>
								</ul>
								<div class="mydog-btn">
									<button type="button" class="btn btn-primary mydog-update-btn" value="${joinDto.dog_id}">수정</button>
									<button type="button" class="btn btn-danger mydog-del-btn" value="${joinDto.dog_id}">삭제</button>
								</div>
							</div>
						</div>
					</div>
					</c:forEach>
				</div>
				<!-- If we need navigation buttons -->
				<div class="swiper-button-prev"></div>
				<div class="swiper-button-next"></div>
			</div>
		</div>



		<div class="mydog-add">
			<i class="far fa-plus-square"></i>
			<label>반려견 추가</label>
		</div>
	</section>

	<section class="my-walked">
		<div class="subtitle">
			<h4>산책내역</h4>
		</div>
		<div class="form-group">
			<div class="walked-month">2020년 9월</div>
			<div class="walked-info">
				<img class="img-thumbnail" src="${pageContext.request.contextPath}/images/moveInfo.png" alt="">
				<ul>
					<li>
						<label>날짜</label>
						<span>09-24 목요일 12:00</span>
					</li>
					<li>
						<label>거리</label>
						<span>2.3km</span>
					</li>
					<li>
						<label>산책시간</label>
						<span>30분 12초</span>
					</li>
				</ul>
			</div>
		</div>
	</section>
</div>

<!-- 강아지 추가 모달 -->
<div class="modal-bg hidden dog-add-modal">
	<div class="modal-content" onclick="event.stopPropagation()">
		<button class="close-btn" type="button">&times;</button>
		<form class="mydog-input" enctype="multipart/form-data" action="/aniwalk/owner/myPro.do" method="post">
			<div class="input-form">
				<div>
					<img id="clickImg" src="${pageContext.request.contextPath}/images/profile_test.png" alt="" class="img-rounded">
					<h5>&lt;대표사진설정&gt;</h5>
					<input id="uploadImg" type="file" class="hidden" name="files">
				</div>
				<div style="width: 40%">
					<ul>
						<li>
							<label>* 이름</label>
							<input type="text" class="form-control" name="dog_name" placeholder="강아지 이름을 입력해주세요">
						</li>
						<li>
							<label>* 견종</label>
							<select class="form-control" name="dog_type">
								<option value="" selected>견종</option>
								<option>포메라니안</option>
								<option>말티즈</option>
								<option>폼피츠</option>
								<option>사모예드</option>
								<option>푸들</option>
								<option>진돗개</option>
								<option>리트리버</option>
							</select>
						</li>
						<li>
							<label>생일</label>
							<input type="date" name="dog_birth" class="form-control">
						</li>
						<li>
							<label>특징</label>
						</li>
						<li>
							<label style="width: 100%">
								<textarea class="form-control" name="dog_info" cols="20"></textarea>
							</label>
						</li>
					</ul>
				</div>
			</div>
			<button type="submit" class="btn btn-primary">등록</button>
		</form>
	</div>
</div>

<!-- 강아지 수정 모달 -->
<div class="modal-bg hidden dog-update-modal">
	<div class="modal-content" onclick="event.stopPropagation()">
		<button class="close-btn" type="button">&times;</button>
		<form class="mydog-input" enctype="multipart/form-data" action="/aniwalk/owner/modifyDog.do" method="post">
			<input class="hidden_dog_id" type="hidden" name="dog_id" value="">
			<div class="input-form">
				<div>
					<img id="dogUpdateImg" src="/aniwalk/images/profile_test.png" alt="" class="img-rounded">
					<h5>&lt;대표사진설정&gt;</h5>
					<input id="UpdateuploadImg" type="file" class="hidden" name="files">
				</div>
				<div style="width: 40%">
					<ul>
						<li class="modify_modal_name">
							<label>* 이름</label>
							<input type="text" class="form-control" name="dog_name" value="">
						</li>
						<li class="modify_modal_type">
							<label>* 견종</label>
							<select class="form-control" name="dog_type">
								<option value="" selected>견종</option>
								<option>포메라니안</option>
								<option>말티즈</option>
								<option>폼피츠</option>
								<option>사모예드</option>
								<option>푸들</option>
								<option>진돗개</option>
								<option>리트리버</option>
							</select>
						</li>
						<li class="modify_modal_birth">
							<label>생일</label>
							<input type="date" name="dog_birth" class="form-control" >
						</li>
						<li>
							<label>특징</label>
						</li>
						<li class="modify_modal_info">
							<label style="width: 100%">
								<textarea class="form-control" name="dog_info" cols="20"></textarea>
							</label>
						</li>
					</ul>
				</div>
			</div>
			<div class="btn-line">
				<button type="submit" class="btn btn-primary">수정</button>
				<button id="updateModalClose" type="button" class="btn btn-default">취소</button>
			</div>

		</form>
	</div>
</div>

<!-- 반려견 삭제 팝업 / delete문으로 삭제하면 에러남. update문으로 이름, 생일, 견종을 null로 만들어야함. 리스트 뿌릴때도 name이 아닌 것만 나오게 해주세요-->
<div class="popup-bg hidden">
	<div class="popup-content" onclick="event.stopPropagation()">
		<h3 style="text-align: center; margin-bottom: 50px;">삭제하시겠습니까?</h3>
		<form class="mydog-del-modal-form" action="delete.do">	
			<input id="delDogId" type="hidden" value="" name="dog_id">
			<button class="btn btn-danger" type="submit">삭제</button>
			<button id="popupCloseBtn" class="btn btn-default" type="button">취소</button>
		</form>
	</div>
</div>

<script>
	const mydogAdd = document.querySelector('.mydog-add');
	const dogAddModal = document.querySelector('.dog-add-modal');
	const close = document.querySelector('.close-btn');
	mydogAdd.addEventListener('click',function(){
		dogAddModal.classList.remove('hidden');
	});
	dogAddModal.addEventListener('click',function (){
		dogAddModal.classList.add('hidden');
	});
	close.addEventListener('click',function (){
		dogAddModal.classList.add('hidden');
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
			}
		});
	});
</script>
<script>
//슬라이더
	var swiper = new Swiper('.swiper-container', {
		navigation: {
			nextEl: '.swiper-button-next',
			prevEl: '.swiper-button-prev',
		},
	});
</script>

<script>
	//반려견 생일 시간 삭제
	const dogBirth = document.querySelectorAll('.dog-birth');
	for(let i=0; i<dogBirth.length; i++){
		dogBirth[i].innerText = dogBirth[i].textContent.split(' ')[0];
	}
</script>

<!--반려견 수정 모달-->
<script>
	const dogUpdateModal = document.querySelector('.dog-update-modal');
	const dogUpdateBtn = document.querySelectorAll('.mydog-update-btn');
	const updateModalClose = document.getElementById('updateModalClose');
	for(let i=0; i<dogUpdateBtn.length; i++){
		dogUpdateBtn[i].addEventListener('click',function (){
			dogUpdateModal.classList.remove('hidden');
			/*경찬이형 여기 ajax로 기존에 있는 데이터들 불러와야되요*/					
			
			$.ajax({
				url: "/aniwalk/owner/dogInfoList.do",
				type: "get",
				data: {
					"dog_id" : dogUpdateBtn[i].value			
				},	
				success: function(data) {				
					let startDate = data[0].dog_birth.split(' ');				
					$(".dog-update-modal").find(".modify_modal_name").children().val(data[0].dog_name);
					$(".dog-update-modal").find(".modify_modal_type").children().val(data[0].dog_type);										
					$(".dog-update-modal").find(".modify_modal_birth").children().val(startDate[0]);					
					$(".dog-update-modal").find(".modify_modal_info").children().children().val(data[0].dog_info);
					$(".dog-update-modal").find(".hidden_dog_id").val(data[0].dog_id);			
					$(".dog-update-modal").find("#dogUpdateImg").attr('src', '/owner/' + String(data[0].dog_image));																
				},
				error:function(a,b,c){
				}
			});
			
			$('.close-btn').on('click', function() {
				dogUpdateModal.classList.add('hidden');
			});
		})
	};
	dogUpdateModal.addEventListener('click',function (){
		dogUpdateModal.classList.add('hidden');
	});
	
	updateModalClose.addEventListener('click',function (){
		dogUpdateModal.classList.add('hidden');
	});
											
	document.getElementById("dogUpdateImg").addEventListener("click", function() {
		document.getElementById("UpdateuploadImg").click();
	});

	$('#UpdateuploadImg').on('change', function(event) {
		//let file = event.target.files;				
		$('#dogUpdateImg').attr('src', URL.createObjectURL(event.target.files[0]));						
	});

</script>


<!--반려견 삭제 팝업창-->
<script>
	const popupBg = document.querySelector('.popup-bg');
	const delBtn = document.querySelectorAll('.mydog-del-btn');
	const popupCloseBtn = document.getElementById('popupCloseBtn');
	const delDogId = document.getElementById('delDogId');

	for(let i=0; i<delBtn.length; i++){
		delBtn[i].addEventListener('click',function (){
			popupBg.classList.remove('hidden');
			delDogId.value = this.value;
		});
	}

	popupBg.addEventListener('click',function (){
		popupBg.classList.add('hidden');
	});
	popupCloseBtn.addEventListener('click',function (){
		popupBg.classList.add('hidden');
	})
</script>
</body>
</html>