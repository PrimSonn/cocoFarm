package cocoFarm.dto;

import java.util.Date;

public class Account {
	private int idx;
	private String id;
	private String pw;
	private String name;
	private String email;
	private String phone;
	private String postnum;
	private String addr;
	private String detailed_addr;
	private int account_type;
	private String thumb_loc;
	private Date reg_date;
	private int isDel;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
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
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPostnum() {
		return postnum;
	}
	public void setPostnum(String postnum) {
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
	public int getAccount_type() {
		return account_type;
	}
	public void setAccount_type(int account_type) {
		this.account_type = account_type;
	}
	public String getThumb_loc() {
		return thumb_loc;
	}
	public void setThumb_loc(String thumb_loc) {
		this.thumb_loc = thumb_loc;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public int getIsDel() {
		return isDel;
	}
	public void setIsDel(int isDel) {
		this.isDel = isDel;
	}
	@Override
	public String toString() {
		return "ACCOUNT [idx=" + idx
				+ ", id=" + id
				+ ", pw=" + pw
				+ ", name=" + name
				+ ", email=" + email
				+ ", phone=" + phone
				+ ", postnum=" + postnum
				+ ", addr=" + addr
				+ ", detailed_addr=" + detailed_addr
				+ ", account_type=" + account_type
				+ ", thumb_loc=" + thumb_loc
				+ ", reg_date=" + reg_date + "]";
	}
}
