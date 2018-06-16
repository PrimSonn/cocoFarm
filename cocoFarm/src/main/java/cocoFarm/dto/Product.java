package cocoFarm.dto;

import java.util.Date;

public class Product {
	private Integer idx;
	private Integer accIdx;
	private String title;
	private String origin;
	private Integer hit;
	private Date writtenTime;
	private Date lastEdited;
	private String content;
	private String faceImg;
	private String mainImg;
	private Integer isdel;
	
	//2018 05 31 hwanmin update
	//user table
	private String name; 					//계정 이름
	
	private String thumb_img;				//계정 이미지
	private String email;					//이메일 주소
	
	//business table
	private String corporation_name;		//법인 명
	private Integer business_license_code;		//사업자번호
	private String representative;			//대표자 이름
	private String business_addr;			//판매자 주소
	private String business_category;		//업태 종류 		

	//category, ltc table
	private Integer category;					//카테고리 번호
	private String category_name;			//카테고리 이름
	private String min_price; 				//옵션 최소 가격 받아오기
	private String search_name; 			//검색할 이름
	
	public Integer getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public Integer getAccIdx() {
		return accIdx;
	}
	public void setAccIdx(int accIdx) {
		this.accIdx = accIdx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getOrigin() {
		return origin;
	}
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	public Integer getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public Date getWrittenTime() {
		return writtenTime;
	}
	public void setWrittenTime(Date writtenTime) {
		this.writtenTime = writtenTime;
	}
	public Date getLastEdited() {
		return lastEdited;
	}
	public void setLastEdited(Date lastEdited) {
		this.lastEdited = lastEdited;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFaceImg() {
		return faceImg;
	}
	public void setFaceImg(String faceImg) {
		this.faceImg = faceImg;
	}
	public String getMainImg() {
		return mainImg;
	}
	public void setMainImg(String mainImg) {
		this.mainImg = mainImg;
	}
	public Integer getIsdel() {
		return isdel;
	}
	public void setIsdel(int isdel) {
		this.isdel = isdel;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getThumb_img() {
		return thumb_img;
	}
	public void setThumb_img(String thumb_img) {
		this.thumb_img = thumb_img;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCorporation_name() {
		return corporation_name;
	}
	public void setCorporation_name(String corporation_name) {
		this.corporation_name = corporation_name;
	}
	public Integer getBusiness_license_code() {
		return business_license_code;
	}
	public void setBusiness_license_code(int business_license_code) {
		this.business_license_code = business_license_code;
	}
	public String getRepresentative() {
		return representative;
	}
	public void setRepresentative(String representative) {
		this.representative = representative;
	}
	public String getBusiness_addr() {
		return business_addr;
	}
	public void setBusiness_addr(String business_addr) {
		this.business_addr = business_addr;
	}
	public String getBusiness_category() {
		return business_category;
	}
	public void setBusiness_category(String business_category) {
		this.business_category = business_category;
	}
	public Integer getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public String getMin_price() {
		return min_price;
	}
	public void setMin_price(String min_price) {
		this.min_price = min_price;
	}
	public String getSearch_name() {
		return search_name;
	}
	public void setSearch_name(String search_name) {
		this.search_name = search_name;
	}
	@Override
	public String toString() {
		return "Product [idx=" + idx
				+ ", accIdx=" + accIdx
				+ ", title=" + title
				+ ", origin=" + origin
				+ ", hit=" + hit
				+ ", writtenTime=" + writtenTime
				+ ", lastEdited=" + lastEdited
				+ ", content=" + content
				+ ", faceImg=" + faceImg
				+ ", mainImg=" + mainImg
				+ ", isdel=" + isdel
				+ "]";
	}
}
