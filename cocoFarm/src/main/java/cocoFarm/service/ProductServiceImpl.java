package cocoFarm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cocoFarm.dao.ProductDao;
import cocoFarm.dao.SaleOptionDao;
import cocoFarm.dto.Option;
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
		// Product 또는 SaleOption 어떤 list를 불러올 것인지
//		return productDao.countAll();
		return saleOptionDao.countAll();
	}
	
	@Override
	public List getPagingList(Paging paging) {
		// Product 또는 SaleOption 어떤 list를 불러올 것인지
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
	public void update(Product product, Option Option) {
		// TODO Auto-generated method stub
	}
	
	@Override
	public void update(Option option) {
		// saleIdx를 통해 옵션 idx를 얻어 setting
		List<SaleOption> optionIdx = saleOptionDao.selectOptionByIdx(option.getSaleOptions().get(0).getSaleIdx());
//		System.out.println(optionIdx.get(0));
//		System.out.println(optionIdx.get(1));
//		System.out.println(optionIdx.get(2));
		System.out.println(optionIdx.size());
		System.out.println("--------------");
		
		System.out.println(option.getSaleOptions().size());
//		System.out.println(option.getSaleOptions().get(0));
//		System.out.println(option.getSaleOptions().get(1));
		
		int optionSize = option.getSaleOptions().size();
		for(int i=0; i<optionIdx.size(); i++) {
			// 옵션 제거
			if(i > optionSize-1) {
				saleOptionDao.delete(optionIdx.get(i));
				break;
			}
			// 기존 옵션 수정
			option.getSaleOptions().get(i).setIdx(optionIdx.get(i).getIdx());
			saleOptionDao.update(option.getSaleOptions().get(i));
			// 옵션 추가
			if(optionIdx.size() <= optionSize) {
				saleOptionDao.updateNew(option.getSaleOptions().get(i));
			}
		}
	}
	
	@Override
	public void update(Product product) {
		// 이미지가 등록되었을 경우, 등록되지 않았을 경우 나눠서 생각해 본다.
		
		productDao.update(product);
	}
	
	//2018_05_26 hwanmin work
	@Override
	public List getProMainList(){
		return productDao.ProMainList();
	}
	
	@Override
	public List getSerchList(Product product){
		return productDao.SerchPro(product);
	}
	//2018_05_26 
	@Override
	public Product getDetailList(Product product) {
		return productDao.getDetailList(product);
	}
	
	@Override
	public List getOptionList(SaleOption saleoption) {
		return productDao.getOptionList(saleoption);
	}
	
	//2018_06_24
	@Override
	public List getOption_amid(Product product, SaleOption saleoption) {
		return null;
	}
	
	@Override
	public List<SaleOption> getPayOption(String query) {
		return productDao.getPayOption(query);
	}
		
	@Override
	public List<Product> getSale_Option(String salequery) {
		return productDao.getSale_Option(salequery);
	}
	
}
