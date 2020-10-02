package kr.pandorabox.aniwalk.manager;

import java.util.List;

import kr.pandorabox.aniwalk.walker.WalkerDTO;

public interface ManagerService {
	public int managerLogin(String manager_id, String manage_pw);
	public List<MemberDTO> memberList();
	public List<WalkerDTO> walkerList();
}
