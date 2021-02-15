<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
</head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/manager.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<body>
<div class="user-info">
    <div class="info-top">
        <h4>Applier Profile</h4>
    </div>
    <div class="info-content">
        <div class="left-box">
            <img class="img-rounded" src="/walker/${walkerInfo[0].wk_profile_img1}" alt="">
            <ul>
                <li>
                    <label>신청자:</label>
                    <span>${walkerInfo[0].wk_name}</span>
                </li>
                <li>
                    <label>생년월일:</label>
                    <span>${fn:substring(walkerInfo[0].wk_birth, 0, 10)}</span>
                </li>
                <!--  
                <li>
                    <label>핸드폰</label>
                    <span>${walkerInfo[0].wk_phone}</span>
                </li> -->
                <li>
                	<label>핸드폰:</label>
                    <span>
                    	${fn:substring(walkerInfo[0].wk_phone, 0, 3)}
                    	- ${fn:substring(walkerInfo[0].wk_phone, 3, 7)}
                    	- ${fn:substring(walkerInfo[0].wk_phone, 7, 11)} 
                    </span>
                </li>           
                <li>
                    <label>거주지</label>
                    <span style="display:block;">${walkerInfo[0].wk_addr}</span>
                </li>
                <li>
                    <label>이메일:</label>
                    <span id="applierEmail">${walkerInfo[0].wk_email}</span>
                </li>
                <c:if test="${walkerInfo[0].apply_state eq 4}">
	                <li>
		                <!-- 합격상태 and 아이디가 없는 경우 활성화 -->
		                <!-- 아이디 생성 버튼 누르면 email@앞으로 id가 생성되고 비밀번호는 영어숫자랜덤으로 6자리 제공한다 -->
	               		<button id="walkerIdCreate" type="button" class="btn btn-primary">아이디 생성</button>
	               		<!-- 합격상태 and 아이디가 있는 경우 -->
	   	            	<!-- 임시비밀번호 발급 버튼을 누르면 현재 비밀번호가 임시 비밀번호로 변경된다. -->
	               		<button id="walkerPwIssue" type="button" class="btn btn-danger">임시비밀번호 발급</button>
	               	</li>
               	</c:if>
            </ul>
        </div>

        <form class="right-box" method="post" action="/aniwalk/manager/updateWalker.do" onkeydown="return captureReturnKey(event)">
            <input type="hidden" name="wk_id" value="${walkerInfo[0].wk_id}">
            <ul class="applier-info">
	            <c:if test="${walkerInfo[0].apply_state ne 4}">
	            	<h4>신청정보</h4>
	                <li>
	                    <label>신청날짜</label>
	                    <span>${walkerInfo[0].apply_date}</span>
	                </li>
	                <li>
	                	<label>신청한 활동지역</label>
	                	<span> ${walkerInfo[0].wk_location1} / ${walkerInfo[0].wk_location2} </span>
	                </li>
	                <li>
	                    <label>신청상태</label>
	                    <select name="apply_state" id="apply_state">
	                        <option value="1">서류 검토 중</option>
	                        <option value="2">교육 대기</option>
	                        <option value="3">교육 수료</option>
	                        <option value="4">합격</option>
	                        <option value="5">불합격</option>
	                    </select>
	                </li>
	            </c:if>
	            <c:if test="${walkerInfo[0].apply_state eq 4}">
	               	<h4>활동정보</h4>
	               	<li>
	                    <label>아이디</label>
	                    <span id="walker_id">${walkerInfo[0].walker_id}</span>
	                </li>
	                <li>
	                    <label>활동시작 날짜</label>
	                    <span>${walkerInfo[0].activity_start_date}</span>
	                </li>
	                <li>
	                    <label>활동지역</label>
	                    <span>${walkerInfo[0].wk_location1} / ${walkerInfo[0].wk_location2}</span>
	                </li>
	                <li>
	                    <label>활동상태</label>
	                    <select name="activity_state" id="activity_state">
	                        <option value='1'>활동</option>
	                        <option value='2'>중지</option>
	                    </select>
	                </li>
	            </c:if>
            	<li>
                    <label>자기소개</label>
                    <pre><span>${walkerInfo[0].wk_intro}</span></pre>
                </li>
                <li>
                	<label>등록한 자격정보</label>
                	<div class="certificate-group">
                		<!-- 등록한 자격증이 없는 경우 -->
                		<c:if test="${certificateImg.size() == 0}">
                			<h3>등록한 자격증 정보가 없습니다.</h3>
                		</c:if>
                		<!-- 등록한 자격증이 있는경우 -->
                		<!-- 클릭시 모달로 이미지 크게 보이게 할것임 -->
                		<c:forEach var="img" items="${certificateImg}">
	                		<img class="certificate-img" src="/walker/${img}">
                		</c:forEach>
                	</div>
                </li>
                <li>
                	<label>자격증 입력</label>
                	<div class="certificate-input-box">
                		<input id='cert-name' onkeydown="certName()" type="text" class="form-control" placeholder="자격증 이름을 입력해주세요">
                		<button id='cert-btn' class="btn btn-success" type="button">등록</button>
                	</div>
                </li>
                <li>
					<label>자격증 리스트</label>                
                	<ol id='cert-list'>
                		<c:set var="wk_certificate_list" value="${fn:split(walkerInfo[0].wk_certificate_list,'/')}"/>
                		<c:forEach var="certi" items="${wk_certificate_list}">
                			<c:if test="${certi != ''}">
                				<li>${certi}	<input onclick="delCert(this)" class="btn btn-light" type="button" value='삭제'></li>
                			</c:if>
                		</c:forEach>
                	</ol>
                </li>
            </ul>
            <input type="hidden" name="wk_certificate_list" id="wk_certificate_list">
            <div class="btn-line">
                <button class="btn btn-primary" type="submit">수정</button>
                <button class="btn btn-danger" type="button">취소</button>
            </div>
        </form>
    </div>
</div>
<div class="modal-bg hidden">
	<div class="modal-content" onclick="event.stopPropagation()">
		<button class="close-btn" type="button">&times;</button>
		<img src="aniwalk/images/certificate.jpg" class="img-rounded big-img">
	</div>
</div>

<script>
	$(document).ready(function(){
		var apply_state = "${walkerInfo[0].apply_state}";
		var activity_state = "${walkerInfo[0].activity_state}";
		var walker_id = "${walkerInfo[0].walker_id}";
		$('#apply_state').val(apply_state).attr('selected', 'selected');
		$('#activity_state').val(activity_state).attr('selected', 'selected');
		if(walker_id != null && walker_id != '') {
			$('#walkerIdCreate').addClass('hidden');
		} else {
			$('#walkerPwIssue').addClass('hidden');
		}
		wk_certificate_list();
	})
</script>
<script>
	function captureReturnKey(e) { 
	    if(e.keyCode == 13 && e.srcElement.type != 'input') 
	        return false; 
	}
	
	function wk_certificate_list() {
		var wk_certificate_list = '';
		for(var i=1;i<=$('#cert-list li').length; i++) {
			wk_certificate_list += $('#cert-list > li:nth-child('+ (i) +')').text() + '/';
		}
		$('#wk_certificate_list').val(wk_certificate_list);
	}

	function certName(){
		if(event.keyCode == 13 && $('#cert-name').val() != '') {
			$('#cert-list').append('<li>'+ $('#cert-name').val() + '	<input onclick="delCert(this)" class="btn btn-light" type="button" value="삭제"></li>');
			$('#cert-name').val('');
			wk_certificate_list();
		}
	}
	$('#cert-btn').on('click', function(){
		if($('#cert-name').val() != ''){
			$('#cert-list').append('<li>'+ $('#cert-name').val() + '	<input onclick="delCert(this)" class="btn btn-light" type="button" value="삭제"></li>');
			$('#cert-name').val('');
			wk_certificate_list();
		}
	})
	
	function createWalkerIdAndPw(){
    const walker_id = applierEmail.innerText;
    const wk_pw = Math.random().toString(36).substr(2,6);
	    $.ajax({
	        url : '/aniwalk/manager/createWalkerId.do',	//이름 바꿔도됨
	        type : 'post',
	        data :{
	            "walker_id" : walker_id,
	            "wk_pw" : wk_pw,
	            "wk_id" : "${walkerInfo[0].wk_id}"
	        },
	        success : function(data) {
	            if(data == 'success'){
	            	$('#walker_id').text(walker_id);
	            	$('#walkerIdCreate').addClass('hidden');
	            	$('#walkerPwIssue').removeClass('hidden');
	            } else {
	            	alert('아이디가 생성 실패');
	            }
	        },
	        error : function(a, b, c) {
	            console.log(c);
	        }
	    })
	}
	
	function delCert(cert){
		cert.parentNode.parentNode.removeChild(cert.parentNode);
		wk_certificate_list();
	}
</script>
<script>
	const certificateImg = document.querySelectorAll('.certificate-img');
	const modalBigImg = document.querySelector('.big-img');
	const modalBg = document.querySelector('.modal-bg');
	const closeBtn = document.querySelector('.close-btn');

	for (let i=0; i<certificateImg.length; i++){
	    certificateImg[i].addEventListener('click',function (){
	         modalBigImg.src = this.src;
	         console.log(modalBigImg.src);
	         modalBg.classList.remove('hidden');
        })
    }
	modalBg.addEventListener('click',function (){
	    modalBg.classList.add('hidden');
    });
    modalBg.addEventListener('click',function (){
        modalBg.classList.add('hidden');
    });
    closeBtn.addEventListener('click',function (){
        modalBg.classList.add('hidden');
    });
</script>
<script>
	const walkerPwIssue = document.getElementById('walkerPwIssue');
	const walkerIdCreate = document.getElementById('walkerIdCreate');
	
	//임시비밀번호 발급 버튼 클릭
	walkerPwIssue.addEventListener('click', function() {
		alert('임시비밀번호가 생성되었습니다.');
		createWalkerIdAndPw();
	});
	//아이디 생성 버튼 클릭
	walkerIdCreate.addEventListener('click',function() {
		alert('아이디가 생성되었습니다.');
		createWalkerIdAndPw();
	});
</script>
</body>
</html>