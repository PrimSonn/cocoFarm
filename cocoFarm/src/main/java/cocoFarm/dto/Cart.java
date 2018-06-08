package cocoFarm.dto;

import java.util.Date;

public class Cart {
	private int idx;
	private int accIdx;
	private int saleOptionIdx;
	private int count;
	private Date addedTime;
	
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
	public int getSaleOptionIdx() {
		return saleOptionIdx;
	}
	public void setSaleOptionIdx(int saleOptionIdx) {
		this.saleOptionIdx = saleOptionIdx;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public Date getAddedTime() {
		return addedTime;
	}
	public void setAddedTime(Date addedTime) {
		this.addedTime = addedTime;
	}
	@Override
	public String toString() {
		return "Cart [idx=" + idx
				+ ", accIdx=" + accIdx
				+ ", saleOptionIdx=" + saleOptionIdx
				+ ", count=" + count
				+ ", addedTime=" + addedTime
				+ "]";
	}
}
