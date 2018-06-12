package cocoFarm.dto;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class Board {
	
	private int acc_idx;
	private String title;
//	private String writerid;
	private String content;
	private Date written_date;
	private String main_img; //여기에 프로필 사진 조회해서 가지고 오기 
	private int hit;
	private int recommend;
	
	private MultipartFile fileup;
	
	private String stored_filename;
				
	public String getStored_filename() {
		return stored_filename;
	}
	public void setStored_filename(String stored_filename) {
		this.stored_filename = stored_filename;
	}
	
	public MultipartFile getFileup() {
		return fileup;
	}
	public void setFileup(MultipartFile fileup) {
		this.fileup = fileup;
	}
	public int getAcc_idx() {
		return acc_idx;
	}
	public void setAcc_idx(int acc_idx) {
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
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public int getRecommend() {
		return recommend;
	}
	public void setRecommend(int recommend) {
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
