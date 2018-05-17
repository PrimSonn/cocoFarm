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
	
	@RequestMapping(value="/product/view.do", method=RequestMethod.GET)
	public String viewList(Product product, Model model) {
		
		return "product/view";
	}
	
	@RequestMapping(value="/product/insert.do", method=RequestMethod.POST)
	public String insertProduct(Product product) {
		productService.insert(product);
		
		return "redirect:/product/view.do?";
	}
	
	@RequestMapping(value="/product/update.do", method=RequestMethod.POST)
	public String updateProduct(Product product) {
		productService.update(product);
		
		return "redirect:/product/view.do?";
	}
	
}
