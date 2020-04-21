<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>제목</title>
   	<tiles:insertAttribute name="top"/>
<link rel="stylesheet" href="<c:url value="/resources/css/template.css?val=5"/>">
</head>
<body>

<div class="container">
  <div class="jumbotron">
		<nav id="nav">
			<tiles:insertAttribute name="nav"/>
		</nav>  
  		<section id="section">
			<tiles:insertAttribute name="content"/>
		</section>
		<footer id="footer">
			<tiles:insertAttribute name="footer"/>
		</footer>
  </div>
</div>

</body>
</html>