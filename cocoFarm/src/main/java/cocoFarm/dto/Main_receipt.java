package cocoFarm.dto;

import java.sql.Date;

public class Main_receipt {
	
	private long idx;
	private String payment_code;
	private int buyer_idx;
	private int money_amount;
	private String paid_name;
	private String paid_code;
	private Date contract_time;
	private int state_code;
	private long refund_of;
	
	
	public long getIdx() {
		return idx;
	}
	public void setIdx(long idx) {
		this.idx = idx;
	}
	public String getPayment_code() {
		return payment_code;
	}
	public void setPayment_code(String payment_code) {
		this.payment_code = payment_code;
	}
	public int getBuyer_idx() {
		return buyer_idx;
	}
	public void setBuyer_idx(int buyer_idx) {
		this.buyer_idx = buyer_idx;
	}
	public int getMoney_amount() {
		return money_amount;
	}
	public void setMoney_amount(int money_amount) {
		this.money_amount = money_amount;
	}
	public String getPaid_name() {
		return paid_name;
	}
	public void setPaid_name(String paid_name) {
		this.paid_name = paid_name;
	}
	public String getPaid_code() {
		return paid_code;
	}
	public void setPaid_code(String paid_code) {
		this.paid_code = paid_code;
	}
	public Date getContract_time() {
		return contract_time;
	}
	public void setContract_time(Date contract_time) {
		this.contract_time = contract_time;
	}
	public int getState_code() {
		return state_code;
	}
	public void setState_code(int state_code) {
		this.state_code = state_code;
	}
	public long getRefund_of() {
		return refund_of;
	}
	public void setRefund_of(long refund_of) {
		this.refund_of = refund_of;
	}
	
	

}
