package cocoFarm.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import cocoFarm.dto.Notice;
import cocoFarm.service.NoticeService;
import cocoFarm.util.Paging;

@Controller
public class NoticeController {
	
	@Autowired NoticeService noticeService;
		
	@RequestMapping(value="/notice/list.do", method=RequestMethod.GET)
	public String list(@RequestParam(defaultValue="0") int curPage, Paging search, Model model) {
				// 페이징 처리 - totalCount, curPage
				// curPage - list.do에서 요청
				// totalCount - DB 조회				
				int totalCount = noticeService.getTotal();			// 전체 게시글 수							
				Paging paging = new Paging(totalCount, curPage);
				model.addAttribute("paging", paging);
				
				// 페이징 처리된 게시글 목록		
				List list = noticeService.getPagingList(paging);		// 전체 게시글 조회
				model.addAttribute("list", list);
				
				return "notice/list";
	}

	@RequestMapping(value="/notice/write.do", method=RequestMethod.GET)
	public void write(Notice notice, HttpSession session) {
	}

	@RequestMapping(value="/notice/write.do", method=RequestMethod.POST)
	public String writeProcess(Notice notice, HttpSession session) {

		if((Integer)session.getAttribute("type")<=1) {
			notice.setWriter_idx((Integer)session.getAttribute("type"));
			noticeService.write(notice);
		}
		
		return "redirect:/notice/list.do";
	}

	@RequestMapping(value="/notice/view.do", method=RequestMethod.GET)
	public String view(Notice viewNotice, Model model) {
		
		if (viewNotice ==null) {
			return "redirect:/notice/list.do";
		} else if(viewNotice.getIdx() ==null) {
			return "redirect:/notice/list.do";
		} else if (viewNotice.getIdx() < 1) {
			return "redirect:/notice/list.do";
		}
		
		viewNotice = noticeService.noticeView(viewNotice);
		model.addAttribute("view", viewNotice);
		
		return "notice/view";		
	}

	@RequestMapping(value="/notice/update.do", method=RequestMethod.GET)
	public String update(Notice notice, HttpSession session, Model model) {

		notice = noticeService.noticeView(notice);
		model.addAttribute("view", notice);		
		
		return "notice/update";		
	}
	
	@RequestMapping(value="/notice/update.do", method=RequestMethod.POST)
	public String updateProcess(Notice notice, HttpSession session) {
		
		if((Integer)session.getAttribute("type")<=1) noticeService.update(notice);		
		return "redirect:/notice/view.do?idx="+notice.getIdx();			
	}
	
	@RequestMapping(value="/notice/delete.do", method=RequestMethod.GET)
	public String deleteProcess(Notice notice, Model model, HttpSession session) {
		
		if((Integer)session.getAttribute("type")<=1) {
			noticeService.delete(notice);
			model.addAttribute("msg", "공지사항 삭제 완료");
		}
		model.addAttribute("url", "/notice/list.do");
		
		return "util/alert";		
	}
	
	
	
	
}
