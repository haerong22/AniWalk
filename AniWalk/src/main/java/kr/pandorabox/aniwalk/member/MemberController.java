package kr.pandorabox.aniwalk.member;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import kr.pandorabox.aniwalk.FileUploadLogic;

@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService; 
	
	@Autowired
	FileUploadLogic uploadService;
	
	@RequestMapping("/loginPro.do")
	public ModelAndView checkMember(int kakao_id, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		String mem_nickname = memberService.joinCheck(kakao_id);
		String filename = memberService.getProfile(mem_nickname);
		System.out.println("filename : " + filename );
		
		if(mem_nickname == null) {
			mav.setViewName("login");		// main/signUp.jsp
			return mav;
		} else {
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
	public ModelAndView joinMember(JoinMemberDogImgDTO joinMemberDogImgDTO, HttpServletRequest request) throws Exception {
		String mem_nickname = joinMemberDogImgDTO.getMem_nickname();
		
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
		
		int result = memberService.joinMember(joinMemberDogImgDTO, filelist);
		
		if(result == 1) {
			request.getSession().setAttribute("mem_nickname", mem_nickname);
			mav.setViewName("redirect:/owner/index.do");
		} else {
			mav.setViewName("login");
		}	
		return mav;
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
		String getForeign_Mem_id = memberService.getMem_id(mem_nickname);
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
			
			int result = memberService.updateUserInfo(joinMemberDogImgDTO, filelist);
			String filename = memberService.getProfile(mem_nickname);

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
