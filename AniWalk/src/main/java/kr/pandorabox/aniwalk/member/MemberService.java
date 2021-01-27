package kr.pandorabox.aniwalk.member;

import java.util.ArrayList;
import java.util.List;

public interface MemberService {
	String joinCheck (int kakao_id);
	int joinMember(JoinMemberDogImgDTO joinMemberDogImgDTO, ArrayList<String> filelist);
	public List<JoinMemberDogImgDTO> myPage(String mem_nickname);
	int addDog(JoinMemberDogImgDTO joinMemberDogImgDTO, ArrayList<String> filelist);
	public String getMem_id(String mem_nickname);
	public String getPhone_number(String mem_nickname);
	public int updateUserInfo(JoinMemberDogImgDTO joinMemberDogImgDTO, ArrayList<String> filelist);	
	public String getProfile(String mem_nickname);
	public List<JoinMemberDogImgDTO> getDogInfo(String mem_nickname, String dog_id);
	public void modifyDogInfo(JoinMemberDogImgDTO JoinMemberDogImgDTO);
	public void delDog(String dog_id);
	public String phoneCheck(String phoneNum);
	public int nicknameCheck(String mem_nickname);
	
	
}
