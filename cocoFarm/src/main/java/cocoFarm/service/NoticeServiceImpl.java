package cocoFarm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cocoFarm.dao.NoticeDao;
import cocoFarm.dto.Notice;
import cocoFarm.util.Paging;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired NoticeDao noticeDao;

	@Override
	public List getList() {
		return noticeDao.selectAll();
	}

	@Override
	public int getTotal() {
		return noticeDao.countAll();
	}

	@Override
	public List getPagingList(Paging paging) {
		return noticeDao.selectPage(paging);
	}

	@Override
	public void write(Notice notice) {
		noticeDao.write(notice);
	}

	@Override
	public Notice noticeView(Notice viewNotice) {
		
//		noticeDao.updateHit(viewNotice);
		
		return noticeDao.selectNoticeByIdx(viewNotice);
	}

	@Override
	public void update(Notice Notice) {
		noticeDao.update(Notice);
	}

	@Override
	public void delete(Notice notice) {
		noticeDao.delete(notice);		
	}	
	
	

}
