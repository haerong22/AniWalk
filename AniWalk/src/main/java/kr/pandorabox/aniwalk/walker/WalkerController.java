package kr.pandorabox.aniwalk.walker;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.pandorabox.aniwalk.Authentication;
import kr.pandorabox.aniwalk.SHA256;
import kr.pandorabox.aniwalk.member.MemberService;
import kr.pandorabox.aniwalk.review.ReviewDTO;
import kr.pandorabox.aniwalk.review.ReviewService;

@Controller
public class WalkerController {
	@Autowired
	private WalkerService walkerService;
	@Autowired
	private Authentication auth;
	@Autowired
	private SHA256 hash;
	@Autowired
	private MemberService memberService;
	@Autowired
	private ReviewService reviewService;
	
	
	// 펫 프렌즈 이메일 중복확인
	@ResponseBody
	@RequestMapping(value = "/walker/emailCheck.do",
			method = RequestMethod.GET)
	public String emailCheck(String email) {
		int result = walkerService.emailCheck(email);
		return result == 0 ? "y" : "n";
	}
	
	// 펫 프렌즈 신청 관리
	@RequestMapping("/manager/updateWalker.do")
	public String UpdateWalker(WalkerDTO walkerDto) {
		int result = walkerService.updateWalker(walkerDto);
		return "redirect:/manager/walkerInfo.do?wk_id="+walkerDto.getWk_id();
	}
	
	// 펫 프렌즈 아이디 생성
	@ResponseBody
	@RequestMapping(value = "/manager/createWalkerId.do",
			method = RequestMethod.POST,
			produces = "application/text;charset=utf-8")
	public String CreateWalkerId(WalkerDTO walkerDto) {
		int result = walkerService.createWakerId(walkerDto);
		if(result == 1) {
			return "success";
		}
		return "fail";
	}
	
	// owner페이지 펫 프렌즈 리스트
	@RequestMapping("owner/walker.do")
	public ModelAndView walkerList(String searchWalker, HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		List<WalkerDTO> list = walkerService.getWalkerList(searchWalker);
		
		mav.addObject("walkerList",list);
		mav.setViewName("owner/walkerList"); // ownerWalkerList.jsp
		return mav;
	}
	
	// owner페이지  펫 프렌즈 상세 정보
	@RequestMapping("owner/walkerInfo.do")
	public ModelAndView ownerWalkerInfo(String wk_id, HttpServletRequest req) {
		String mem_nickname = (String)req.getSession().getAttribute("mem_nickname");
		System.out.println(mem_nickname);
		ModelAndView mav = new ModelAndView();
		List<WalkerDTO> walkerInfo = walkerService.applierList(wk_id);
		List<ReviewDTO> reviewList = reviewService.getWalkerReviewList(wk_id);
	
		double total = reviewList.size() == 0 ? 0 : reviewList.stream()
				.mapToInt(review -> Integer.parseInt(review.getReview_score())).sum()/(double) reviewList.size();
		total = Math.round(total*10)/10.0;
		mav.setViewName("owner/walkerInfo");	// ownerWalkerInfo.jsp
		mav.addObject("reviewList", reviewList);
		mav.addObject("totalScore", total);
		mav.addObject("walkerInfo", walkerInfo);
		return mav;
	}
	
	// 인증번호 확인 
	@ResponseBody
	@RequestMapping(value="walker/authNum.do",
			method = RequestMethod.POST,
			produces = "application/text;charset=utf-8")
	public String authNum(String auth_num, String auth) {
	    //auth = hash.toSHA256(auth);
	    if(auth_num.equals(auth)) {
	    	return "pass";
	    }
		return "fail";
	}
	
	// 문자인증 메시지 보내기
	@ResponseBody
	@RequestMapping(value="walker/auth.do",
			method = RequestMethod.POST,
			produces = "application/text;charset=utf-8")
	public String auth(String wk_phone) {
		Random ran = new Random();
	    String auth = Integer.toString(ran.nextInt(899999) + 100000); 
	    System.out.println("auth: " + auth);
	    //auth = hash.toSHA256(auth);
	    System.out.println("auth2: " + auth);
		return auth;
	}
	
	// 펫 프렌즈 상세 정보
	@RequestMapping("manager/walkerInfo.do")
	public ModelAndView walkerInfo(String wk_id) {
		ModelAndView mav = new ModelAndView();
		List<WalkerDTO> walkerInfo = walkerService.applierList(wk_id);
		List<String> certificateImg = walkerService.certificateImg(wk_id); 
		mav.setViewName("manager/walkerInfo");
		mav.addObject("walkerInfo", walkerInfo);
		mav.addObject("certificateImg", certificateImg);
		return mav;
	}
	
	// 펫 프렌즈 리스트
	@RequestMapping("manager/walker.do")
	public ModelAndView ApplierList(String wk_id, HttpServletRequest req) {
		
		if(req.getSession().getAttribute("manager_id") == null) {
			ModelAndView mav = new ModelAndView();
			mav.setViewName("redirect:/manager/index.do");
			return mav;
		}
		
		String manager_id = (String)req.getSession().getAttribute("manager_id");	
		System.out.println("c manager_i: " + manager_id);
		
		ModelAndView mav = new ModelAndView();
		List<WalkerDTO> list = walkerService.applierList(wk_id);
		mav.addObject("applierList",list);
		mav.setViewName("manager/walker");	// manageApplier.jsp
		return mav;
	}
	
	// 지역
	@ResponseBody
	@RequestMapping(value="/walker/regionCheck.do", 
			method = RequestMethod.GET,
			produces = "application/json;charset=utf-8")
	public String[] city(String area) {
		String[] list = walkerService.getCity(area);
		return list;
	}
	
	// 펫 프렌즈 신청
	@RequestMapping("/apply.do")
	public String walkerApply(WalkerDTO walker, HttpServletRequest req) throws Exception {
		walker.setWk_location1(walker.getWk_location1()+" "+walker.getWk_location2());
		walker.setWk_location2(null);
		walkerService.walkerApply(walker);
		return "index";
	}


	
	//walker 로그인 유효성 검사
	@RequestMapping(value="/walker/loginCheck.do",
			method=RequestMethod.GET,
			produces = "application/json;charset=utf-8")
	public @ResponseBody int login(String walker_id, String wk_pw, HttpServletRequest request) {
		int result = walkerService.walkerLogin(walker_id,wk_pw);
		if(result > 0) {
			request.getSession().setAttribute("walker_id", walker_id);
		}
		return result;
	}
	
	//walker my page
	@RequestMapping("/walker/my.do")
	public ModelAndView walkerMy(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		String wallker_id = (String) request.getSession().getAttribute("walker_id");
		WalkerDTO walkerDto = walkerService.walkerInfo(wallker_id);
		List<WalkerDTO> reviewDtos = walkerService.review(wallker_id);
	
		mav.addObject("walkerDto", walkerDto);
		mav.addObject("reviewDtos", reviewDtos);
		mav.setViewName("walker/my");
		return mav;
	}
	
	
	//워커신청 폰 유효성검사
	@ResponseBody
	@RequestMapping(value="/walker/phoneCheck.do", 
			method = RequestMethod.GET,
			produces = "application/text;charset=utf-8")
	public String phoneCheck(String phoneNum) {
		String result = walkerService.phoneCheck(phoneNum);
		return result;
	}
	
	//개인정보 수정하기
	@RequestMapping("/walker/myInfo.do")
	public ModelAndView myInfoUpdate(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		String walker_id = (String) req.getSession().getAttribute("walker_id");
		WalkerDTO walkerDto = walkerService.myInfo(walker_id);
		
		List<String[]> location = new ArrayList<String[]>();
		location.add(walkerDto.getWk_location1().split(" "));
		System.out.println(walkerDto.getWk_location2());
		if(walkerDto.getWk_location2() != null && ! walkerDto.getWk_location2().equals("")) {
			location.add(walkerDto.getWk_location2().split(" "));
		}
		
		mav.addObject("location", location);
		mav.addObject("walkerDto", walkerDto);
		mav.setViewName("walker/myInfo");
		return mav;
	}
	
	//개인정보 수정완료
	
	@RequestMapping("/walker/myInfoModify.do")
	public String myInfoModify(WalkerDTO walker,String sido2,String gugun2,String sido1,String gugun1) {
		System.out.println("시군구"+sido2+gugun2);
		String wk_location1 = sido1 + " " + gugun1;
		String wk_location2 = sido2 + " " + gugun2;
		walker.setWk_location1(wk_location1);
		if(!sido2.contains("선택")) {
			walker.setWk_location2(wk_location2);
		}
		walkerService.myInfoUpdate(walker);
		
		return "redirect:/walker/my.do";
	}
	
}
