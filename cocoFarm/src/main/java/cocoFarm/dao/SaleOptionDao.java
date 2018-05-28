package cocoFarm.dao;

import cocoFarm.dto.SaleOption;

public interface SaleOptionDao {
	
	public void insert(SaleOption saleOption);

	public void insertCategory(SaleOption saleOption);
}
