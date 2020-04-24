package bts.controller.bean;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import bts.basic.function.Logins;
import bts.model.dao.Bts_MemberDAO;
import bts.model.vo.Bts_MemberVO;


@Controller
@RequestMapping("/banThing/")
public class Bts_MemberBean {
	Logins login = new Logins();
	
	@Autowired
	private Bts_MemberDAO memberDAO;
	
	public HttpServletRequest request=null;
	public HttpServletResponse response=null;
	public Model model = null;
	public HttpSession session = null;
	
	@ModelAttribute
	public void reqres(HttpServletRequest request,HttpServletResponse response, Model model, HttpSession session) {
		this.request=request;
		this.response=response;
		this.model = model;
		this.session = session;
	}
	
	@RequestMapping("signup.1")
	public String signupForm(Bts_MemberVO vo) throws Exception {
		if(request.getMethod().equals("GET")){
			return "signup.1";
		}else if(request.getMethod().equals("POST")){
			//주민번호로 성별 구별하여 vo.gender에 넣어주기
			String ssan = vo.getSsan();
			String gender = "";

			if (ssan.charAt(7) == '1' || ssan.charAt(7) == '3') {
				gender = "남자";
			}else if (ssan.charAt(7) == '2' || ssan.charAt(7) == '4') {
				gender = "여자";
			}else {
				model.addAttribute("ssan","err");
				return "signup.1";
			}
			vo.setGender(gender);
			
	 		memberDAO.signupMember(vo);
	 		model.addAttribute("signup","success");
			
		}
		return "signup.1";
	}
	
	
	@RequestMapping("apiLogin.1")
	public String kakaologin(String id, String nickname, String name, String email) throws Exception {
		//1. 아이디 꺼내서 디비에서 확인
		String api = null;
		if(name == "" || email == "") { api = "k-"; id = api+id; }
		else { api = "n-"; id = "n-"+id; }
		
		int check = memberDAO.apiIdCheck(id);
		
		//2. 있으면 로그인
		if(check == 1) {
			String nick=memberDAO.getNick(id);
			session.setAttribute("sessionId", id);
			session.setAttribute("sessionNick", nick);
			model.addAttribute("check", check);
			System.out.println(id+"("+nick+")"+"님이 로그인하셨습니다.");
			return "map-setting.1";
		}else {
		//3. 없으면 회원가입
				model.addAttribute("id", id);
				model.addAttribute("nick", nickname);				
				model.addAttribute("name", name);				
				model.addAttribute("email", email);				
			return "signup.1";
		}

	}
	
	@RequestMapping("login.1")
	public String loginForm (Bts_MemberVO vo) throws Exception {
		
		if(request.getMethod().equals("GET")) {
			return "login.1";
		}else if(request.getMethod().equals("POST")){
			int check = memberDAO.loginCheck(vo);
			
			if (check == 1) {
				String nick=memberDAO.getNick(vo.getId());
				session.setAttribute("sessionId", vo.getId());
				session.setAttribute("sessionNick", nick);
				model.addAttribute("check", check);
				System.out.println(vo.getId()+"("+nick+")"+"님이 로그인하셨습니다.");
				return "map-setting.1";
			}else {
				model.addAttribute("check", "err");
				return "login.1";
			}
		}
		return "login.1";
	}
	
	@RequestMapping("update.1")
	public String update (Bts_MemberVO vo) throws Exception {
		if(request.getMethod().equals("GET")) {
			String id = (String)session.getAttribute("sessionId");
			Bts_MemberVO vo1 = memberDAO.selectMember(id);
			model.addAttribute("all",vo1);
			return "update.1";
		}else if(request.getMethod().equals("POST")){
			memberDAO.updateMember(vo); 
			model.addAttribute("update","success");
			return "map-setting.1";
		}
		
		return "update.1";
	}
	@RequestMapping("userProfile.1")
	public String userProfile (String nick) throws Exception {
		Bts_MemberVO vo = memberDAO.selectMember01(nick);
		model.addAttribute("user", vo);
		return "userProfile.1";
	}
	@RequestMapping("delete")
	public void delete() throws Exception {
		String id=(String)session.getAttribute("sessionId");
		String token=(String)session.getAttribute("kakaotoken");
		login.unlink(token);
		memberDAO.deleteMember(id);
		response.sendRedirect("logout");
	}
	
	@RequestMapping("logout")
	public String logout() throws Exception {
		String token=(String)session.getAttribute("kakaotoken");
		String id=(String)session.getAttribute("sessionId");
		String nick=(String)session.getAttribute("sessionNick");
		if(token!=null) {
			login.kakaoLogout(token);
		}
		System.out.println(id+"("+nick+")"+"님께서 로그아웃 하셨습니다.");
		session.invalidate();
		model.addAttribute("logout","success");
		return "login.1";
	}

}
