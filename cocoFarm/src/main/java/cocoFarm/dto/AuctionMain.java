package cocoFarm.dto;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

public class AuctionMain {

	
	private Integer idx;	//	경매번호 - 유일성. 복합기본키, 인조식별자. 트리거 있음
	private Integer writter_idx;	//	작성자 인덱스 - 외래키. null 불가
	private Timestamp reg_time;	//	작성시간 - null 불가. 트리거 있음
	private Integer	time_window_code;	//	경매 기간 타입 - 외래키. null불가 트리거 있음(기본값:1 - 3일)
	private Integer start_price;	//	시작가격 - null 불가. 0이상
	private String title;	//	글제목 - null 불가
	private String content;	//	글내용 - null 불가
	private Integer state_code;	//	경매 상태 비즈니스 코드 - 외래키. 트리거 있음
	private String item_img;	//	경매물품 사진 경로(이름)- null 불가
	private Integer highest_bid;	//	최고 입찰액 - 일종의 중복값, 병행 처리를 쉽게 하기 위해 넣은 속성: 경매 행을 lock 한 상태에서 입찰이 이루어짐
	private MultipartFile img_file;	//	경매 물품 사진
	private Timestamp time_window;	// 경매 만료일자
	
	private String id;		// 경매 글 쓴 계정 id
	
	private Integer isDone;	
	
	
	//hwanmin 추가 
	private long business_license_code;
	private String corporation_name;
	private String representative;
	private String  business_addr;
	private String business_category; 
	private Integer acc_idx;
	private String acc_name;
	private String thumb_loc;
	
	
	
	
	
	
	
	
	public long getBusiness_license_code() {
		return business_license_code;
	}
	public void setBusiness_license_code(long business_license_code) {
		this.business_license_code = business_license_code;
	}
	public String getCorporation_name() {
		return corporation_name;
	}
	public void setCorporation_name(String corporation_name) {
		this.corporation_name = corporation_name;
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
	public Integer getAcc_idx() {
		return acc_idx;
	}
	public void setAcc_idx(Integer acc_idx) {
		this.acc_idx = acc_idx;
	}
	public String getAcc_name() {
		return acc_name;
	}
	public void setAcc_name(String acc_name) {
		this.acc_name = acc_name;
	}
	public String getThumb_loc() {
		return thumb_loc;
	}
	public void setThumb_loc(String thumb_loc) {
		this.thumb_loc = thumb_loc;
	}
	public Integer getIsDone() {
		return isDone;
	}
	public void setIsDone(Integer isDone) {
		this.isDone = isDone;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}


	private String name;	// 경매 글 쓴이 이름
	
	private Timestamp systime;	// 오라클 현재시간
	
	
	public Timestamp getSystime() {
		return systime;
	}
	public void setSystime(Timestamp systime) {
		this.systime = systime;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Timestamp getTime_window() {
		return time_window;
	}
	public void setTime_window(Timestamp time_window) {
		this.time_window = time_window;
	}


	
	public MultipartFile getImg_file() {
		return img_file;
	}
	public void setImg_file(MultipartFile img_file) {
		this.img_file = img_file;
	}
	public Timestamp getReg_time() {
		return reg_time;
	}
	public void setReg_time(Timestamp reg_time) {
		this.reg_time = reg_time;
	}
	public Integer getState_code() {
		return state_code;
	}
	public void setState_code(Integer state_code) {
		this.state_code = state_code;
	}
	public Integer getHighest_bid() {
		return highest_bid;
	}
	public void setHighest_bid(Integer highest_bid) {
		this.highest_bid = highest_bid;
	}
	public Integer getIdx() {
		return idx;
	}
	public void setIdx(Integer idx) {
		this.idx = idx;
	}
	public Integer getWritter_idx() {
		return writter_idx;
	}
	public void setWritter_idx(Integer writter_idx) {
		this.writter_idx = writter_idx;
	}
	public Integer getTime_window_code() {
		return time_window_code;
	}
	public void setTime_window_code(Integer time_window_code) {
		this.time_window_code = time_window_code;
	}
	public Integer getStart_price() {
		return start_price;
	}
	public void setStart_price(Integer start_price) {
		this.start_price = start_price;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getItem_img() {
		return item_img;
	}
	public void setItem_img(String item_img) {
		this.item_img = item_img;
	}

	
	@Override
	public String toString() {
		return "Auction [idx="+idx
				+", writter_idx="+writter_idx
				+", reg_time="+reg_time
				+", time_window_code="+time_window_code
				+", start_price="+start_price
				+", title="+title
				+", content="+content
				+", state_code="+state_code
				+", item_img="+item_img
				+", time_window="+time_window
				+", id="+id
				+", systime="+systime
				+", isDone="+isDone
				+", name="+name
				+", highest_bid="+highest_bid+"]";
	}


}
