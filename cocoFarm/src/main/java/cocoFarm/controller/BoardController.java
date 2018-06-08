package cocoFarm.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import cocoFarm.dto.Board;
import cocoFarm.dto.BoardFile;
import cocoFarm.service.BoardService;
import cocoFarm.util.Paging;

@Controller
public class BoardController {
	
	@Autowired BoardService boardService;
	
	@RequestMapping(value="/board/list.do", method=RequestMethod.GET)
	public String list(@RequestParam(defaultValue="0") int curPage, Paging search, Model model) {

		// 페이지 처리
		int totalCount = boardService.getTotal();			// 전체 게시글 수							
		Paging paging = new Paging(totalCount, curPage);
		model.addAttribute("paging", paging);
		
		// 페이징 처리된 게시글 목록	
		List list = boardService.getPagingList(paging);		// 전체 게시글 조회
		model.addAttribute("list", list);		
		
		return "board/list";
	}
	
	@RequestMapping(value="/board/write.do", method=RequestMethod.GET)
	public void write() {}
	
	@RequestMapping(value="/board/write.do", method=RequestMethod.POST)
	public String wirteProcess(Board board, HttpSession session) {
		
		System.out.println("board1:"+board);
		
		board.setAcc_idx((Integer) session.getAttribute("idx"));
					
		System.out.println("board:"+board);
		
		boardService.write(board);
		
		
			
		
		return "redirect:/board/list.do";	
	}
	
	@RequestMapping(value="/board/view.do", method=RequestMethod.GET)
	public String view(Board viewBoard, Model model) {
		
		// 게시글 번호가 1보다 작으면 목록으로 보내기
		if (viewBoard.getAcc_idx() < 1) {
			return "redirect:/board/list.do";
		}
		
		// 게시글 상세 정보 전달
		viewBoard = boardService.boardView(viewBoard);
		model.addAttribute("view", viewBoard);
		
		// 첨부 파일 정보
		BoardFile boardFile = boardService.getFileup(viewBoard);
		model.addAttribute("boardFile", boardFile);
		
		return "board/view";
	}
	
	@RequestMapping(value="/board/update.do", method=RequestMethod.GET)
	public String update(Board board, HttpSession session, Model model) {
		
		board = boardService.boardView(board);
		model.addAttribute("view", board);
		
		return "board/update";		
	}
	
	@RequestMapping(value="/board/update.do", method=RequestMethod.POST)
	public String updateProcess(Board board) {
		
		boardService.update(board);
		
		return "redirect:/board/view.do?acc_idx=" + board.getAcc_idx(); 
	}
	
	@RequestMapping(value="/board/delete.do", method=RequestMethod.GET)
	public String deleteProcess(Board board, Model model) {
		
		boardService.delete(board);
		model.addAttribute("msg", "농부 스토리 삭제 완료");
		model.addAttribute("url", "/board/list.do");
		
		return "util/alert";		
	}
	

}
