package kr.pandorabox.aniwalk.walker;

import java.sql.Date;
import java.util.Arrays;

import org.springframework.web.multipart.MultipartFile;

public class WalkerDTO {
	private String wk_id;
	private String wk_name;
	private String walker_id;
	private String wk_pw;
	private String wk_phone;
	private String wk_birth;
	private String wk_email;
	private String wk_addr;
	private String wk_profile_img1;
	private String wk_profile_img2;
	private String wk_profile_img3;
	private String wk_event_agree;
	private String wk_location;
	private int wk_point;
	private Date apply_date;
	private int apply_state;
	private Date activity_start_date;
	private int activity_state;
	MultipartFile[] files;
	
	//리뷰테이블
	private String review_id;
	private String mem_id;
	private String review_contents;
	private String review_score;
	private Date review_date;
	private String mem_nickname;
	
	@Override
	public String toString() {
		return "WalkerDTO [wk_id=" + wk_id + ", wk_name=" + wk_name + ", walker_id=" + walker_id + ", wk_pw=" + wk_pw
				+ ", wk_phone=" + wk_phone + ", wk_birth=" + wk_birth + ", wk_email=" + wk_email + ", wk_addr="
				+ wk_addr + ", wk_profile_img1=" + wk_profile_img1 + ", wk_profile_img2=" + wk_profile_img2
				+ ", wk_profile_img3=" + wk_profile_img3 + ", wk_event_agree=" + wk_event_agree + ", wk_location="
				+ wk_location + ", wk_point=" + wk_point + ", apply_date=" + apply_date + ", apply_state=" + apply_state
				+ ", activity_start_date=" + activity_start_date + ", activity_state=" + activity_state + ", files="
				+ Arrays.toString(files) + "]";
	}
	
	public String getWk_id() {
		return wk_id;
	}
	public String getWk_name() {
		return wk_name;
	}
	public String getWalker_id() {
		return walker_id;
	}
	public String getWk_pw() {
		return wk_pw;
	}
	public String getWk_phone() {
		return wk_phone;
	}
	public String getWk_birth() {
		return wk_birth;
	}
	public String getWk_email() {
		return wk_email;
	}
	public String getWk_addr() {
		return wk_addr;
	}
	public String getWk_profile_img1() {
		return wk_profile_img1;
	}
	public String getWk_profile_img2() {
		return wk_profile_img2;
	}
	public String getWk_profile_img3() {
		return wk_profile_img3;
	}
	public String getWk_event_agree() {
		return wk_event_agree;
	}
	public String getWk_location() {
		return wk_location;
	}
	public int getWk_point() {
		return wk_point;
	}
	public Date getApply_date() {
		return apply_date;
	}
	public int getApply_state() {
		return apply_state;
	}
	public Date getActivity_start_date() {
		return activity_start_date;
	}
	public int getActivity_state() {
		return activity_state;
	}
	public MultipartFile[] getFiles() {
		return files;
	}
	public void setWk_id(String wk_id) {
		this.wk_id = wk_id;
	}
	public void setWk_name(String wk_name) {
		this.wk_name = wk_name;
	}
	public void setWalker_id(String walker_id) {
		this.walker_id = walker_id;
	}
	public void setWk_pw(String wk_pw) {
		this.wk_pw = wk_pw;
	}
	public void setWk_phone(String wk_phone) {
		this.wk_phone = wk_phone;
	}
	public void setWk_birth(String wk_birth) {
		this.wk_birth = wk_birth;
	}
	public void setWk_email(String wk_email) {
		this.wk_email = wk_email;
	}
	public void setWk_addr(String wk_addr) {
		this.wk_addr = wk_addr;
	}
	public void setWk_profile_img1(String wk_profile_img1) {
		this.wk_profile_img1 = wk_profile_img1;
	}
	public void setWk_profile_img2(String wk_profile_img2) {
		this.wk_profile_img2 = wk_profile_img2;
	}
	public void setWk_profile_img3(String wk_profile_img3) {
		this.wk_profile_img3 = wk_profile_img3;
	}
	public void setWk_event_agree(String wk_event_agree) {
		this.wk_event_agree = wk_event_agree;
	}
	public void setWk_location(String wk_location) {
		this.wk_location = wk_location;
	}
	public void setWk_point(int wk_point) {
		this.wk_point = wk_point;
	}
	public void setApply_date(Date apply_date) {
		this.apply_date = apply_date;
	}
	public void setApply_state(int apply_state) {
		this.apply_state = apply_state;
	}
	public void setActivity_start_date(Date activity_start_date) {
		this.activity_start_date = activity_start_date;
	}
	public void setActivity_state(int activity_state) {
		this.activity_state = activity_state;
	}
	public void setFiles(MultipartFile[] files) {
		this.files = files;
	}

	public String getReview_id() {
		return review_id;
	}

	public void setReview_id(String review_id) {
		this.review_id = review_id;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public String getReview_contents() {
		return review_contents;
	}

	public void setReview_contents(String review_contents) {
		this.review_contents = review_contents;
	}

	public String getReview_score() {
		return review_score;
	}

	public void setReview_score(String review_score) {
		this.review_score = review_score;
	}

	public Date getReview_date() {
		return review_date;
	}

	public void setReview_date(Date review_date) {
		this.review_date = review_date;
	}

	public String getMem_nickname() {
		return mem_nickname;
	}

	public void setMem_nickname(String mem_nickname) {
		this.mem_nickname = mem_nickname;
	}
	
	
	
	
	
}
