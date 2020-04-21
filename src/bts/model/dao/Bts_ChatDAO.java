package bts.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.mybatis.spring.SqlSessionTemplate;
import bts.model.vo.Bts_ChatVO;

public class Bts_ChatDAO {
	
	private SqlSessionTemplate sqlSession = null;

	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public void createChat(Bts_ChatVO vo) {
		sqlSession.insert("chat.createChat", vo);
	}
	
	public List<Bts_ChatVO> getChatInfo() {
	      List<Bts_ChatVO> chatList = sqlSession.selectList("chat.getChatInfo");
	      return chatList;
	}
	public Bts_ChatVO getUniqueChatInfo(int num) {
		Bts_ChatVO vo = sqlSession.selectOne("chat.getUniqueChatInfo",num);
		return vo;
	}
	public int getMaxNum() {
		int num = sqlSession.selectOne("chat.getMaxNum");
		return num;
	}
	
	public int chatExit(String nick,int num) {
		Map map=new HashMap();
		map.put("nick", nick+",");
		System.out.println(map.get("nick"));
		map.put("num", num);
		return sqlSession.update("chat.chatExit",map);
	}
	
	public void chatBoom(int num) {
		sqlSession.delete("chat.chatBoom",num);
	}
	public int setUsers(String nick,int num) {
		Map map=new HashMap();
		
		Bts_ChatVO vo= getUniqueChatInfo(num);
		String users=vo.getUsers();
		String[] usersDetail=users.split(",");
		for(String i: usersDetail) {
			if(i.equals(nick.split(",")[0])) 
				return 0;
		}
		map.put("nick", nick);
		map.put("num", num);
		sqlSession.update("chat.setUsers",map);
		return 1;
	}
	public List<Bts_ChatVO> getChatInfo(String options, String tag) {
		List<Bts_ChatVO> chatList = null;
		if (options.equals("전체")) { //카테고리가 '전체'일 때 : 키워드로만 검색
			chatList = sqlSession.selectList("chat.getChatList_1", tag);
		}else { //카테고리가 '전체'가 아닐 때 : 카테고리 및 키워드 검색
			Map param = new HashMap();
			param.put("options", options);
			param.put("tag", tag);
			chatList = sqlSession.selectList("chat.getChatList_2", param);
		}
	    return chatList;
	}

	public List<Bts_ChatVO> mychat(String nick) {
		List chatList = null;
			chatList = sqlSession.selectList("chat.mychat", nick);
		return chatList;
	}
	
	public List<Bts_ChatVO> inchat(String nick,String id) {
		List chatList = null;
		Map map = new HashMap();
		map.put("nick", nick);
		map.put("id", id);
		chatList = sqlSession.selectList("chat.inchat", map);
		return chatList;
	}
	// 방 정보 수정
	public void modifyChat(Bts_ChatVO vo) {
		sqlSession.update("chat.modifyChat", vo);
	}
	 
}