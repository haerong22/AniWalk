package kr.pandorabox.aniwalk.member;

import java.util.ArrayList;

public interface MemberService {
	String joinCheck (int kakao_id);
	int joinMember(JoinMemberDogImgDTO joinMemberDogImgDTO, ArrayList<String> filelist);
	 
}
