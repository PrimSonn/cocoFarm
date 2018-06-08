package cocoFarm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cocoFarm.dto.Product;
import cocoFarm.dto.SaleOption;
import cocoFarm.service.ProductService;

@Controller
public class MainController {

	@Autowired ProductService productService;

	
	@RequestMapping(value="/main.do",method=RequestMethod.GET)
	public String helloWorld() {
		return "main/cocomain";
	}
	
	@RequestMapping(value="main.do",method=RequestMethod.POST)
	public String mainPost() {
		return helloWorld();
	}
	
	//판매 상세 정보
	@RequestMapping(value="/seller.do",method=RequestMethod.GET)
	public String viewList(Model model) {
		System.out.println(productService.getProMainList());
		model.addAttribute("seller",(productService.getProMainList()));
		
		return "main/mainseller/sellermain";
	}
	
	
	//판매 상세 정보
	@RequestMapping(value="/seller.do",method=RequestMethod.POST)
	public String searchviewList(Product product, Model model) {
		System.out.println(product.getSearch_name());
		model.addAttribute("seller",(productService.getSerchList(product)));
		
		return "main/mainseller/sellermain";
	}
	
	
	
	@RequestMapping(value="/sellerDetail.do",method=RequestMethod.GET)
	public String detailProView(Product product,SaleOption saleoption,Model model) {
		System.out.println(product.getIdx());
		
		/*List<Product> pList;
		pList = productService.getDetailList(product);
		model.addAttribute("product",(productService.getDetailList(product)));
		for(Product p :pList) {
			System.out.println(p.getTitle());
		}*/
		
		/*System.out.println(productService.getDetailList(product).getTitle());*/
		
		model.addAttribute("product",(productService.getDetailList(product)));
	
		
		model.addAttribute("option",(productService.getOptionList(saleoption)));
		
		List<SaleOption> sList;
		sList = productService.getOptionList(saleoption);
		for(SaleOption s :sList) {
			System.out.println(s.getPrice());
		}
		/*System.out.println(productService.getDetailList(product).getFaceImg());*/
		
		return "main/mainseller/sellerDetail";
	}
	
	
}
