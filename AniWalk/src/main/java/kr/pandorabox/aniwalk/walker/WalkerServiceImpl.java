package kr.pandorabox.aniwalk.walker;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.pandorabox.aniwalk.FileUploadLogic;

@Service
public class WalkerServiceImpl implements WalkerService {
	@Autowired
	private WalkerDAO walkerDao;
	@Autowired
	private FileUploadLogic uploadService;
	
	@Override
	public int emailCheck(String email) {
		return walkerDao.emailCheck(email);
	}
	
	// 펫 프렌즈 자격증 정보 
	@Override
	public List<String> certificateImg(String wk_id) {
		return walkerDao.certificateImg(wk_id);
	}
	
	// 펫 프렌즈 아이디 생성
	@Override
	public int createWalkerId(WalkerDTO walkerDto) {
		return walkerDao.createWalkerId(walkerDto);
	}
	
	
	// 펫프렌즈 리스트
	@Override
	public List<WalkerDTO> applierList(String wk_id) {
		return walkerDao.applyierList(wk_id);
	}
	
	// 서류 통과 + 활동중인 walker 리스트
	@Override
	public List<WalkerDTO> getWalkerList(String searchWalker) {
		return walkerDao.getWalkerList(searchWalker);
		
	}
	
	// 펫 프렌즈 신청 관리
	@Override
	public int updateWalker(WalkerDTO walkerDto) {
		return walkerDao.updateWalker(walkerDto);
	}
	
	// 펫프렌즈 신청
	@Override
	public int walkerApply(WalkerDTO walker) {
		MultipartFile[] certifications = walker.getFiles();
		MultipartFile[] profile_imgs = walker.getWk_profile_imgs();
		ArrayList<String> filelist = new ArrayList<String>();
		ArrayList<String> profileImgList = new ArrayList<String>();
		
		String path = "C:/walker";
		for(int i=0; i<certifications.length; i++) {
			String fileName = certifications[i].getOriginalFilename();
			if(fileName.length()!=0) {
				String new_file = uploadService.upload(certifications[i], path, "certi" + fileName);
				filelist.add(new_file);
			}
		}
		
		for(int i=0; i<profile_imgs.length; i++) {
			String fileName = "profile" + profile_imgs[i].getOriginalFilename();
			String new_file = uploadService.upload(profile_imgs[i], path, fileName);
			profileImgList.add(new_file);
		}
		
		switch(profileImgList.size()) {
			case 3: walker.setWk_profile_img3(profileImgList.get(2));
			case 2: walker.setWk_profile_img2(profileImgList.get(1));
			case 1: walker.setWk_profile_img1(profileImgList.get(0));
			default: break;
		}
		
		int result = 0;
		int walker_result = 0; 
		int certificate_result = 0; 
		walker_result = walkerDao.walkerApply(walker);
		if(filelist.size() != 0) {
			for(String file : filelist) {
				certificate_result = walkerDao.walkerApply(file);
			}
			if(walker_result >= 1 && certificate_result >= 1) {
				result = 1;
			}
		}			
		return result;
	}
	
	// 지역 불러오기
	@Override
	public String[] getCity(String area) {
		String[] seoul = {"강남구", "강동구", "강북구", "강서구", "관악구", "광진구",
				"구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구",
				"서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구",
				"용산구", "은평구", "종로구", "중구", "중랑구"};
		String[] incheon = {"계양구", "남동구", "동구", "미추홀구", "부평구", "서구",
				"연수구", "중구", "강화군", "옹진군"};
		String[] daejeon = {"대덕구", "동구", "서구", "유성구", "중구"};
		String[] daegu = {"남구", "달서구", "동구", "북구", "서구", "수성구", "중구", "달성군"};
		String[] busan = {"강서구", "금정구", "남구", "동구", "동래구", "부산진구", "북구",
				"사상구", "사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구", "기장군"};
		String[] ulsan = {"남구", "동구", "북구", "중구", "울주군"};
		String[] gwangju = {"광산구", "남구", "동구", "북구", "서구"};
		String[] gyeonggi = {"고양시", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시",
				"남양주시", "동두천시", "부천시", "성남시", "수원시", "시흥시", "안산시", "안성시", "안양시",
				"양주시", "여주시", "오산시", "용인시", "의왕시", "의정부시", "이천시", "파주시", "평택시",
				"포천시", "하남시", "화성시", "가평군", "양평군", "연천군"};
		String[] chungnam = {"공주시", "계룡시", "논산시", "당진시", "보령시", "서산시", "아산시", "천안시",
				"금산군", "부여군", "서천군", "예산군", "청양군", "태안군", "홍성군"};
		String[] chungbuk = {"제천시", "청주시", "충주시", "괴산군", "단양군", "보은군", "영동군",
				"옥천군", "음성군", "증평군", "진천군"};
		String[] gangwon = {"강릉시", "동해시", "삼척시", "속초시", "원주시", "춘천시", "태백시",
				"고성군", "양구군", "양양군", "영월군", "인제군", "정선군", "철원군", "평창군", "홍천군", "화천군", "횡성군"};
		String[] gyeongbuk = {"경산시", "경주시", "구미시", "김천시", "문경시", "상주시", "안동시", 
				"영주시", "영천시", "포항시", "고령군", "군위군", "봉화군", "성주군", "영덕군", "영양군",
				"예천군", "울릉군", "울진군", "의성군", "청도군", "청송군", "칠곡군"};
		String[] gyeongnam = {"거제시", "김해시", "밀양시", "사천시", "양산시", "진주시", "창원시",
				"통영시", "거창군", "고성군", "남해군", "산청군", "의령군", "창녕군", "하동군", "함안군",
				"함양군", "합천군"};
		String[] jeonbuk = {"군산시", "김제시", "남원시", "익산시", "전주시", "정읍시", "고창군",
				"무주군", "부안군", "순창군", "완주군", "임실군", "장수군", "진안군"};
		String[] jeonnam = {"광양시", "나주시", "목포시", "순천시", "여수시", "강진군", "고흥군",
				"곡성군", "구례군", "담양군", "무안군", "보성군", "신안군", "영광군", "영암군", "완도군",
				"장성군", "장흥군", "진도군", "함평군", "해남군", "화순군"};
		String[] jeju = {"서귀포시", "제주시"};
		String[] sejong = {};
		switch(area) {
			case "강원도": return gangwon; 
			case "경기도": return gyeonggi;
			case "경상남도": return gyeongnam;
			case "경상북도": return gyeongbuk;
			case "광주광역시": return gwangju;
			case "대구광역시": return daegu;
			case "대전광역시": return daejeon;
			case "부산광역시": return busan;
			case "서울특별시": return seoul;
			case "세종특별자치시": return sejong;
			case "울산광역시": return ulsan; 
			case "인천광역시": return incheon;
			case "전라남도": return jeonnam;
			case "전라북도": return jeonbuk;
			case "제주특별자치도": return jeju;
			case "충청남도": return chungnam;
			case "충청북도": return chungbuk;
		}
		return null;
	}
	
	@Override
	public int walkerLogin(String walker_id, String wk_pw) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("walker_id",walker_id);
		map.put("wk_pw",wk_pw);
		int result = 0;
		int result_id = walkerDao.walkerLogin_id(walker_id);
		if(result_id ==1) {
			int result_idpw = walkerDao.walkerLogin(map);
			if(result_idpw==1) {
				result = 2; //아이디와 비밀번호가 일치
			}else {
				result = 3; //아이디와 비밀번호가 일치하지 않음
			}
		}else {
			result = 1; //아이디가 없음 
		}
		return result;
	}
	
	//워커신청 핸드폰체크
	@Override
	public String phoneCheck(String phoneNum) {
		return walkerDao.phoneCheck(phoneNum);
	}
	
	//my 페이지 워커 상세정보
	@Override
	public WalkerDTO walkerInfo(String walker_id) {
		return walkerDao.walkerInfo(walker_id);
	}
	
	@Override
	public List<WalkerDTO> review(String walker_id) {
		return walkerDao.review(walker_id);
	}
	
	@Override
	public WalkerDTO myInfo(String walker_id) {
		return walkerDao.myInfo(walker_id);
	}
	//개인정보수정
	@Override
	public int myInfoUpdate(WalkerDTO walker) {
		return walkerDao.myInfoUpdate(walker);
	}
}
