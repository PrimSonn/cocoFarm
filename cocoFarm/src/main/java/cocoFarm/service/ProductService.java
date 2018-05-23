package cocoFarm.service;

import java.util.List;

import cocoFarm.dto.Product;
import cocoFarm.dto.SaleOption;
import cocoFarm.util.Paging;

public interface ProductService {

	public void insert(Product product, SaleOption saleOption);
	
	public void update(Product product);
	
	public List getlist();
	
	public List getPagingList(Paging paging);
}
