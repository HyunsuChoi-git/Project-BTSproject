package bts.basic.function;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/banThing/")
public class PlatFormSkill {
	@Autowired
	Logins login=null;
	
	HttpServletRequest request=null;
	HttpSession session=null;
	
	// 아래 어노테이션을 이용하여 각 변수 재활용 
	//모델어트리뷰트를 사용하게 되면 맵핑에 해당하는 메소드가 실행되기 전에 가장 먼저 실행 됨
	@ModelAttribute
	public void setting(HttpServletResponse response,HttpSession session,HttpServletRequest request,Model model) {
		this.request=request;
		this.session=session;
	}
	
	//카카오 로그인
	@RequestMapping("kakaologin")
	public String kakaologin(String code){
		System.out.println("카카오 로그인 발동!");
		String token= login.kakaoToken(code);
		session.setAttribute("kakaotoken", token);
		Map userInfo=login.kakaoInfo(token);
		request.setAttribute("userInfo", userInfo);
		return "/banThing/logins";
	}

}
