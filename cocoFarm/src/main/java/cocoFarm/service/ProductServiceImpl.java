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
	public List getList() {
		return saleOptionDao.selectAll();
	}
	
	@Override
	public int getListCount() {
		// Product 또는 SaleOption 어떤 것을 뿌려줄 것인지...
//		return productDao.countAll();
		return saleOptionDao.countAll();
	}
	
	@Override
	public List getPagingList(Paging paging) {
		// Product 또는 SaleOption 어떤 것을 뿌려줄 것인지...
//		return productDao.selectPage(paging);
		return saleOptionDao.selectPage(paging);
	}
	
	@Override
	public void insert(Product product) {
		productDao.insert(product);
	}
	
	@Override
	public void insert(Product product, SaleOption saleOption) {
//		System.out.println(product);
//		System.out.println(">>>>>>>>>>>> idx = " + product.getIdx());
		saleOption.setPkIdx(product.getIdx());
		saleOptionDao.insert(saleOption);
		saleOptionDao.insertCategory(saleOption);
	}
	
	@Override
	public Product productView(int saleIdx) {
		return productDao.selectProductByIdx(saleIdx);
	}
	
	@Override
	public List optionView(int saleIdx) {
//		List<SaleOption> saleList = saleOptionDao.selectOptionByIdx(saleIdx);
		
		return saleOptionDao.selectOptionByIdx(saleIdx);
	}
	
	@Override
	public int optionNumber(int saleIdx) {
		return saleOptionDao.countOption(saleIdx);
	}
	
	@Override
	public void update(Product product, SaleOption saleOption) {
		// TODO Auto-generated method stub
	}
	
}
