package cocoFarm.controller;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import cocoFarm.dto.OptReceiptMkr;
import cocoFarm.dto.Option;
import cocoFarm.dto.SaleOption;
import cocoFarm.service.ProductService;
import cocoFarm.service.ReceiptService;
import cocoFarm.service.RestSvc;
import cocoFarm.util.recptMaker.SaleOptSerializer;

@Controller
public class PayController {
	
	@Autowired ProductService productService;
	@Autowired ReceiptService receiptSvc;
	@Autowired RestSvc restSvc;
	
	@RequestMapping(value="/orderpay.do",method=RequestMethod.GET)
	public String payVieworder(SaleOption saleoption) {
		/*System.out.println(saleoption.getProAmount());*/
		
		
		return "payment/oderPay";
	}
	
	
	
	@RequestMapping(value="/orderpay.do",method=RequestMethod.POST)
	public String payorder(Option option,Model model) {

		
		/*06월 04일 추가*/
		try{
			List<SaleOption> saleList = option.getSaleOptions();
			
			//옵션 불러오는것 idx
			String query ="(";
			
			List<Integer> listA = new ArrayList();
			
			
			for(int i=0; i<saleList.size()-1; i++) {
				query += saleList.get(i).getIdx()+",";
				listA.add(saleList.get(i).getProAmount());
			}
			query +=saleList.get(saleList.size()-1).getIdx() +")";
			listA.add(saleList.get(saleList.size()-1).getProAmount());
			
			System.out.println(query);
			System.out.println(listA);
			
			
			model.addAttribute("opt",(productService.getPayOption(query)));
			System.out.println((productService.getPayOption(query)));
			model.addAttribute("amount",listA);
		
			//옵션 판매글 불러오는것 
			String salequery ="(";
			
			for(int i=0; i<productService.getPayOption(query).size()-1; i++) {
				salequery += productService.getPayOption(query).get(i).getSaleIdx()+",";
				
			}
			salequery += productService.getPayOption(query).get(productService.getPayOption(query).size()-1).getSaleIdx()+")";
			/*System.out.println(salequery);*/
			
			
			productService.getSale_Option(salequery);
			System.out.println(productService.getSale_Option(salequery));
			/*System.out.println(productService.getPayOption(query).get(0).getSaleIdx());
			*/
			
			model.addAttribute("pro",(productService.getSale_Option(salequery)));
			
		}catch(NullPointerException np) {
				System.out.println("리스트에 아무것도 없습니다.");
		}
		return "payment/oderPay";
	}
	
	/*
	@RequestMapping(value="/paycomple.do",method=RequestMethod.GET)
	public String paycomple(SaleOption saleoption) {
		System.out.println(saleoption.getProAmount());
		
		
		return "payment/oderPay";
	}
	*/
	@RequestMapping(value="/paycomple.do",method=RequestMethod.POST)
	@ResponseBody
	public String paycomplepots(HttpSession session,String optionlist, String memdeliver,String buyer_name,String memname,String text) {
//		model.addAttribute("memname", memname);
//		System.out.println(memname);
		
		System.out.println("확인 결제 확인"+text);
		Gson gson=new Gson();
		List list = gson.fromJson(optionlist, List.class);
//		System.out.println("---optionlist---");
		
		
		List<SaleOptSerializer> saleOptionList = new ArrayList<>();
		for(int i=0; i<list.size(); i++) {
			Map map = (Map) list.get(i);
			SaleOption so = new SaleOption();
			so.setIdx(((Double)map.get("idx")).intValue());
			so.setProAmount( ((Double)map.get("proAmount")).intValue());
			saleOptionList.add(so);
			
			
//			System.out.println( map.get("idx"));
//			System.out.println( map.get("proAmount"));
		}
		
//		for(SaleOptSerializer s : saleOptionList) {
//			System.out.println(s);
//		}
		
		
		/*==================================================================
		 * 
		 * result.getIsDone() = 결과가 1이면 성공 0이면 실패
		 * result.getMainRcpt() = 받아온 영수증 번호, 실패시 null
		 * 
		 =================================================================*/
		OptReceiptMkr result=null;
		
		if(session.getAttribute("idx")!=null) {
			result = receiptSvc.makeTempReceipt((Integer)session.getAttribute("idx"), null, saleOptionList);
		}else {
			//return to errpage
		}
		if(result!=null) {
			System.out.println("======== got Result =========");
			System.out.println("isDone: "+result.getIsDone());
			System.out.println("MainRcpt: "+result.getMainRcpt());
		}else {
			System.out.println("failed!!!!");
		}
		
		
		
		return "{\"MainRcpt\":\""+result.getMainRcpt()+"\",\"isDone\":\""+result.getIsDone()+"\"}";
		
		
//		try {
//			writer.write("{\"result\":"+ memname +"}");
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		
		
		/*Gson gson = new Gson();
		JsonObject jsonObject = new JsonObject();*/		
//		try {
//		
//			writer.write("{\"result\":"+ memname +"}");
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		List<SaleOption> payList = option.getSaleOptions();
//		System.out.println(payList.get(0).getIdx());
		//return "payment/oderPay";
	}
	
	
	/*============================================================================================================================
	 * 
	 * 결과값 설명
	 * 		-100 이하: 코드상의 오류 혹은 각종 예외상황
	 * 		-20: 결제상태가 "paid" 가 아님
	 * 	아래는 DB 접속 결과 코드 (위의 경우가 아닌 경우 결과값으로 반환해옴)
	 *    -결제 정보 확인 후 코드:
	 * 		2: 해당 영수증이 임시 대기 상태가 아니며 같은 결제번호로 요청이 들어옴 (누군가 의도적으로 중복값을 보냄. 환불 대상이 아님)
	 *		1: 성공
	 *		0: 에러
	 *  	-1: 해당 번호의 임시 영수증이 없음.
	 *		-2: 해당 영수증이 처리 불가능한 상태임 ('임시 대기' 상태가 아님.)
	 *		-3: 해당 번호의 영수증이 있고, 임시 영수증인데 요청 계정이 다름(뭔가 잘못됨, 환불해야 함!!)
	 *		-4: 임시 처리한 영수증의 금액과 결제 정보의 금액이 다름. (임시 영수증 삭제함, 환불해야됨!!)
	 *		-5: 임시 영수증에 저장된 옵션이 활성화 상태가 아님 (삭제되었거나, 그 외 비활성 상태, 역시 환불해야 함!!)
	 *		-6: 구매한 옵션 중 최소 하나의 옵션이 남은 재고가 부족함 ( 환불해야 함!!!)
	 *		-7: 뭔가 매우 잘못됨 (환불해야 함!!)
	 *	서비스 안에서 환불 시도까지 하고 있음. (환불 영수증을 추가로 작성하고, 상태값 변화하는 부분 아직 미완성)
	 *  결제 취소가 일어났을 때(사용자가 아임포트 결제를 하다가 취소했을 때) 임시 영수증을 삭제하기 위해 추가 로직이 필요.
	 *  
	 =============================================================================================================================*/
	@RequestMapping(value="/pay.do",method=RequestMethod.POST)
	@ResponseBody
	public String paycomple(String imp_uid, HttpSession session) {
		
//		System.out.println("merchant_uid : " +merchant_uid + ", imp_uid: "+imp_uid+ ", session.idx: " + session.getAttribute("idx"));
		String returnCode = null;
		if((Integer)session.getAttribute("idx")!=null) {
			returnCode =restSvc.checkPayment(imp_uid, (Integer)session.getAttribute("idx")).toString();
		}
		
		return "{\"returnCode\":\""+returnCode+"\"}";
	}
	
	
}
