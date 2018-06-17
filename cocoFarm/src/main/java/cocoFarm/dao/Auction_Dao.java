package cocoFarm.dao;

import java.util.List;

import cocoFarm.dto.Account;
import cocoFarm.dto.Auction;
import cocoFarm.dto.Auction_Inquire;
import cocoFarm.dto.BidDto;
import cocoFarm.util.Admin_Auction_Paging;
import cocoFarm.util.Auction_Paging;

public interface Auction_Dao {
	
	/**
	 * 경매글 전체 조회
	 * 
	 * @return List - 경매글 전제 조회 결과
	 */
	public List selectAll();
	
	/**
	 * 경매글 전체 수
	 * 
	 * @return int - 총 게시글 수
	 */
	public int countAll();

	/**
	 * 페이지 경매글 조회
	 * 
	 * @param paging - 페이징 정보
	 * @return List - 페이지 경매글 리스트
	 */
	public List selectPage(Auction_Paging paging);

	/**
	 * 검색어 적용한 경매글 수
	 * 
	 * @param search - 검색어
	 * @return int - 검색된 경매글 수
	 */
	public int countSearch(Auction_Paging search);
	
	/**
	 * 검색어 적용한 경매글 목록 조회
	 * 
	 * @param search - 검색어
	 * @return List - 검색되어 페이징처리된 경매글
	 */
	public List selectPageSearch(Auction_Paging search);

	/**
	 * 경매글 등록
	 * 
	 * @param auction - 경매글 내용
	 */
	public void write(Auction auction);

	
	/**
	 * 첨부파일 기록
	 * 
	 * @param Auction - 첨부파일 경로 등록
	 */
	public void insertFile(Auction Auction);
	
	
	/**
	 * 경매글 상세 보기
	 * 
	 * @param viewAuction - 경매글 idx
	 * @return Auction - 경매글 정보
	 */
	public Auction selectAuctionByAuctionIDX(Auction viewAuction);
	
	/**
	 * 경매 문의글 등록
	 * 
	 * @param inquire - 경매 문의글 내용
	 */
	public void insertInquire(Auction_Inquire inquire);
	
	/**
	 * 경매 문의글 리스트
	 * 
	 * @param viewAuction - 경매 번호
	 * @return List 문의글 리스트
	 */
	public List selectInquire(Auction viewAuction);
	
	/**
	 * 경매 문의 답변
	 * 
	 * @param inquire - 경매글번호, 문의글번호, 답변내용
	 */
	public void updateAnswer(Auction_Inquire inquire);
	
	
	
	/**
	 * 경매 입찰 하기
	 * 
	 * @param bid - 경매 입찰 정보
	 */
	public void putBid(BidDto bid);
	
	/**
	 * 경매 상위 입찰 불러오기
	 * 
	 * @param viewAuction - 경매글 번호
	 * @return List - 경매 입찰 상위 리스트
	 */
	public List getBidderList(Auction viewAuction);
	
	/**
	 * 개인 입찰 리스트
	 * 
	 * @param account - 계정 번호
	 * @return - 개인 입찰 리스트
	 */
	public List getMemberBid(Account account);
	
	/**
	 * 경매 입찰 취소
	 * 
	 * @param bid - 입찰정보
	 */
	public void cancelBid(BidDto bid);
	
	/**
	 * 등록 경매글 조회
	 * 
	 * @param auction - 판매자 idx
	 * @return	- 경매글 리스트
	 */
	public List getauctionList(Auction auction);
	
	/**
	 * 경매 글 삭제
	 * 
	 * @param auction - 경매글 idx, 판매자 idx
	 */
	public void auctionCancel(Auction auction);
	
	/**
	 * 메인에 올라갈 경매글 리스트
	 * 
	 * @return - 종료임박 상위 5개 경매글 리스트
	 */
	public List getAuctionMainList();
	
	
	public List getMainAuctionList();
	
	//=========================관리자 경매글 리스트
	
	/**
	 * 관리자 경매글 전체 리스트 조회
	 * 
	 * @return - 전체 경매글 리스트
	 */
	public List admingetauctionList();
	
	/**
	 * 전체 경매글 수
	 * 
	 * @return - 전체 경매글 수
	 */
	public int admingetauctionTotal();
	
	/**
	 * 관리자 페이지별 경매글 조회
	 * 
	 * @param paging - 페이지 정보
	 * @return - 페이지별 게시물
	 */
	public List admingetauctionPagingList(Admin_Auction_Paging paging);
	
	
	//=========================관리자 영수증 리스트
	
		/**
		 * 관리자 영수증 전체 리스트 조회
		 * 
		 * @return - 전체 영수증 리스트
		 */
		public List admingetReceiptList();
		
		/**
		 * 전체 영수증 수
		 * 
		 * @return - 전체 영수증 수
		 */
		public int admingetReceiptTotal();
		
		/**
		 * 관리자 페이지별 영수증 조회
		 * 
		 * @param paging - 페이지 정보
		 * @return - 페이지별 게시물
		 */
		public List admingetReceiptPagingList(Admin_Auction_Paging paging);
	
}
