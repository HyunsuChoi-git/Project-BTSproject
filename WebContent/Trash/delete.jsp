<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="<c:url value="/resources/css/base1/delete.css"/>">
<c:if test="${update eq 'success'}">
	<script>
		alert('본인인증 성공.');
	</script>
</c:if>

<div id="index">
	<div class="name">
		<h1 class="bts">반띵</h1>
		<h1 class="bts">(로고)</h1>
		<h3 class="bts">탈퇴확인</h3>
	</div>
	<div class="signup-setting">
		<br/>
		<form name="deleteForm" action="delete.1"  method="post">
			<button onclick="window.location.href='delete.1'" class="btn btn-info">
				탈퇴
			</button>
		</form>
		<button onclick="window.location.href='member.2'" class="btn btn-info">
			뒤로가기
		</button>
	</div>
</div>
