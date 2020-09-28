package kr.pandorabox.aniwalk.walker;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class WalkerDAOImpl implements WalkerDAO{
	@Autowired
	SqlSession session;
	
	// 펫프렌즈 list
	@Override
	public List<WalkerDTO> applyierList(String wk_id) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("wk_id", wk_id);
		return session.selectList("kr.pandorabox.aniwalk.walker.applierList", map);
	}
	
	// 펫프렌즈 자격증 정보 insert
	@Override
	public int fileInsert(ArrayList<String> filelist) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("filelist", filelist);
		return session.insert("kr.pandorabox.aniwalk.walker.fileinsert", paramMap);
	}
	
	// 펫프렌즈 신청자 insert
	@Override
	public int walkerApply(WalkerDTO walker) {
		return session.insert("kr.pandorabox.aniwalk.walker.walkerApply", walker);
	}
	
	//워커 로그인 check
	@Override
	public int walkerLogin(HashMap<String, String> map) {
		return session.selectOne("kr.pandorabox.aniwalk.walker.walkerLogin", map);
	}
	@Override
	public int walkerLogin_id(String walker_id) {
		return session.selectOne("kr.pandorabox.aniwalk.walker.walkerLogin_id",walker_id);
	}
	
}