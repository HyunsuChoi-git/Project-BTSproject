<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="<c:url value="/resources/css/base1/dealDetail.css"/>">
<!DOCTYPE html>

 <div id="index">
	<div class="name">
		<h1 class="bts">반띵</h1>
		<h1>(로고)</h1></br>
		<h3 class="bts">거래 정보</h3>
		<h4 style="color:white">동의 ? 보감!!!!!!!!</h4>
	</div>
	<div class="deal">
		<form action="#" id="a" method="post">
			아이디:<input type="text" name="id" value="${sessionId}" class="btn" readonly="readonly"><br/><br/>
			<input type="hidden" name="num" value="${vo.num}">
			<input type="hidden" name="users" value="${vo.users}">
			상품 이름:<input type="text" name="product" class="btn" value="${vo.product}" readonly="readonly"><br/><br/>
			상품 가격:<input type="text" name="price" class="btn" value="${vo.price}" readonly="readonly"><br/><br/>
			장소:<input type="text" name="place" class="btn" value="${vo.place}" readonly="readonly"><br/><br/>
			<c:if test="${param.state==0}">
				<input type="submit" id="go" class="btn btn-info" value="동의"/>&nbsp;&nbsp;&nbsp;
				<button type="button" class="btn btn-info">거절</button><br/>
			</c:if>
		</form>
	</div>
</div>

<script>
	//동의 버튼 클릭시 form태그 submit 실행과 동시에 페이지 닫힘
	$("#go").click(function(){
		$("#a").attr("action","#");
		self.close();
	})
</script>
