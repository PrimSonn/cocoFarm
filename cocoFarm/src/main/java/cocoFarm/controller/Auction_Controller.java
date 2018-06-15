package cocoFarm.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import cocoFarm.dto.Account;
import cocoFarm.dto.Auction;
import cocoFarm.dto.Auction_Inquire;
import cocoFarm.dto.BidDto;
import cocoFarm.dto.RecptCallParamHolder;
import cocoFarm.dto.SaleOption;
import cocoFarm.service.Auction_Service;
import cocoFarm.service.ReceiptService;
import cocoFarm.service.RestSvc;
import cocoFarm.service.LoginService;
import cocoFarm.util.Auction_Paging;
import cocoFarm.util.recptMaker.SaleOptSerializer;

@Controller
public class Auction_Controller {
	
	private static final Logger logger = LoggerFactory.getLogger(Auction_Controller.class);
	
	@Autowired Auction_Service auctionService;
	@Autowired ReceiptService receiptSvc;
	@Autowired RestSvc restSvc;
	@Autowired LoginService loginService;
	
//	==================================경매등록=============================================
	/*임시로 로그인 세션 처리 idx=1*/
	@RequestMapping(value="/auction/auction_register.do", method=RequestMethod.GET)
	public void register() {}
		
	@RequestMapping(value="/auction/auction_register.do", method=RequestMethod.POST)
	public String registerProcess(Auction auction, HttpSession session) {
		/*로그인 세션에서 ID 받아와서 writter_idx에 넣기*/
//		session.setAttribute("idx", 1);
//		System.out.println(session.getAttribute("idx"));
//		auction.setWritter_idx(session.getAttribute("idx"));
//		auction.setWritter_idx(Integer.parseInt((String) session.getAttribute("idx")));
		auction.setWritter_idx((Integer) session.getAttribute("idx"));
		auctionService.write(auction);
		System.out.println(auction);
		
		
		return "redirect:/auction/auction_list.do";
	}
	
//	==================================판매자 경매 등록 리스트=============================================
	
	@RequestMapping(value="/auction/auction_auctionCheck.do", method=RequestMethod.GET)
	public void auctionCheck(Auction auction, HttpSession session, Model model) {
		auction.setWritter_idx((Integer) session.getAttribute("idx"));
		System.out.println(auctionService.getauctionList(auction));
		model.addAttribute("auctionList", auctionService.getauctionList(auction));
	}
	
	
	@RequestMapping(value="/auction/auction_cancel.do", method=RequestMethod.POST)
	public String auctionCancel(Auction auction, HttpSession session) {
		auction.setWritter_idx((Integer) session.getAttribute("idx"));
		
		auctionService.auctionCancel(auction);
		System.out.println(auction);
		
		return "redirect:/auction/auction_auctionCheck.do";
	}
	
//	==================================경매리스트=============================================
	@RequestMapping(value="/auction/auction_list.do"
			, method=RequestMethod.GET)
	public String list(
			@RequestParam(defaultValue="0") int curPage
			, Auction_Paging search
			, Model model) {
		
//		int totalCount = auctionService.getTotal();	//전체 게시글 수
		int totalCount = auctionService.getTotal(search);	//검색어 적용 게시글 수

		// 페이징 생성
		Auction_Paging paging = new Auction_Paging(totalCount, curPage);
//		paging.setSearch(search.getSearch()); // 검색어 추가
		model.addAttribute("paging", paging);

//		List list = auctionService.getPagingList(paging); // 전체 게시글 조회
		List list = auctionService.getSearchPagingList(paging); // 검색어 적용 게시글 조회

		model.addAttribute("list", list);
		
		return "auction/auction_list";
	}
	
//	==================================경매 상세보기==============================================
	@RequestMapping(value="/auction/auction_view.do", method=RequestMethod.GET)
	public String auctionView(Auction viewAuction, Auction_Inquire auctionInquire
			, Model model
			, HttpSession session) {
		// 게시글 번호가 1보다 작으면 목록으로 보내기
				if(viewAuction.getIdx() < 1) {
					return "redirect:/auction/auction_list.do";
				}
				
				// 경매 번호 받기
				viewAuction = auctionService.auctionView(viewAuction);
				
				// 계정 타입 검사
				
				
				// 경매 상세 정보 전달
				model.addAttribute("view", viewAuction);
				model.addAttribute("bidderList",auctionService.getBidderList(viewAuction));
				model.addAttribute("inquireList",auctionService.getInquireList(viewAuction));
				
				
//				System.out.println(viewAuction);
//				System.out.println(auctionInquire);
//				System.out.println(auctionService.getInquireList(viewAuction));
				return "auction/auction_view";
	}
	
//	=================================경매 문의===========================================
	@RequestMapping(value="/auction/auction_inquire.do", method=RequestMethod.POST)
	public String insertInquire(Auction_Inquire inquire) {
		
//		System.out.println(inquire);
		auctionService.insertInquire(inquire);
		return "redirect:/auction/auction_view.do?idx="+inquire.getAuction_idx();
	}
	
	@RequestMapping(value="/auction/auction_answer.do", method=RequestMethod.POST)
	public String insertAnswer(Auction_Inquire inquire) {
		
//		System.out.println(inquire);
		auctionService.updateAnswer(inquire);
		
		return "redirect:/auction/auction_view.do?idx="+inquire.getAuction_idx();
		
	}
	
//	==================================입찰==============================================
	

	
	@RequestMapping(value="/auction/auctionBid.do", method=RequestMethod.POST)
	public String auctionBid(Auction auction,Model model, BidDto bid, HttpSession session) {
		bid.setBidder_idx((Integer) session.getAttribute("idx"));
//		System.out.println(bid);
//		System.out.println(auction);
		auctionService.putBid(bid);
		
		if(bid.getIsDone()==-1) {
			model.addAttribute("msg", "최소 입찰가 보다 낮은 입찰을 하셨습니다.");			
			model.addAttribute("check",0);
		model.addAttribute("url", "/auction/bidPopup.do?highest_bid="+auction.getHighest_bid()
				+"&start_price="+auction.getStart_price() 
				+"&title="+auction.getTitle()
				+"&name="+auction.getName() 
				+"&idx="+bid.getAuction_idx());
			return "util/auctionAlert";
		}else if(bid.getIsDone()==1) {
		model.addAttribute("msg", "입찰성공");
		model.addAttribute("check",1);
		return "util/auctionAlert";
		}
		System.out.println(bid);
		
		return "util/auctionAlert";
	}
	
	@RequestMapping(value="/auction/bidPopup.do", method=RequestMethod.GET)
	public void bidPopup(Auction auction, Model model) { 
//		System.out.println(auction);
		model.addAttribute("bid", auction);
		}
	
	
	
//	==================================개인 입찰 목록 확인==============================================
	
	@RequestMapping(value="/auction/auction_bidCheck.do", method=RequestMethod.GET)
	public void bidCheck(HttpSession session, Account account, BidDto bid, Model model) {
		session.getAttribute("idx");
		account.setIdx((Integer)session.getAttribute("idx"));
//		System.out.println(account);
		model.addAttribute("memberBidList",auctionService.getMemberBid(account));
		
		//2018년 06월 15일 작업
		int idx = (int)session.getAttribute("idx");
		Account accountone = loginService.selectAll(idx);
		model.addAttribute("account",accountone);
	}
	
	
	
//	==================================개인 입찰 취소==============================================
	@RequestMapping(value="/auction/auction_bidCancel.do", method=RequestMethod.GET)
	public String bidCancel(BidDto bid, HttpSession session) {
		bid.setBidder_idx((Integer) session.getAttribute("idx"));
		
		auctionService.cancelBid(bid);
//		System.out.println(bid);
		return "redirect:/auction/auction_bidCheck.do";
	}
	
//	==================================경매 결재==============================================
	@RequestMapping(value="/auction/auction_pay.do",method=RequestMethod.POST)
	@ResponseBody
	public String paycomplepots(HttpSession session, String auctionData, BidDto bid) {
		
		Gson gson=new Gson();
		List list = gson.fromJson(auctionData, List.class);
		System.out.println(bid);
		
		RecptCallParamHolder result=null;
		if(session.getAttribute("idx")!=null) {
			result = receiptSvc.makeTempReceipt((Integer)session.getAttribute("idx"), null, bid);
		}else {
			//return to errpage
		}
		if(result!=null) {
			System.out.println("======== got Result =========");
			System.out.println("isDone: "+result.getIsDone());
			System.out.println("MainRcpt: "+result.getArg3());
		}else {
			System.out.println("failed!!!!");
		}
		
		return "{\"MainRcpt\":\""+result.getArg3()+"\",\"isDone\":\""+result.getIsDone()+"\"}";
//		
//	}
	}
	
}
