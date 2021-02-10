package kr.pandorabox.aniwalk.walking;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.pandorabox.aniwalk.member.MemberService;
import kr.pandorabox.aniwalk.review.ReviewDTO;
import kr.pandorabox.aniwalk.review.ReviewService;

@Controller
public class WalkingController {
	@Autowired
	private WalkingService walkingService;
	@Autowired
	private ReviewService reviewService;
	@Autowired
	MemberService memberService; 
	
	@RequestMapping("/owner/activDone.do")
	public ModelAndView getOwnerActivDoneInfo(String walking_id, HttpServletRequest req) {
		String mem_nickname = (String)req.getSession().getAttribute("mem_nickname");
		ModelAndView mav = new ModelAndView();
		String filename = memberService.getProfile(mem_nickname);
		List<WalkingDTO> missionList = walkingService.getMissionList(walking_id);
		WalkingDTO walkingInfo = walkingService.getWalkingInfo(walking_id);
		ReviewDTO review = reviewService.getReview(walking_id);
		mav.setViewName("owner/activDone");
		mav.addObject("filename", filename);
		mav.addObject("review", review);
		mav.addObject("missionList", missionList);
		mav.addObject("walkingInfo", walkingInfo);
		return mav;
	}
	
	@RequestMapping("/walker/activDone.do")
	public ModelAndView getActivDoneInfo(String walking_id) {
		ModelAndView mav = new ModelAndView();
		List<WalkingDTO> missionList = walkingService.getMissionList(walking_id);
		WalkingDTO walkingInfo = walkingService.getWalkingInfo(walking_id);
		mav.setViewName("walker/activDone");
		mav.addObject("missionList", missionList);
		mav.addObject("walkingInfo", walkingInfo);
		return mav;
	}
	
	@RequestMapping("/walker/main.do")
	public ModelAndView main(HttpServletRequest req) {
		String walker_id = (String) req.getSession().getAttribute("walker_id");
		List<WalkingDTO> walkingList = walkingService.getAllWalkingList(walker_id);
		return new ModelAndView("walker/main", "walkingList", walkingList);
	}	
	
	@RequestMapping("/walker/recruit/detail.do")
	public ModelAndView getSearchRecruitList(WalkingDTO walkingDto) {
		List<WalkingDTO> recruitList = walkingService.getSearchRecruitList(walkingDto);
		return new ModelAndView("walker/recruitlist", "recruitList", recruitList);
	}
	
	@ResponseBody
	@RequestMapping(value = "/walking/getWalkingMission.do",
			method = RequestMethod.POST,
			produces = "application/json;charset=utf-8")
	public List<WalkingDTO> getWalkingMission(String walking_id) {
		List<WalkingDTO> result = walkingService.getMissionList(walking_id);
		return result;
	}	
	
	@ResponseBody
	@RequestMapping(value = "/walking/getWalkingLocation.do",
			method = RequestMethod.POST,
			produces = "application/json;charset=utf-8")
	public List<WalkingDTO> getWalkingLocation(String walking_id) {
		List<WalkingDTO> path = walkingService.getWalkingLocation(walking_id);
		return path;
	}	
	
	@ResponseBody
	@RequestMapping(value = "/walker/insertWalkingLocation.do",
			method = RequestMethod.GET,
			produces = "application/text;charset=utf-8")
	public String walkingLocation(WalkingDTO walkingDto) {
		System.out.println(walkingDto.getWalking_lat());
		System.out.println(walkingDto.getWalking_lng());
		System.out.println(walkingDto.getWalking_id());
		int result = walkingService.insertWalkingLocation(walkingDto);
		return "success";
	}	
	
	@ResponseBody
	@RequestMapping(value = "/walking/walkingStart.do",
			method = RequestMethod.POST,
			consumes ={"multipart/form-data"})
	public List<WalkingDTO> walking(WalkingDTO walkingDto) {
		int result = walkingService.insertWalkingData(walkingDto);
		List<WalkingDTO> list = walkingService.getMissionList(walkingDto.getWalking_id());
		return list;
	}
	
	@RequestMapping("/walker/activList.do")
	public ModelAndView getWalkingList(HttpServletRequest req) {
		String walker_id = (String) req.getSession().getAttribute("walker_id");
		List<WalkingDTO> list = walkingService.getWalkingList(walker_id);
		return new ModelAndView("walker/activList", "activList", list);
	}

	@RequestMapping("/walker/activiting.do")
	public ModelAndView getMissionList(String walking_id) {
		ModelAndView mav = new ModelAndView();
		List<WalkingDTO> list = walkingService.getMissionList(walking_id);
		ReviewDTO review = reviewService.getReview(walking_id);
		mav.setViewName("walker/activiting");
		mav.addObject("review", review);
		mav.addObject("missionList", list);
		mav.addObject("walking_id",walking_id);
		return mav;
	}
	
	@RequestMapping("/walker/recruitlist.do")
	public ModelAndView recruitlist(String search, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		List<WalkingDTO> list = walkingService.getRecruitList(search);
		String walker_id = (String) request.getSession().getAttribute("walker_id");
		String wk_id = walkingService.wkId(walker_id);
		mav.addObject("wk_id", wk_id);
		mav.addObject("recruitList", list);
		mav.setViewName("walker/recruitlist");
		return mav;
	}
	
	@RequestMapping("/owner/recruit.do")
	public ModelAndView recruit(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String mem_nickname = (String) request.getSession().getAttribute("mem_nickname");
		//String filename = memberService.getProfile(mem_nickname);
		List<WalkingDTO> walkingDtos = walkingService.recruitDog(mem_nickname);
		String recruit_mem_id = walkingDtos.get(0).getMem_id();
		//mav.addObject("filename", filename);
		mav.addObject("recruit_mem_id",recruit_mem_id);
		mav.addObject("walkingDtos", walkingDtos);
		mav.setViewName("owner/recruit");	// owner/ownerRecruit.jsp
		return mav;
	}
	
	@RequestMapping("/owner/recruitInsert.do")
	public String recruitInsert(WalkingDTO walking) {
		int result = walkingService.recruitInsertUpdate(walking);
		return "redirect:/owner/recruitList.do";
	}
	
	@RequestMapping("/owner/recruitList.do")
	public ModelAndView list(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		String mem_nickname = (String) req.getSession().getAttribute("mem_nickname");
		String filename = memberService.getProfile(mem_nickname);
		List<WalkingDTO> walkingDtos= walkingService.recruitlist(mem_nickname);
		mav.addObject("filename", filename);
		mav.setViewName("owner/recruitList");
		mav.addObject("mem_nickname", mem_nickname);
		mav.addObject("walkingDtos", walkingDtos);
		return mav;
	}
	
	@RequestMapping(value="/walking/ajax_applyList.do",
			method = RequestMethod.GET,
			produces = "application/json;charset=utf-8")
	public @ResponseBody List<ApplyWalkingDTO> ajax_applyList(String walking_id){
		List<ApplyWalkingDTO> applyList = walkingService.applyList(walking_id);
		return applyList;
	}
	
	@RequestMapping("/walking/matching.do")
	public String matching(String match_wk_id, String walking_id) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("match_wk_id", match_wk_id);
		map.put("walking_id", walking_id);
		walkingService.matching(map);
		return "owner/activityList";
	}
	
	@RequestMapping("/owner/index.do")
	public ModelAndView ownerIndex(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		String mem_nickname = (String) req.getSession().getAttribute("mem_nickname");
		String filename = memberService.getProfile(mem_nickname);
		
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		Date today = new Date();
		String walk_date = format1.format(today);
		System.out.println("walk_date: " + walk_date);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mem_nickname", mem_nickname);
		map.put("walk_date", walk_date);
		
		List<WalkingDTO> todayList = walkingService.todayWalking(map);
		mav.addObject("filename", filename);
		mav.addObject("todayList", todayList);
		mav.setViewName("owner/index");
		return mav;
	}
	
	@RequestMapping("/owner/activityList.do")
	public ModelAndView todayWalking(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		String mem_nickname = (String) req.getSession().getAttribute("mem_nickname");
		String filename = memberService.getProfile(mem_nickname);
		List<WalkingDTO> allList =walkingService.allWalking(mem_nickname);
		mav.addObject("filename", filename);
		mav.addObject("allList", allList);
		mav.setViewName("owner/activityList");
		return mav;
	}
	
	@RequestMapping("/owner/activity.do")
	public ModelAndView walkingInfo(String walking_id, HttpServletRequest req) {
		String mem_nickname = (String)req.getSession().getAttribute("mem_nickname");
		ModelAndView mav = new ModelAndView();
		String filename = memberService.getProfile(mem_nickname);
		WalkingDTO walkingInfo = walkingService.getWalkingInfo(walking_id);
		List<WalkingDTO> missionList = walkingService.getMissionList(walking_id);
		mav.addObject("filename", filename);
		mav.addObject("walkingInfo", walkingInfo);
		mav.addObject("missionList", missionList);
		mav.setViewName("owner/activity");
		return mav;
	}
	
	@RequestMapping("walker/walkingRecruit.do")
	public String walkingRecruit(String walking_id, String wk_id) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("walking_id", walking_id);
		map.put("wk_id", wk_id);
		walkingService.walkingRecruit(map);
		return "redirect:/walker/recruitlist.do";
	}
	
	@RequestMapping(value="/walking/applyCheck.do",
			method = RequestMethod.GET,
			produces = "application/json;charset=utf-8")
	public @ResponseBody int applyCheck(String walking_id,String wk_id) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("walking_id", walking_id);
		map.put("wk_id", wk_id);
		
		int result=walkingService.applyCheck(map);
		
		return result;
	}
	
}
