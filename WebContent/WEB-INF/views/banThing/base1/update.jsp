<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="<c:url value="/resources/css/base1/update.css?var=2"/>">

<div id="index">
	<div class="name">
		<img width="480" height="160" src="<c:url value="/resources/img/logo.jpg"/>"></h1>
	</div>
	<div class="signup-setting">
		<form name="signUpForm" action="update.1"  method="post">
				<input type="text" id="id" name="id" class="btn" value="${all.id}" readonly><br/>
				<input type="password" id="pw" name="pw" class="btn" placeholder="*패스워드"><br/>
				<input type="password" name="pw2" class="btn" placeholder="*패스워드 확인"><br/>
				<input type="text" id="name" name="name" class="btn" value="${all.name}" readonly><br/>
				<input type="text" id="ssan" name="ssan" class="btn" value="${all.ssan}" readonly><br/>
				<input type="text" id="ph" name="ph" class="btn" value="${all.ph}" placeholder="*전화번호 (010-1234-1234)"><br/>
				<input type="button" id="addrBtn" class="btn btn-warning" style="width:15%" value="검색" onclick="address_setting()">
				<input type="text" id="addr" name="addr" class="btn " style="width:35%" placeholder="주소" value="${all.addr}" readonly="readonly"><br/>
				<input type="text" id="email" name="email" class="btn" value="${all.email}" placeholder="이메일"><br/>
				<input type="text" id="nick" name="nick" class="btn" value="${all.nick}" placeholder="*닉네임"><br/>
			<br/>
			<button type="button" onclick="window.location.href='update.1'" class="btn btn-info">
				회원 수정
			</button>
			<button type="button" onclick="history.go(-1);" class="btn btn-info">
				뒤로가기
			</button>
		</form>
	</div>
</div>

<c:if test="${update eq 'success'}">
	<script>
		alert('회원수정이 완료되었습니다.');
		window.location.href="index.2";
	</script>
</c:if>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 유효성 검사 & 정규식 표현 -->
<script>
	function address_setting(){
	    new daum.Postcode({
	        oncomplete: function(data) {
	        	$("#addr").val(data['address']);
	        }
	    }).open();
	}
	
	function check(){
		var signup = document.signUpForm;

		var regExp = /\s/g;
		var idReg = /^[a-z0-9]{5,15}$/g;
		var pwReg = /^[A-za-z0-9]{3,19}$/g;
		var nameReg = /^[가-힣ㄱ-ㅎㅏ-ㅣ]{1,10}$/g;
		var ssanReg = /^(?:[0-9]{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[1,2][0-9]|3[0,1]))-[1-4][0-9]{6}$/g;
		var phonReg = /(^02.{0}|^01.{1}|[0-9]{3})*[-]([0-9]+)*[-]([0-9]{4})/g;
		var emailReg = /^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{1,5}$/g;
		var nickReg = /^[가-힣ㄱ-ㅎㅏ-ㅣA-za-z0-9]{1,10}$/g;

 		if(!signup.id.value){
			alert("아이디를 입력하세요.");
			return false;
		}
		if(!idReg.test(signup.id.value) || regExp.test(signup.id.value)){
			alert("아이디는 6~16자 사이의 영문 소문자+숫자만 가능합니다.");
			return false;
		}
		if(!signup.pw.value){
			alert("비밀번호를 입력하세요.");
			return false;
		}
		if(!pwReg.test(signup.pw.value) || regExp.test(signup.pw.value)){
			alert("비밀번호는 4~20자 사이의 영문 대소문자+숫자만 가능합니다.");
			return false;
		}
		if(signup.pw.value != signup.pw2.value){
			alert("비밀번호와 비밀번호확인이 일치하지 않습니다.");
			return false;
		}
		if(!signup.name.value){
			alert("이름을 입력하세요.");
			return false;
		}
		if(!nameReg.test(signup.name.value) || regExp.test(signup.name.value)){
			alert("이름을 다시 입력하세요.");
			return false;
		}
		if(!signup.ssan.value){
			alert("주민등록번호를 입력하세요.");
			return false;
		}
		if(!ssanReg.test(signup.ssan.value) || regExp.test(signup.ssan.value)){
			alert("주민등록번호를 다시 입력하세요. ( - 포함)");
			return false;
		}
		if(!signup.nick.value){
			alert("닉네임을 입력하세요.");
			return false;
		}
		if(!phonReg.test(signup.ph.value)){
			alert("핸드폰 번호를 다시 입력하세요.");
			return false;
		}
		if(!emailReg.test(signup.email.value)){
			alert("이메일 주소를 다시 입력하세요.");
			return false;
		}
		if(!nickReg.test(signup.nick.value) || regExp.test(signup.nick.value)){
			alert("닉네임은 2~10자 사이의 영문, 한글, 숫자만 가능합니다.");
			return false;
		}

	}
</script>
