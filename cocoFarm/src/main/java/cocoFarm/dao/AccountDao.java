package cocoFarm.dao;

import java.util.List;

import cocoFarm.dto.Account;

public interface AccountDao {// 예시로 등록해 둠, 지우고 진행할 것.
	public void signUp(Account account);
	public Account signIn(Account account);
	public List<Account> accountList();
	public void delAccount(String idx);
}