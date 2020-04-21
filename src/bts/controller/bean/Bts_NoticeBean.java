package bts.controller.bean;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import bts.model.dao.Bts_NoticeDAO;
import bts.model.vo.Bts_NoticeVO;

@Controller
@RequestMapping("/banThing/")
public class Bts_NoticeBean {
	
	@Autowired
	Bts_NoticeDAO noticeDAO;
	
	@RequestMapping("notice")
	@ResponseBody
	public String notice(String title,String content) {
		Bts_NoticeVO vo = new Bts_NoticeVO();
		vo.setTitle(title);
		vo.setContent(content);
		noticeDAO.insertNotice(vo);
		System.out.println("insert 성공");
		return "insert Notice Save";
	}

	@RequestMapping(value = "chnotice", headers="Accept=*/*",  produces="application/json")
	@ResponseBody
	public Map chnotice() {
		Map map = new HashMap();
		List noticeList = null;
		
		noticeList = noticeDAO.chNotice();
		map.put("notice", noticeList);
		
		return map;
	}
}
