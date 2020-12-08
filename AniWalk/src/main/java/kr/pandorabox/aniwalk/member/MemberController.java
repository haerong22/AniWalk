package kr.pandorabox.aniwalk.member;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import kr.pandorabox.aniwalk.FileUploadLogic;
import kr.pandorabox.aniwalk.SHA256;

@Controller
public class MemberController {
	
	@Autowired
	private SHA256 hash;
	
	@Autowired
	MemberService memberService; 
	
	@Autowired
	FileUploadLogic uploadService;
	
	@RequestMapping("/loginPro.do")
	public ModelAndView checkMember(int kakao_id, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		System.out.println("Hello java11 upgrade");
		
		// 넘겨받은 카카오 id를 통해 aniwalk 서비스에 가입되어 있는 아이디인지 체크 하는 메소드
		String mem_nickname = memberService.joinCheck(kakao_id);
		String filename = memberService.getProfile(mem_nickname);
		
		 
		if(mem_nickname == null) {
			// 위 메소드에서 가입되어 있는 아이디가 없을시 회원가입 페이지로 이동
			mav.setViewName("login");														// main/signUp.jsp
			return mav;
		} else {	
			// 아이디가 존재한다면 session에 해당 nickname을 저장하며 onwer 메인 페이지로 이동
			request.getSession().setAttribute("mem_nickname", mem_nickname);
			request.getSession().setAttribute("filename", filename);
			mav.addObject("filename", filename);
			mav.addObject("mem_nickname", mem_nickname);
			mav.addObject("kakao_id", kakao_id);
			mav.setViewName("redirect:/owner/index.do");
			return mav;
		}			
	}
	 
	@RequestMapping(value = "/signIn.do", method = RequestMethod.POST)
	public ModelAndView joinMember(JoinMemberDogImgDTO joinMemberDogImgDTO, HttpServletRequest request) 
			throws Exception {
		// signUp.jsp에서 입력했던 mem_nickname을 가져온다 ⇒ ①
		String mem_nickname = joinMemberDogImgDTO.getMem_nickname();	
		ModelAndView mav = new ModelAndView();
		
		// signUp.jsp에서 입력했던 반려견 file을 가져와 
		// SpringFrameWork의 MultipartFile인터페이스에 배열 형식으로 담는다.		
		MultipartFile[] files = joinMemberDogImgDTO.getFiles();
		ArrayList<String> filelist = new ArrayList<String>();
		String path = "C:/owner";
		for(int i=0; i<files.length; i++) {
			// file의 갯수만큼 시스템에 저장되어 있는 파일의 원래 이름을 반환하여 String fileName에 담는다.
			String fileName = files[i].getOriginalFilename();
			if(fileName.length() != 0) {	
				
				// 따로 만들어놓은 FileUploadLogic클래스의 upload 메소드에 
				// (files[i], path, fileName)을 매개변수에 담아 보낸다.
				String new_file = uploadService.upload(files[i], path, fileName);
				filelist.add(new_file);
			}
		}
		// signUp.jsp에서 입력받은 회원 정보들인 joinMemberDogImgDTO와 사진file인 filelist를 
		// DB에 insert하기 위한 메소드
		int result = memberService.joinMember(joinMemberDogImgDTO, filelist);
		
		if(result == 1) {
			// 성공적으로 DB에 등록되면 session에 mem_nickname을 저장하며 user메인 페이지로 이동
			request.getSession().setAttribute("mem_nickname", mem_nickname);
			mav.setViewName("redirect:/owner/index.do");
		} else {
			// 등록에 실패했을시 회원가입 페이지로 다시 이동
			mav.setViewName("login");
		}	
		return mav;
	}
	
	// 멤버 회원가입 핸드폰 ajax 처리용
	@ResponseBody
	@RequestMapping("/member/phoneCheck.do")
	public String phoneCheck(String phoneNum) {
		String result = memberService.phoneCheck(phoneNum);
		return result;
	}
	
	// 멤버 회원가입 닉네임 중복 ajax처리
	@ResponseBody
	@RequestMapping("/member/nicknameCheck.do")
	public int nicknameCheck(String mem_nickname) {
		int result = memberService.nicknameCheck(mem_nickname);
		return result;
	}
	
	// 문자인증 메시지 보내기
	@ResponseBody
	@RequestMapping(value="member/auth.do",
			method = RequestMethod.POST,
			produces = "application/text;charset=utf-8")
	public String auth(String wk_phone) {
		Random ran = new Random();
	    String auth = Integer.toString(ran.nextInt(899999) + 100000); 
	    System.out.println("auth: " + auth);
	    auth = hash.toSHA256(auth);
	    System.out.println("auth2: " + auth);
		return auth;
	}
	
	// 인증번호 확인 
	@ResponseBody
	@RequestMapping(value="member/authNum.do",
			method = RequestMethod.POST,
			produces = "application/text;charset=utf-8")
	public String authNum(String auth_num, String auth) {
	    auth = hash.toSHA256(auth);
	    if(auth_num.equals(auth)) {
	    	return "pass";
	    }
		return "fail";
	}
	
	@RequestMapping("/owner/my.do")
	public ModelAndView ownerMy(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		String mem_nickname = (String) req.getSession().getAttribute("mem_nickname");
		
		List<JoinMemberDogImgDTO> joinDtos = memberService.myPage(mem_nickname);
		mav.addObject("joinDtos", joinDtos);
		mav.setViewName("owner/my");		//ownerMy.jsp
		return mav;
	}
	
	// 반려견 정보 추가
	@RequestMapping("/owner/myPro.do")
	public ModelAndView addDog(JoinMemberDogImgDTO joinMemberDogImgDTO, HttpServletRequest request) {
		String mem_nickname = (String) request.getSession().getAttribute("mem_nickname");
		// 지금 로그인 하고있는 특정 회원의 반려견 정보만 추가하기 위해 dog table에 연결되어 있는 
		// member의 foreigh key인 member_id를 가져온다.
		String getForeign_Mem_id = memberService.getMem_id(mem_nickname);
		// 가져온 member_id를 DTO에 set해준다. 
		joinMemberDogImgDTO.setMem_id(getForeign_Mem_id);
	
		ModelAndView mav = new ModelAndView();
		
		MultipartFile[] files = joinMemberDogImgDTO.getFiles();
		ArrayList<String> filelist = new ArrayList<String>();
		String path = "C:/owner";
		for(int i=0; i<files.length; i++) {
			String fileName = files[i].getOriginalFilename();
			System.out.println("fileName: " + fileName);
			if(fileName.length()!=0) {
				String new_file = uploadService.upload(files[i], path, fileName);
				filelist.add(new_file);
			}
		}
		// foreigh key인 member_id를 담은 joinMemberDogImgDTO와 반려견 img file을 매개변수로 담아 처리한다.
		int result = memberService.addDog(joinMemberDogImgDTO, filelist);
		
		if(result == 1) {
			mav.setViewName("redirect:/owner/my.do");
		} else {
			mav.setViewName("owner/index");
		}	
		return mav;
	}
	
	// ajax용 반려견 정보 
	@ResponseBody
	@RequestMapping(value = "/owner/dogInfoList.do", method = RequestMethod.GET, 
		produces = "application/json;charset=utf-8")
	public List<JoinMemberDogImgDTO> dogInfoList(HttpServletRequest req, String dog_id) {
		System.out.println("ajaxdog_id: " + dog_id);
		String mem_nickname = (String)req.getSession().getAttribute("mem_nickname");		
		return memberService.getDogInfo(mem_nickname, dog_id);
	}	
	
	// 반려견 정보 수정
	@RequestMapping("/owner/modifyDog.do")
	public ModelAndView modifyDogInfo(HttpServletRequest req, JoinMemberDogImgDTO JoinMemberDogImgDTO) {
		memberService.modifyDogInfo(JoinMemberDogImgDTO);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/owner/my.do");
		return mav;
	}
	
	// 반려견 정보 삭제 
	@RequestMapping("/owner/delete.do")
	public ModelAndView delDogInfo(HttpServletRequest req, String dog_id) {
		System.out.println("del dog_id: " + dog_id);
		ModelAndView mav = new ModelAndView();
		memberService.delDog(dog_id);
		mav.setViewName("redirect:/owner/my.do");
		return mav;
	}
	
	// 회원 정보 수정 뷰단
	@RequestMapping("/owner/ownerMyInfoUpdate.do")
	public ModelAndView modifyInfo(HttpServletRequest req) {
		String mem_nickname = (String)req.getSession().getAttribute("mem_nickname");
		String mem_phone = memberService.getPhone_number(mem_nickname);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("phone", mem_phone);
		mav.addObject("mem_nickname", mem_nickname);
		mav.setViewName("owner/ownerMyInfoUpdateView");		// owner/ownerMyInfoUpdate.jsp
		return mav;
	}
		
	// 회원정보 수정
	@RequestMapping("/owner/ownerMyInfoUpdatePro.do")
	public ModelAndView modifyInfoPro(JoinMemberDogImgDTO joinMemberDogImgDTO, HttpServletRequest req) {
		String mem_nickname = (String)req.getSession().getAttribute("mem_nickname");
	
		ModelAndView mav = new ModelAndView();
		// 파일을 등록하는 논리는 회원가입시 반려견 사진 등록 메커니즘과 동일
		MultipartFile[] files = joinMemberDogImgDTO.getFiles();
		ArrayList<String> filelist = new ArrayList<String>();
		String path = "C:/owner";
		for(int i=0; i<files.length; i++) {
			String fileName = files[i].getOriginalFilename();
			if(fileName.length()!=0) {
				String new_file = uploadService.upload(files[i], path, fileName);
				filelist.add(new_file);
			}
		}
		// 뷰에서 넘어온 수정원하는 개인사진과 닉네임을 매개변수로 받아 DB에 update시키는 메소드
		int result = memberService.updateUserInfo(joinMemberDogImgDTO, filelist);
		// 특정회원의 filename 가져오는 메소드
		String filename = memberService.getProfile(mem_nickname);
		
		// 정상적으로 update시 1을 리턴받아 mem_nickname과 회원의 사진 filename을 session에 저장
		// ◈ filename을 session에 저장하는 이유 => 본 프로젝트는 tile을 이용하여 top, nav를 구성했는데 filename을 session에 
		// 저장하지 않은 경우 각 controller에 모두 filename을 ModelAndView의 setViewName에 저장해야 하는 번거로운 현상이 발생하였다.		
		if(result == 1) {
			req.getSession().setAttribute("mem_nickname", joinMemberDogImgDTO.getMem_nickname());
			req.getSession().setAttribute("filename", filename);
			mav.addObject("filename", filename);
			mav.setViewName("redirect:/owner/my.do");	
		} else if(result == 2) {
			mav.setViewName("redirect:/owner/my.do");
		} else {
			mav.setViewName("redirect:/owner/ownerMyInfoUpdate.do");
		}
		return mav; 
	}
}
