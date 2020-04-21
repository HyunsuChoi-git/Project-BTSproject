<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="<c:url value="/resources/css/base1/updateChat.css?asdss"/>">
<style>

</style>
<div id="index">
	<div class="name" style="margin-bottom:10px;">
		<img width="390" height="150" src="<c:url value="/resources/img/logo.jpg"/>">
	</div>
	<div class="signup-setting">
			<form name="web_RoomSet" class="web_RoomSet" action="updateChat" method="post" enctype="multipart/form-data">
           		<input type="hidden" name="id" value="${sessionId}"/>
           		<input type="hidden" name="num" value="${vo.num}"/>
           		<input type="hidden" name="img" value="${vo.img}"/>
           		
           		<span>방 제목:</span><input type="text" class="btn" name="title" placeholder="방제목" value="${vo.title }"><br/>
				<span>카테고리:</span><select class="btn" name="options" id="optionsSelect">
						<option value="">카테고리 설정</option>
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
				</select><br/>
				
				<span>키워드:</span><input type="text" class="btn" name="tag" placeholder="#해쉬태그, #이렇게, #작성하세요," value="${vo.tag }"><br/>
				<span>상품 이름:</span><input type="text" class="btn" name="product" placeholder="상품이름" style="width:140px;" value="${vo.product}"><br/>
				<span>상품 가격:</span><input type="text" class="btn" name="price" placeholder="상품가격" style="width:140px;" value="${vo.price }"><br/>
				
				<span>거래 방식:</span><select class="btn" name="pay" id="paySelect" value="${vo.pay}" >
					<option value="">거래 방식</option>
					<option value="협의">협의</option>
					<option value="만나서">만나서</option>
					<option value="계좌이체">계좌이체</option>
					<option value="안전거래">안전거래</option>
				</select><br/>
				
				<span>성별:</span><select class="btn" name="gender" style="width:140px;" id="genderSelect" value="${vo.gender }" >
					<option value="">성별</option>
					<option value="무관">무관</option>
					<option value="여자">여자</option>
					<option value="남자">남자</option>
				</select><br/>
				
				<span>인원 수:</span><select class="btn" name="personnel" style="width:140px;" id="personnelSelect" value="${vo.personnel }">
					<option value="">인원수</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
				</select><br/>
				
				<span>만남 장소:</span><input type="text" class="btn" name="place" id="place" placeholder="거래 장소" style="width:220px;" readonly="readonly" value="${vo.place}">
				<input type="hidden" name="placeInfo" id="placeInfo" >
				<input type="button" class="btn" value="검색" onclick="address_setting()" style="width:60px;"><br>
				<span>상품 이미지:</span><input style="display: inline-block;" type="file" id="file" class="btn" name="orgImg" placeholder="상품 이미지" ><br/>
				<span>내용 :</span><textarea style="margin-bottom:5px;" name="content" cols="50" rows="6" class="btn">${vo.content}</textarea>
		        <button type="button" class="btn web_Exit" id="web_RoomExitBtn">닫기</button>
		        <button class="btn web_RoomOpen" id="web_RoomOpenBtn" onclick="submit" >수정</button>
           </form>
	</div>
</div>

<c:if test="${update == 'success'}">
	<script>
		alert('채팅방 수정이 완료되었습니다.');
		self.close();
	</script>
</c:if>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 유효성 검사 & 정규식 표현 -->
<script>

	$(document).ready(function () {
		// option값으로 자동 셀렉 (selected)
		$("#paySelect").val("${vo.pay}");
		$("#optionsSelect").val("${vo.options}");
		$("#genderSelect").val("${vo.gender}");
		$("#personnelSelect").val("${vo.personnel}");
	});
	function address_setting(){
	    new daum.Postcode({
	        oncomplete: function(data) {
	        	$("#place").val(data['address']);
	        }
	    }).open();
	}

</script>
