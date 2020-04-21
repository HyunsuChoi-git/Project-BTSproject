package bts.model.dao;
import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import bts.model.vo.Bts_NoticeVO;

public class Bts_NoticeDAO {
	
	private SqlSessionTemplate sqlSession = null;

	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public void insertNotice(Bts_NoticeVO vo) {
		sqlSession.insert("notice.insertNotice",vo);
	}

	public List chNotice() {
		List noticeList = null;
		noticeList = sqlSession.selectList("notice.chNotice");
		
		
		return noticeList;
	}
}
