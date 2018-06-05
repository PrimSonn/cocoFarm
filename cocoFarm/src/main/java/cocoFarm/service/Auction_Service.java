package cocoFarm.service;

import java.util.List;

import cocoFarm.dto.Auction;
import cocoFarm.dto.Auction_Inquire;
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
}
