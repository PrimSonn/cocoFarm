package cocoFarm.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import cocoFarm.dao.TestBidDao;
import cocoFarm.dto.TestBidDto;
import cocoFarm.service.ReceiptService;
import cocoFarm.service.RestSvc;

@SuppressWarnings("unused")
@Controller
public class TestController {

	@Autowired TestBidDao bidDao;
	@Autowired ReceiptService recptSvc;
	@Autowired RestSvc restSvc;
	
	@RequestMapping(value="recptSvc",method=RequestMethod.GET)
	public ModelAndView recptSvc(ModelAndView mv) {
		
		recptSvc.test();
		mv.setViewName("main/cocomain");
		return mv;
	}
	
	@RequestMapping(value="getIn",method=RequestMethod.POST)
	public ModelAndView getInPost(ModelAndView mav,HttpSession session) {
		return getIn(mav,session);
	}
	
	@RequestMapping(value="getIn",method=RequestMethod.GET)
	public ModelAndView getIn(ModelAndView mav,HttpSession session) {
		
		session.setAttribute("idx", Integer.valueOf(0));
		session.setAttribute("type", Integer.valueOf(1));
		mav.setViewName("main/cocomain");
		return mav;
	}
	
	@RequestMapping(value="restTest",method=RequestMethod.GET)
	public ModelAndView restTest(ModelAndView mav) {
		
		
		System.out.println("-------------------------------\r\nrestSvc result: "+restSvc.checkPayment("imp_862596445680", 0)+"\r\n");
		mav.setViewName("main/cocomain");
		return mav;
	}
	
//	@RequestMapping(value="main",method=RequestMethod.GET)
//	public ModelAndView mainGet(ModelAndView mv) {
//		
//		mv.setViewName("Main/cocomain");
//		return mv;
//	}
//
//	@RequestMapping(value="signIn",method=RequestMethod.POST)
//	public ModelAndView testSignIn(ModelAndView mv, HttpSession session, HttpServletRequest request) {
//		
//		String idx = request.getParameter("idx");
//		String type = request.getParameter("type");
//		System.out.println("idx: "+idx+" , type: "+type);
//		if(idx !=null && type !=null && !idx.equals("") & !type.matches("") ) {
//			try {
//				session.setAttribute("idx", Integer.parseInt(idx));
//				session.setAttribute("type", Integer.parseInt(type));
//			} catch (NumberFormatException e) {
//				session.invalidate();
//			}
//		}
//		
////		for(Object key : request.getParameterMap().keySet()) {
////			System.out.println("[key: "+key+", value: "+request.getParameter((String) key)+"]");
////			for(String val : (String[])request.getParameterMap().get(key)) {
////				System.out.println(val);
////			}
////		}
//		
//		mv.setViewName("redirect:auction/bidder");
////		mv.setViewName("redirect:/");
//		return mv;
//	}
//
//	@RequestMapping(value="auction/bidder",method=RequestMethod.GET)
//	public ModelAndView bidderGet(ModelAndView mv) {
//
//		mv.setViewName("testBid/bidder");
//		return mv;
//	}
//
//	@RequestMapping(value="auction/bidder",method=RequestMethod.POST)
//	public ModelAndView bidder(ModelAndView mv, TestBidDto bid, HttpSession session) {
//
//		bid.setBidder_idx((Integer)session.getAttribute("idx"));
//		bid.setIsDone(Integer.valueOf(-5));
//		System.out.println(bid);
//		
//		bidDao.putBid(bid);
//		System.out.println(bid);
//		
//		mv.setViewName("redirect:/");
//		return mv;
//	}
//	
//	@RequestMapping(value="auction/bid",method=RequestMethod.GET)
//	public ModelAndView testBid(ModelAndView mv) {
//		
//		
//		
//		mv.setViewName("testBid/BidList");
//		return mv;
//	}
//
//	@RequestMapping(value="/",method=RequestMethod.GET)
//	public ModelAndView helloWorld(ModelAndView mv) {
//		
//		mv.setViewName("helloWorld");
//		return mv;
//	}
//	
//	
//	@RequestMapping (value="test1",method=RequestMethod.POST)
//	public ModelAndView test1(ModelAndView mv, TestDto tester) {
//		
//		if(tester==null) {
//			System.out.println(tester==null);
//		}else {
//			System.out.println(tester.getAttr());
//		}
//		
//		mv.setViewName("helloWorld");
//		return mv;
//	}
//	
//	@RequestMapping (value="test2",method=RequestMethod.POST)
//	public ModelAndView test2(ModelAndView mv, List<TestDto> testerList) {
//		
//		if(testerList==null) {
//			System.out.println(testerList==null);
//		}else {
//			for(TestDto tester: testerList) {
//				System.out.println(tester.getAttr());
//			}
//		}
//		
//		mv.setViewName("helloWorld");
//		return mv;
//	}
//	
//	@RequestMapping(value="test3",method=RequestMethod.POST)
//	public ModelAndView test3(ModelAndView mv, HttpServletRequest request) {
//		
//		String attr[] = request.getParameterValues("attr");
//		
//		if (attr !=null) {
//			
//			System.out.println("attr: "+attr);
//			
//			TestDto[] dtoList = new TestDto[attr.length];
//			System.out.println("attr length: "+ attr.length);
//			
//			for(int i=0; i<attr.length; i++) {
//				dtoList[i] = new TestDto();
//				dtoList[i].setAttr(attr[i]);
//			}
//			System.out.println("===========================");
//			
//			int i=0;
//			for(TestDto oneDto:dtoList) {
//				i++;
//				System.out.println(i+"th dto attr: "+oneDto.getAttr());
//			}
//			
//		}else {
//			System.out.println("attr[] is null!");
//		}
//		
//		mv.setViewName("helloWorld");
//		return mv;
//	}
//	
//	@RequestMapping (value="test4",method=RequestMethod.POST)
//	public ModelAndView test4(ModelAndView mv, TestDto[] testerArr) {
//		
//		if(testerArr==null) {
//			System.out.println(testerArr==null);
//		}else {
//			System.out.println(testerArr.length);
//			int i=0;
//			for(TestDto dto: testerArr) {
//				
//				System.out.println(++i + "th dto attr: "+ dto.getAttr());
//			}
//		}
//		
//		mv.setViewName("helloWorld");
//		return mv;
//	}
//	
//	@RequestMapping	(value="test1",method=RequestMethod.GET)
//	public ModelAndView testGet1(ModelAndView mv) {
//		mv.setViewName("redirect:/");
//		return mv;
//	}
//	@RequestMapping	(value="test2",method=RequestMethod.GET)
//	public ModelAndView testGet2(ModelAndView mv) {
//		mv.setViewName("redirect:/");
//		return mv;
//	}@RequestMapping(value="test3",method=RequestMethod.GET)
//	public ModelAndView testGet3(ModelAndView mv, HttpServletRequest request) {
//		mv.setViewName("redirect:/");
//		return mv;
//	}@RequestMapping(value="test4",method=RequestMethod.GET)
//	public ModelAndView testGet4(ModelAndView mv, HttpServletRequest request) {
//		mv.setViewName("redirect:/");
//		return mv;
//	}
}
