package kr.pandorabox.aniwalk.manager;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.pandorabox.aniwalk.member.JoinMemberDogImgDTO;
import kr.pandorabox.aniwalk.member.MemberService;

@Controller
public class ManagerController {
	
	@Autowired
	private ManagerService managerService;
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("manager/index.do")
	public String index(HttpServletRequest req) {
		String manager_id = (String)req.getSession().getAttribute("manager_id");
		System.out.println("manager_id: " + manager_id);
		System.out.println(req.getSession().getAttribute("result"));
		if(manager_id == null) {
			req.getSession().removeAttribute("result");
			return "manager/index";
		} else {
			return "redirect:/manager/user.do";
		}
		
	}
	
	@RequestMapping(value = "manager/indexPro.do", method = RequestMethod.POST)
	public ModelAndView index(String manager_id, String manager_pw, HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		
		int result = managerService.managerLogin(manager_id, manager_pw);
		System.out.println("result: " + result);
		if(result == 0 || result == -1) {
			
			mav.setViewName("redirect:/manager/index.do");	
			return mav;	// managerIndex.jsp
		} else {
			req.getSession().setAttribute("manager_id", manager_id);
			req.getSession().setAttribute("result", result);
			
			mav.setViewName("redirect:/manager/user.do");	
			return mav;	
		}
		
	}
	
	@RequestMapping("manager/user.do")
	public ModelAndView memberList(HttpServletRequest req) {
		
		String manager_id = (String)req.getSession().getAttribute("manager_id");	
		int result = (int) req.getSession().getAttribute("result");
		if(manager_id != null) {	
			ModelAndView mav = new ModelAndView();
			List<MemberDTO> memlist = managerService.memberList();
			
			mav.addObject("result", result);
			mav.addObject("memlist", memlist);
			mav.setViewName("manager/user");	// manageUser.jsp
			return mav;
		} else {
			ModelAndView mav = new ModelAndView();
			req.getSession().setAttribute("manager_id", null);
			mav.setViewName("manager/index");		// manager/managerIndex.jsp
			return mav;
		}
		
	}
	
	@RequestMapping("manager/logout.do")
	public String logout(HttpServletRequest req) {
		req.getSession().removeAttribute("manager_id");
		req.getSession().removeAttribute("result");
		return "redirect:/manager/index.do";
	}
	
	@RequestMapping("manager/userInfo.do")
	public ModelAndView userInfo(String kakao_id) {
		ModelAndView mav = new ModelAndView();
		List<JoinMemberDogImgDTO> userList = managerService.userInfo(kakao_id);		
		
		String mem_profile = memberService.getProfile(userList.get(0).getMem_nickname());
		mav.addObject("mem_profile", mem_profile);
		mav.addObject("userList", userList);
		mav.setViewName("manager/userInfo");	// manageUserInfo.jsp
		return mav;
	}
	
	@RequestMapping("manager/manageMatching.do")
	public ModelAndView manageMatching(HttpServletRequest req) {
		if(req.getSession().getAttribute("manager_id") == null) {
			ModelAndView mav = new ModelAndView();
			mav.setViewName("redirect:/manager/index.do");
			return mav;
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/manageMatching");
		return mav;
	}
	
	@RequestMapping("manager/managePoint.do")
	public ModelAndView managePonint(HttpServletRequest req) {
		if(req.getSession().getAttribute("manager_id") == null) {
			ModelAndView mav = new ModelAndView();
			mav.setViewName("redirect:/manager/index.do");
			return mav;
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/managePoint");
		return mav;
	}
}
