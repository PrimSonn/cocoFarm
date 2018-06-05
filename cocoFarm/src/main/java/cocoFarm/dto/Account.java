package cocoFarm.dto;

import java.sql.Timestamp;

public class Account {
	private Integer idx;			//	게정번호- 복합기본키. 유일성(unique). 인조식별자 - 트리거 있음
	private String id;				//	계정 아이디 - null 안됨, unique
	private String pw;				//	계정 암호 null 안됨
	private String name;			//	사용자 이름 null 안됨
	private String email;			//	이메일
	private int phone;				//	전화번호
	private int phone2;				//	전화번호2
	private int postnum;			//	우편번호
	private String addr;			//	주소 - 도 시 구 동 까지만, api 따름
	private String detailed_addr;	//	세부주소
	private Integer type_code;		//	계정타입 - 외래키, null 안됨(식별관계) 기본값 3(트리거, 일반계정)
	private Integer isdel;			//	상태 확인 코드 - 복합기본키+ 외래키 null 안됨 기본값:0(트리거)
	private String thumb_img;		//	썸네일 위치 디렉토리+파일 이름
	private Timestamp reg_date;		//	계정 등록일 - null안됨, 트리거 있음
	
	public Integer getIdx() {
		return idx;
	}
	public void setIdx(Integer idx) {
		this.idx = idx;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getPhone() {
		return phone;
	}
	public void setPhone(int phone) {
		this.phone = phone;
	}
	public int getPhone2() {
		return phone2;
	}
	public void setPhone2(int phone2) {
		this.phone2 = phone2;
	}
	public int getPostnum() {
		return postnum;
	}
	public void setPostnum(int postnum) {
		this.postnum = postnum;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getDetailed_addr() {
		return detailed_addr;
	}
	public void setDetailed_addr(String detailed_addr) {
		this.detailed_addr = detailed_addr;
	}
	public Integer getType_code() {
		return type_code;
	}
	public void setType_code(Integer type_code) {
		this.type_code = type_code;
	}
	public Integer getIsdel() {
		return isdel;
	}
	public void setIsdel(Integer isdel) {
		this.isdel = isdel;
	}
	public String getThumb_img() {
		return thumb_img;
	}
	public void setThumb_img(String thumb_img) {
		this.thumb_img = thumb_img;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	
	
	@Override
	public String toString() {
		return "Account [idx="+idx
				+", id="+id
				+", pw="+pw
				+", name="+name
				+", email="+email
				+", phone="+phone
				+", phone2="+phone2
				+", postnum="+postnum
				+", addr="+addr
				+", detailed_addr="+detailed_addr
				+", type_code="+type_code
				+", isdel="+isdel
				+", thumb_img="+thumb_img
				+", reg_date="+reg_date+"]";
	}
	














}
