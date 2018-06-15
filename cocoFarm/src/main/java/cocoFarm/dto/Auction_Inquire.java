package cocoFarm.dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class Auction_Inquire {

	
	private Integer idx;			//경매 문의글 번호 - 기본키, 인조식별자 트리거있음
	private Integer auction_idx;	//경매글 번호 - null불가. 외래키
	private Integer writer_idx;		//문의 계정 번호 - null불가. 외래키
	private String content;			//문의내용 - null불가
	private Timestamp written_time;	//문의글 작성시각 - null불가, 트리거있음(기본값 시스템시간처리)
	private String answer;			//문의글에 대한 답변 - null가능.
	private Timestamp answer_time;	//문의글 답변 시각 - null가능, 트리거있음 (답변 작성시 자동으로 시간 기입)
	private Integer isdel;			//삭제 혹은 이외의(블라인드 따위) 글 상태 - 외래키 null불가 트리거있음 (기본값 0)
	
	private String id;				//댓글 작성자 이름..? 아이디로 하는게 편하지 않을까.. 싶기도 한데 아이디로할까?
	
	private String name;



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public String getId() {
		return id;
	}



	public void setId(String id) {
		this.id = id;
	}



	public Integer getIdx() {
		return idx;
	}



	public void setIdx(Integer idx) {
		this.idx = idx;
	}



	public Integer getAuction_idx() {
		return auction_idx;
	}



	public void setAuction_idx(Integer auction_idx) {
		this.auction_idx = auction_idx;
	}



	public Integer getWriter_idx() {
		return writer_idx;
	}



	public void setWriter_idx(Integer writer_idx) {
		this.writer_idx = writer_idx;
	}



	public String getContent() {
		return content;
	}



	public void setContent(String content) {
		this.content = content;
	}



	public String getWritten_time() {
		if(written_time !=null) {
			return new SimpleDateFormat("YYYY/MM/dd HH:mm:ss").format(written_time);
		}else {
			return "----/--/-- --:--:--";
		}
		
	}



	public void setWritten_time(Timestamp written_time) {
		this.written_time = written_time;
	}



	public String getAnswer() {
		return answer;
	}



	public void setAnswer(String answer) {
		this.answer = answer;
	}



	public Timestamp getAnswer_time() {
		return answer_time;
	}



	public void setAnswer_time(Timestamp answer_time) {
		this.answer_time = answer_time;
	}



	public Integer getIsdel() {
		return isdel;
	}



	public void setIsdel(Integer isdel) {
		this.isdel = isdel;
	}



	@Override
	public String toString() {
		return "Auction_Inquire [idx="+idx
				+", auction_idx="+auction_idx
				+", writer_idx="+writer_idx
				+", content="+content
				+", written_time="+written_time
				+", answer="+answer
				+", answer_time="+answer_time
				+", isdel="+isdel+"]";
	}


}
