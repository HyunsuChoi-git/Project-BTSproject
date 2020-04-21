<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
  
<script>
	//실행시 카카오 로그인시 apiLogin.1 팝업창 띄움
	opener.location.href="http://localhost:8080/BTS/banThing/apiLogin.1?id=${userInfo.id}"+
	"&nickname=${userInfo.nickname}&name=${userInfo.name}&email=${userInfo.email}";
	self.close();
</script>
</body>
</html>