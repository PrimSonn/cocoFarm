package cocoFarm.dao;

import cocoFarm.dto.LicenseDto;

public interface LicenseDao {
	public void insertLicense(LicenseDto license);
	public void deleteLicense(LicenseDto license);

}
