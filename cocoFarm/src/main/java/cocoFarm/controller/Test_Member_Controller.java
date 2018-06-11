package cocoFarm.controller;


import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cocoFarm.dto.Account;
import cocoFarm.service.TestMemberService;

@Controller
public class Test_Member_Controller {
	private static final Logger logger = LoggerFactory.getLogger(Test_Member_Controller.class);
	
	@Autowired TestMemberService memberService;

	@RequestMapping(value="/main/cocomain.do", method=RequestMethod.GET)
	public void mainview() {}
	
	
	
	@RequestMapping(value="/member/login.do"
			, method=RequestMethod.GET)
	public void login() { }

	@RequestMapping(value="/member/login.do"
			, method=RequestMethod.POST)
	public String loginProcess(
			Account member,
			HttpSession session,
			Model model) {
		System.out.println(member);
		
		boolean loginResult = memberService.login(member);
		
		if(loginResult) {
			logger.info("로그인 성공");
			model.addAttribute("msg", "로그인 성공");
			model.addAttribute("url", "/main/cocomain");
			
			session.setAttribute("login", true);
			session.setAttribute("id", member.getId());
			session.setAttribute("type", memberService.getUsertype(member));
			session.setAttribute("idx", memberService.getUserIdx(member));
			session.setAttribute("name", memberService.getUsernick(member));
			
			logger.info("세션상태 : " + session.getAttribute("login"));
			logger.info("세션 아이디 : " + session.getAttribute("id"));
			logger.info("세션 닉네임 : " + session.getAttribute("name"));
			
		} else {
			logger.info("로그인실패");
			model.addAttribute("msg", "로그인 실패");
			model.addAttribute("url", "/member/login.do");
		}
		
		return "main/cocomain";
	}

	@RequestMapping(value="/member/logout.do"
			, method=RequestMethod.GET)
	public String logout(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/main/cocomain.do";
	}
}
	
	

