package cocoFarm.service;

import java.util.List;

import cocoFarm.dto.Product;
import cocoFarm.dto.SaleOption;
import cocoFarm.util.Paging;

public interface ProductService {

	/**
	 * 판매상품 등록
	 * 
	 * @param Product - 판매상품, SaleOption - 옵션
	 */
	public void insert(Product product, SaleOption saleOption);
	
	/**
	 * 판매상품 수정
	 * 
	 * @param Product - 판매상품, SaleOption - 옵션
	 */
	public void update(Product product, SaleOption saleOption);
	
	/**
	 * 옵션 전체 조회
	 *  
	 * @return List - 옵션 전제 조회 결과
	 */
	public List getList();
	
	/**
	 * 옵션 수 조회
	 * 
	 * @return int - 옵션 총 갯수
	 */
	public int getListCount();
	
	/**
	 * 선택된 페이지에 알맞는 옵션 리스트 조회
	 *  
	 * @param paging - 페이징 정보
	 * @return List - 페이징 처리된 옵션 리스트
	 */
	public List getPagingList(Paging paging);
}
