package cocoFarm.dao;

import java.util.List;

import cocoFarm.dto.Product;
import cocoFarm.util.Paging;

public interface ProductDao {
	
	public List selectAll();
	
	public int countAll();
	
	public List selectPage(Paging paging);

	public Product selectProductByIdx(int saleIdx);
	
	public void insert(Product product);
	
	public void update(Product product);
}
