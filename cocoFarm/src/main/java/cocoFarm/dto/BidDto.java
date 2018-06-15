package cocoFarm.dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import cocoFarm.util.recptMaker.BidSerializer;

public class BidDto implements BidSerializer{

	private Integer auction_idx;	//	대상 경매 번호 - 복합기본키. 외래키 (경매)
	private Integer amount;			//	입찰액 - 복합 기본키, 0이상
	private Timestamp bid_time;		//	입찰 시각 - null불가. 트리거 있음: 새 입찰 등록시, 시스템 시각 지정
	private Integer bidder_idx;		//	입찰자 계정번호 - 외래키 (계정) null불가
	private Integer state_code;		//	입찰 상태 코드 - 외래키. 트리거 있음 (기본값 1) null불가
	private Integer isDone;			//	

	private String title;			//	경매 제목
	private String name;			//	경매 입찰자 이름
	
	private Timestamp payment_due;
	
	public String getPayment_due() {
		if(payment_due !=null) {
			return new SimpleDateFormat("YYYY/MM/dd HH:mm:ss").format(payment_due);
		}else {
			return "----/--/-- --:--:--";
		}
	}

	public void setPayment_due(Timestamp payment_due) {
		this.payment_due = payment_due;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getTime_window() {
		if(time_window !=null) {
			return new SimpleDateFormat("YYYY/MM/dd HH:mm:ss").format(time_window);
		}else {
			return "----/--/-- --:--:--";
		}
	}

	public void setTime_window(Timestamp time_window) {
		this.time_window = time_window;
	}
	private Timestamp time_window;	//	경매 만료일자
	
	
	@Override
	public String toString() {
		return "BID [auction_idx=" + auction_idx
				+ ", amount=" + amount
				+ ", bid_time=" + bid_time
				+ ", bidder_idx=" + bidder_idx
				+ ", state_code=" + state_code
				+ ", title=" + title
				+ ", name=" + name
				+ ", isDone=" + isDone
				+ ", time_window=" + time_window+ "]";
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
