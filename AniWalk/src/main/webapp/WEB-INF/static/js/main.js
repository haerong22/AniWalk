const agreeError = '필수 항목에 동의하셔야 합니다.';
const nameError = '이름을 올바르게 입력하세요.';
const emailError = '올바른 이메일 형식으로 작성해주세요.';
const phoneAuthPassError = '핸드폰 인증을 진행해주세요';
const phoneMinusError = `
        <div class="text-danger">-을 빼고 작성해주세요</div>
    `;
const phoneInputError = `
        <div class="text-danger">핸드폰번호를 제대로 입력해주세요</div>
    `;

const check_num = /[0-9]/;                  // 숫자
const check_eng = /[a-zA-Z]/;               // 문자
const check_spc = /[~!@#$%^&*()_+|<>?:{}]/; // 특수문자
const check_kor = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;      // 한글체크
const check_minWord = /[ㄱ-ㅎ|ㅏ-ㅣ]/;           // 모음, 자음 체크

const check_email = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;       //이메일 정규식
const check_passwd = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,10}$/;                   //  8 ~ 10자 영문, 숫자 조합     비밀번호 정규식



//워커신청 유효성
applyCheck =  function(){
    let wkNameValue = applyForm1.wk_name.value;
    let wkEmailValue = applyForm1.wk_email.value
    if(applyForm1.essentialAgreeYn.value === ''){
        alert(agreeError);
        return false;
    }
    if(check_num.test(wkNameValue) || check_spc.test(wkNameValue) || check_eng.test(wkNameValue) || check_minWord.test(wkNameValue)){
        alert(nameError);
        return false;
    }
    if(! check_email.test(wkEmailValue)){
        alert(emailError);
        return false;
    }
    if(applyForm1.auth_pass.value !== 'auth-pass'){
        alert(phoneAuthPassError);
        return false;
    }

}

// user 회원가입 유효성
function signUpCheck() {
	let userNickname = signUpForm.mem_nickname.value;
	let dogNameValue = signUpForm.dog_name.value;
	let dogType = signUpForm.dog_type.value;
	
	if(check_minWord.test(userNickname)) {
		alert(nameError);
		return false;
	}
	if(signUpForm.duple.value === "1") {
		alert("중복된 닉네임은 사용할 수 없습니다.");
		return false;
	}
	if(dogNameValue === '' || check_spc.test(dogNameValue) || check_minWord.test(dogNameValue)) {
		alert(nameError);
		return false;
	}
}

//핸드폰인증 유효성
addPhoneAuthForm = function() {
    const authPart = document.querySelector('.auth-part');
    const unuse = document.querySelector('.unuse');
    const addForm = `
        <form id="authForm" style="display: flex; justify-content: space-around; margin-top: 10px;">
            <label>인증번호</label>
            <input class="auth form-control" style="width: 65%;">
            <button onclick="auth()" id="authNum" type="button" class="btn btn-primary">인증번호입력</button>
        </form>
    `;
    const inputPhoneNum = document.getElementById('phoneNum');
  
    let phoneNum = inputPhoneNum.value.split(''); 
    let minusError = 0;
    for(let i=0; i<phoneNum.length; i++){
        if(phoneNum[i] === '-'){
            minusError++;
        }
    }

    if(minusError >= 1){
        authPart.innerHTML = phoneMinusError;
        return false;
    }else if (inputPhoneNum.value.length < 11){
        authPart.innerHTML = phoneInputError;
        return false;
    }else if (check_kor.test(inputPhoneNum.value) || check_eng.test(inputPhoneNum.value) || check_spc.test(inputPhoneNum.value) ){
        authPart.innerHTML = phoneInputError;
        return false;
    }
    else{
        authPart.innerHTML = addForm;
        unuse.innerHTML = '';
        return true;
    }
}

//작성한 핸드폰 번호가 사용중인 번호일 때 호출
phoneUnusable = function(){
    const unuse = document.querySelector('.unuse');
    const authPart = document.querySelector('.auth-part');

    const unusable = `
        <div class="text-danger">이미 사용중인 번호입니다.</div>
    `
    unuse.innerHTML = unusable;
    authPart.innerHTML = '';
}

