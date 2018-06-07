package cocoFarm.dao;

import java.util.List;

import cocoFarm.dto.SaleOption;
import cocoFarm.util.Paging;

public interface SaleOptionDao {
	
	public List selectAll();
	
	public int countAll();
	
	public List selectPage(Paging paging);
	
	public void insert(SaleOption saleOption);

	public void insertCategory(SaleOption saleOption);
	
	public int countOption(int saleIdx);
	
	public List<SaleOption> selectOptionByIdx(int saleIdx);
	
	// 옵션 수정
	public void update(SaleOption saleOption);
	
	// 옵션 추가
	public void updateNew(SaleOption saleOption);
	
	// 옵션 제거
	public void delete(SaleOption saleOption);
}
