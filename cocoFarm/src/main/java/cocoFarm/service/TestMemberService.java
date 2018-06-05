package cocoFarm.service;

import cocoFarm.dto.Account;

public interface TestMemberService {

	
	/**
	 * 회원가입
	 * @param writer
	 */
	public boolean join(Account member);

	/**
	 * 로그인
	 * @param writer
	 * @return
	 */
	public boolean login(Account member);

	/**
	 * 닉네임 가져오기
	 * @param writer
	 * @return
	 */
	public String getUsernick(Account member);

}














