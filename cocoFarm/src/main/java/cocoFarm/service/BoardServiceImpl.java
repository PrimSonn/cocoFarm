package cocoFarm.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import cocoFarm.dao.BoardDao;
import cocoFarm.dto.Board;
import cocoFarm.dto.BoardFile;
import cocoFarm.util.Paging;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired BoardDao boardDao;
	@Autowired ServletContext context;
	
	@Override
	public List getList() {
		return boardDao.selectAll();
	}

	@Override
	public int getTotal() {
		return boardDao.countAll();
	}

	@Override
	public List getPagingList(Paging paging) {
		return boardDao.selectPage(paging);
	}

	@Override
	public void write(Board board) {
		
		boardDao.write(board);
		
		MultipartFile file = board.getFileup();
		
		if (file != null && !file.isEmpty()) {
			
			// 파일 업로드
			String path = context.getRealPath("/resources/img/todays_farmer_upload");
			String filename = file.getOriginalFilename()+"_"+UUID.randomUUID().toString().split("-")[0];
			File dest = new File(path, filename);
			try {
				file.transferTo(dest);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			// DB 기록
			BoardFile boardFile = new BoardFile();
			boardFile.setAcc_idx(board.getAcc_idx());
			boardFile.setOriginal_filename(file.getOriginalFilename());
			boardFile.setStored_filename(filename);  
			
			boardDao.insertFile(boardFile);
			
		}
	}

	@Override
	public Board boardView(Board viewBoard) {		
		boardDao.updateHit(viewBoard);
		
		return boardDao.selectBoardByAcc_idx(viewBoard);
	}

	@Override
	public void update(Board board) {
		boardDao.update(board);
	}

	@Override
	public void delete(Board board) {
		boardDao.delete(board);		
	}

	@Override
	public BoardFile getFileup(Board viewBoard) {
		return boardDao.getFile(viewBoard);
	}
	
	@Override
	public List<Board> getboardMainList(){
		
		
		return boardDao.getboardMainList();
	}
	
	@Override
	public List getboardList(){
		
		return boardDao.boardSelectAll();
	}
	
	
}
