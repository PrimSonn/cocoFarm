package cocoFarm.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import cocoFarm.dao.TestBidDao;
import cocoFarm.service.ReceiptService;
import cocoFarm.service.RestSvc;
import cocoFarm.util.runners.RunnerManager;

@Controller
public class TestController {

	@Autowired TestBidDao bidDao;
	@Autowired ReceiptService recptSvc;
	@Autowired RestSvc restSvc;
	
	/*
	 * 개발자용 임시 뒷구멍.
	 * 나중에 막아놓기.
	 */
	@RequestMapping(value="getIn",method=RequestMethod.GET)
	public ModelAndView getIn(ModelAndView mav, HttpSession session, String key) {
		
		if(key!=null) {
			if(key.equals("cocoSystem$1234")) {
				session.setAttribute("idx", Integer.valueOf(0));
				session.setAttribute("type", Integer.valueOf(0));
				session.setAttribute("name", "시스템");
				System.out.println("시스템 로그인!");
			}
		}
		mav.setViewName("main/cocomain");
		return mav;
	}
	
	/*
	 * 쓰레드 등의 상태 확인용 뒷구멍
	 */
	@RequestMapping(value="getThreadStatus",method=RequestMethod.GET)
	public ModelAndView getTreadStatus(ModelAndView mav, HttpSession session) {
		
		if(session.getAttribute("idx")==null) {
			mav.setViewName("main/cocomain");
		}else if((Integer)session.getAttribute("type")==0 && (Integer)session.getAttribute("idx")==0) {
			mav.addAllObjects(RunnerManager.getStatus());
			mav.setViewName("util/threadStatus");
		}else {
			mav.setViewName("main/cocomain");
		}
		return mav;
	}
	
	/*
	 * 타이머 쓰레드들 재시작.
	 * 주의: 막 실행하면 쓰레드 에러가 날 수 있습니다.
	 * */
	@RequestMapping(value="startThread",method=RequestMethod.GET)
	public ModelAndView startThread(ModelAndView mav, HttpSession session) {
		
		if((Integer)session.getAttribute("type")==0 && (Integer)session.getAttribute("idx")==0) {
			RunnerManager.restart();
			mav.addAllObjects(RunnerManager.getStatus());
			mav.setViewName("util/threadStatus");
		}else {
			mav.setViewName("main/cocomain");
		}
		
		return mav;
	}
	
	/*
	 *  타이머들을 다 죽입니다(멈추고 나면 다시 쓸 수 없습니다.)
	 *  주의: 막 실행하면 쓰레드 에러가 날 수 있습니다.
	 * */
	@RequestMapping(value="killThread",method=RequestMethod.GET)
	public ModelAndView killThread(ModelAndView mav, HttpSession session) {
		
		if((Integer)session.getAttribute("type")==0 && (Integer)session.getAttribute("idx")==0) {
			RunnerManager.finish();
			mav.addAllObjects(RunnerManager.getStatus());
			mav.setViewName("util/threadStatus");
		}else {
			mav.setViewName("main/cocomain");
		}
		
		return mav;
	}
}
