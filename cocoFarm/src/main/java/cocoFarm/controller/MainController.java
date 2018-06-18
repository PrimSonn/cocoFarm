package cocoFarm.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import cocoFarm.dto.Product;
import cocoFarm.service.Auction_Service;
import cocoFarm.service.BoardService;
import cocoFarm.service.ProductService;

@Controller
public class MainController {

	@Autowired ProductService productService;
	@Autowired BoardService boardService;
	@Autowired Auction_Service auctionService;
	
	/*
	 *빈 URL -> 메인 
	 */
	@RequestMapping(value="/", method=RequestMethod.GET)
	public ModelAndView emptytUrl(ModelAndView mav) {
		
		mav.addObject("seller",productService.getProViewMainList());
		mav.addObject("farm",boardService.getboardMainList());
		mav.addObject("auction",auctionService.getMainAuctionList());
		mav.setViewName("main/cocomain");
		return mav;
	}
	
	//2018 06월 11일 main 넣은것
	@RequestMapping(value="/main/cocomain.do", method=RequestMethod.GET)
	public String main(HttpSession session,Product product, Model model){
		
		//판매글 최근 5개 띄우기
		model.addAttribute("seller",productService.getProViewMainList());
		
		/*boardService.getboardMainList();*/
		model.addAttribute("farm",boardService.getboardMainList());
		
		//model.addAttribute("auction",auctionService.getAuctionMainList());
		model.addAttribute("auction",auctionService.getMainAuctionList());
		
		return "main/cocomain";
	}
	
	//2018 06월 12일 hwanmin 작업 
	
	//판매 상세 정보
	@RequestMapping(value="/companyinfo.do",method=RequestMethod.GET)
	public String companyInfo(Product product, Model model) {
		
		return "companyinfo/comintro";
	}
	//민주 페이지에 띄우기
	@RequestMapping(value="/main/faq.do",method=RequestMethod.GET)
	public void faq() {
		
	}
}
