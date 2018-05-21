package cocoFarm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cocoFarm.dao.ProductDao;
import cocoFarm.dto.Product;
import cocoFarm.util.Paging;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired ProductDao productDao;
	
	@Override
	public List getlist() {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public List getPagingList(Paging paging) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public void insert(Product product) {
		productDao.insert(product);
	}
	
	@Override
	public void update(Product product) {
		// TODO Auto-generated method stub
		
	}
}
