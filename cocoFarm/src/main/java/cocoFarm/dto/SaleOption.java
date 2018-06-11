package cocoFarm.dto;

import java.util.Date;

import cocoFarm.util.recptMaker.SaleOptSerializer;

public class SaleOption implements SaleOptSerializer {
	
	private int pkIdx;		// SALE pk idx
	private int idx;
	private int saleIdx;
	private String optionName;
	private String description;
	private int price;
	private String unit;
	private int startAmount;
	private int leftAmount;
	private Date lastsoldTime;
	private Date writtenTime;
	private Date lastEdited;
	private int isdel;
	private int category;
	
	//2018 06 01 hwanmin add
	private Integer proAmount;      //사용자들이 상품 담은 총 개수
	

	
	public Integer getProAmount() {
		return proAmount;
	}
	public void setProAmount(int proAmount) {
		this.proAmount = proAmount;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public Integer getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getPkIdx() {
		return pkIdx;
	}
	public void setPkIdx(int pkIdx) {
		this.pkIdx = pkIdx;
	}
	public int getSaleIdx() {
		return saleIdx;
	}
	public void setSaleIdx(int saleIdx) {
		this.saleIdx = saleIdx;
	}
	public String getOptionName() {
		return optionName;
	}
	public void setOptionName(String optionName) {
		this.optionName = optionName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public int getStartAmount() {
		return startAmount;
	}
	public void setStartAmount(int startAmount) {
		this.startAmount = startAmount;
	}
	public int getLeftAmount() {
		return leftAmount;
	}
	public void setLeftAmount(int leftAmount) {
		this.leftAmount = leftAmount;
	}
	public Date getLastsoldTime() {
		return lastsoldTime;
	}
	public void setLastsoldTime(Date lastsoldTime) {
		this.lastsoldTime = lastsoldTime;
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
	public int getIsdel() {
		return isdel;
	}
	public void setIsdel(int isdel) {
		this.isdel = isdel;
	}
	@Override
	public String toString() {
		return "SaleOption [pkIdx=" + pkIdx
				+ ", idx=" + idx
				+ ", saleIdx=" + saleIdx
				+ ", optionName=" + optionName
				+ ", description=" + description
				+ ", price=" + price
				+ ", unit=" + unit
				+ ", startAmount=" + startAmount
				+ ", leftAmount=" + leftAmount
				+ ", lastsoldTime=" + lastsoldTime
				+ ", writtenTime=" + writtenTime
				+ ", lastEdited=" + lastEdited
				+ ", isdel=" + isdel
				+ ", proAmount=" + proAmount
				+ "]";
	}
}
