package cocoFarm.dao;

import java.util.List;

import cocoFarm.dto.Account;
import cocoFarm.dto.Message;

public interface LoginDao {
	public void join(Account account);

	public int loginCheck(Account account);

	public Account login(Account account);

	public int selectId(Account account);
	
	public String findId(Account account);
	
	public String findPw(Account account);
	
	public Account selectAll(int idx);

	public void updateAccount(Account account);
	
	public void updateProfile(Account account);
	
	public int checkPw(Account account);
	
	public void deleteAcc(Account account);
}
