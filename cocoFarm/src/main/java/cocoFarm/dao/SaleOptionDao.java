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
	
	public List selectOptionByIdx(int saleIdx);
}
