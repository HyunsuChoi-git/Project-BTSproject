<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="<c:url value="/resources/css/base1/login.css?val=1"/>">

<div id="index">
	<div class="name">
		<img width="480" height="160" src="<c:url value="/resources/img/logo.jpg"/>"></h1>
	</div>
	<div class="login">
		<form id="login" action="login.1" method="post">
			<input type="text" id="id" name="id" class="btn" placeholder="ID"><br/>
			<input type="text" id="pw" name="pw" class="btn" placeholder="PW">
			<br/><br/><br/>
			<div class="btn-setting">
				<input type="submit" class="btn btn-info" value="일반 로그인" onclick="return loginCheck()"><br/>
				<button type="button" class="btn btn-warning" onclick="kakao()">
					카카오톡 로그인
				</button><br/>
				<button type="button" onclick="window.location.href='signup.1'" class="btn btn-danger">
					일반 회원가입
				</button><br/>
				<button type="button" onclick="unMember()" class="btn btn-primary">
					비회원 로그인
				</button>
			</div>
		</form>
	</div>
</div>
<script>
	function unMember(){
		var check=confirm("비회원으로 로그인시 일부 기능들을 사용하실 수 없는데 괜찮방구?");
		if(check){
			alert("뿡");
			window.location.href='map-setting.1';
		}else{
			alert("회원가입을 해서 모든 기능을 이용하세요!");
			return false;
		}
	}
</script>
<c:if test="${ signup eq 'success' }">
	<script>
		alert('회원가입이 완료되었습니다.');
	</script>
</c:if>
<c:if test="${ check eq 'err' }">
	<script>
		alert('아이디와 비밀번호를 확인하세요.');
	</script>
</c:if>
<c:if test="${ logout eq 'success' }">
	<script>
		alert('로그아웃이 완료되었습니다.');
		window.location.href="login.1";
	</script>
</c:if>
<c:if test="${sessionId!=null}">
	<script>
		alert('현재 로그인 중 입니다.');
		window.location.href="map-setting.1";
	</script>
</c:if>
<script>
	/* 일반 */
	function loginCheck(){
	  if ($('#id').val() == '' || $('#pw').val() == ''){
	    alert('아이디 혹은 비밀번호를 입력하세요.');
	    return false;
	  }
	}
	/*카카오 */
	function kakao(){
		var app_key='f3009baa4d561e7bb39263c63ba9a21b';
		var redirect_uri= 'http://192.168.0.136:8080/BTS/banThing/kakaologin';
		var kakao_url='https://kauth.kakao.com/oauth/authorize?client_id='
				+app_key+'&redirect_uri='+redirect_uri
				+'&response_type=code';
		open(kakao_url, "카카오" , "toolbar=no, status=no, menubar=no, scrollbars=no, resizalbe=no, width=600px, height=600px,left=400px,top=200px");
	}
</script>
