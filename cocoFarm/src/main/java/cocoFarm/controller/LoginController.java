package cocoFarm.controller;

import java.io.File;
import java.io.IOException;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import cocoFarm.dto.Account;
import cocoFarm.service.LoginService;

@Controller
public class LoginController {
//	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired LoginService loginService;
	@Autowired ServletContext context;

	@RequestMapping(value="/login/logout.do", method=RequestMethod.GET)
	public String logout(HttpSession session){
		session.invalidate();
		
		return "redirect:/main/cocomain.do";
	}
	
	@RequestMapping(value="/login/login.do", method=RequestMethod.GET)
	public void login(HttpSession session, Account account, Model model){
	}
	
	@RequestMapping(value="/login/login.do", method=RequestMethod.POST)
	public String loginProc(HttpSession session, Account account, Model model){
		System.out.println(account);
		
		if(loginService.login(account, session)) {
			return "redirect:/main/cocomain.do";
		} else {
			model.addAttribute("msg", "로그인 실패");
			model.addAttribute("url", "/login/login.do");
//			return "redirect:/login/login.do";
			return "util/alert";
		}
	}
	
	@RequestMapping(value="/login/findIdPw.do", method=RequestMethod.GET)
	public void findIdPw(){}
	
	@RequestMapping(value="/login/findId.do", method=RequestMethod.POST)
	public void findId(Account account, Writer writer){
		try {
			writer.write("{\"result\":\""+ loginService.findId(account) +"\"}");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/login/findPw.do", method=RequestMethod.POST)
	public void findPw(Account account, Writer writer){
		try {
			writer.write("{\"result\":\""+ loginService.findPw(account) +"\"}");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/login/join.do", method=RequestMethod.GET)
	public void join(){}
	
	@RequestMapping(value="/login/join.do", method=RequestMethod.POST)
	public String joinProc(Account account){

		loginService.join(account);
		
		return "redirect:/main/cocomain.do"; 
	}
	
	@RequestMapping(value="/login/idCheck.do", method=RequestMethod.POST)
	public void idCheck(Account account, Writer writer){
		try {
			writer.write("{\"result\":"+ loginService.isDuplicate(account) +"}");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/mypage/user/updateAccount.do", method=RequestMethod.GET)
	public void updateAccount(HttpSession session, Model model){
		int idx = (int)session.getAttribute("idx");
//		System.out.println(idx);
		Account account = loginService.selectAll(idx);
		
		model.addAttribute("account", account);
	}
	
	@RequestMapping(value="/mypage/user/updateAccount.do", method=RequestMethod.POST)
	public String updateAccountProc(HttpSession session, Account account){
		int idx = (int)session.getAttribute("idx");

		account.setIdx(idx);
		
		loginService.updateAccount(account);
		
		return "redirect:/mypageIntro.do";
	}
	
	@RequestMapping(value="/mypage/user/updateProfile.do", method=RequestMethod.POST)
	public String updateProfile(HttpSession session, MultipartFile profile){
		
		
		String path = context.getRealPath("/resources/img/profile");
		
		UUID uid = UUID.randomUUID();
		String filename = profile.getOriginalFilename()+"_"+uid.toString().substring(0, 8); 
				
		File file = new File(path, filename);
		
		try {
			profile.transferTo(file);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		Account account = new Account();

		int idx = (int)session.getAttribute("idx");
		account.setIdx(idx);

		account.setThumb_loc(filename);

		loginService.updateProfile(account);
		
		return "redirect:/mypageIntro.do";
	}
	
	@RequestMapping(value="/mypage/deleteAcc.do", method=RequestMethod.GET)
	public void deleteAcc() { }
	
	@RequestMapping(value="/mypage/deleteAccProc.do", method=RequestMethod.POST)
	public @ResponseBody Map<Object,Object> deleteAccProc(Account account, HttpSession session) {
		
		int count;
		boolean check;
		count = loginService.checkPw(account);
		Map<Object,Object> map = new HashMap<Object, Object>();
		
		if( count == 1 ) {
			loginService.deleteAcc(account);
			session.invalidate();
			check = true;
			map.put("check", check);
		} else {
			check=false;
			map.put("check", check);
		}
		
		return map;
	}
	
	@RequestMapping(value="/mypage/deleteAccNewWindow.do", method=RequestMethod.GET)
	public void deleteAccNewWindow() {	}
}
