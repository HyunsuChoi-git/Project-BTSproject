package bts.model.dao;

import java.util.HashMap;
import java.util.Map;
import org.mybatis.spring.SqlSessionTemplate;
import bts.model.vo.Bts_DealVO;

public class Bts_DealDAO {
	
	private SqlSessionTemplate sqlSession = null;

	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}
	public void createDeal(Bts_DealVO vo) {
		
		sqlSession.insert("deal.createDeal",vo);
	}
	public Bts_DealVO getUniqueDeal(int num) {
		return sqlSession.selectOne("deal.getUniqueDeal",num); 
	}
	public int dealStart(Bts_DealVO vo) {
		return sqlSession.update("deal.dealStart",vo); 
	}
	public int dealStartUpdate(int num,String nick) {
		Map map=new HashMap();
		map.put("num", num);
		map.put("nick", nick);
		return sqlSession.update("deal.dealStartUpdate",map); 
	}
	public int dealMoneyUpdate(int num,String nick) {
		
		Map map=new HashMap();
		map.put("num", num);
		map.put("nick", nick);
		return sqlSession.update("deal.dealMoneyUpdate",map); 
	}
	public int setDealState(String state,int num) {
		Map map=new HashMap();
		map.put("state", state);
		map.put("num", num);
		return sqlSession.update("deal.setDealState",map); 
	}
	 
}