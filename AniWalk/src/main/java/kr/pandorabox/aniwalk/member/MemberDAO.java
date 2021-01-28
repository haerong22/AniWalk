package kr.pandorabox.aniwalk.member;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface MemberDAO {
	String joinCheck(int kakao_id);
	int joinMember(JoinMemberDogImgDTO joinMemberDogImgDTO);
	int joinDog(JoinMemberDogImgDTO joinMemberDogImgDTO);
	int fileInsert(ArrayList<String> filelist);
	//owner my page
	public List<JoinMemberDogImgDTO> myPage(String mem_nickname);
	public int addDog(JoinMemberDogImgDTO joinMemberDogImgDTO);
	public int addfileInsert(ArrayList<String> filelist);
	public String getMem_id(String mem_nickname);
	public String getPhone_num(String mem_nickname);
	public int updateUserInfo(JoinMemberDogImgDTO joinMemberDogImgDTO);
	public int updateUserProfile(List<String> list);
	public String getProfile(String mem_nickname);
	public List<JoinMemberDogImgDTO> getDogInfo(Map<String, String> map);
	public void modifyDogInfo(JoinMemberDogImgDTO JoinMemberDogImgDTO);
	public void modifyDogProfile(String dog_id, ArrayList<String> filelist);
	public void delDog(String dog_id);
	public String phoneCheck(String phoneCheck);
	public int nicknameCheck(String mem_nickname);	
	
}
