package cocoFarm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cocoFarm.dao.TestMemberDao;
import cocoFarm.dto.Account;

@Service
public class TestMemberServiceImpl implements TestMemberService {

	@Autowired TestMemberDao memberDao;
	
	@Override
	public boolean join(Account member) {
		if(memberDao.selectByUserid(member)>0)
			return false;
		
		memberDao.join(member);
		
		if(memberDao.selectByUserid(member)>0)
			return true;
		else return false;
	}

	@Override
	public boolean login(Account member) {
		int loginChk = memberDao.login(member);
		if(loginChk > 0)	return true;
		else return false;
	}

	@Override
	public String getUsernick(Account member) {
		return memberDao.getUsernick(member);
	}

	
}













