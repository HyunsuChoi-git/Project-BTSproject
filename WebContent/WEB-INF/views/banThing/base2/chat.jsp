<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>  
<link rel="stylesheet" href="<c:url value="/resources/css/base2/chat.css?zf=4"/>">
<div class="main1">

	<div class="subject">
		방 제목:${vo.title}    
	</div>
	<!-- 가장 큰 컨테이너 -->
	<div class="chatBox">
	
		<!-- 대화 -->
		<div id="chatLog" class="chatLog">
		</div>
		
		<!-- 채팅 밑3칸 -->
		<div id="chatSub">
			<input id="name" class="name" value="${sessionNick}" type="text" readonly>
			<input id="message" onkeydown="Enter_Check()" class="message" type="text" autocomplete="off" required="required">
			<button class="chat-button bg-light round-input" onclick="chat_submit()">전송</button>
		</div>
		
		<!-- 결제 상태  -->
		<div class="chatfunction">
		</div>
		
		<!-- 방정보보기 및 방정보 수정 -->
		<div id="roomBtn">
			<button class='dealBtn' onclick='roomInfo()'>방 정보 보기</button> <br/>
		</div>
		
		<!-- 거래 버튼 -->
		<div id="dealBtn"></div>
		<button type="button" class="exit-button" onclick="chat_exit()">나가기</button>
			
		<!-- 거래 콘솔창 -->	
		<div class="chatDealStart">
		미 진행 중...
		</div>
		
		<!-- 방 유저정보 -->
		<div id="userInfo">		    
	    </div>
	    
	    <!-- 방장이 아닐 경우 -->
	    <div id="roomInfo">
	    	<h2>방 정보</h2>
	    	<!--방 정보  뽑음 -->
	    	<table class="table" id="roomInfoTable">
			</table>
			<c:if test="${sessionId==vo.id}">	
				<button type="button" style="color:black;" onclick="updateChat()" class="btn web_Exit">수정</button>
			</c:if>
			<button type="button" style="color:black;" class="btn web_Exit" id="web_ExitBtn1">닫기</button>
	    </div>		    
		
	</div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a44d7ff9bef3120be5c58e8aa20ddfe0&libraries=clusterer,services"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<c:if test="${sessionId==null}">
	<script>
		alert('로그인 후 접속해주세요.');
		window.location.href="login.1";
	</script>
</c:if>
<script>
	
	//채팅방 수정
	function updateChat(){
		$("#roomInfo").fadeOut(500);
		open("updateChat.1?num=${vo.num}", "거래시작" , "toolbar=no,location=no,status=no, menubar=no, scrollbars=no, resizalbe=no, width=600px, height=750px,left=400px,top=200px");
	}
	//채팅방 수정-> 닫기버튼
	$("#web_ExitBtn1").click(function(){
		$("#roomInfo").fadeOut(500);
	});
	
	//현재 Bts_chat 가져오기
	function roomInfo(){
		$.ajax({
			url:"roomInfo",
	        type: 'get',
	        data: { num:"${vo.num}"},
	        dataType:'json', 
	        contentType:"application/json;charset=UTF-8",
			success:function(data){
				var vo=data['vo'];
				var detail="";
				detail +='<tr><th>방제</th><td colspan="3">'+vo.title+'</td></tr>';
				detail +='<tr><th>카테고리</th><td>'+vo.options+'</td><th>해쉬태그</th><td>'+vo.tag+'</td></tr>';
				detail +='<tr><th>상품명</th><td>'+vo.product+'</td><th>가격</th><td>'+vo.price+'</td></tr>';
				detail +='<tr><th>거래방식</th><td>'+vo.pay+'</td><th>성별</th><td>'+vo.gender+'</td></tr>';
				detail +='<tr><th>최대인원</th><td>'+vo.gender+'</td><th>장소</th><td>'+vo.place+'</td></tr>';
				detail +='<tr><th>내용</th><td colspan="3">'+vo.content+'</td></tr>';
		        $("#roomInfoTable").html(detail);
	 		}
		});
		$("#roomInfo").fadeToggle(500);
	}

    //채팅유저 정보 가져오기
	function userInfo(){
   		$.ajax({
   			url:"roomInfo",
   			data:{num:"${vo.num}"},
   			dataType:"json",
   			contentType:"application/json;charset=UTF-8",
   			success:function(data){
   				var vo=data['vo'];
   				var chatInfo=vo.users.split(",");
   		    	var userProfiles="<p style='margin-bottom:5px'><strong>참여자</strong></p>";
   		    	for(i = 0; i < chatInfo.length-1; i++){
   		    			var id="'"+chatInfo[i]+"'";
   		    			if(chatInfo[i] == "${sessionNick}"){
   		    				userProfiles +='<i class="fas fa-user"></i> '+chatInfo[i]+'(방장)(me)</br>';					
   		    			}else{
   		    				userProfiles +='<i class="fas fa-user"></i> '+chatInfo[i]+'&nbsp <button style=" border-radius: 5px; border-style:hidden;" onclick="userProfile('+id+')">정보보기</button></br>';
   		    			}
   		    	}
   		    	$("#userInfo").html(userProfiles);
   			}
   		})
	}
	
	//거래 시작시 Bts_deal 테이블 변경 및 거래시작 거래 전->동의 중으로 변경 됨
	function dealStart(){
		var dealStart=open("dealStart.1?num=${vo.num}", "거래시작" , "toolbar=no,location=no,status=no, menubar=no, scrollbars=no, resizalbe=no, width=527px, height=527px,left=400px,top=200px");
		//거래시작시 중단버튼과 완료버튼 나옴
	}
	
	//거래 도중 결제 상태 변경 (거래 전,동의 중,동의 완료,결제 중,결제 완료) 
	function setDealState(mes,a){
		$.ajax({
			url:"setDealState",
	        type: 'get',
	        data: { state:mes,num:a},
	        contentType:"application/json;charset=UTF-8",
			success:function(data){
				console.log(data);
	 		}
		});
	}
	//채팅방 나가기 (방장이면 방폭파)
	function chat_exit(){
		if("${vo.nick}"=="${sessionNick}"){
			var check=confirm("너가 나가면 방폭파되는게 괜찮 방구?");
			if(check){
				window.location.href="chatBoom?num=${vo.num}";
			}else{
				return false;
			}
		}else{
			window.location.href="chatExit?nick=${sessionNick}&num=${vo.num}&id=${sessionId}";
		}
	}
	
	//채팅 글 전송
	function chat_submit(){
		if($("#message").val()==""){
			alert("메세지를 입력해주세요");
		     $('#message').val("");
			return false;
		}
		$.ajax({
			url:"chatSave",
	        type: 'get',
	        data: { num:"${vo.num}",nick:"${sessionNick}",mes:$("#message").val()},
	        dataType:'json', 
	        contentType:"application/json;charset=UTF-8",
			success:function(data){
				chat_Info();
	 		}
		});
		$("#message").val("");
		$("#chatLog").scrollTop($("#chatLog")[0].scrollHeight);
	}
	
	//엔터 버튼 실행시 전송가능하도록
	function Enter_Check(){
	    if(event.keyCode == 13){
	      chat_submit();
	      $('#message').val("");
	    }
	}
	
	//페이지 실행시 채팅 정보는 0.5초 / 거래상태는 1초마다 빼오기
	$(document).ready(function(){
		setInterval(chat_Info, 300);
		setInterval(dealState, 1000);
		setInterval(userInfo, 300);
		$("#chatLog").scrollTop($("#chatLog")[0].scrollHeight);
	})
	

	// 유저정보보기
	function userProfile(nick){
		console.log(nick);
	    var url = "userProfile.1?nick="+nick;
	    var name = "userProfile";
	    var option = "width = 500, height = 400, top = 100, left = 200, location = no";
	    window.open(url, name, option);
	}
	
	/* 실시간 채팅을 위해 반드시 필요 */
	function chat_Info(){
		$.ajax({
			url:"logInfo",
	        type: 'get',
	        data: { num:"${vo.num}",id:"${sessionId}",nick:"${sessionNick}"},
	        dataType:'json',
	        contentType:"application/json;charset=UTF-8",
			success:function(data){
				let chatLog="<p>공+지 : BTS 채팅방에 오신 걸 환영합니다 !</p>";
				data['log'].forEach(function(i){
					if(i.id=="${sessionNick}"){
						chatLog +="<p class='myMessage'>"+i.id+":"+i.mes+"</p>";
					}else if(i.id=="운영자"){
						chatLog +="<p style='color:red;'>"+i.id+":"+i.mes+"</p>";
					}else{
						chatLog +="<p>"+i.id+":"+i.mes+"</p>";
					}						
				})
				//거래 시작시 나오는 페이지
					$("#chatLog").html(chatLog);
	 		}
		});
	}
	//거래 정보 가져오기
	function dealState(){
		$.ajax({
			url:"dealinfo",
	        type: 'get',
	        data: { num:"${vo.num}"},
	        dataType:'json',
	        contentType:"application/json;charset=UTF-8",
			success:function(data){
				var vo=data['vo'];
				var users=vo['users'].split(',');
				var dealstate=vo['dealState'];
				var agree="";
				var count=0;
				var deal="";
				var sample="";
				users.forEach(function(i,index){
				var dealBtn="";
					//동의 묻는 중
					if(dealstate=="거래 전"){
						deal="<p style='color:red; margin-bottom:2px;'>운영자:대화를 통해 거래를 물어보세요.</p>";
						deal+="<p style='color:red; margin-bottom:2px;'>운영자:거래가 성사될시 하단에 거래 신청을 눌러주세요.</p>";
						if("${sessionId}"=="${vo.id}"){
							dealBtn += "<button class='dealBtn' onclick='dealStart()'>거래 신청하기</button>";
						}
					}
					
					if(dealstate=="동의 중"){
						deal="<p style='color:red; margin-bottom:2px;'>운영자:거래 시작하기 앞서 동의여부를 묻도록 하겠습니다.</p>";
						deal+="<p style='color:red; margin-bottom:2px;'>운영자:아래 상세페이지를 읽어주시고 동의/거절 버튼을 눌러주세요.</p>";
						deal+="<p style='color:red; margin-bottom:2px;'>운영자:<a href='#' onclick='dealDetail()'>거래 상세페이지</a> </p>";
						if(i.includes(1)){
							console.log(i);
							agree+="<p>"+i.split('1')[0]+"님 동의</p>";
							count++;
						}
						if(count==users.length-1){
							var state=["'"+"동의 완료"+"'",vo['num']];
							if("${sessionId}"=="${vo.id}"){
								dealBtn += '<button class="dealBtn" onclick="setDealState('+state+');">거래 시작하기</button>';
							}
						}
					}
					
					else if(dealstate=="동의 완료"){
						var state=["'"+"결제 중"+"'",vo['num']];
						agree="<p>거래 스타뚜!!!!!!!!~</p>";
						deal="<p style='color:#911414'>운영자:모든 사람이 동의를 허가하였습니다.</p>";
						deal+="<p style='color:#911414'>운영자:방장은 결제 시작 버튼을 눌러주세요.</p>";
						deal+="<p style='color:#911414'>운영자:<a href='#' onclick='dealDetail("+"1"+")'>거래 상세페이지</a> </p>";
						var param = [vo['num'],"'"+vo['product']+"'",vo['price'],users.length-1];
						if("${sessionNick}"=="${vo.nick}"){
							dealBtn='<button class="dealBtn" onclick="setDealState('+state+');">결제 시작</button><br/><br/>';
						}
					}
					else if(dealstate=="결제 중"){
						var state=[vo['num'],"'"+vo['product']+"'",vo['price'],users.length-1];
						deal="<p style='color:#911414'>운영자:오른쪽 하단에 결제 하기 버튼을 클릭하시고 결제를 해주세요.</p>";
						deal+="<p style='color:#911414'>운영자:비용은 n빵입니다 ㅋㅋ..ㅎㅎ 불만없제?ㅋㅋ</p>";
						deal+="<p style='color:#911414'>운영자:<a href='#' onclick='dealDetail("+"1"+")'>거래 상세페이지</a> </p>";
						dealBtn='<button class="dealBtn" id="dealPay" onclick="dealPay('+state+');">결제 하기</button><br/><br/>'; 
						if(i.includes(2)){
							count++;
							agree+="<p>"+i.split('2')[0]+"님 결제완료</p>";
						}
						if(count==users.length-1){
							var state=["'"+"결제 완료"+"'",vo['num']];
							if("${sessionNick}"=="${vo.nick}"){
								dealBtn='<button class="dealBtn" onclick="setDealState('+state+');">결제 완료 하기</button><br/><br/>';
							}
						}
					}
					else if(dealstate=="결제 완료"){
						var state=["'"+"거래 완료"+"'",vo['num']];
						deal="<p style='color:#911414'>운영자:모든 결제가 완료되었습니다.</p>";
						deal+="<p style='color:#911414'>운영자:방장은 배송날짜를 명확히 알려주세요.</p>";
						deal+="<p style='color:#911414'>운영자:도착한 후 거래 완료 버튼을 눌러주세요.</p>";
						if("${sessionNick}"=="${vo.nick}"){
 							sample+='<button class="btn" onclick="setDealState('+state+');">거래 완료</button><br/>';
						}
					}
						//거래는 시작했는데 동의를 하지 않는경우.

					$("#dealBtn").html(dealBtn);
			 		$(".dealSetting").html(sample);
					$(".chatDealStart").html(deal);
					$(".chatfunction").html(agree);
				})
	 		}
		});
	}

	
	//결제 창 켜기
	function dealPay(a,b,c,d){
		open("kakaoPay?num="+a+"&product="+b+"&price="+c+"&userCount="+d, "거래시작" , "toolbar=no,location=no,status=no, menubar=no, scrollbars=no, resizalbe=no, width=600px, height=750px,left=400px,top=200px");
	}
	//거래 상세정보
	function dealDetail(state){
		if(state==undefined){
			state=0;
		}
		open("dealDetail.1?num=${vo.num}&state="+state, "거래시작" , "toolbar=no,location=no,status=no, menubar=no, scrollbars=no, resizalbe=no, width=600px, height=750px,left=400px,top=200px");
	}
	
</script>

