package cocoFarm.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cocoFarm.dto.Comment;
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
	public int getListCount(int acc_idx);
	
	/**
	 * 선택된 페이지에 알맞는 옵션 리스트 조회
	 *  
	 * @param paging - 페이징 정보
	 * @return List - 페이징 처리된 옵션 리스트
	 */
	public List getPagingList(Paging paging, int acc_idx);
	
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
	public void insert(Product product, SaleOption saleOption);	//구현X
	
	public void update(Product product);
	
	public void update(Option option);
	
	/**
	 * 판매상품 수정
	 * 
	 * @param Product - 판매상품, SaleOption - 옵션
	 */
	public void update(Product product, Option Option);
	
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
	
	/**
	 * 장바구니 담기
	 * 
	 * @param Option - 장바구니에 넣을 옵션 리스트, accIdx - 계정 idx
	 */
	public void insertCart(Option option, int accIdx);
	
	/**
	 * 장바구니 조회
	 * 
	 * @param accIdx - 계정 idx
	 */
	public List cartView(int accIdx);
	
	public List selectCart(int accIdx);
	
	/**
	 * 장바구니 삭제
	 * 
	 * @param saleIdx - 판매 상품 idx
	 */
	public void deleteCart(int saleIdx);
	
	public void updateCart(Map cart);
	
	/**
	 * Desc : 상품평 등록
	 * @method : insertComment
	 * @param comment - 상품평 정보
	 * @return : void
	 * @since  : 2018. 6. 13.
	 * @author : jieun
	 */
	public void insertComment(Comment comment);
	
	public List<HashMap<String, Object>> getCommentList(int saleIdx);
	
	public Product selectProductByReceipt(int receiptIdx, int optionIdx);
	
	/* ==================================================================================== */
	
	//2018_05_26 hwanmin work
	public List<Product> getProMainList();
	
	public List<Product> getSerchList(Product product);
	
	//2018 05 31 DETAIL VEIW  HWAN
	public Product getDetailList(Product product);
	public List<SaleOption> getOptionList(SaleOption saleoption);
	
	//2018 06월 04일  option amount, idx select 
	public List getOption_amid(Product product,SaleOption saleoption);

		
	//2018 06월 04일  2# 
	public List<SaleOption> getPayOption(String query); 
		
	public List<Product> getSale_Option(String salequery);
	
	//2018 06월 12일 
	public List<Product> getProViewMainList();
	
//	2018년 06월 14일 판매자 결제내역조회
	public List procPayNee(int accIdx);
	
}
