package cocoFarm.dto;

import java.util.Date;

public class Product {
	private int idx;
	private int accIdx;
	private String title;
	private String origin;
	private int hit;
	private Date writtenTime;
	private Date lastEdited;
	private String content;
	private String faceImg;
	private String mainImg;
	private int isdel;
	private int category;
	
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getAccIdx() {
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
	public int getHit() {
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
	public int getIsdel() {
		return isdel;
	}
	public void setIsdel(int isdel) {
		this.isdel = isdel;
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
