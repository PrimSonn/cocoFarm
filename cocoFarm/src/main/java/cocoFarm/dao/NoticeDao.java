package cocoFarm.dao;

import java.util.List;

import cocoFarm.dto.Notice;
import cocoFarm.util.Paging;

public interface NoticeDao {
	
	public List selectAll();

	public int countAll();

	public List selectPage(Paging paging);

	public void write(Notice notice);

	public void updateHit(Notice viewNotice);

	public Notice selectNoticeByIdx(Notice viewNotice);	

	public void update(Notice notice);

	public void delete(Notice notice);

	
	
	
}
