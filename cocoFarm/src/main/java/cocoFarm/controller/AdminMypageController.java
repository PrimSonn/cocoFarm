package cocoFarm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cocoFarm.dto.Account;
import cocoFarm.dto.LicenseDto;
import cocoFarm.service.AdminMypageService;

@Controller
public class AdminMypageController {
	
	@Autowired
	AdminMypageService adminMypageService;
	
	@RequestMapping(value="/mypage/wholeAcc.do", method=RequestMethod.GET)
	public void wholeAcc(Account account, Model model) {
		
		List wholeAccList = adminMypageService.wholeAcc(account);
		
		model.addAttribute("wholeAccList", wholeAccList);
		
	}
	
	@RequestMapping(value="/mypage/delWholeAcc.do", method=RequestMethod.GET)
	public void delWholeAcc(Account account, Model model) {
		
		List delWholeAccList = adminMypageService.delWholeAcc(account);
		
		model.addAttribute("delWholeAccList", delWholeAccList);
		
	}
	
	@RequestMapping(value="/mypage/licenseList.do", method=RequestMethod.GET)
	public void licenseList(Model model) {
		
		List licenseList = adminMypageService.licenseList();
		
		model.addAttribute("licenseList", licenseList);
		
	}
	
	@RequestMapping(value="/mypage/licenseView.do", method=RequestMethod.POST)
	public void licenseView(LicenseDto license, Model model) {
		
		model.addAttribute("licenseView", adminMypageService.licenseView(license));
		
	}
	
	@RequestMapping(value="/mypage/licenseOk.do", method=RequestMethod.POST)
	public String licenseOk(int acc_idx) {
//		System.out.println("승인 작동 = " + acc_idx);
		//관리자가 판매자등록 승인 버튼 누르면 작동하는 메소드
		
		adminMypageService.licenseOk(acc_idx);
		adminMypageService.licenseOkMsg(acc_idx);
		
		return "redirect:/mypage/licenseList.do";
	}
	
	@RequestMapping(value="/mypage/licenseNo.do", method=RequestMethod.POST)
	public String licenseNo(int acc_idx) {
//		System.out.println("승인 작동 = " + acc_idx);
		//관리자가 판매자등록 거절 버튼 누르면 작동하는 메소드
		
		adminMypageService.licenseNoMsg(acc_idx);
		
		return "redirect:/mypage/licenseList.do";
	}
	

}
