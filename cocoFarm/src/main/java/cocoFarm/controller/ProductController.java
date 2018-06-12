package cocoFarm.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.google.gson.JsonArray;

import cocoFarm.dto.FileDto;
import cocoFarm.dto.Option;
import cocoFarm.dto.Product;
import cocoFarm.dto.SaleOption;
import cocoFarm.service.ProductService;
import cocoFarm.util.Paging;

@Controller
public class ProductController {
	
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	@Autowired ProductService productService;
	@Autowired ServletContext context;
	
	@RequestMapping(value="/seller/mypage/nav", method=RequestMethod.GET)
	public String nav() {
		return "mypage/seller/mypage_load";
	}
	
	@RequestMapping(value="/product", method=RequestMethod.GET)
	public String productList(@RequestParam(defaultValue="0") int curPage
							, Model model) {
		
		int totalCount = productService.getListCount();
		
		// 페이징 생성
		Paging paging  = new Paging(totalCount, curPage);
		model.addAttribute("paging", paging);
		
		List optionList = productService.getPagingList(paging);
		model.addAttribute("optionList", optionList);
//		System.out.println(optionList.get(0));  // 가장 최근 SaleOption 정보 출력
		
		return "mypage/seller/productList";
	}
	
	@RequestMapping(value="/product/insert.do", method=RequestMethod.GET)
	public String insert(HttpSession session) {
		logger.info("insert.do get!");
		return "mypage/seller/productInsert";
	}
	
	@RequestMapping(value="/product/insert.do", method=RequestMethod.POST)
	public String insertProduct(Product product
								, Option opt
								, FileDto f
								, HttpSession session) {
		
		logger.info("insert.do post!");
		List<MultipartFile> list = f.getUpload();
		
		logger.info("faceImg: \"" + list.get(0).getOriginalFilename() + "\"");
		logger.info("mainImg: " + list.get(1).getOriginalFilename());
		logger.info("size: " + list.size());
		logger.info("length: " + list.get(0).getOriginalFilename().length());
		
		// 고유 식별자
		logger.info(UUID.randomUUID().toString());
		String uID = UUID.randomUUID().toString().split("-")[0];
		
		// 파일이 저장될 경로
		String realpath = context.getRealPath("resources/proimg");
		logger.info(realpath);
		
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
		
		// 상품을 등록하는 사람의 idx
		product.setAccIdx((Integer)session.getAttribute("idx"));
		
		productService.insert(product);
		
		List<SaleOption> saleList = opt.getSaleOptions();
		for(int i=0; i<saleList.size(); i++) {
			productService.insert(product, saleList.get(i));
		}
		
		return "redirect:/product";
	}
	
	@RequestMapping(value="/product/update.do", method=RequestMethod.GET)
	public String update(SaleOption saleOption
//						, HttpSession session
						, Model model) {
		logger.info("update.do get!");
		
		// 판매상품, 대표이미지, 상세설명이미지
		Product productView = productService.productView(saleOption.getSaleIdx());
		model.addAttribute("product", productView);

		// 대표이미지, 상세설명이미지
//		model.addAttribute("productImg", )
		
		// 옵션 개수
		// 필요 없었다... optionView.size()로 해결
//		int num = productService.optionNumber(saleOption.getSaleIdx());
//		model.addAttribute("optionNum", num);
		
		// 판매상품 옵션
		List optionView = productService.optionView(saleOption.getSaleIdx());
		model.addAttribute("optionView", optionView);
		
//		session.setAttribute("saleIdx", productView.getIdx());
		
		return "mypage/seller/productUpdate";
	}
	
	@RequestMapping(value="/product/update.do", method=RequestMethod.POST)
	public String updateProduct(Product product
								, Option opt
								, FileDto f) {
		logger.info("update.do post!");
		
		System.out.println(product.getIdx());
		
		// 이미지를 새로 등록
		List<MultipartFile> list = f.getUpload();
		
		logger.info("faceImg: " + list.get(0).getOriginalFilename());
		logger.info("mainImg: " + list.get(1).getOriginalFilename());
		logger.info("size: " + list.size());
		
		// 고유 식별자
		logger.info(UUID.randomUUID().toString());
		String uID = UUID.randomUUID().toString().split("-")[0];
		
		// 파일이 저장될 경로
		String realpath = context.getRealPath("resources/proimg");
		logger.info(realpath);
		
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
		
		// 대표이미지, 상세설명이미지가 하나라도 등록되면 실행
//		if(list.get(0).getOriginalFilename().length()!=0
//				|| list.get(1).getOriginalFilename().length()!=0) {
//		}
		
		productService.update(product);
		
//		System.out.println(opt.getSaleOptions().get(0).getIdx()); //0
//		System.out.println(opt.getSaleOptions().get(1).getIdx()); //0
		
		// 쿼리스트링을 통해 받은 idx (Product) ( = saleIdx (SaleOption) )
		for(int i=0; i<opt.getSaleOptions().size(); i++) {
			opt.getSaleOptions().get(i).setSaleIdx(product.getIdx());
		}
		productService.update(opt);
		
		return "redirect:/product";
	}
	
	@RequestMapping(value="/product/cart.do", method=RequestMethod.GET)
	public String basketList(Model model, HttpSession session) {
		logger.info("cart.do get!");

		logger.info("-----------controller-----------");

		int accIdx = (Integer)session.getAttribute("idx");
		List<SaleOption> cartOptionList = productService.cartView(accIdx);
		model.addAttribute("optionCart", cartOptionList);
//		logger.info("proAmount: " + cartOptionList.get(0).getProAmount());
		
		Product product = null;
		List<Product> cartProductList = new ArrayList<>();
		
		int saleIdx = 0;
		if(cartOptionList.get(0) != null) {
			saleIdx = cartOptionList.get(0).getSaleIdx();
			product = productService.productView(saleIdx);
			cartProductList.add(product);
		}
		for(int i=0; i<cartOptionList.size(); i++) {
			if(saleIdx != cartOptionList.get(i).getSaleIdx()) {
				saleIdx = cartOptionList.get(i).getSaleIdx();
				product = productService.productView(saleIdx);
				cartProductList.add(product);
			} else { continue; }
		}
		model.addAttribute("productCart", cartProductList);
		
		return "mypage/common/productCart";
	}
	
//	@RequestMapping(value="/product/cart.do", method=RequestMethod.GET)
//	@ResponseBody
//	public List<HashMap<String, Object>> getItems() {
//	public HashMap<String, Object> getItems() {
//		
//		
//		return null;
//	}
	
	@RequestMapping(value="/product/cart.do", method=RequestMethod.POST)
	public String insertBasket(Option option
							, HttpSession session
							, Model model) {
		logger.info("cart.do post!");
		
		List<SaleOption> saleList = option.getSaleOptions();
//		for(int i=0; i<saleList.size(); i++) {
//			logger.info("Option" + (i+1) + ": " + saleList.get(i));
//		}
		
		// 상품을 등록하는 사람의 idx
		productService.insertCart(option, (Integer)session.getAttribute("idx"));
		
//		model.addAttribute("optionCart", option);
		
		return "redirect:/product/cart.do";
	}
	
	@RequestMapping(value="/product/deleteCart.do", method=RequestMethod.POST)
	public String deleteBasket(String productIdx) {
		if( !"".equals(productIdx) && productIdx != null) {
			int saleIdx = Integer.parseInt(productIdx);
			productService.deleteCart(saleIdx);
		}
		return "redirect:/product/cart.do";
	}
	
	@RequestMapping(value="/product/insertComment.do", method=RequestMethod.POST)
	@ResponseBody
	public void insertComment(@RequestBody List comment,
//								Comment comment,
								HttpSession session) {
		Gson gson = new Gson();
//		List<Map<String, Object>> resultMap = new ArrayList<Map<String,Object>>();
//		resultMap = JsonArray.fromObject(comment);
		
//		List list = gson.fromJson(comment, List.class);
		logger.info("-------------------comment-----------------");
//		logger.info("comment: " + list);
		logger.info("comment: " + comment);
		
//		for(int i=0; i<list.size(); i++) {
//			Map map = (Map)list.get(i);
//			System.out.println(map);
//		}
	}
	
}
