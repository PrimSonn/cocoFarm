package cocoFarm.dao;

import java.util.List;

import cocoFarm.dto.Account;

public interface AccountDao {
	public void signUp(Account account);
	public Account signIn(Account account);
	public List<Account> accountList();
	public void delAccount(String idx);
}