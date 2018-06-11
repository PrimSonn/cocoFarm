package cocoFarm.service;

import java.util.List;

import cocoFarm.dto.LicenseDto;
import cocoFarm.dto.Main_receipt;
import cocoFarm.util.Paging;

public interface AdminMypageService {

//	페이징 전체 게시글 갯수 조회
	public int getTotalAcc();
	
//	페이징 전체 게시글 갯수 조회
	public int getTotalDelAcc();
	
//	전체회원조회
	public List wholeAcc(Paging paging);
	
//	탈퇴회원조회
	public List delWholeAcc(Paging paging);
	
//	판매자등록 신청 회원 전부 조회 
	public List licenseList();
	
//	판매자등록 신청한 리스트 뷰
	public LicenseDto licenseView(LicenseDto license);
	
//	관리자가 판매자등록 승인 버튼 누르면 회원 테이블 타입을 일반->판매자 로 업데이트 하는 메소드 
	public void licenseOk(int acc_idx);
	
//	관리자가 판매자등록 승인 버튼 누르면 회원에게 승인 완료 메세지를 보냄
	public void licenseOkMsg(int acc_idx);
	
//	관리자가 판매자등록 거절 버튼 누르면 회원에서 거절 메세지를 보냄
	public void licenseNoMsg(int acc_idx);
	
//	전체 결제 내역(주 영수증) 조회
	public List selectPayAll();
	
}
