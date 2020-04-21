<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="<c:url value="/resources/css/base1/dealStart.css"/>">
<!DOCTYPE html>
<style>

</style>
<div id="index">
	<div class="name">
		<h1 class="bts">반띵</h1>
		<h1>(로고)</h1></br>
		<h3 class="bts">거래 정보</h3>
		<h4 style="color:white">아이디를 제외한 나머지는 변경하셔도 괜찮습니다.</h4>
	</div>
	<div class="deal">
		<form action="#" id="a" method="post">
			아이디:<input type="text" name="id" value="${vo.id}" class="btn" readonly="readonly"><br/><br/>
			<input type="hidden" name="num" value="${vo.num}">
			상품 이름:<input type="text" name="product" class="btn" value="${vo.product}"><br/><br/>
			상품 가격:<input type="text" name="price" class="btn" value="${vo.price}"><br/><br/>
			장소:<input type="text" name="place" class="btn" value="${vo.place}"><br/><br/>
			<input type="submit" id="go" class="btn btn-info" value="확인"/><br/>
		</form>
	</div>
</div>

<script>
	//동의 버튼클릭시 submit 실행과 동시에 페이지 닫힘
	$("#go").click(function(){
		$("#a").attr("action","#");
		self.close();
	})
</script>
	
