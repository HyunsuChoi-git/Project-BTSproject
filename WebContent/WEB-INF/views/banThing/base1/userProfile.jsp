<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보</title>
<link rel="stylesheet" href="<c:url value="/resources/css/base1/userProfile.css?v"/>">
</head>
<body>
	<div class="deal">
		아이디:<input type="text" name="id" value=" ${user.id}" class="btn" readonly="readonly"><br/>
		닉네임:<input type="text" name="nick" value=" ${user.nick}"><br/>
		이름:<input type="text" name="product" class="btn" value="${user.name}"><br/>
		성별:<input type="text" name="price" class="btn" value="${user.gender}"><br/>
		주소:<input type="text" name="place" class="btn" value="${user.addr}"><br/>
		이메일:<input type="text" name="place" class="btn" value="${user.email}"><br/>
		<button onclick="window.close()">닫기</button>
	</div>
</body>
</html>