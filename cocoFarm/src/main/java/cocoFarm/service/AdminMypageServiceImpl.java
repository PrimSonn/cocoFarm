package cocoFarm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cocoFarm.dao.AdminMypageDao;
import cocoFarm.dto.Account;
import cocoFarm.dto.LicenseDto;

@Service
public class AdminMypageServiceImpl implements AdminMypageService {

	@Autowired
	AdminMypageDao adminMypageDao;
	
	@Override
	public List wholeAcc(Account account) {
		return adminMypageDao.wholeAcc(account);
	}
	
	@Override
	public List delWholeAcc(Account account) {
		return adminMypageDao.delWholeAcc(account);
	}
	
	@Override
	public List licenseList() {
		return adminMypageDao.licenseList();
	}
	
	@Override
	public LicenseDto licenseView(LicenseDto license) {
		return adminMypageDao.licenseView(license);
	}
	
	@Override
	public void licenseOk(int acc_idx) {
		adminMypageDao.licenseOk(acc_idx);
	}
	
	@Override
	public void licenseOkMsg(int acc_idx) {
		adminMypageDao.licenseOkMsg(acc_idx);
	}
	
	@Override
	public void licenseNoMsg(int acc_idx) {
		adminMypageDao.licenseNoMsg(acc_idx);
	}
	
}
