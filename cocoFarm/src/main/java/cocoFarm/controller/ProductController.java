package cocoFarm.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import cocoFarm.dto.Account;
import cocoFarm.dto.Cart;
import cocoFarm.dto.Comment;
import cocoFarm.dto.FileDto;
import cocoFarm.dto.Option;
import cocoFarm.dto.Product;
import cocoFarm.dto.SaleOption;
import cocoFarm.service.LoginService;
import cocoFarm.service.ProductService;
import cocoFarm.util.Paging;

@Controller
public class ProductController {
	
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	@Autowired ProductService productService;
	@Autowired ServletContext context;
	@Autowired LoginService loginService;

	//판매 상세 정보 옴김
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
	
	
	//판매 디테일 뷰
	@RequestMapping(value="/sellerDetail.do",method=RequestMethod.GET)
	public String detailProView(Product product
								, SaleOption saleoption
								, Model model) {
		
		logger.info("sellerDetail.do GET!!!");

		model.addAttribute("product", (productService.getDetailList(product)));
		model.addAttribute("option", (productService.getOptionList(saleoption)));
		
		return "main/mainseller/sellerDetail";
	}
	
	@RequestMapping(value="/product", method=RequestMethod.GET)
	public String productList(@RequestParam(defaultValue="0") int curPage
							, Model model,HttpSession session) {
		//추가 해준거 
		int idx = (int)session.getAttribute("idx");
		Account account = loginService.selectAll(idx);
		System.out.println(session.getAttribute("type"));
		model.addAttribute("account", account);
		
		
		
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
						, HttpSession session
						, Model model) {
		
		logger.info("update.do get!");
		
		//추가 해준거 
		int idx = (int)session.getAttribute("idx");
		Account account = loginService.selectAll(idx);
		System.out.println(session.getAttribute("type"));
		model.addAttribute("account", account);

		
		
		
		// 판매상품, 대표이미지, 상세설명이미지
		Product productView = productService.productView(saleOption.getSaleIdx());
		model.addAttribute("product", productView);

		// 대표이미지, 상세설명이미지
//		model.addAttribute("productImg", )
		
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
		
		
		if (f != null) {
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
			
		}
		
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
		logger.info("/product/cart.do GET !!!!");
		logger.info("-----------controller-----------");
		
		int idx = (int)session.getAttribute("idx");
		Account account = loginService.selectAll(idx);

		System.out.println(session.getAttribute("type"));
		model.addAttribute("account", account);
		
		int accIdx = (Integer)session.getAttribute("idx");
		
		List<Cart> cart = productService.selectCart(accIdx);
		model.addAttribute("cart", cart);
		
		List<SaleOption> cartOptionList = null;
		cartOptionList = productService.cartView(accIdx);
		model.addAttribute("optionCart", cartOptionList);
		
		List<Product> cartProductList = new ArrayList<>();
		Product product = null;
		
		// 장바구니에 담긴 상품이 없다면 
		int saleIdx = 0;
		if(cartOptionList.size() != 0) {
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
		
		if((Integer)session.getAttribute("type")<=1){
			return "mypage/admin/adminCart";
		}else if((Integer)session.getAttribute("type")==2) {
			return "mypage/seller/sellerCart";
		}else {
			return "mypage/user/userCart";
		}
	}
	
	@RequestMapping(value="/product/cart.do", method=RequestMethod.POST)
	public String insertBasket(Option option
							, HttpSession session
							, Model model) {
		logger.info("/product/cart.do POST !!!");
		
		// 상품을 등록하는 사람의 idx
		productService.insertCart(option, (Integer)session.getAttribute("idx"));
		
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
	
	@RequestMapping(value="/product/updateCart.do", method=RequestMethod.POST)
	@ResponseBody
	public List updateCart(String cart, HttpSession session) {
		logger.info("updateCart.do POST !!!!");
		
		Gson gson = new Gson();
		List list = gson.fromJson(cart, List.class);
		
		logger.info("cart: " + list);

		System.out.println(list.get(0));
		
		Cart c = new Cart();
		for(int i=0; i<list.size(); i++) {
			Map<String, Integer> map = (Map) list.get(i);
			System.out.println(map);
//			c.setSaleOptionIdx(map.get("saleOptionIdx"));
//			c.setSaleOptionIdx( ((Double)map.get("saleOptionIdx")).intValue() );
//			c.setCount( ((Double)map.get("sa	leOptionIdx")).intValue() );
			
			productService.updateCart(map);
		}
		List items = productService.selectCart((Integer)session.getAttribute("idx"));
		
		return items;
	}
	
	@RequestMapping(value="/product/viewComment.do", method=RequestMethod.POST)
	@ResponseBody
	public List<HashMap<String, Object>> comment(Comment comment
											, String insertComm) {
		logger.info("viewComment.do POST !!!!");
		
//		logger.info("sale_idx: " + comment.getSale_idx());
		
		Gson gson = new Gson();
		List list = gson.fromJson(insertComm, List.class);
		
		logger.info("-------------------Constroller comment-----------------");
		logger.info("list: " + list);
		logger.info("viewComment: " + comment);
		if(list.get(0) != null) {
			for(int i=0; i<list.size(); i++) {
				Map<String, Object> map = (Map) list.get(i);
				Comment comm = new Comment();
				comm.setSale_idx( ((Double)map.get("saleIdx")).intValue() );
				comm.setScore(5);
				comm.setTitle( (String) map.get("title") );
				comm.setContent( (String) map.get("content") );
				
				productService.insertComment(comm);
			}
		}
		List<HashMap<String, Object>> items = new ArrayList<HashMap<String,Object>>();
		Map<String, Object> item = new HashMap<>();
//		item = productService.getCommentList(comment.getSale_idx());
//		Comment comm = productService.getCommentList(comment.getSale_idx());
		
//		item.put("score", comm.getScore());
//		item.put("content", comm.getContent());
//		item.put("accName", comm.getAcc_name());
		
//		items.add(item);
		items = productService.getCommentList(comment.getSale_idx());
		logger.info("####### Response commentList: " + items);
		
		return items;
	}
	
	@RequestMapping(value="/product/viewComment.do", method=RequestMethod.GET)
	public void comm() {
		logger.info("viewComment.do GET !!!!");
	}
	
	@RequestMapping(value="/product/payNee.do", method=RequestMethod.GET)
	public String procPaynee(HttpSession session, Model model) {
		
		int accIdx = (int) session.getAttribute("idx");
		
		model.addAttribute("procPaynee", productService.procPayNee(accIdx));
		
		return "mypage/common/procPaynee";
		
	}
}
