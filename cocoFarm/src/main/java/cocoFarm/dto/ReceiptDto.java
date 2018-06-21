package cocoFarm.dto;

import java.sql.Timestamp;

public class ReceiptDto {
	
	private String idx;				//구매글번호
	private int buyer_idx;			//구매자 idx
	private int money_amount;		//총결제금액
	private String paid_name;		//결제시 쓰는 구매자 이름
	private Timestamp contract_time;		//결제시간
	private int state_code;			//임시영수증 인지 체크하는 코드
	private long refund_of;			//환불영수증번호
	private String seller;			//판매자 이름
	private String buyer;			//구매자 이름
	private String name;			//옵션이름
	private int amount;				//수량
	private String unit;			//단위
	private int price;				//단위당 가격
	private String sale_title;		//경매글 제목
	
	private String main_recpt_idx;	//영수증 번호
	private int sale_option_idx;	//옵션 번호
	private int comm;				//상품후기 여부 (0: 등록X, 1: 등록O)
	
	public int getComm() {
		return comm;
	}
	public void setComm(int comm) {
		this.comm = comm;
	}
	public int getSale_option_idx() {
		return sale_option_idx;
	}
	public void setSale_option_idx(int sale_option_idx) {
		this.sale_option_idx = sale_option_idx;
	}
	public String getMain_recpt_idx() {
		return main_recpt_idx;
	}
	public void setMain_recpt_idx(String main_recpt_idx) {
		this.main_recpt_idx = main_recpt_idx;
	}
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
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
	public Timestamp getContract_time() {
		return contract_time;
	}
	public void setContract_time(Timestamp contract_time) {
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSeller() {
		return seller;
	}
	public void setSeller(String seller) {
		this.seller = seller;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getSale_title() {
		return sale_title;
	}
	public void setSale_title(String sale_title) {
		this.sale_title = sale_title;
	}
	
	public String getBuyer() {
		return buyer;
	}
	public void setBuyer(String buyer) {
		this.buyer = buyer;
	}
	
	@Override
	public String toString() {
		return "[ Receipt : idx = " + idx
				+ ", buyer_idx = " + buyer_idx
				+ ", money_amount = " + money_amount
				+ ", paid_name = " + paid_name
				+ ", contract_time = " + contract_time
				+ ", state_code = " + state_code
				+ ", refund_of = " + refund_of
				+ ", seller = " + seller
				+ ", buyer = " + buyer
				+ ", name = " + name
				+ ", amount = " + amount
				+ ", unit = " + unit
				+ ", price = " + price
				+ ", sale_title = " + sale_title
				+ " ]";
				
	}
	
	

}
