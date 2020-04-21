<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="<c:url value="/resources/css/base1/map-setting.css?val=6"/>">

<div id="index">
<!--  -->
	<div class="name">
		<img width="480" height="160" src="<c:url value="/resources/img/logo.jpg"/>"></h1>
	</div>
	<div class="map-name">
		<h1 style="margin-top: 30px;padding-bottom: 30px;">맵 필터 설정</h1>
	</div>
	<div class="map-setting">
		<div><br/>
			<select id="address1" class="btn">
				<option value="1">서울</option>
				<option value="2">부산</option>
				<option value="3">광주</option>
				<option value="4">울산</option>
				<option value="5">인천</option>
			</select>
		</div>
		<br/>
		<select id="options" class="btn">
			<option value="">카테고리 설정</option>
			<option value="전체">전체</option>
			<option value="의류잡화">의류/잡화</option>
			<option value="뷰티">뷰티</option>
			<option value="식품">식품</option>
			<option value="유아">유아</option>
			<option value="생활용품">생활용품</option>
			<option value="가전">가전</option>
			<option value="스포츠">스포츠/레저</option>
			<option value="자동차용품">자동차 용품</option>
			<option value="도서음반">도서/음반/DVD</option>
			<option value="취미">취미</option>
			<option value="오피스">문구/오피스</option>
			<option value="반려동물">반려동물용품</option>
			<option value="헬스">헬스/건강식품</option>
			<option value="여행">여행/티켓</option>
		</select><br/><br/>
		<input type="text" id="tag" class="btn" placeholder="키워드" />
	</div>
	<div class="btn-setting">
		<button type="submit" onclick="tossvl()" class="btn btn-info">
			적용
		</button>
		<button type="button" onclick="window.location.href='index.2'" class="btn btn-info">
			전체
		</button>
	</div>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a44d7ff9bef3120be5c58e8aa20ddfe0&libraries=services,clusterer,drawing"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	var res="";
	function address_setting(){
	    new daum.Postcode({
	        oncomplete: function(data) {
	            $("#address").text(data["address"]);
	            console.log(data);
	            var Geocoder = new kakao.maps.services.Geocoder();
	        	Geocoder.addressSearch(data.address,function(result, status){
	        		 if (status === kakao.maps.services.Status.OK) {
	        				console.log(result);
	        				console.table(result);
	        		        console.log(result[0].y);
	        		        console.log(result[0].x);
	        		        res = result;
	        		        return res;
	        		 }
	        	});
	        }
	    }).open()
	}
	
	function tossvl(){
		var addr = $("#address1 option:selected").val();
		var options = '';
		if ($("#options option:selected").val() == '') {
			alert('카테고리를 선택하세요');
			return false;
		}else options = $("#options option:selected").val();
		var tag = $('#tag').val();
		window.location.href="index.2?addr="+addr+"&options="+options+"&tag="+tag;
	}
</script>