package cocoFarm.dao;

import java.util.List;
import java.util.Map;

import cocoFarm.dto.Cart;
import cocoFarm.dto.SaleOption;
import cocoFarm.util.Paging;

public interface SaleOptionDao {
	
	// 모든 옵션 조회
	public List selectAll();
	
	// 모든 옵션 개수 조회
	public int countAll(int acc_idx);
	
	public List selectPage(Paging paging, int acc_idx);
	
	public void insert(SaleOption saleOption);

	public void insertCategory(SaleOption saleOption);
	
	// 판매 상품의 옵션 개수 조회
	public int countOption(int saleIdx);
	
	// 판매 상품 번호(saleIdx)에 따른 옵션 조회
	public List<SaleOption> selectOptionBySaleIdx(int saleIdx);
	
	// 옵션 번호(idx)에 따른 옵션 조회
	public SaleOption selectOptionByIdx(int idx);
	
	// 옵션 수정
	public void update(SaleOption saleOption);
	
	// 옵션 추가
	public void updateNew(SaleOption saleOption);
	
	// 옵션 제거
	public void delete(SaleOption saleOption);
	
	// 장바구니 등록
	public void insertCart(SaleOption saleOption, int accIdx);
	
	public List<Cart> selectCart(int accIdx);
	
	// 장바구니 옵션 번호 조회
//	public List<SaleOption> selectCart(int accIdx);
	
	public void deleteCart(int saleOptionIdx);
	
	public void updateCart(Map cart);
}
