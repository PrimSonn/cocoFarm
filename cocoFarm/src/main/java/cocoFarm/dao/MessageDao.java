package cocoFarm.dao;

import java.util.HashMap;
import java.util.List;

import cocoFarm.dto.Message;
import cocoFarm.util.Paging;

public interface MessageDao {
	
	public int totalCount(HashMap<String, Object> totalMap);

	public List getReceiveMessage(HashMap<String, Object> pagingMap);
	
	public List getSendMessage(HashMap<String, Object> pagingMap);
	
	public Message getOneMessage(Message message);
	
	public void isRead(Message message);
	
	public String getReceiver(int receiverIdx);
	
	public String getSender(int senderIdx);
	
	public List getIsdel(String names);
	
	public void deleteMessageList(String names);
	
	public void deleteReceiveMessage(String names);
	
	public void deleteSendMessageList(String names);

	public void writeMessage(Message msg);

	public int getAlarmCount(int idx);
}
