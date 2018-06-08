package cocoFarm.dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class TestBidDto {

	private Integer auction_idx;
	private Integer amount;
	private Timestamp bid_time;
	private Integer bidder_idx;
	private Integer state_code;
	private Integer isDone;

	@Override
	public String toString() {
		return "BID [auction_idx: "+auction_idx+", amount "+amount+", bid_time "+bid_time+", bidder_idx "+bidder_idx+", state_code "+state_code+", isIn "+isDone+"]";
	}

	public Timestamp getWakeTime() {
		return this.bid_time;
	}

	
	public Integer getAuction_idx() {
			return auction_idx;
	}
	public void setAuction_idx(Integer auction_idx) {
		this.auction_idx = auction_idx;
	}

	public Integer getAmount() {
			return amount;
	}
	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public String getBid_time() {
		
		if(bid_time !=null) {
			return new SimpleDateFormat("YYYY/MM/dd HH:mm:ss").format(bid_time);
		}else {
			return "----/--/-- --:--:--";
		}
	}
	public void setBid_time(Timestamp bid_time) {
		this.bid_time = bid_time;
	}

	public Integer getBidder_idx() {
		return bidder_idx;
	}
	public void setBidder_idx(Integer bidder_idx) {
		this.bidder_idx = bidder_idx;
	}

	public Integer getState_code() {
		return state_code;
	}
	public void setState_code(Integer state_code) {
		this.state_code = state_code;
	}

	public Integer getIsDone() {
		return isDone;
	}public void setIsDone(Integer isDone) {
		this.isDone = isDone;
	}
	
}
