package cocoFarm.dto;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

public class AuctionReceipt {

	
	private String idx;				//주 영수증 번호 - 후보키. 복합기본키, 인조식별자, 트리거있음
	private String payment_code;		//결제번호 - 결제 대행사의 결제번호
	private Integer buyer_idx;			//영수증 결제 계정 번호 - 복합기본키. 외래키. null불가 : 구매 영수증이 있는 계정은 정보 완전 삭제 불가
	private Integer payment_type_code;	//결제타입 - 외래키. null불가. 트리거있음 (기본값 : 0) 안 써도 문제없이 작동하게 해둠
	private Integer money_amount;		//돈돈돈 - null불가
	private String paid_name;			//결제자 이름 - null불가. 결제정보에서 가져올 수 있다면 가져오고 없으면 적당히 넣기
	private String paid_desc;			//결제 정보 - null 가능. 뭔가 결제정보에 추가적인 정보를 저장해야 한다면 여기에 넣기
	private Timestamp contract_time;	//결제시간 - null불가. 트리거있음 (강제로 insert 당시 시스템 시간을 넣음) 입찰과 관련되서 밀리초 까지 넣음
	private Integer state_code;			//주 영수증 상태 코드 - null불가. 트리거있음(기본값 0)
	private Integer refund_of;			//환불 대상 영수증 번호 - 복합 외래키 null가능. 환불 영수증 통합용 속성
	
	private String title;				//경매 등록 상품명
	
	
	
	public String getIdx() {
		return idx;
	}




	public void setIdx(String idx) {
		this.idx = idx;
	}




	public String getPayment_code() {
		return payment_code;
	}




	public void setPayment_code(String payment_code) {
		this.payment_code = payment_code;
	}




	public Integer getBuyer_idx() {
		return buyer_idx;
	}




	public void setBuyer_idx(Integer buyer_idx) {
		this.buyer_idx = buyer_idx;
	}




	public Integer getPayment_type_code() {
		return payment_type_code;
	}




	public void setPayment_type_code(Integer payment_type_code) {
		this.payment_type_code = payment_type_code;
	}




	public Integer getMoney_amount() {
		return money_amount;
	}




	public void setMoney_amount(Integer money_amount) {
		this.money_amount = money_amount;
	}




	public String getPaid_name() {
		return paid_name;
	}




	public void setPaid_name(String paid_name) {
		this.paid_name = paid_name;
	}




	public String getPaid_desc() {
		return paid_desc;
	}




	public void setPaid_desc(String paid_desc) {
		this.paid_desc = paid_desc;
	}




	public Timestamp getContract_time() {
		return contract_time;
	}




	public void setContract_time(Timestamp contract_time) {
		this.contract_time = contract_time;
	}




	public Integer getState_code() {
		return state_code;
	}




	public void setState_code(Integer state_code) {
		this.state_code = state_code;
	}




	public Integer getRefund_of() {
		return refund_of;
	}




	public void setRefund_of(Integer refund_of) {
		this.refund_of = refund_of;
	}




	public String getTitle() {
		return title;
	}




	public void setTitle(String title) {
		this.title = title;
	}




	@Override
	public String toString() {
		return "AuctionReceipt [idx="+idx
				+", payment_code="+payment_code
				+", buyer_idx="+buyer_idx
				+", payment_type_code="+payment_type_code
				+", money_amount="+money_amount
				+", paid_name="+paid_name
				+", paid_desc="+paid_desc
				+", contract_time="+contract_time
				+", state_code="+state_code
				+", refund_of="+refund_of
				+", title="+title+"]";
	}


}
