package cocoFarm.service;

import java.util.List;

import org.springframework.stereotype.Service;

import cocoFarm.dto.Product;
import cocoFarm.util.Paging;

public interface ProductService {

	public void insert(Product product);
	
	public void update(Product product);
	
	public List getlist();
	
	public List getPagingList(Paging paging);
}
