package kr.pandorabox.aniwalk.manager;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.pandorabox.aniwalk.member.JoinMemberDogImgDTO;
import kr.pandorabox.aniwalk.walker.WalkerDTO;

@Service
public class ManagerServiceImpl implements ManagerService{
	@Autowired
	private ManagerDAO managerDAO;
	
	public int managerLogin(String manager_id, String manage_pw) {
		System.out.println("service_manager_id: " + manager_id);
		System.out.println("service_manage_pw: " + manage_pw);
		
		int result_id = managerDAO.managerLoginId(manager_id);
		System.out.println("Service_result_id: " + result_id);
		
		if(result_id == 1) {
			int result_pw = managerDAO.managerLoginPw(manage_pw);
			System.out.println("result_pw: " + result_pw);
			
			if(result_pw == 1) {
				return 1;
			} else {
				return 2;
			}
		} else {
			return 2;
		}
		
	}
	
	@Override
	public List<MemberDTO> memberList() {
		List<MemberDTO> memlist = managerDAO.memberList();
		return memlist;
	}
	
	@Override
	public List<WalkerDTO> walkerList() {
		List<WalkerDTO> walkerList = managerDAO.walkerList();
		return walkerList;
	}
	
	@Override
	public List<JoinMemberDogImgDTO> userInfo(String kakao_id) {
		System.out.println("service kakao_id: " + kakao_id);
		List<JoinMemberDogImgDTO> userlist = managerDAO.userInfo(kakao_id);
		System.out.println(userlist.get(0).getMem_nickname());
		return userlist;
	}
}