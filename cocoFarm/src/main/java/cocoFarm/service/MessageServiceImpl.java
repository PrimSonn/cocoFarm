package cocoFarm.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cocoFarm.dao.MessageDao;
import cocoFarm.dto.Message;
import cocoFarm.util.Paging;

@Service
public class MessageServiceImpl implements MessageService {

	@Autowired
	MessageDao messageDao;
	
	@Override
	public int getTotal(HashMap<String, Object> totalMap) {

		return messageDao.totalCount(totalMap);
	}
	
	@Override
	public List getReceiveMessage(HashMap<String, Object> pagingMap) {
		return messageDao.getReceiveMessage(pagingMap);
	}
	
	@Override
	public List getSendMessage(HashMap<String, Object> pagingMap) {
		return messageDao.getSendMessage(pagingMap);
	}
	
	@Override
	public Message getOneMessage(Message message) {
		return messageDao.getOneMessage(message);
	}
	
	@Override
	public void isRead(Message message) {
		messageDao.isRead(message);
	}
	
	@Override
	public String getReceiver(int receiverIdx) {
		
		return messageDao.getReceiver(receiverIdx);
	}
	
	@Override
	public String getSender(int senderIdx) {
		
		return messageDao.getSender(senderIdx);
	}
	
	@Override
	public List getIsdel(String names) {
		
		return messageDao.getIsdel(names);
	}
	
	@Override
	public void deleteMessageList(String names) {

		messageDao.deleteMessageList(names);
	}
	
	@Override
	public void deleteReceiveMessage(String names) {

		messageDao.deleteReceiveMessage(names);
	}
	
	@Override
	public void deleteSendMessageList(String names) {

		messageDao.deleteSendMessageList(names);
	}

	@Override
	public void writeMessage(Message msg) {
		messageDao.writeMessage(msg);
	}

	@Override
	public int getAlarmCount(int idx) {
		return messageDao.getAlarmCount(idx);
	}
}
