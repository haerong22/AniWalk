package kr.pandorabox.aniwalk.walker;

import java.util.HashMap;
import java.util.List;

public interface WalkerDAO {

	public int walkerApply(WalkerDTO walker);
	public int walkerApply(String file);

	public List<WalkerDTO> applyierList(String wk_id);
	
	public int walkerLogin(HashMap<String, String> map);
	public int walkerLogin_id(String walker_id);
	
	//워커신청 폰체크
	public String phoneCheck(String phoneNum);
	public WalkerDTO walkerInfo(String walker_id);
	
	//워커 산책 후기
	public List<WalkerDTO> review(String walker_id);
	//개인정보 불러오기
	public WalkerDTO myInfo(String walker_id);
	//개인정보 수정
	public int myInfoUpdate(WalkerDTO walker);
	public int updateWalker(WalkerDTO walkerDto);
	public int createWalkerId(WalkerDTO walkerDto);
	public List<String> certificateImg(String wk_id);
	public List<WalkerDTO> getWalkerList(String searchWalker);
	public int emailCheck(String email);
	
}
