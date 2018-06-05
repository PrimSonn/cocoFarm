package cocoFarm.dao;

import cocoFarm.dto.Account;

public interface TestMemberDao {
	/**
	 * 회원가입
	 * @param writer
	 */
	public void join(Account member);
	
	/**
	 * userid로 조회하기
	 * @return
	 */
	public int selectByUserid(Account member);
	
	/**
	 * 로그인
	 * @param writer
	 * @return
	 */
	public int login(Account member);
	
	/**
	 * 님네임 가져오기
	 * @param writer
	 * @return
	 */
	public String getUsernick(Account member);
}












