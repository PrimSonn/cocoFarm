package cocoFarm.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import cocoFarm.dto.Account;
import cocoFarm.dto.Message;

public interface LoginService {
	public void join(Account account);
	
	public boolean login(Account account, HttpSession session);
	
	public boolean isDuplicate(Account account); 
	
	public String findId(Account account);
	
	public String findPw(Account account);
	
	public Account selectAll(int idx);

	public void updateAccount(Account account);
	
	public void updateProfile(Account account);
	
	public int checkPw(Account account);
	
	public void deleteAcc(Account account);

}
