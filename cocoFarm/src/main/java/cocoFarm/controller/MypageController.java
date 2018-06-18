package cocoFarm.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cocoFarm.dto.Account;
import cocoFarm.dto.Option;
import cocoFarm.service.LoginService;

@Controller
public class MypageController {
	@Autowired LoginService loginService;
	
	@RequestMapping(value="/mypage/mypage.do", method=RequestMethod.GET)
	public void mypage(){}
	
	/*2018년 6월 10일 추가 마이페이지 인트로 */
	@RequestMapping(value="/mypageIntro.do", method=RequestMethod.GET)
	public String mypageIntro(Option option
							, HttpSession session
							, Model model) {
		int idx = (int)session.getAttribute("idx");
		Account account = loginService.selectAll(idx);
		model.addAttribute("account", account);
		
		if((Integer)session.getAttribute("type")<=1){
			return "mypage/admin/adminIntro";
		}else if((Integer)session.getAttribute("type")==2) {
			return "mypage/seller/productIntro";
		}else {
			return "mypage/user/userIntro";
		}
		
	}
@RequestMapping(value="/testIntro.do", method=RequestMethod.GET)
public String testIntro(Option option
						, HttpSession session
						, Model model) {
	int idx = (int)session.getAttribute("idx");
	Account account = loginService.selectAll(idx);
	model.addAttribute("account", account);
	
	if((Integer)session.getAttribute("type")<=1){
		return "mypage/admin/adminIntro";
	}else if((Integer)session.getAttribute("type")==2) {
		return "mypage/seller/productIntro";
	}else {
		return "mypage/user/loadtest";
		//return "mypage/common/productCart";
	}
	
}

}


