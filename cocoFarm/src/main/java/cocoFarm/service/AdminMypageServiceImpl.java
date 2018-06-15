package cocoFarm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cocoFarm.dao.AdminMypageDao;
import cocoFarm.dto.Account;
import cocoFarm.dto.LicenseDto;
import cocoFarm.util.Paging;

@Service
public class AdminMypageServiceImpl implements AdminMypageService {

	@Autowired
	AdminMypageDao adminMypageDao;
	
	@Override
	public int getTotalAcc() {
		return adminMypageDao.getAccAllCount();
	}
	
	@Override
	public int getTotalDelAcc() {
		return adminMypageDao.getAccDelCount();
	}
	
	@Override
	public List wholeAcc(Paging paging) {
		return adminMypageDao.wholeAcc(paging);
	}
	
	@Override
	public List delWholeAcc(Paging paging) {
		return adminMypageDao.delWholeAcc(paging);
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
	
	@Override
	public void licenseNo(int acc_idx) {
		adminMypageDao.licenseNo(acc_idx);
	}
	
	@Override
	public List adminPaynee() {
		return adminMypageDao.adminPaynee();
	}
	
}
