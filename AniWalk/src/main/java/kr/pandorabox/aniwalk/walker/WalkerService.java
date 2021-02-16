package kr.pandorabox.aniwalk.walker;

import java.util.List;

import org.springframework.stereotype.Service;

@Service
public interface WalkerService {
	public String[] getCity(String area);
	public int walkerApply(WalkerDTO walker);
	public List<WalkerDTO> applierList(String wk_id);
	public int walkerLogin(String walker_id,String wk_pw);
	public String phoneCheck(String phoneNum);
	public WalkerDTO walkerInfo(String walker_id);
	public List<WalkerDTO> review(String walker_id);
	public WalkerDTO myInfo(String walker_id);
	public int myInfoUpdate(WalkerDTO walker);
	public int updateWalker(WalkerDTO walkerDto);
	public int createWalkerId(WalkerDTO walkerDto);
	public List<String> certificateImg(String wk_id);
	public List<WalkerDTO> getWalkerList(String searchWalker);
	public int emailCheck(String email);
}
