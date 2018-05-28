package cocoFarm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cocoFarm.dao.ProductDao;
import cocoFarm.dao.SaleOptionDao;
import cocoFarm.dto.Product;
import cocoFarm.dto.SaleOption;
import cocoFarm.util.Paging;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired ProductDao productDao;
	@Autowired SaleOptionDao saleOptionDao;
	
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
	public void insert(Product product, SaleOption saleOption) {
		productDao.insert(product);
//		System.out.println(product);
//		System.out.println(">>>>>>>>>>>> idx = " + product.getIdx());
		saleOption.setPkIdx(product.getIdx());
		saleOptionDao.insert(saleOption);
		saleOptionDao.insertCategory(saleOption);
	}
	
	@Override
	public void update(Product product) {
		// TODO Auto-generated method stub
		
	}
}
