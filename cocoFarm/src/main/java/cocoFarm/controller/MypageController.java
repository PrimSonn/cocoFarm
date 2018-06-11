package cocoFarm.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cocoFarm.dto.Option;

@Controller
public class MypageController {
	
	@RequestMapping(value="/mypage/mypage.do", method=RequestMethod.GET)
	public void mypage(){}
	
	/*2018년 6월 10일 추가 마이페이지 인트로 */
	@RequestMapping(value="/mypageIntro.do", method=RequestMethod.GET)
	public String mypageIntro(Option option
							, HttpSession session
							, Model model) {
		System.out.println(session.getAttribute("type"));
		
		/*
		if((Integer)session.getAttribute("type")==1) {
		
		}else {
		
		*/
		if(session.getAttribute("type")=="1"){
			return "Mypage/user/userIntro1";
		}else if(session.getAttribute("type")=="2") {
			return "Mypage/user/userIntro2";
		}else {
			return "Mypage/user/userIntro";
		}
		
	}
	
	
}
