package cocoFarm.dao;

import java.util.List;

import cocoFarm.dto.SaleOption;
import cocoFarm.util.Paging;

public interface SaleOptionDao {
	
	// 모든 옵션 조회
	public List selectAll();
	
	// 모든 옵션 개수 조회
	public int countAll();
	
	public List selectPage(Paging paging);
	
	public void insert(SaleOption saleOption);

	public void insertCategory(SaleOption saleOption);
	
	// 판매 상품의 옵션 개수 조회
	public int countOption(int saleIdx);
	
	public List<SaleOption> selectOptionByIdx(int saleIdx);
	
	public SaleOption selectOption(int idx);
	
	// 옵션 수정
	public void update(SaleOption saleOption);
	
	// 옵션 추가
	public void updateNew(SaleOption saleOption);
	
	// 옵션 제거
	public void delete(SaleOption saleOption);
	
	public void insertBasket(SaleOption saleOption);
}
