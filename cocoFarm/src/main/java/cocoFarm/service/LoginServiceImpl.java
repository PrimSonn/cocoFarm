package cocoFarm.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cocoFarm.dao.LoginDao;
import cocoFarm.dto.Account;
import cocoFarm.dto.Message;

@Service
public class LoginServiceImpl implements LoginService {

	@Autowired LoginDao loginDao;
	
	@Override
	public void join(Account account) {
		loginDao.join(account);
	}

	@Override
	public boolean login(Account account, HttpSession session) {
		if( loginDao.loginCheck(account) > 0) {
			account = loginDao.login(account);
			session.setAttribute("idx", account.getIdx());
			session.setAttribute("type", account.getAccount_type());
			session.setAttribute("name", account.getName());
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean isDuplicate(Account account) {
		if(loginDao.selectId(account)>0) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public String findId(Account account) {
		return loginDao.findId(account);
	}

	@Override
	public String findPw(Account account) {
		return loginDao.findPw(account);
	}

	@Override
	public Account selectAll(int idx) {
		return loginDao.selectAll(idx);
	}

	@Override
	public void updateAccount(Account account) {
		loginDao.updateAccount(account);
	}

	@Override
	public void updateProfile(Account account) {
		loginDao.updateProfile(account);
	}
	
	@Override
	public void deleteAcc(Account account) {
		loginDao.deleteAcc(account);
		
	}
	
	@Override
	public int checkPw(Account account) {
		return loginDao.checkPw(account);
	}
}
