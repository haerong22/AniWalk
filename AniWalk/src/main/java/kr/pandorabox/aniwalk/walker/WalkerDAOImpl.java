package kr.pandorabox.aniwalk.walker;

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
	
	@Override
	public int emailCheck(String email) {
		return session.selectOne("kr.pandorabox.aniwalk.walker.emailCheck", email);
	}
	
	// 오너 페이지 - 펫 프렌즈 리스트 
	@Override
	public List<WalkerDTO> getWalkerList(String searchWalker) {
		return session.selectList("kr.pandorabox.aniwalk.walker.getWalkerList", searchWalker);
	}
	
	// 펫 프렌즈 자격증 정보
	@Override
		public List<String> certificateImg(String wk_id) {
			return session.selectList("kr.pandorabox.aniwalk.walker.certificateImg", wk_id);
		}	
	
	// 펫 프렌즈 아이디 생성
	@Override
	public int createWalkerId(WalkerDTO walkerDto) {
		return session.update("kr.pandorabox.aniwalk.walker.createWalkerId", walkerDto);
	}
	
	// 펫 프렌즈 신청 관리
	@Override
	public int updateWalker(WalkerDTO walkerDto) {
		System.out.println("확인: " + walkerDto.getWk_certificate_list());
		return session.update("kr.pandorabox.aniwalk.walker.updateWalker", walkerDto);
	}
	
	
	// 펫프렌즈 list
	@Override
	public List<WalkerDTO> applyierList(String wk_id) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("wk_id", wk_id);
		return session.selectList("kr.pandorabox.aniwalk.walker.applierList", map);
	}
	
	// 펫프렌즈 자격증 정보 insert
	@Override
	public int walkerApply(String file) {
		return session.insert("kr.pandorabox.aniwalk.walker.fileinsert", file);
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
	
	//워커신청 폰체크
	@Override
	public String phoneCheck(String phoneNum) {
		return session.selectOne("kr.pandorabox.aniwalk.walker.phoneCheck",phoneNum);
	}
	@Override
	public WalkerDTO walkerInfo(String walker_id) {
		return session.selectOne("kr.pandorabox.aniwalk.walker.walkerInfo",walker_id);
	}
	@Override
	public List<WalkerDTO> review(String walker_id) {
		return session.selectList("kr.pandorabox.aniwalk.walker.review",walker_id);
	}
	
	//개인정보 불러오기
	@Override
	public WalkerDTO myInfo(String walker_id) {
		return session.selectOne("kr.pandorabox.aniwalk.walker.myInfo",walker_id);
	}
	//개인정보 수정
	@Override
	public int myInfoUpdate(WalkerDTO walker) {
		return session.update("kr.pandorabox.aniwalk.walker.myInfoUpdate",walker);
	}
}
