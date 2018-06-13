package cocoFarm.dao;

import java.util.List;

import cocoFarm.dto.Board;
import cocoFarm.dto.BoardFile;
import cocoFarm.util.Paging;

public interface BoardDao {
	
	public List selectAll();
	
	public int countAll();
	
	public List selectPage(Paging paging);
	
	public void write(Board board);
	
	public void updateHit(Board viewBoard);
	
	public Board selectBoardByAcc_idx(Board viewBoard);
	
	public void update(Board board);
	
	public void delete(Board board);

	public void insertFile(BoardFile boardFile);
	
	public BoardFile getFile(Board viewBoard);

	/*2018년 6월 12일 hwanmin 추가 */
	public List getboardMainList();
	
	public List boardSelectAll();

}
