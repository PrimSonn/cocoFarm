package cocoFarm.dto;

import java.util.Date;

public class Board {
	
	private Integer acc_idx;
	private String title;
//	private String writerid;
	private String content;
	private Date written_date;
	private String main_img;
	private Integer hit;
	private Integer recommend;
	
	public Integer getAcc_idx() {
		return acc_idx;
	}
	public void setAcc_idx(Integer acc_idx) {
		this.acc_idx = acc_idx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
//	public String getWriterid() {
//		return writerid;
//	}
//	public void setWriterid(String writerid) {
//		this.writerid = writerid;
//	}
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
	public String getMain_img() {
		return main_img;
	}
	public void setMain_img(String main_img) {
		this.main_img = main_img;
	}
	public Integer getHit() {
		return hit;
	}
	public void setHit(Integer hit) {
		this.hit = hit;
	}
	public Integer getRecommend() {
		return recommend;
	}
	public void setRecommend(Integer recommend) {
		this.recommend = recommend;
	}
	
	@Override
	public String toString() {
		return "Board [ACC_IDX=" + acc_idx 
				+", TITLE=" + title
//				+", WRITERID=" + writerid
				+", CONTENT=" + content 
				+", WRITTEN_DATE=" + written_date 
				+", MAIN_IMG=" + main_img 
				+", HIT=" + hit 
				+", RECOMMEND=" + recommend + "]";		
	}
	

}
