package cocoFarm.dao;

import java.util.List;

import cocoFarm.dto.Auction;
import cocoFarm.dto.Auction_Inquire;
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
}
