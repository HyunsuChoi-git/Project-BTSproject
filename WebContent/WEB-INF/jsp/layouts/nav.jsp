<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<link rel="stylesheet" href="<c:url value="/resources/css/nav.css?val=4"/>">
<div class="container-fluid" style="padding-right:12px">
	<div class="navbar-header" style="margin:0 auto; width:100%">
	  <!-- 웹 -->
		<div class="top-box2">
			<div class="name-set">
				<h1><strong><a href="index.2">반띵</a></strong></h1>
				<a href="index.2"><img width="170" height="170" src="<c:url value="/resources/img/logo.png"/>"></a>
				<hr>
			</div>
			<div class="catergory-set">
				<ul>
					<li><h2><a href="#" id="web_FooterBtn5">공지 사항</a></h2></li>
					<c:if test="${sessionId!=null}">
						<li><h2><a href="#" id="web_FooterBtn1">채팅방 개설</a></h2></li>
						<li><h2><a href="#" id="web_FooterBtn2">맵 필터 설정</a></h2></li>
						<li><h2><a href="#" id="web_FooterBtn4">모든 채팅방</a></h2></li>
						<li><h2><a href="#" id="web_FooterBtn3">내 채팅방</a></h2></li>
						<li><h2><a href="#" id="web_FooterBtn6">회원 정보</a></h2></li>
						<li><h2><a href="#" onclick="logout()">로그 아웃</a></h2></li>
					</c:if>
					<c:if test="${sessionId==null}">
						<li><h2><a href="login.1">로그인</a></h2></li>
					</c:if>
				</ul>
			</div>
		</div>
	<!-- 앱 -->
		<div class="rows top-box">
			<div class="col-xs-4">
				<h1><strong>(로고)</strong></h1>
			</div>
			<div class="col-xs-4">
				<h1><strong>반띵</strong></h1>
			</div>
			<div id="myroom-setting" class="col-xs-4">
				<a href="#" id="myroom"><i class="fas fa-sms fa-4x"></i></a>
			</div>
		</div>
	</div>
</div>
 <script>
 	function logout(){
 		var check=confirm("진짜 로그아웃 할꾸얌? 나 무져웡ㅠ_ㅠ");
 		if(check){
 			window.location.href="logout";
 		}else{
 			alert("잘 생각했어!");
 			return false;
 		}
 	}
 </script>   
