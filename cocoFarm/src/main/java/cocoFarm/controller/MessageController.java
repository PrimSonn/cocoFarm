package cocoFarm.controller;

import java.io.IOException;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import cocoFarm.dto.Account;
import cocoFarm.dto.Message;
import cocoFarm.service.LoginService;
import cocoFarm.service.MessageService;
import cocoFarm.util.Paging;

@Controller
public class MessageController {

	@Autowired
	MessageService messageService;
	@Autowired LoginService loginService;

	@RequestMapping(value="/mypage/message.do", method=RequestMethod.GET)
	public void message(@RequestParam(defaultValue="0") int curPage, Account account, HttpSession session, Model model){
		model.addAttribute("curPage", curPage);
		
		int idx = (Integer) session.getAttribute("idx");
		
	}
	   
	@RequestMapping(value="/mypage/readMessage.do", method=RequestMethod.POST)
	public void readMessage(@RequestParam(defaultValue="0") int curPage, int messageCate, HttpSession session, Model model){
	    
		//�α����� ȸ�� idx
		int idx = (Integer) session.getAttribute("idx");
	    
//		System.out.println(idx);
		
		// ����¡ ó�� - totalCount, curPage
		// totalCount - DB��ȸ
		// ȸ�� idx�� messageCate ��ȣ�� ������ ���ù� ī��Ʈ ��ȸ
		HashMap<String, Object> totalMap = new HashMap<String, Object>();
		totalMap.put("idx", idx);
		totalMap.put("messageCate", messageCate);
		int totoalCount = messageService.getTotal(totalMap);
//		System.out.println("��Ż����Ʈ"+totoalCount);
		
		// curPage - list.do���� ��û
		Paging paging = new Paging(totoalCount, curPage);
		paging.setMessageCate(messageCate);
		model.addAttribute("paging", paging);
//		System.out.println(paging);
		
		HashMap<String, Object> pagingMap = new HashMap<String, Object>();
		pagingMap.put("idx", idx);
		pagingMap.put("paging", paging);
		
		List<Message> messageList = null;
		if(messageCate == 1) { //����������  
		messageList = messageService.getReceiveMessage(pagingMap);
		} else { //����������
		messageList = messageService.getSendMessage(pagingMap);
		}
		
		
		model.addAttribute("messageList", messageList);
		model.addAttribute("messageCate", messageCate);
	}
	
	@RequestMapping(value="/mypage/writeMessage.do", method=RequestMethod.GET)
	public void writeMessage(int msgTo, HttpSession session, Model model){
		int idx = (int)session.getAttribute("idx");
		Account account = loginService.selectAll(idx);
		
		model.addAttribute("account", account);
		
		Account account2 = loginService.selectAll(msgTo);
		model.addAttribute("msg", account2);
	}
	
	@RequestMapping(value="/mypage/writeMessage.do", method=RequestMethod.POST)
	public String writeMessageProc(Message message, Model model){
		
		messageService.writeMessage(message);

		model.addAttribute("msg", "메시지 전송 완료");
		model.addAttribute("url", "close");
		
		return "util/alert";
	}
	
	@RequestMapping(value="/mypage/writeInquiry.do", method=RequestMethod.GET)
	public void inquiry(Model model, HttpSession session) {
		int idx = (Integer) session.getAttribute("idx");
		Account account = loginService.selectAll(idx);
		model.addAttribute("account", account);
	}
	
	@RequestMapping(value="/mypage/writeInquiry.do", method=RequestMethod.POST)
	public ModelAndView inquiryProc(Message message) {
		System.out.println(message);
		message.setReceiver_idx(1);
		messageService.writeMessage(message);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("msg", "전송완료");
		mav.addObject("url", "/mypage/message.do");	//보낸쪽지함으로 보내야함,, 쪽지함선택된상태로!!
		mav.setViewName("util/alert");
		return mav;
	}
	
	@RequestMapping(value="/mypage/messageView.do", method=RequestMethod.POST)
	public void messageView(int messageCate, Message message, Model model) {
		
		
		message = messageService.getOneMessage(message);
		messageService.isRead(message);
		System.out.println(messageCate);
		
		System.out.println(message.toString());
		
		if( messageCate == 1 ) {
			int senderIdx = message.getSender_idx();
//			System.out.println(senderIdx);
//			System.out.println(messageService.getSender(senderIdx));
			model.addAttribute("sender", messageService.getSender(senderIdx));
		}else {
			int receiverIdx = message.getReceiver_idx();
//			System.out.println(receiverIdx);
//			System.out.println(messageService.getReceiver(receiverIdx));
			model.addAttribute("receiver", messageService.getReceiver(receiverIdx));
		}
		
		model.addAttribute("messageCate", messageCate);
		model.addAttribute("message", message);
	
	}
	
	@RequestMapping(value="/mypage/delMessageList.do", method=RequestMethod.POST)
	public String deleteMessageList(String names, int messageCate) {
		
		System.out.println("names = " + names);
		System.out.println("messageCate = " + messageCate);
		
		List isdel = messageService.getIsdel(names);
		System.out.println("isdel = " + isdel);
		
		if( !"".equals(names) && names != null) {
			
			for ( int i=0; i<isdel.size(); i++) {
				int isdelVal = (Integer) isdel.get(i);
//				System.out.println(isdelVal);
				if( messageCate == 1 &&  isdelVal == 3) {
					System.out.println("1 = " + isdelVal);
					messageService.deleteMessageList(names);
					
				} else if( messageCate == 2 && isdelVal == 2 ) {
					System.out.println("2 = " + isdelVal);
					messageService.deleteMessageList(names);
					
				} else if( messageCate == 1 && isdelVal == 0 ) {
					System.out.println("3 = " + isdelVal);
					messageService.deleteReceiveMessage(names);
					
				} else if( messageCate == 2 && isdelVal == 0 ) {
					System.out.println("4 = " + isdelVal);
					messageService.deleteSendMessageList(names);
					
				}
				
			}
		}
		
		return "redirect:/mypage/message.do";
	}
	@RequestMapping(value="/mypage/user/mes_arl.do", method=RequestMethod.POST)
	public void mes_arl(Writer writer, HttpSession session) {
		int idx = (int)session.getAttribute("idx");
		
		int alarmCnt = messageService.getAlarmCount(idx);
		
		try {
			writer.append("{\"alarmCnt\":" + alarmCnt + "}");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
