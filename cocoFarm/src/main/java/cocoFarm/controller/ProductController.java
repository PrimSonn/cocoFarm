package cocoFarm.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import cocoFarm.dto.Product;
import cocoFarm.dto.SaleOption;
import cocoFarm.service.ProductService;

@Controller
public class ProductController {
	
	@Autowired ProductService productService;
	@Autowired ServletContext context;
	
	@RequestMapping(value="/product/insert.do", method=RequestMethod.GET)
	public String insert() {
		System.out.println("insert.do get!");
		return "mypage";
	}
	
	@RequestMapping(value="/product/insert.do", method=RequestMethod.POST)
	public String insertProduct(Product product, SaleOption saleOption,
								HttpSession session, MultipartFile file) {
		// 고유 식별자
		String uID = UUID.randomUUID().toString().split("-")[0];
		
		// 파일이 저장될 경로
		String realpath = context.getRealPath("upload");
		
		// 파일이 저장될 이름
		String stored = file.getOriginalFilename() + "_" + uID;
		
		File dest = new File(realpath, stored);
		System.out.println(dest);
		
		// 실제 파일 업로드
		try {
			file.transferTo(dest);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		product.setFaceImg(stored);
		
		product.setAccIdx(1);
//		System.out.println(session.getAttribute("idx"));
//		product.setAccIdx((Integer)session.getAttribute("idx"));
//		System.out.println(product.getAccIdx());
		
		productService.insert(product, saleOption);
//		System.out.println(saleOption);
		
//		return "mypage";
		return "redirect:/product/insert.do?";
	}
	
}
