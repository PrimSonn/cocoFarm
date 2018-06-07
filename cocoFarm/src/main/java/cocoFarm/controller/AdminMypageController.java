package cocoFarm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cocoFarm.dto.Account;
import cocoFarm.service.AdminMypageService;

@Controller
public class AdminMypageController {
	
	@Autowired
	AdminMypageService adminMypageService;
	
	@RequestMapping(value="/mypage/wholeacc.do", method=RequestMethod.GET)
	public void wholeAcc(Account account, Model model) {
		
		List wholeAccList = adminMypageService.wholeAcc(account);
		
		model.addAttribute("wholeAccList", wholeAccList);
		
	}
	


}
