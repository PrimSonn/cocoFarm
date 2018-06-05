package cocoFarm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cocoFarm.dao.BoardDao;
import cocoFarm.dto.Board;
import cocoFarm.util.Paging;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired BoardDao boardDao;
	
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
	
}
