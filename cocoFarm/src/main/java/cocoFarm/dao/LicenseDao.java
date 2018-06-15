package cocoFarm.dao;

import cocoFarm.dto.LicenseDto;

public interface LicenseDao {

//	라이센스 등록
	public void insertLicense(LicenseDto license);
	
//	라이센스 삭제
	public void deleteLicense(LicenseDto license);
	
//	 라이센스 삭제 시 회원 타입 판매자->일반 으로 변경
	public void updateAccType(LicenseDto license);
	
//	라이센스 삭제 시 회원 판매글 isdel -> 1로 변경(판매글 삭제 시키는 쿼리)
	public void updateSaleIsdel(LicenseDto license);

}
