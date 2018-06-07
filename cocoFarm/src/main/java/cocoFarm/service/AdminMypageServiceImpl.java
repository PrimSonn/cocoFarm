package cocoFarm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cocoFarm.dao.AdminMypageDao;
import cocoFarm.dto.Account;

@Service
public class AdminMypageServiceImpl implements AdminMypageService {

	@Autowired
	AdminMypageDao adminMypageDao;
	
	@Override
	public List wholeAcc(Account account) {
		return adminMypageDao.wholeAcc(account);
	}
	
	
	
}
