package cocoFarm.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cocoFarm.dao.ProductDao;
import cocoFarm.dao.SaleOptionDao;
import cocoFarm.dto.Cart;
import cocoFarm.dto.Comment;
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
	public int getListCount(int acc_idx) {
		// Product 또는 SaleOption 어떤 list를 불러올 것인지
//		return productDao.countAll();
		return saleOptionDao.countAll(acc_idx);
	}
	
	@Override
	public List getPagingList(Paging paging, int acc_idx) {
		// Product 또는 SaleOption 어떤 list를 불러올 것인지
//		return productDao.selectPage(paging);
		return saleOptionDao.selectPage(paging, acc_idx);
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
//		List<SaleOption> saleList = saleOptionDao.selectOptionBySaleIdx(saleIdx);
		return saleOptionDao.selectOptionBySaleIdx(saleIdx);
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
		List<SaleOption> optionIdx = saleOptionDao.selectOptionBySaleIdx(option.getSaleOptions().get(0).getSaleIdx());

		int optionSize = option.getSaleOptions().size();
		
		int i=0;
		// 옵션 제거
		if(optionIdx.size() > optionSize) {
			for(i=optionSize; i<optionIdx.size(); i++) {
				saleOptionDao.delete(optionIdx.get(i));
			}
		// 기존 옵션 수정
		} else if(optionIdx.size() == optionSize) {
			for(i=0; i<optionIdx.size(); i++) {
				option.getSaleOptions().get(i).setIdx(optionIdx.get(i).getIdx());
				saleOptionDao.update(option.getSaleOptions().get(i));
			}
		// 옵션 추가
		} else if(optionIdx.size() < optionSize) {
			for(i=optionIdx.size(); i<optionSize; i++) {
				saleOptionDao.updateNew(option.getSaleOptions().get(i));
			}
		}
	}
	
	@Override
	public void update(Product product) {
		productDao.update(product);
		// 이미지가 등록되었을 경우, 등록되지 않았을 경우(기존 이미지 유지) 나눠서 생각해 본다. 나중에
	}
	
	@Override
	public void insertCart(Option option, int accIdx) {
		SaleOption saleOption = null;

		List<Cart> cart = saleOptionDao.selectCart(accIdx);
		
		for(int i=0; i<cart.size(); i++) {
			if(!option.equals(null)) {
				for(int j=0; j<option.getSaleOptions().size(); j++) {
					if(cart.get(i).getSaleOptionIdx() == option.getSaleOptions().get(j).getIdx()) {
						return;
					}
				}
			}
		}
		// 장바구니에 등록되어 있지 않은 경우
		for(int i=0; i<option.getSaleOptions().size(); i++) {
			if(option.getSaleOptions().get(i).getIdx() != 0) {
			
				saleOption = saleOptionDao.selectOptionByIdx(option.getSaleOptions().get(i).getIdx());
				saleOption.setProAmount(option.getSaleOptions().get(i).getProAmount());
			
				saleOptionDao.insertCart(saleOption, accIdx);
			}
		}
		
	}
	
	@Override
	public List cartView(int accIdx) {
		// 장바구니 리스트 조회
		List<Cart> cartList = saleOptionDao.selectCart(accIdx);
		List<SaleOption> optionCart = new ArrayList<SaleOption>();
		SaleOption saleOption;
		
		for(int i=0; i<cartList.size(); i++) {
			saleOption = saleOptionDao.selectOptionByIdx(cartList.get(i).getSaleOptionIdx());
			saleOption.setProAmount(cartList.get(i).getCount());
			optionCart.add(i, saleOption);
		}
//		saleOption = saleOptionDao.selectOptionByIdx(cartList.get(0).getSaleOptionIdx());
//		System.out.println(saleOption);
//		optionCart.add(0, saleOption);
		
		return optionCart;
//		return option;
	}
	
	@Override
	public List selectCart(int accIdx) {
		return saleOptionDao.selectCart(accIdx);
	}
	
	@Override
	public void deleteCart(int saleIdx) {
		List<SaleOption> optionIdx = saleOptionDao.selectOptionBySaleIdx(saleIdx);
		for(int i=0; i<optionIdx.size(); i++) {
			saleOptionDao.deleteCart(optionIdx.get(i).getIdx());
		}
	}
	
	@Override
	public void updateCart(Map cart) {
		saleOptionDao.updateCart(cart);
	}
	
	@Override
	public void insertComment(Comment comment) {
		productDao.insertComment(comment);
	}
	
	@Override
	public List<HashMap<String, Object>> getCommentList(int saleIdx) {
		return productDao.selectAllComment(saleIdx);
	}
	
	@Override
	public Product selectProductByReceipt(int receiptIdx, int optionIdx) {
		return productDao.selectProductByReceipt(receiptIdx, optionIdx);
	}
	
	/* ==================================================================================== */
	
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
	
	@Override
	public List<Product> getProViewMainList(){
		
		return productDao.ProViewMainList();
	}
	
	@Override
	public List procPayNee(int accIdx) {
		return productDao.procPayNee(accIdx);
	}
	
}
