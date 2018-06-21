package cocoFarm.dao;

import java.util.HashMap;
import java.util.List;

import cocoFarm.dto.Comment;
import cocoFarm.dto.Product;
import cocoFarm.dto.SaleOption;
import cocoFarm.util.Paging;

public interface ProductDao {
	
	public List selectAll();
	
	public int countAll();
	
	public List selectPage(Paging paging);

	public Product selectProductByIdx(int saleIdx);
	
	public void insert(Product product);
	
	public void update(Product product);
	
	public void insertComment(Comment comment);
	
	public List<HashMap<String, Object>> selectAllComment(int sale_idx);
	
	public Product selectProductByReceipt(int receiptIdx, int optionIdx);
	
	/* ==================================================================================== */
	
	//hwanmin work 2018_05_26
	
	public List ProMainList();
	public List SerchPro(Product product);
	
	//hwanmin work 2018_05_31
	public Product getDetailList(Product product);
	public List getOptionList(SaleOption saleoption);
	
	//2018_06_04
	public List getOption_amid(Product product, SaleOption saleoption);
	
	public List getPayOption(String query);
	
	public List getSale_Option(String salequery);
	
	public List ProViewMainList();

//	2018년 06월 14일 판매자 결제내역조회
	public List procPayNee(int accIdx);
	
}
