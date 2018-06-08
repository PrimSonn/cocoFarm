package cocoFarm.service;

import java.util.List;

import cocoFarm.dto.Notice;
import cocoFarm.util.Paging;

public interface NoticeService {
	
	public List getList();
	
	public int getTotal();

	public List getPagingList(Paging paging);
	
	public void write(Notice notice);
	
	public Notice noticeView(Notice viewNotice);
	
	public void update(Notice notice);
	
	public void delete(Notice notice);

	
}
