package bts.controller.bean;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import bts.basic.function.ChatMethod;
import bts.model.dao.Bts_ChatDAO;
import bts.model.dao.Bts_DealDAO;
import bts.model.vo.Bts_ChatVO;
import bts.model.vo.Bts_DealVO;

//채팅기능 관련 컨트롤러
@Controller
@RequestMapping("/banThing/")
public class Bts_ChatBean {
	
	@Autowired
	private Bts_ChatDAO chatDAO;
	@Autowired
	private Bts_DealDAO dealDAO;
	@Autowired
	ChatMethod cm=null;
	
	public HttpServletRequest request=null;
	public Model model = null;
	public HttpSession session=null;
	String uri=null;
	String nick=null;
	String id=null;
	String path=null;
	
	@ModelAttribute
	public void reqres(HttpServletRequest request, Model model,HttpSession session) {
		this.request=request;
		this.model = model;
		this.session=session;
		uri=request.getRequestURI();
		nick=(String)session.getAttribute("sessionNick");
		id=(String)session.getAttribute("sessionId");
		path=request.getRealPath("/WEB-INF/chatRoom/");
	}
	
	//채팅방  접속할 곳
	@RequestMapping("chat.2")
	public String chat(int num) throws Exception{
		System.out.println(num+"번 채팅방 페이지로 이동!");
		//users컬럼에 세션에 저장된 닉과 테이블번호 보내서 ex)최병찬,꼴로 저장
		int check=chatDAO.setUsers(nick+",",num);
		//특정 튜플 가져오기.
		Bts_ChatVO vo=chatDAO.getUniqueChatInfo(num);
		//페이지에 chatVo보내기
		model.addAttribute("vo", vo);
		//check==1 값변경 성공
		if(check == 1) {
			//ChatMethod에있는 saveJson 실행하여 보내주기.
			cm.saveJson(path,num, id, nick, nick+"님께서 입장하셨습니다.");
			return uri.split("/")[3];
		}else {
			return uri.split("/")[3];
		}
	}
	
	//방 개설
	@RequestMapping("submit")
	public void createChat (Bts_ChatVO vo, MultipartHttpServletRequest multireq,HttpServletResponse response) throws Exception {
		int num = 0;
		if (request.getMethod().equals("POST")) {
			System.out.println("방 개설 중!");
			MultipartFile mf = null;
			String newName = null;
			try {
				// # 파일이름 중복처리  :  날짜 + 오리지널파일명
				mf = multireq.getFile("orgImg");									//0. 파일 정보 담기
				String orgName = mf.getOriginalFilename();//1. 오리지널 파일명
				String imgName = orgName.substring(0, orgName.lastIndexOf('.')); 	//2. 파일명만 추출
				String ext = orgName.substring(orgName.lastIndexOf('.'));			//3. 확장자 추출
				long date = System.currentTimeMillis();								//4. 날짜 받아오기
				newName = date + imgName + ext;										//5. 최종 파일이름
				String nick=(String)session.getAttribute("sessionNick");
				// # DB에 form 저장
				vo.setUsers(nick+",");
				vo.setImg(newName);
				vo.setNick(nick);
				vo.setTag(vo.getTag().replaceAll(" ", ""));
				//방개설
				chatDAO.createChat(vo);
				//방 번호흭득
				num=chatDAO.getMaxNum();
				
				Bts_DealVO dealvo=new Bts_DealVO();
				dealvo.setDealState("거래 전");
				dealvo.setId(vo.getId());
				dealvo.setNum(num);
				dealvo.setPlace(vo.getPlace());
				dealvo.setPrice(vo.getPrice());
				dealvo.setProduct(vo.getProduct());
				dealvo.setUsers(vo.getNick()+",");
				dealvo.setUrl("");
				dealvo.setTid("");
				//거래 개설
				dealDAO.createDeal(dealvo);
				
		        BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(path+num+".json"));
				// # 서버에 이미지 저장 : WEB-INF  >  chatImg
				String path1 = multireq.getRealPath("/resources/chatImg");
				String imgPath = path1+ "\\" + newName;
				File copyFile = new File(imgPath);
				mf.transferTo(copyFile);
				
				model.addAttribute("createChat","success");
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				response.sendRedirect("chat.2?num="+num);
			}
		}
	}
		@RequestMapping("updateChat.1")
		public String updateChat(int num) throws Exception{
	   		Bts_ChatVO chatVo= chatDAO.getUniqueChatInfo(num);
	   		model.addAttribute("vo", chatVo);
			return uri.split("/")[3];	   		
		}
		// 방 수정
	   @RequestMapping("updateChat")
	   public String updateChat(int num,Bts_ChatVO vo,MultipartHttpServletRequest multireq,HttpServletResponse response) {
			   	System.out.println("채팅방 수정 중!");
			    MultipartFile mf = null;
				String newName = null;
				// 1. 기존이미지 삭제
				mf = multireq.getFile(vo.getImg());
				String path = multireq.getRealPath("chatImg");
				String imgPath = path+ "\\" + vo.getImg();
				File copyFile = new File(imgPath);
				copyFile.delete();
				
				// 2. 이미지 다시 담기.
				mf = multireq.getFile("orgImg");		
				String orgName = mf.getOriginalFilename();// 오리지널 파일명
				String imgName = orgName.substring(0, orgName.lastIndexOf('.')); 	// 파일명만 추출
				String ext = orgName.substring(orgName.lastIndexOf('.'));			// 확장자 추출
				long date = System.currentTimeMillis();								// 날짜 받아오기
				newName = date + imgName + ext;
				vo.setImg(newName);
					// # 서버에 이미지 저장 : WEB-INF  >  chatImg
					path = multireq.getRealPath("chatImg");
					imgPath = path+ "\\" + newName;
					copyFile = new File(imgPath);
					try {
						mf.transferTo(copyFile);
						// 방 정보 수정
						chatDAO.modifyChat(vo);
						model.addAttribute("update", "success");
					} catch (Exception e) {
						e.printStackTrace();
						System.out.println("채팅방 수정 에러");
					}finally {
						System.out.println("채팅방 수정 완료");
					}
					return "updateChat.1";
	   }

	//방 폭파~ 붐!!!
	@RequestMapping("chatBoom")
	public void chatExit(int num,HttpServletResponse response) throws IOException{
		System.out.println(num+"채팅방 Boom~~");
		chatDAO.chatBoom(num);
		response.sendRedirect("index.2");
	}
	

	//채팅 저장
	@RequestMapping("chatSave")
	public void chatSave(int num,String mes,String nick) throws Exception{
		System.out.println(num+"번 json파일 메세지 저장!");
		//바꾸지마샘 채팅은 닉으로 보낼거임 ㅋㅋ
		cm.saveJson(path,num, nick, nick,mes);
	}
	
	//방 나가는 메서드
	@RequestMapping("chatExit")
	public void chatExit(String nick,String id,int num,HttpServletResponse response) throws Exception{
		int check=chatDAO.chatExit(nick,num);
		//check==1 나가짐
		if(check==1) {
			System.out.println(nick+"님이"+num+"번 방에 퇴장 했습니다.");
			cm.saveJson(path,num, id, nick,nick+"님께서 퇴장하셨습니다.");
		}
		response.sendRedirect("index.2");
	}
	//채팅 빼오기
   @ResponseBody
   @RequestMapping("logInfo")
   public void logInfo(int num,String id,String nick,String entrance,HttpServletResponse response) throws Exception{
	  response.setHeader("Content-Type", "application/xml"); 
      response.setContentType("text/html;charset=UTF-8"); 
      response.setCharacterEncoding("utf-8");
      JSONObject jo=null;
      JSONParser parser = new JSONParser();
      JSONArray log=new JSONArray();
  	  JSONObject chat=new JSONObject();
      String path=request.getRealPath("/WEB-INF/chatRoom/");
      try {
    	  jo = (JSONObject)parser.parse(new FileReader(path+num+".json"));
      }catch(Exception e) {
      	  log=new JSONArray();
      	  chat=new JSONObject();
      	  jo=new JSONObject();
      	  jo.put("num", num);
      	  chat.put("id", nick);
      	  chat.put("mes", nick+"님께서 입장하셨습니다.");
      	  log.add(chat);
          jo.put("log", log);
          FileWriter save = new FileWriter(path+num+".json"); 
          //스트링 타입으로 저장
          save.write(jo.toJSONString()); 
          save.flush();
          save.close(); 
      }
        
      response.getWriter().print(jo.toString());
   }
   
   //내가만든 채팅방,내가 들어간 채팅방 찾기
	@RequestMapping(value = "mychat", headers="Accept=*/*",  produces="application/json")
	@ResponseBody
	public Map mychat(String num) {
		Map map=new HashMap(); 
		List chatList=new ArrayList();
	   if(num != null) {
		   if(num.equals("1")) {
			   chatList = chatDAO.mychat(nick);
		   }else if(num.equals("2")){
			   chatList = chatDAO.inchat(nick,id);
		   }
	   }else {
		   num = "0";
	   }
	   map.put("myChat", chatList);
	   return map;
   }
	
	//bts_chat 테이블을 json타입으로 변경
	@RequestMapping(value = "chatinfo", headers="Accept=*/*",  produces="application/json")
	@ResponseBody
	public Map ChatInfo(String[] search){
		// search[0~2] >>지도관련 변수들
		// search[3] >>카테고리 , search[4] >>키워드 변수 		
		List chatList=new ArrayList();
		chatList=chatDAO.getChatInfo(search[3],search[4]);
		
		Map map=new HashMap(); 
		map.put("chatList", chatList);
		map.put("lat", search[0]);
		map.put("lng", search[1]);
		map.put("level", search[2]);
		map.put("options", search[3]);
		map.put("keyword", search[4]);
		 
		return map;
	}
	
	//bts_deal 테이블을 json타입으로 변경
	@RequestMapping(value = "dealinfo", headers="Accept=*/*",  produces="application/json")
	@ResponseBody
	public Map DealInfo(int num){
		
		Bts_DealVO vo= dealDAO.getUniqueDeal(num);
		Map map=new HashMap(); 
		map.put("vo", vo);
		
		return map;
	}
	
	//맵->JSON 형식으로 파싱하여 데이터 전달
	@RequestMapping(value = "roomInfo", headers="Accept=*/*",  produces="application/json")
	@ResponseBody
	public Map roomInfo(int num){
		
		Bts_ChatVO vo= chatDAO.getUniqueChatInfo(num);
		Map map=new HashMap(); 
		map.put("vo", vo);
		
		return map;
	}

}
