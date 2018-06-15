package cocoFarm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import cocoFarm.dto.Account;
import cocoFarm.dto.LicenseDto;
import cocoFarm.service.AdminMypageService;
import cocoFarm.util.Paging;

@Controller
public class AdminMypageController {
	
	@Autowired
	AdminMypageService adminMypageService;
	
	@RequestMapping(value="/mypage/wholeAcc.do", method=RequestMethod.GET)
	public void wholeAcc(@RequestParam(defaultValue="0") int curPage, Account account, Model model) {
		
		int totalCount = adminMypageService.getTotalAcc();
		
		Paging paging = new Paging(totalCount, curPage);
		model.addAttribute("paging", paging);
		
		List wholeAccList = adminMypageService.wholeAcc(paging);
		
		model.addAttribute("wholeAccList", wholeAccList);
		
	}
	
	@RequestMapping(value="/mypage/delWholeAcc.do", method=RequestMethod.GET)
	public void delWholeAcc(@RequestParam(defaultValue="0") int curPage, Account account, Model model) {
		
		int totalCount = adminMypageService.getTotalDelAcc();
		
		Paging paging = new Paging(totalCount, curPage);
		model.addAttribute("paging", paging);
		
		List delWholeAccList = adminMypageService.delWholeAcc(paging);
		
		model.addAttribute("delWholeAccList", delWholeAccList);
		
	}
	
	@RequestMapping(value="/mypage/licenseList.do", method=RequestMethod.GET)
	public void licenseList(Model model) {
		
		List licenseList = adminMypageService.licenseList();
		
		model.addAttribute("licenseList", licenseList);
		
	}
	
	@RequestMapping(value="/mypage/licenseView.do", method=RequestMethod.GET)
	public void licenseView(LicenseDto license, Model model) {
		
		model.addAttribute("licenseView", adminMypageService.licenseView(license));
		
	}
	
	@RequestMapping(value="/mypage/licenseOk.do", method=RequestMethod.POST)
	public String licenseOk(int acc_idx) {
//		System.out.println("승인 작동 = " + acc_idx);
		//관리자가 판매자등록 승인 버튼 누르면 작동하는 메소드
		
		adminMypageService.licenseOk(acc_idx);
		adminMypageService.licenseOkMsg(acc_idx);
		
		return "redirect:/mypageIntro.do";
	}
	
	@RequestMapping(value="/mypage/licenseNo.do", method=RequestMethod.POST)
	public String licenseNo(int acc_idx) {
//		System.out.println("승인 작동 = " + acc_idx);
		//관리자가 판매자등록 거절 버튼 누르면 작동하는 메소드
		
		adminMypageService.licenseNoMsg(acc_idx);
		adminMypageService.licenseNo(acc_idx);
		
		return "redirect:/mypageIntro.do";
	}
	
	
	@RequestMapping(value="/mypage/adminPaynee.do", method=RequestMethod.GET)
	public String adminPaynee(Model model) {
		
		model.addAttribute("adminPaynee", adminMypageService.adminPaynee());
		
		return "mypage/common/adminPaynee";
	}
	

}
