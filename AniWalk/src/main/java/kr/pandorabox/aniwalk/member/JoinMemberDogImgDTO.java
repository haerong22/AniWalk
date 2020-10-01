package kr.pandorabox.aniwalk.member;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class JoinMemberDogImgDTO {
	String mem_id;
	String mem_nickname;
	String kakao_id;
	int mem_point;
	String mem_profile_img;
	Date mem_join_date;
	String dog_id;
	String dog_name;
	String dog_type;
	String dog_size;
	String dog_info;
	Date dog_birth;
	String dog_img_id;
	String dog_image;
	MultipartFile[] files;
	
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getMem_nickname() {
		return mem_nickname;
	}
	public void setMem_nickname(String mem_nickname) {
		this.mem_nickname = mem_nickname;
	}
	public String getKakao_id() {
		return kakao_id;
	}
	public void setKakao_id(String kakao_id) {
		this.kakao_id = kakao_id;
	}
	public int getMem_point() {
		return mem_point;
	}
	public void setMem_point(int mem_point) {
		this.mem_point = mem_point;
	}
	public String getMem_profile_img() {
		return mem_profile_img;
	}
	public void setMem_profile_img(String mem_profile_img) {
		this.mem_profile_img = mem_profile_img;
	}
	public Date getMem_join_date() {
		return mem_join_date;
	}
	public void setMem_join_date(Date mem_join_date) {
		this.mem_join_date = mem_join_date;
	}
	public String getDog_id() {
		return dog_id;
	}
	public void setDog_id(String dog_id) {
		this.dog_id = dog_id;
	}
	public String getDog_name() {
		return dog_name;
	}
	public void setDog_name(String dog_name) {
		this.dog_name = dog_name;
	}
	public String getDog_type() {
		return dog_type;
	}
	public void setDog_type(String dog_type) {
		this.dog_type = dog_type;
	}
	public String getDog_size() {
		return dog_size;
	}
	public void setDog_size(String dog_size) {
		this.dog_size = dog_size;
	}
	public String getDog_info() {
		return dog_info;
	}
	public void setDog_info(String dog_info) {
		this.dog_info = dog_info;
	}
	public Date getDog_birth() {
		return dog_birth;
	}
	public void setDog_birth(Date dog_birth) {
		this.dog_birth = dog_birth;
	}
	public String getDog_img_id() {
		return dog_img_id;
	}
	public void setDog_img_id(String dog_img_id) {
		this.dog_img_id = dog_img_id;
	}
	public String getDog_image() {
		return dog_image;
	}
	public void setDog_image(String dog_image) {
		this.dog_image = dog_image;
	}
	public MultipartFile[] getFiles() {
		return files;
	}
	public void setFiles(MultipartFile[] files) {
		this.files = files;
	}
	
	
	
	
	
}
