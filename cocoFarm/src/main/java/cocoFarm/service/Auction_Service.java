package cocoFarm.service;

import java.util.List;

import cocoFarm.dto.Account;
import cocoFarm.dto.Auction;
import cocoFarm.dto.Auction_Inquire;
import cocoFarm.dto.BidDto;
import cocoFarm.util.Admin_Auction_Paging;
import cocoFarm.util.Auction_Paging;

public interface Auction_Service {

	/**
	 * 경매글 전체 조회
	 *  
	 * @return List - 경매글 전제 조회 결과
	 */
	public List getList();
	
	/**
	 * 경매글 전체 수 조회
	 * 
	 * @return int - 경매글 총 갯수
	 */
	public int getTotal();

	/**
	 * 검색어 적용 경매글 수 조회
	 * 
	 * @param String - 검색어
	 * @return int - 경매글 총 갯수
	 */
	public int getTotal(Auction_Paging search);

	/**
	 * 선택된 페이지에 알맞는 경매글 리스트 조회
	 *  
	 * @param paging - 페이징 정보
	 * @return List - 페이징 처리된 경매글 리스트
	 */
	public List getPagingList(Auction_Paging paging);

	/**
	 * 검색결과에 페이징 처리한 경매글 목록
	 * 
	 * @param paging - 페이징,검색어 정보
	 * @return List - 검색되고 페이징처리 된 경매글
	 */
	public List getSearchPagingList(Auction_Paging search);
	
	/**
	 * 경매글 작성
	 * 
	 * @param auction - 경매글 내용
	 */
	public void write(Auction auction);
	
	
	/**
	 * 경매 상세보기
	 * 
	 * @param viewAuction - 경매글 번호
	 * @return Auction - 상세 경매글
	 */
	public Auction auctionView(Auction viewAuction);
	
	/**
	 * 경매 문의글 등록
	 * 
	 * @param inquire - 문의글 내용
	 */
	public void insertInquire(Auction_Inquire inquire);
	
	/**
	 * 경매 문의글 리스트
	 * 
	 * @param viewAuction 경매 번호
	 * @return List - 문의글 리스트
	 */
	public List getInquireList(Auction viewAuction);
	
	/**
	 * 경매 문의 답변
	 * 
	 * @param inquire - 경매글번호, 문의글번호, 답변내용
	 */
	public void updateAnswer(Auction_Inquire inquire);
	
	/**
	 * 경매 입찰
	 * 
	 * @param bid - 입찰 내용
	 */
	public void putBid(BidDto bid);
	
	/**
	 * 경매 입찰자 상위리스트
	 * 
	 * @param viewAuction - 경매글 번호
	 */
	public List getBidderList(Auction viewAuction);
	
	/**
	 * 개인 입찰 리스트
	 * 
	 * @param account - 계정번호
	 * @return - 개인 입찰 리스트
	 */
	public List getMemberBid(Account account);
	
	/**
	 * 경매 입찰 취소
	 * 
	 * @param bid - 개입 입찰 정보
	 */
	public void cancelBid(BidDto bid);
	
	/**
	 * 등록 경매글 조회
	 * 
	 * @param auction - 판매자 idx
	 * @return - 경매글 리스트
	 */
	public List getauctionList(Auction auction);
	
	/**
	 * 경매 글 삭제
	 * 
	 * @param auction - 경매글 번호, 판매자 idx
	 */
	public void auctionCancel(Auction auction);
	
	/**
	 * 메인 경매 글 리스트
	 * 
	 * @return - 종료임박 경매글 5개
	 */
	public List getAuctionMainList();
	
	
	//hwanmin 추가 
	public List getMainAuctionList();
	
	//=======================================관리자 경매글 페이징
	
	/**
	 * 관리자 경매글 전체 조회
	 *  
	 * @return List - 경매글 전제 조회 결과
	 */
	public List getauctionList();
	
	/**
	 * 관리자 경매글 전체 수 조회
	 * 
	 * @return int - 경매글 총 갯수
	 */
	public int getauctionTotal();
	

	/**
	 * 관리자 선택된 페이지에 알맞는 경매글 리스트 조회
	 *  
	 * @param paging - 페이징 정보
	 * @return List - 페이징 처리된 경매글 리스트
	 */
	public List getauctionPagingList(Admin_Auction_Paging paging);
	
	
	//=======================================관리자 경매 결제항목 페이징
	
		/**
		 * 관리자 영수증 전체 조회
		 *  
		 * @return List - 경매글 전제 조회 결과
		 */
		public List getReceiptList();
		
		/**
		 * 관리자 영수증 전체 수 조회
		 * 
		 * @return int - 영수증 총 갯수
		 */
		public int getReceiptTotal();
		

		/**
		 * 관리자 선택된 페이지에 알맞는 영수증 리스트 조회
		 *  
		 * @param paging - 페이징 정보
		 * @return List - 페이징 처리된 영수증 리스트
		 */
		public List getReceiptPagingList(Admin_Auction_Paging paging);

	
}
