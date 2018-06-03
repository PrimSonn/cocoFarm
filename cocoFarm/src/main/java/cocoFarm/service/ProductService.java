package cocoFarm.service;

import java.util.List;

import cocoFarm.dto.Option;
import cocoFarm.dto.Product;
import cocoFarm.dto.SaleOption;
import cocoFarm.util.Paging;

/**
 *
 * <pre>
 * cocoFarm.service
 * ProductService.java
 * </pre>
 *
 * @title  : 
 * @since  : 2018. 6. 2.
 * @author : jieun
 *
 */
public interface ProductService {

	/**
	 * 옵션 전체 조회
	 *  
	 * @return List - 옵션 전제 조회 결과
	 */
	public List getList();
	
	/**
	 * 판매상품/옵션 수 조회
	 * 
	 * @return int - 판매상품/옵션 총 갯수
	 */
	public int getListCount();
	
	/**
	 * 선택된 페이지에 알맞는 옵션 리스트 조회
	 *  
	 * @param paging - 페이징 정보
	 * @return List - 페이징 처리된 옵션 리스트
	 */
	public List getPagingList(Paging paging);
	
	/**
	 * 판매상품 등록
	 * 
	 * @param Product - 판매상품
	 */
	public void insert(Product product);
	
	/**
	 * 판매상품 옵션 등록
	 * 
	 * @param Product - 판매상품 idx, SaleOption - 옵션
	 */
	public void insert(Product product, SaleOption saleOption);
	
	/**
	 * 판매상품 수정
	 * 
	 * @param Product - 판매상품, SaleOption - 옵션
	 */
	public void update(Product product, SaleOption saleOption);
	
	/**
	 * 판매상품 불러오기
	 * 
	 * @param saleIdx - 조회될 판매상품의 idx
	 * @return Product - 조회된 판매상품
	 */
	public Product productView(int saleIdx);
	
	/**
	 * 판매상품 옵션 불러오기
	 * 
	 * @param product - 조회될 판매상품의 idx
	 * @return Option - 조회된 판매상품 옵션
	 */
	public List optionView(int saleIdx);
	
	
	/**
	 * 판매상품 옵션 개수 불러오기
	 * 
	 * @param saleOption - 옵션의 idx를 통해 판매상품의 saleIdx
	 * @return Option - 조회된 판매상품 옵션
	 */
	public int optionNumber(int saleIdx);
}
