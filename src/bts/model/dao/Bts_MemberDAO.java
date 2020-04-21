package bts.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import bts.model.vo.Bts_MemberVO;

//sql.xml 호출하는 곳
public class Bts_MemberDAO{
	
	private SqlSessionTemplate sqlSession = null;

	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public void signupMember(Bts_MemberVO vo) throws Exception {
		sqlSession.insert("member.signupMember", vo);
	}
	public String getNick(String id) throws Exception {
		return sqlSession.selectOne("member.nickCheck", id);
		
	}

	public int loginCheck(Bts_MemberVO vo) throws Exception {
		return sqlSession.selectOne("member.loginCheck", vo);
	}
	
	public int apiIdCheck(String id) throws Exception {
		return sqlSession.selectOne("member.apiIdCheck", id);
	}

	public Bts_MemberVO selectMember(String id) throws Exception {
		return sqlSession.selectOne("member.selectMember",id);
	}

	public void updateMember(Bts_MemberVO vo) throws Exception {
		sqlSession.update("member.updateMember",vo);
	}

	public void deleteMember(String id) throws Exception {
		sqlSession.delete("member.deleteMember",id);
	}
	//nick으로 데이터 가져오기
	public Bts_MemberVO selectMember01(String nick) {
		return sqlSession.selectOne("member.selectMember01",nick);
	}
}
