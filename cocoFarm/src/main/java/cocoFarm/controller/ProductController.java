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
		
		model.addAttribute("seller",(productService.getProMainList()));
		return "main/mainseller/sellermain";
	}
	
	//판매 상세 정보
	@RequestMapping(value="/seller.do",method=RequestMethod.POST)
	public String searchviewList(Product product, Model model) {
		
		model.addAttribute("seller",(productService.getSerchList(product)));
		return "main/mainseller/sellermain";
	}
	
	//판매 디테일 뷰
	@RequestMapping(value="/sellerDetail.do",method=RequestMethod.GET)
	public String detailProView(Product product, SaleOption saleoption, Model model) {

		model.addAttribute("product", (productService.getDetailList(product)));
		model.addAttribute("option", (productService.getOptionList(saleoption)));
		
		return "main/mainseller/sellerDetail";
	}
	
	// 판매 상품 옵션 조회
	@RequestMapping(value="/product", method=RequestMethod.GET)
	public String productList(@RequestParam(defaultValue="0") int curPage
							, Model model, HttpSession session) {
		
		int idx = (int)session.getAttribute("idx");
		Account account = loginService.selectAll(idx);
		model.addAttribute("account", account);
		
		int totalCount = productService.getListCount(idx);
		
		// 페이징 생성
		Paging paging  = new Paging(totalCount, curPage);
		model.addAttribute("paging", paging);
		
		List optionList = productService.getPagingList(paging, idx);
		model.addAttribute("optionList", optionList);
		
		return "mypage/seller/productList";
	}
	
	@RequestMapping(value="/product/insert.do", method=RequestMethod.GET)
	public String insert(HttpSession session, Model model) {

		int idx = (int)session.getAttribute("idx");
		Account account = loginService.selectAll(idx);
		model.addAttribute("account", account);
		
		return "mypage/seller/productInsert";
	}
	
	// 판매 상품 등록
	@RequestMapping(value="/product/insert.do", method=RequestMethod.POST)
	public String insertProduct(Product product, Option opt, FileDto f, HttpSession session) {
		
		List<MultipartFile> list = f.getUpload();
		
		// 고유 식별자
		String uID = UUID.randomUUID().toString().split("-")[0];
		
		// 파일이 저장될 경로
		String realpath = context.getRealPath("resources/proimg");
		
		// 파일이 저장될 이름
		String stored1 = "0" + list.get(0).getOriginalFilename() + "_" + uID;
		String stored2 = "1" + list.get(1).getOriginalFilename() + "_" + uID;
		
		File dest1 = new File(realpath, stored1);
		File dest2 = new File(realpath, stored2);
		
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
	
	// 판매 상품 정보 불러오기
	@RequestMapping(value="/product/update.do", method=RequestMethod.GET)
	public String update(SaleOption saleOption, HttpSession session, Model model) {
		
		int idx = (int)session.getAttribute("idx");
		Account account = loginService.selectAll(idx);
		model.addAttribute("account", account);
		
		// 판매상품, 대표이미지, 상세설명이미지
		Product productView = productService.productView(saleOption.getSaleIdx());
		model.addAttribute("product", productView);

		// 대표이미지, 상세설명이미지
//		model.addAttribute("productImg", )
		
		// 판매상품 옵션
		List optionView = productService.optionView(saleOption.getSaleIdx());
		model.addAttribute("optionView", optionView);
		
		return "mypage/seller/productUpdate";
	}
	
	// 판매 상품 수정
	@RequestMapping(value="/product/update.do", method=RequestMethod.POST)
	public String updateProduct(Product product, Option opt, FileDto f) {
		
		// 고유 식별자
		String uID = UUID.randomUUID().toString().split("-")[0];
		// 파일이 저장될 경로
		String realpath = context.getRealPath("resources/proimg");
		
		String[] destAr = new String[2];
		int j=-1;
		for(MultipartFile m: f.getUpload()) {
			++j;
			if(m.isEmpty())continue;
			try {
				destAr[j] = new StringBuilder()
							.append(String.valueOf(j))
							.append(m.getOriginalFilename())
							.append("_")
							.append(uID)
							.toString();
				m.transferTo( new File(realpath,destAr[j]) );
				
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
		product.setFaceImg(destAr[0]);
		product.setMainImg(destAr[1]);
		
		productService.update(product);
		
		// 쿼리스트링을 통해 받은 idx (Product) ( = saleIdx (SaleOption) )
		for(int i=0; i<opt.getSaleOptions().size(); i++) {
			opt.getSaleOptions().get(i).setSaleIdx(product.getIdx());
		}
		productService.update(opt);
		
		return "redirect:/product";
	}
	
	@RequestMapping(value="/product/cart.do", method=RequestMethod.POST)
	public String basket() {
		return "redirect:/product/cart.do";
	}

	// 장바구니 조회
	@RequestMapping(value="/product/cart.do", method=RequestMethod.GET)
	public String basketList(Model model, HttpSession session) {
		int idx = (int)session.getAttribute("idx");
		Account account = loginService.selectAll(idx);
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
	
	// 장바구니 담기
	@RequestMapping(value="/product/cartInsert.do", method=RequestMethod.POST)
	public String insertBasket(Option option
							, HttpSession session
							, Model model) {
		
		System.out.println(option.equals(null));
		System.out.println(option.getSaleOptions().equals(null));
		
		// 상품을 등록하는 사람의 idx
		productService.insertCart(option, (Integer)session.getAttribute("idx"));
		int idx = (int)session.getAttribute("idx");
		Account accountone = loginService.selectAll(idx);
		model.addAttribute("account",accountone);
		return "redirect:/product/cart.do";
	}
	
	// 장바구니 삭제
	@RequestMapping(value="/product/deleteCart.do", method=RequestMethod.POST)
	public String deleteBasket(String productIdx) {
		if( !"".equals(productIdx) && productIdx != null) {
			int saleIdx = Integer.parseInt(productIdx);
			productService.deleteCart(saleIdx);
		}
		return "redirect:/product/cart.do";
	}
	
	// 장바구니 옵션 수정
	@RequestMapping(value="/product/updateCart.do", method=RequestMethod.GET)
	public String updateCart() {
		return "redirect:/product/cart.do";
	}
	
	// 장바구니 옵션 수정
	@RequestMapping(value="/product/updateCart.do", method=RequestMethod.POST)
	@ResponseBody
	public List updateCart(String cart, HttpSession session) {
		
		Gson gson = new Gson();
		List list = gson.fromJson(cart, List.class);

		Cart c = new Cart();
		for(int i=0; i<list.size(); i++) {
			Map<String, Integer> map = (Map) list.get(i);
//			c.setSaleOptionIdx(map.get("saleOptionIdx"));
//			c.setSaleOptionIdx( ((Double)map.get("saleOptionIdx")).intValue() );
//			c.setCount( ((Double)map.get("saleOptionIdx")).intValue() );
			productService.updateCart(map);
		}
		List items = productService.selectCart((Integer)session.getAttribute("idx"));
		
		return items;
	}

	@RequestMapping(value="/product/viewComment.do", method=RequestMethod.GET)
	public void comm() {	}
	
	// 상품 후기 조회
	@RequestMapping(value="/product/viewComment.do", method=RequestMethod.POST)
	@ResponseBody
	public List<HashMap<String, Object>> comment(Comment comment, String sale_idx) {
				
		List<HashMap<String, Object>> items = new ArrayList<HashMap<String,Object>>();
		Map<String, Object> item = new HashMap<>();
		
		items = productService.getCommentList(comment.getSale_idx());
		
		return items;
	}
	
	@RequestMapping(value="/product/insertComment.do", method=RequestMethod.GET)
	public void insertComm() {	}
	
	// 상품후기 등록
	@RequestMapping(value="/product/insertComment.do", method=RequestMethod.POST)
	@ResponseBody
	public boolean insertComment(Comment comment
								, int receiptIdx
								, int optionIdx
								, String content
								, HttpSession session) {

//		Gson gson = new Gson();
//		List list = gson.fromJson(insertComm, List.class);
		
		Product product = productService.selectProductByReceipt(receiptIdx, optionIdx);
		
//		if(list.get(0) != null) {
//			for(int i=0; i<list.size(); i++) {
//				Map<String, String> map = (Map) list.get(i);
//				String str = map.get("main_recpt_idx");
				
				Comment comm = new Comment();
				
				comm.setSale_idx(product.getIdx());
				comm.setScore(5);
				comm.setTitle(product.getTitle());
				comm.setMain_recpt_idx(receiptIdx);
				comm.setContent(content);
				
				productService.insertComment(comm);
//			}
//		}
		
		return true;
	}
}
