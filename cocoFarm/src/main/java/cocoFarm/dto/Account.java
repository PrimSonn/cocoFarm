package cocoFarm.dto;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Account {
	
	private int idx;
	private String id;
	private String pw;
	private Date regDate;
	
	@Override
	public boolean equals(Object obj) {
		
		if(obj!=null&&obj.getClass().isInstance(this)) {
			String id = ((Account)obj).getId();
			String pw = ((Account)obj).getPw();
			if(id!=null&&pw!=null) {
				if(id.matches(this.id)&pw.matches(this.pw)) {
					return true;
				}
			}
		}else {
		}
		return super.equals(obj);
	}
	
	@Override
	public String toString() {
		return "Account [idx: "+idx+" ,id: "+id+" ,pw: "+pw+" ,regDate: "+regDate+"]";
	}
	
	public int getIdx() {
		return idx;
	}public void setIdx(int idx) {
		this.idx = idx;
	}public String getId() {
		return id;
	}public void setId(String id) {
		this.id = id;
	}public String getRegDate() {
		if(regDate!=null) {
			DateFormat formatter = new SimpleDateFormat("YYYY/MM/dd");
			return formatter.format(regDate);
		}else {
			return "";
		}
	}public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}public String getPw() {
		return pw;
	}public void setPw(String pw) {
		this.pw = pw;
	}
}
