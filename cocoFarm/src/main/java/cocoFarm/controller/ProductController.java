package cocoFarm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cocoFarm.dto.Product;
import cocoFarm.service.ProductService;

@Controller
public class ProductController {
	
	@Autowired ProductService productService;
	
	@RequestMapping(value="/product/insert.do", method=RequestMethod.GET)
	public String insert() {
		System.out.println("여기?");
		return "mypage";
	}
	
	@RequestMapping(value="/product/insert.do", method=RequestMethod.POST)
	public String insertProduct(Product product) {
		System.out.println(product.getTitle());
		productService.insert(product);
		return "mypage";
//		return "redirect:/product/insert.do?";
	}
	
}
