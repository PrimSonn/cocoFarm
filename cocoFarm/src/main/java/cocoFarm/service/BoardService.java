package cocoFarm.service;

import java.util.List;

import cocoFarm.dto.Board;
import cocoFarm.util.Paging;

public interface BoardService {

	public List getList();
	
	public int getTotal();
	
	public List getPagingList(Paging paging);
	
	public void write(Board board);
	
	public Board boardView(Board viewBoard);
	
	public void update(Board board);
	
	public void delete(Board board);
	
}
