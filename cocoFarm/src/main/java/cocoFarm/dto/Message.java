package cocoFarm.dto;

import java.util.Date;

public class Message {
	private int idx;
	private int sender_idx;
	private String sender; 
	private int receiver_idx;
	private String receiver; 
	private String title;
	private String content;
	private Date written_time;
	private int is_read;
	private Date read_time;
	private int type_code;
	private int isdel;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getSender_idx() {
		return sender_idx;
	}
	public void setSender_idx(int sender_idx) {
		this.sender_idx = sender_idx;
	}
	public int getReceiver_idx() {
		return receiver_idx;
	}
	public void setReceiver_idx(int receiver_idx) {
		this.receiver_idx = receiver_idx;
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
	public Date getWritten_time() {
		return written_time;
	}
	public void setWritten_time(Date written_time) {
		this.written_time = written_time;
	}
	public int getIs_read() {
		return is_read;
	}
	public void setIs_read(int is_read) {
		this.is_read = is_read;
	}
	public Date getRead_time() {
		return read_time;
	}
	public void setRead_time(Date read_time) {
		this.read_time = read_time;
	}
	public int getType_code() {
		return type_code;
	}
	public void setType_code(int type_code) {
		this.type_code = type_code;
	}
	public int getIsdel() {
		return isdel;
	}
	public void setIsdel(int isdel) {
		this.isdel = isdel;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	
	@Override
	public String toString() {
		return "Message {idx=" + idx 
				+ ", sender_idx=" + sender_idx 
				+ ", sender=" + sender 
				+ ", receiver_idx=" + receiver_idx
				+ ", receiver=" + receiver
				+ ", title=" + title
				+ ", content=" + content
				+ ", written_time=" + written_time
				+ ", is_read=" + is_read
				+ ", read_time=" + read_time
				+ ", type_code=" + type_code
				+ ", isdel=" + isdel;
	}
}
