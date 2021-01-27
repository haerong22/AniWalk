package kr.pandorabox.aniwalk.member;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.pandorabox.aniwalk.FileUploadLogic;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	FileUploadLogic uploadService;
	
	@Override
	public String joinCheck(int kakao_id) {			
		return memberDAO.joinCheck(kakao_id);
	}
	
	@Override
	public int joinMember(JoinMemberDogImgDTO joinMemberDogImgDTO, ArrayList<String> filelist) {
		int result1 = memberDAO.joinMember(joinMemberDogImgDTO);
		int result2 = memberDAO.joinDog(joinMemberDogImgDTO);
		int result = 0;
		
		if(filelist.size() != 0) {
			int success = memberDAO.fileInsert(filelist);
			if(result1 >= 1 && result2 >= 1 && success >= 1) {
				result = 1;
			}
		}	
		return result;
	}
	
	// ajax phone 중복검사용
	@Override
	public String phoneCheck(String phoneNum) {
		String result = memberDAO.phoneCheck(phoneNum);
		return result;
	}
	
	// 멤버 회원가입 닉네임 중복 ajax처리
	@Override
	public int nicknameCheck(String mem_nickname) {
		return memberDAO.nicknameCheck(mem_nickname);
	}
		
	@Override
	public List<JoinMemberDogImgDTO> myPage(String mem_nickname) {
		return memberDAO.myPage(mem_nickname);
	}
	
	@Override
	public int addDog(JoinMemberDogImgDTO joinMemberDogImgDTO, ArrayList<String> filelist) {
		int result1 = memberDAO.addDog(joinMemberDogImgDTO);
		int result = 0;
		
		if(filelist.size() != 0) {
			int success = memberDAO.addfileInsert(filelist);
			if(result1 >= 1 && success >= 1) {
				result = 1;
			}
		}	
		
		return result;
	}
	
	// 반려견 추가시 외래키mem_id 값을 얻기위한 메소드
	@Override
	public String getMem_id(String mem_nickname) {
		return memberDAO.getMem_id(mem_nickname);
	}
	
	// 회원정보 수정 페이지의 전화번호 띄우기
	@Override
	public String getPhone_number(String mem_nickname) {
		return memberDAO.getPhone_num(mem_nickname);
	}
	
	// 회원정보 수정
	@Override
	public int updateUserInfo(JoinMemberDogImgDTO joinMemberDogImgDTO, ArrayList<String> filelist) {
		List<String> list = new ArrayList<String>();		
		int result = 0;
		int memInfo = 0;
		int memProfile = 0;
		
		if(filelist.size() == 0) {		
			memInfo = memberDAO.updateUserInfo(joinMemberDogImgDTO);	
		} else {
			memInfo = memberDAO.updateUserInfo(joinMemberDogImgDTO);	
			list.add(joinMemberDogImgDTO.getMem_nickname());
			list.add(filelist.get(0));
			memProfile = memberDAO.updateUserProfile(list);
		}												
		
		if(memInfo >= 1 || memProfile >= 1) {
			result = 1;
		} else {
			result = 2;
		}
		return result;
	}
	
	// 특정회원의 filename 가져오기
	@Override
	public String getProfile(String mem_nickname) {
		return memberDAO.getProfile(mem_nickname);
	}
	
	// ajax용 반려견 정보
	public List<JoinMemberDogImgDTO> getDogInfo(String mem_nickname, String dog_id) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("mem_nickname", mem_nickname);
		map.put("dog_id", dog_id);
		return memberDAO.getDogInfo(map);
	}
	
	// 강아지 정보 수정
	@Override
	public void modifyDogInfo(JoinMemberDogImgDTO JoinMemberDogImgDTO) {	
		
		MultipartFile[] files = JoinMemberDogImgDTO.getFiles();
		ArrayList<String> filelist = new ArrayList<String>();
		String path = "C:/owner";
		for(int i=0; i<files.length; i++) {
			String fileName = files[i].getOriginalFilename();
			if(fileName.length()!=0) {
				String new_file = uploadService.upload(files[i], path, fileName);
				filelist.add(new_file);
			}
		}
		
		String dog_id = JoinMemberDogImgDTO.getDog_id();
		
		if(filelist.size() == 0) {		
			memberDAO.modifyDogInfo(JoinMemberDogImgDTO);	
		} else {
			memberDAO.modifyDogInfo(JoinMemberDogImgDTO);	
			memberDAO.modifyDogProfile(dog_id, filelist);
		}		
	}
	
	// 개 정보 삭제
	@Override
	public void delDog(String dog_id) {
		memberDAO.delDogImg(dog_id);
		memberDAO.delDog(dog_id);	
	}

}
