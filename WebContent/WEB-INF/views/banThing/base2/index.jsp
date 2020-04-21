<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="<c:url value="/resources/css/base2/index.css?val=5"/>">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a44d7ff9bef3120be5c58e8aa20ddfe0&libraries=clusterer,services"></script>
<script  src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script> 
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">

<!-- 웹 -->
<div class="web">
	<div style="width:100%;height:100%;position:relative;">
	
 		<!-- 웹 1. 맵 -->
		<div id="web_Map"></div>
		
		<!-- 웹 2. 맵 아이콘  왼쪽/아래쪽/오른쪽-->
		<div class="web_Icon" style="left:10px">
			<a href="#" id="web_refresh" style="left:10;"><i class="fas fa-redo-alt fa-2x"></i></a>
		</div>
		<div class="web_Icon" style="right:10px">
		<c:if test="${sessionId!=null}">
			<a href="#" id="web_MyRoomBtn"><i class="fas fa-sms fa-2x"></i></a>
			<a href="#" id="web_RoomBtn"><i class="fas fa-plus fa-2x"></i></a>
		</c:if>
			<a href="#" id="web_MapFilterBtn"><i class="fas fa-filter fa-2x"></i></a>
		</div>
		<div class="web_Icon" style="right:0px;top:50%">
			<a href="#" id="web_AllRoomBtn"><i class="fas fa-arrow-left fa-2x"></i></a>
		</div>
		<div class="web_Icon" id="web_AllRoomClose" style="right:0px;top:50%;display:none">
			<a href="#" id="web_AllRoomBtn2"><i class="fas fa-arrow-right fa-2x"></i></a>
		</div>
		
		<!--웹 3. 방 개설  -->
		<div class="web_Room">
			<h1> 방 개설</h1>
			<!-- 웹 방 개설 셋팅 -->   
				<form name="web_RoomSet" class="web_RoomSet" action="submit" onsubmit="return check()" method="post" enctype="multipart/form-data">
	           		<input type="hidden" name="id" value="${sessionId}"/>
	           		<input type="text" class="btn" name="title" placeholder="방제목"><br/>
					<select class="btn" name="options">
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
					<input type="text" class="btn" name="tag" placeholder="#해쉬태그, #이렇게, #작성하세요,"><br/>
					<input type="text" class="btn" name="product" placeholder="상품이름" style="width:140px;">
					<input type="text" class="btn" name="price" placeholder="상품가격" style="width:140px;"><br/>
					<select class="btn" name="pay">
						<option value="">거래 방식</option>
						<option value="협의">협의</option>
						<option value="만나서">만나서</option>
						<option value="안전거래">안전거래</option>
					</select><br/>
					<select class="btn" name="gender" style="width:140px;">
						<option value="">성별</option>
						<option value="무관">무관</option>
						<option value="여자">여자</option>
						<option value="남자">남자</option>
					</select>
					<select class="btn" name="personnel" style="width:140px;">
						<option value="">인원수</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
						<option value="6">6</option>
					</select>
					<input type="text" class="btn" name="place" id="place" placeholder="거래 장소" style="width:220px;" readonly="readonly">
					<input type="hidden" name="placeInfo" id="placeInfo" >
					<input type="button" class="btn" value="검색" onclick="address_setting()" style="width:60px;"><br/>
					<input type="file" class="btn" name="orgImg" placeholder="상품 이미지"><br/>
					<textarea name="content"> 내용 </textarea>
			        <button type="button" class="btn web_Exit" id="web_RoomExitBtn">닫기</button>
			        <button class="btn web_RoomOpen" id="web_RoomOpenBtn" onclick="submit" >개설</button>
	           </form>
	   </div>
	   
		<!-- 4. 맵 필터 설정  -->
		<div class="web_MapFilter">
		    <div class="web_MFName">
       			<br/>
				<h1>맵 필터 설정</h1>
			</div>
			<div class="web_MFSetting">
				<select class="btn" id="address1">
					<option value="1">서울</option>
					<option value="2">부산</option>
					<option value="3">광주</option>
					<option value="4">울산</option>
					<option value="5">인천</option>
				</select>
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
				</select><br/>
				<input type="text" id="tag" class="btn" placeholder="검색어" />
			</div>
			<div class="btn web_MFBtn">
				<button onclick="tossvl()" class="btn">
					적용
				</button>
				<button onclick="window.location.href='index.2'" class="btn">
					전체
				</button><br/><br/>
				<button class="btn exit3" id="web_MapFilterExitBtn">닫기</button>
			</div>
		</div>
	   
	<!-- 5.내 채팅 목록  -->
		<div class="web_MyRoom">
			<div class="btn-setting">
				<br/>
				<button id="button"  value="1" >내가 만든방</button>
				<button id="button1"  value="2" >들어간 방</button>
			</div>
			<!-- 내가 만든 채팅방 -->
			<div class="web_MyRoom_Me" style="display:none;overflow:auto;height:80%;">
				<div class="name">
					<h3 class="bts">내가 만든 채팅방</h3>
				</div>
				<div class="login">
					<table class="table" style="width:100%;">
						<thead>
							<tr>
								<td>방제목</td>
								<td>상품명</td>
								<td>최대인원</td>
								<td>지역</td>
							</tr>
						</thead>
						<tbody id="web_MyRoom_MeBody">
						</tbody>
					</table>
				</div>
			</div>
			<!-- 내가 들어간 채팅방 -->
			<div class="web_MyRoom_You" style="display:none;overflow:auto;height:80%;">
				<div class="name">
					<h3 class="bts">내가 들어간 채팅방</h3>
				</div>
				<div class="login">
					<table class="table" style="width:100%;">
						<thead>
							<tr>
								<td>방제목</td>
								<td>상품명</td>
								<td>최대인원</td>
								<td>지역</td>
							</tr>
						</thead>
						<tbody id="web_MyRoom_YouBody">
						</tbody>
					</table>
				</div>
			</div>
           <button class="btn web_Exit" id="web_MyRoomExitBtn">닫기</button>
       </div>
	
	<!-- 6.전체 채팅 목록  -->
		<div class="web_AllRoom">
			<!-- 방 상세보기 -->
			<div class="web_AllRoomDetail" style="display:none;width:100%;height:100%;font-size:30px;">
				<h1 style="color:black">방 정보</h1>
				<table class="table" id="web_ARDTable">
			    </table>
			    <div id='roomContent'>
			    </div>
			</div>
			<!-- 방 목록 보기 -->
			<div class="web_AllRoomView">
				<h1 style="color:black">채팅 목록</h1>
				<table class="table">
		     		<thead>
			      		<tr>
				          <td><strong>번호</strong></td>
				          <td><strong>방 제목</strong></td>
				          <td><strong>인원수</strong></td>
				          <td><strong>방 정보</strong></td>
				          <td><strong></strong></td>
				        </tr>
		     		</thead>
			    	<tbody id="web_ARTbody">
			    	</tbody>
			    </table>
		    </div>
		</div>
		
		<!-- 7.공지사항 -->
		<div class="web_Notice" style="display:none;">
			<div class="web_NoticeDetail" style="display:show;overflow:auto;height:80%;">
				<h1 style="color:black">공지 사항</h1>
					<table class="table">
				      <thead>
				        <tr>
				          <th>#</th>
				          <th>제목</th>
				          <th>내용</th>
				          <th>등록일</th>
				          <c:if test="${sessionId eq 'admin'}">
				          <th><button id="web_NoticewriteBtn">글작성</button></th>
				          </c:if>
				        </tr>
				      </thead>
				      <tbody id="web_Notice_body">
					  </tbody>
			    </table>
		    </div>
		    <!-- 공지사항 작성 -->
			<div class="web_Noticewirte" style="display:none;overflow:auto;height:80%;">
				<h1 style="color:black">공지 사항 작성</h1>
						<table class="table">
					      <tbody>
					        <tr>
					          <td>제 목</td>
					          <td><input type="text" id="notice_title"style="width:280px;"placeholder="t i t l e"></td>
					        </tr>
					        <tr>
					          <td>공지내용</td>
					          <td><textarea id="notice_content" style="width:280px; height:250px;" placeholder="c o n t e n t"></textarea></td>
					        </tr>
				    </table>
				     <button id="back_notice">뒤로가기</button>
				    <c:if test="${sessionId eq 'admin'}">
				          <button id="upload_not">확인</button>
					</c:if>
		    </div>
		    <button class="btn web_Exit" id="web_NoticeExitBtn">닫기</button>
		</div>
		
		<!-- 8.회원 정보 -->
		<div class="web_Member">
			<div id="member-set" class="icon_set">
				<br/>
				<button class="btn btn-warning" style="font-size: 26px;width:230px;" onclick="window.location.href='update.1'">
					사용자 정보 변경
				</button><br/>
				<button class="btn btn-warning" style="font-size: 26px;width:230px;" onclick="delMember()">
					회원 탈퇴
				</button><br/>
			</div>
			<button class="btn web_Exit" id="web_MemberExitBtn">닫기</button>
		</div>
		
	</div>
</div>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	//1-1 맵 표시
	var map = new kakao.maps.Map(document.getElementById('web_Map'), { // 지도를 표시할 div
		    center : new kakao.maps.LatLng("${lat}", "${lng}"), // 지도의 중심좌표 
		    level :"${level}"
	});
	
	//1-2 이벤트 별 맵 마킹
	//새로고침시 마킹
	$("#web_refresh").click(function(){
		marking();
	})
	
	//시작할때 마킹
	$(document).ready(function(){
		marking();
	}) 
	
	//이동시 마킹
	kakao.maps.event.addListener(map, 'dragend', function() {        
		marking();
	});
	
	//마커 이쁘게 만드는거
	function addMarker(position, idx) {
	   var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	       imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
	       imgOptions =  {
	           spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
	           spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	           offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	       },
	       markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	           marker = new kakao.maps.Marker({
	           position: position, // 마커의 위치
	           image: markerImage 
	       });
	
	   marker.setMap(map); // 지도 위에 마커를 표출합니다
	
	   return marker;
	}

	//1-3 맵 마킹
	function marking(){
		$.ajax({
			url:"chatinfo",
	       type: 'get',
	       dataType:'json',
	       traditional : true,
	       data: {'search' : ['${lat}','${lng}','${level}','${options}','${tag}']},
	       contentType:"application/json;charset=UTF-8",
			success:function(data){
				chatInfo=data['chatList'];
			    var bounds = map.getBounds();
			    var sw = bounds.getSouthWest();  //남서쪽
			    var ne = bounds.getNorthEast(); //북동쪽 
			    var lb=new kakao.maps.LatLngBounds(sw, ne);
			    let result="";
		    	var count=0;
				$(data['chatList']).map(function(index, i) {
					var x=i.placeInfo.split('-')[0];
					var y=i.placeInfo.split('-')[1];
				    var markerposition=new kakao.maps.LatLng(y,x);
				    if(lb.contain(markerposition)){
			    		var marker=addMarker(markerposition,count);
			    		var nowUsers=i.users.split(',').length-1;
				    	count++;
				    	/*방 정보 */
			    		result +="<tr>";
			    		result +="<td>"+count+"</td>";
			    		result +="<td>"+i.title+"</td>";
			    		result +="<td>"+nowUsers+"/"+i.personnel+"</td>";
			    		result +="<td>"+"<button onclick='roomDetail("+i.num+","+nowUsers+")' class='btn'>상세보기</button>"+"</td>";
			    		if("${sessionId}"!=""){
				    		if(nowUsers==i.personnel){
				    			if(i.users.split(',').includes("${sessionNick}")){
					    			result +="<td>"+"<button class='btn' onclick='chatGo("+i.num+")'>입장</button>"+"</td>";
				    			}else{
				    				result +="<td>"+"<button class='btn' onclick='fullChat()'>입장</button>"+"</td>";
				    			}
				    		}else{
				    			result +="<td>"+"<button class='btn' onclick='chatGo("+i.num+")'>입장</button>"+"</td>";
				    		}
			    		}
			    		result +="</tr>";
	
				    }				    
					$("#web_ARTbody").html(result);
				});
			}
		});
	}
	
	//3-1 방 개설 주소검색
	function address_setting(){
	    new daum.Postcode({
	        oncomplete: function(data) {
	            $("#place").val(data["address"]);
	            console.log(data);
				var geocoder = new kakao.maps.services.Geocoder();
	        	geocoder.addressSearch(data.address,function(result, status){
	        		 if (status === kakao.maps.services.Status.OK) {
	        		        $("#placeInfo").val(result[0].x+"-"+result[0].y);
	        		        console.log(result[0].x+"-"+result[0].y);
	        		 }
	        	});
	        }
	    }).open();
	}
	
	//4-1 맵 필터 설정
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
	
	// 5-1 내가 들어간 채팅방 
	$("#button").click(function(){
		$(".web_MyRoom_You").hide(500);
		$(".web_MyRoom_Me").show(500);
		
		var root = $(this).attr('value');
		var detail="";
		$.ajax({
			url:'mychat',
	        type: 'get',
	        data: { num:root},
	        dataType:'json', 
	        contentType:"application/json;charset=UTF-8",
			success:function(data){
				var mychat=data['myChat'];
				mychat.forEach(function(i){
					detail +='<tr><td>'+i.title+'</td>';
					detail +='<td>'+i.product+'</td>';
					detail +='<td>'+i.personnel+'</td>';
					detail +='<td>'+i.place+'</td></tr>';
				})
				$("#web_MyRoom_MeBody").html(detail);
	 		}
		});
	});
	
	// 5-1 내가 만든 채팅방
	$("#button1").click(function(){
		$(".web_MyRoom_Me").hide(500);
		$(".web_MyRoom_You").show(500);
		
		var root = $(this).attr('value');
		var detail="";
		$.ajax({
			url:'mychat',
	        type: 'get',
	        data: { num:root},
	        dataType:'json', 
	        contentType:"application/json;charset=UTF-8",
			success:function(data){
				var mychat=data['myChat'];
				mychat.forEach(function(i){
					detail +='<tr><td>'+i.title+'</td>';
					detail +='<td>'+i.product+'</td>';
					detail +='<td>'+i.personnel+'</td>';
					detail +='<td>'+i.place+'</td></tr>';
				})
				$("#web_MyRoom_YouBody").html(detail);
	 		}
		});
	});
	
	//6-1 방 입장시 꽉찼을때 이벤트
	//풀방 X 입장 O + 풀방O 입장 O (내 방일시)
	function chatGo(num){
		window.location.href='chat.2?num='+num;
	}
	
	//풀방 O 입장 X
	function fullChat(){
		alert("유감스럽게도 꽉찼어요 ㅠ-ㅠ,,");
	}
	
	//6-2 방 상세보기 내에 버튼 이벤트
	function AllRoomDetailBack(){
        $(".web_AllRoomDetail").fadeOut();
        $(".web_AllRoomView").fadeIn();
    }
	
	//6-3 방 상세보기 이벤트
	function roomDetail(num, nowUsers){
		var detail="";
		var detail2="";		
		var room='';
		chatInfo.forEach(function(i,index){
			if(i.num==num){
				room=chatInfo[index];
			}
		})
		/*방 상세정보  */
		detail +='<tr><td class="strong" colspan="4"><h3 style="margin-top:2px;margin-bottom:15px;">제목 :'+room.title+'</h3>';
		detail +='<h4>상품명 : &nbsp'+room.product+'&nbsp &nbsp &nbsp 글쓴이 : &nbsp'+room.nick+'</h4><h5><a href="#">상품사진보기</a></h5></td></tr>';
		
		detail +='<tr><td class="strong" colspan="2">';		
		detail +='<h5 align="right">카테고리&nbsp &nbsp &nbsp</h5></td> <td class="strong" colspan="2"><h4 align="left">&nbsp &nbsp'+room.options+'</h4></td></tr>';	
		
		detail +='<tr><td class="strong" colspan="2"><h5>거래 방식</h5> <h4>'+room.pay+'</h4></td>';
		detail +='<td class="strong" colspan="2"><h5>상품 가격</h5> <h4>'+room.price+' 원</h4></td></tr>';
		detail +='<tr><td class="strong" colspan="2"><h5>참여 가능한 성별</h5> <h4>'+room.gender+'</h4></td>';
		detail +='<td class="strong" colspan="2"><h5>참여 인원</h5> <h4>'+nowUsers+'/'+room.personnel+'명</h4></td></tr>';
		
		detail2 +='<div>'+room.content+'</div>';
		detail2 +='<h5>검색 키워드 : &nbsp '+room.tag+'</h5>';
		detail2 +="<button onclick='AllRoomDetailBack()' class='btn'>뒤로가기</button> &nbsp &nbsp ";
		if("${sessionId}"!=""){
			detail2 +="<button class='btn' onclick='chatGo("+num+")'>입장</button>";
		}
		$("#web_ARDTable").html(detail);
		$("#roomContent").html(detail2);
		$(".web_AllRoomView").fadeOut();
		$(".web_AllRoomDetail").fadeIn();
	}
	
	//6-4 방개설 유효성 검사
 	function check(){
		var chat = document.web_RoomSet;

		var regExp = /\s/g;
		var priceReg = /^[0-9]{3,19}$/g;
		var productReg = /^[가-힣ㄱ-ㅎㅏ-ㅣA-za-z0-9]{1,20}$/g;
		var titleReg = /^(?=[\S\s]{1,30}$)[\S\s]*/
		
		if(!chat.id.value){
			alert("로그인 후 이용가능합니다.");
			window.location.href="login.1";
			return false;
		}
		
 		if(!chat.title.value){
			alert("제목을 입력하세요.");
			return false;
		}
 		if(!titleReg.test(chat.title.value)){
			alert("제목 : 최대 30자, 특수문자 제외");
			return false;
		}
		if(chat.options.value == ""){
			alert("카테고리를 선택하세요.");
			return false;
		}
		if(!productReg.test(chat.product.value)){
			alert("상품이름 : 최대 20자, 특수문자 제외");
			return false;
		}
		if(!priceReg.test(chat.price.value)){
			alert("상품가격 : 숫자만 작성 가능");
			return false;
		}
		if(chat.pay.value == ""){
			alert("거래방식을 선택하세요.");
			return false;
		}
		if(chat.gender.value == ""){
			alert("성별을 선택하세요.");
			return false;
		}
		if(chat.personnel.value == ""){
			alert("인원수를 선택하세요.");
			return false;
		}
		if(!chat.place.value){
			alert("거래 장소를 선택하세요.");
			return false;
		}
		if(!chat.orgImg.value){
			alert("상품 이미지를 등록하세요.");
			return false;
		}
		
	}

	//7-1 공지사항 글작성 버튼 이벤트
	$("#web_NoticewriteBtn").click(function(){
		$(".web_NoticeDetail").hide(500);
		$(".web_Noticewirte").show(500);
		
	});
	
	//7-2 Bts_Notice 공지사항 정보 가져오기
	$("#web_FooterBtn5").click(function(){
		getnotice();
	});
	
	//Bts_Notice 정보 가져오기
	function getnotice(){
		var cont="";
		var num=1;
		$.ajax({
			url:"chnotice",
			type:'get',
			dataType:'json',
			contentType:"application/json;charset=UTF-8",
			success:function(data){
				var noti = data['notice'];
				console.log(noti);	
				noti.forEach(function(i){
					var reg=i.reg.split(" ")[0];
					cont += '<tr><td>'+num+'</td>';
					cont += '<td>'+i.title+'</td>';
					cont += '<td>'+i.content+'</td>';
					cont += '<td>'+reg+'</td></tr>';
					num++;
				})	
				$("#web_Notice_body").html(cont);
				$(".web_Notice").fadeToggle(500);
			}
		});
	}
	
	//7-3 공지사항 버튼 클릭 이벤트
	$("#back_notice").click(function(){
		$(".web_Noticewirte").hide();
		$(".web_NoticeDetail").show();
	});

	//7-4 공지사항 글작성 이벤트
	$("#upload_not").click(function(){
		var cont="";
		var num=1;
		var a = $("#notice_title").val();
		var b = $("#notice_content").val();
		$.ajax({
			url:"notice",
			type:'get',
			data:{title:a,content:b},
			dataType:'text',
			contentType:"application/text;charset=UTF-8",
			success:function(data){
				getnotice();
				$(".web_Noticewirte").fadeOut();
				$(".web_NoticeDetail").fadeIn(500);
			}
		});
	});
	
	//8-1회원 탈퇴
	function delMember(){
		var check=confirm("진짜룽 회원탈퇴 하꾸얌?ㅠ-ㅠ,,!!? 나 무져웡");
		if(check){
			window.location.href="delete";
		}else{
			alert("잘 생각했어!");
			return false;
		}
	}

	//각 버튼별 이벤트 처리
	$(document).ready(function(){
       		web_AddRoom=function(){
            $(".web_Room").fadeToggle(500);
        },
        	web_MapFilter=function(){
            $(".web_MapFilter").fadeToggle(500);
        },
        	web_MyRoom=function(){
            $(".web_MyRoom").fadeToggle(500);
        },
        	web_AllRoom=function(){
            $(".web_AllRoom").toggle(500);
			$("#web_AllRoomBtn").toggle(500);            
			$("#web_AllRoomClose").toggle(500);            
        },
        	web_AllRoom2=function(){
            $("#web_AllRoomClose").toggle(500); 
            $(".web_AllRoom").toggle(500);
            $("#web_AllRoomBtn").toggle(500);  
        },
        	web_Member=function(){
            $(".web_Member").fadeToggle(500); 
        },
        	web_Exit=function(){
            $(".web_Room").fadeOut();
            $(".web_MapFilter").fadeOut();
            $(".web_Notice").fadeOut();
            $(".web_Member").fadeOut();
            $(".web_MyRoom").hide(500);
        };
		//웹 
		//1.방 개설
		$("#web_RoomBtn").click(web_AddRoom);
		$("#web_FooterBtn1").click(web_AddRoom);
		$("#web_RoomExitBtn").click(web_Exit);
		
		//2.맵필터 
		$("#web_MapFilterBtn").click(web_MapFilter);
		$("#web_FooterBtn2").click(web_MapFilter);
		$("#web_MapFilterExitBtn").click(web_Exit);
		
		//3.내채팅방
		$("#web_MyRoomBtn").click(web_MyRoom);
		$("#web_FooterBtn3").click(web_MyRoom);
		$("#web_MyRoomExitBtn").click(web_Exit);
		
		//4.전체 채팅방
		$("#web_AllRoomBtn").click(web_AllRoom);
		$("#web_FooterBtn4").click(web_AllRoom);
		$("#web_AllRoomBtn2").click(web_AllRoom2);
		$("#web_AllRoomExitBtn").click(web_AllRoom);
		$("#web_AllRoomBackBtn").click(AllRoomDetailBack);
		
		//5.공지사항
		$("#web_NoticeExitBtn").click(web_Exit);
		
		//6.회원 정보
		$("#web_FooterBtn6").click(web_Member);
		$("#web_MemberExitBtn").click(web_Exit);

	})
</script>
