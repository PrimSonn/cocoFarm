package cocoFarm.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import cocoFarm.dto.FileDto;
import cocoFarm.dto.Option;
import cocoFarm.dto.Product;
import cocoFarm.dto.SaleOption;
import cocoFarm.service.ProductService;

@Controller
public class ProductController {
	
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	@Autowired ProductService productService;
	@Autowired ServletContext context;
	
	@RequestMapping(value="/product/insert.do", method=RequestMethod.GET)
	public String insert() {
		logger.info("insert.do get!");
		return "Mypage/seller/productInsert";
	}
	
	@RequestMapping(value="/product/insert.do", method=RequestMethod.POST)
	public String insertProduct(Product product
//								, SaleOption saleOption
								, Option opt
								, FileDto f
								, HttpSession session) {
		
		logger.info("insert.do post!");
		List<MultipartFile> list = f.getUpload();
		
//		List<SaleOption> saleList = opt.getOption();
//		System.out.println("옵션1 optionName: " + saleList.get(0).getOptionName());
		
		System.out.println("list1: " + list.get(0).getOriginalFilename());
		System.out.println("list2: " + list.get(1).getOriginalFilename());
		
//		System.out.println(UUID.randomUUID().toString());
		// 고유 식별자
		String uID = UUID.randomUUID().toString().split("-")[0];
		
		// 파일이 저장될 경로
		String realpath = context.getRealPath("upload");
		System.out.println(realpath);
		
		// 파일이 저장될 이름
		String stored1 = "0" + list.get(0).getOriginalFilename() + "_" + uID;
		String stored2 = "1" + list.get(1).getOriginalFilename() + "_" + uID;
		
		File dest1 = new File(realpath, stored1);
		File dest2 = new File(realpath, stored2);
		System.out.println(dest1);
		System.out.println(dest2);
		
		// 실제 파일 업로드
		try {
			list.get(0).transferTo(dest1);
			list.get(1).transferTo(dest2);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		product.setFaceImg(stored1);
		product.setMainImg(stored2);
		product.setAccIdx(2);
//		System.out.println(session.getAttribute("idx"));
//		product.setAccIdx((Integer)session.getAttribute("idx"));
//		System.out.println(product.getAccIdx());

		//이거
//		productService.insert(product, saleOption);
		
		return "Mypage/seller/productResult";
//		return "redirect:/product/insert.do?";
	}
	
}
