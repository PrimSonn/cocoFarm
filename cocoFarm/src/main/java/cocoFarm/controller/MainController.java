package cocoFarm.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cocoFarm.dto.Product;
import cocoFarm.service.BoardService;
import cocoFarm.service.ProductService;

@Controller
public class MainController {

	@Autowired ProductService productService;
	@Autowired BoardService boardService;
	
	/*
	 *빈 URL -> 메인 
	 */
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String emptytUrl() {
		return "main/cocomain";
	}
	
	//2018 06월 11일 main 넣은것
	@RequestMapping(value="/main/cocomain.do", method=RequestMethod.GET)
	public String main(HttpSession session,Product product, Model model){
		System.out.println(session.getAttribute("idx"));
		System.out.println(session.getAttribute("type")); 
		//판매글 최근 5개 띄우기
		model.addAttribute("seller",productService.getProViewMainList());
		
		/*boardService.getboardMainList();*/
		model.addAttribute("farm",boardService.getboardMainList());
		
		/*
	
		SELECT acc_idx, title, content, written_date, hit, ISDEL,
		(SELECT stored_filename FROM TODAYS_FARMER_file WHERE acc_idx = t.acc_idx) AS stored_filename	
		FROM TODAYS_FARMER t 
		inner join (select IDX, THUMB_LOC main_img from account) a
		on t.acc_idx = a.IDX;
		    
		*/
		return "main/cocomain";
	}
	
	//2018 06월 12일 hwanmin 작업 
	
	//판매 상세 정보
	@RequestMapping(value="/companyinfo.do",method=RequestMethod.GET)
	public String companyInfo(Product product, Model model) {
		
		return "companyinfo/comintro";
	}
}
