package cocoFarm.dto;

import java.util.Date;

public class Comment {
	private int sale_idx;
	private int main_recpt_idx;
	private int score;
	private String title;
	private String content;
	private Date reg_time;
	private Date last_edited;
	private int isdel;
	
	public int getSale_idx() {
		return sale_idx;
	}
	public void setSale_idx(int sale_idx) {
		this.sale_idx = sale_idx;
	}
	public int getMain_recpt_idx() {
		return main_recpt_idx;
	}
	public void setMain_recpt_idx(int main_recpt_idx) {
		this.main_recpt_idx = main_recpt_idx;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
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
	public Date getReg_time() {
		return reg_time;
	}
	public void setReg_time(Date reg_time) {
		this.reg_time = reg_time;
	}
	public Date getLast_edited() {
		return last_edited;
	}
	public void setLast_edited(Date last_edited) {
		this.last_edited = last_edited;
	}
	public int getIsdel() {
		return isdel;
	}
	public void setIsdel(int isdel) {
		this.isdel = isdel;
	}
	@Override
	public String toString() {
		return "Comment [saleIdx=" + sale_idx
				+ ", main_recpt_idx=" + main_recpt_idx
				+ ", score=" + score
				+ ", title=" + title
				+ ", content=" + content
				+ ", reg_time=" + reg_time
				+ ", last_edited=" + last_edited
				+ ", isdel=" + isdel
				+ "]";
	}
}
