package cocoFarm.main.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import cocoFarm.dao.AccountDao;
import cocoFarm.dto.Account;


@Controller
public class CocoMain {

	@Autowired AccountDao accDao;
	private static final Logger logger= LoggerFactory.getLogger(CocoMain.class);
	
	@RequestMapping(value="/Main",method=RequestMethod.GET)
	public ModelAndView cocoMain(ModelAndView m) {
		
		List<Account> list=accDao.accountList();
		m.addObject("accountList", accDao.accountList());
		m.setViewName("/Main/Page");
		return m;
	}
	
	@RequestMapping(value="/deleteAccount",method=RequestMethod.POST)
	public ModelAndView delAccount(ModelAndView m, HttpServletRequest request) {
		
		accDao.delAccount(request.getParameter("idx"));
		m.setViewName("redirect:Main");
		return m;
		
	}
	
}
