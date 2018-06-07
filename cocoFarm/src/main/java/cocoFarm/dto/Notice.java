package cocoFarm.dto;

import java.util.Date;

public class Notice {

	private Integer idx;
	private Integer writer_idx;
	private String title;
	private String writerName;	
	private String content;		
	private Date written_date;
	private Date last_edited;
	
	public Integer getIdx() {
		return idx;
	}
	public void setIdx(Integer idx) {
		this.idx = idx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setWriter_idx(Integer writer_idx){
		this.writer_idx = writer_idx;
	}
	public Integer getWriter_idx(){
		return writer_idx;
	}
	public String getWriterName() {
		return writerName;
	}
	public void setWriterName(String writerName) {
		this.writerName = writerName;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getWritten_date() {
		return written_date;
	}
	public void setWritten_date(Date written_date) {
		this.written_date = written_date;
	}
	public Date getLast_edited() {
		return last_edited;
	}
	public void setLast_edited(Date last_edited) {
		this.last_edited = last_edited;
	}
	@Override
	public String toString() {
		return "Notice [idx=" + idx
				+", writer_idx=" + writer_idx
				+", title=" + title
				+", writerName=" + writerName
				+", content=" + content				
				+", writtendate=" + written_date
				+", last_edited=" + last_edited+"]";
	}
	

}