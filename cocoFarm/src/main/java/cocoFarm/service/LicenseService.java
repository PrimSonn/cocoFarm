package cocoFarm.service;

import cocoFarm.dto.LicenseDto;

public interface LicenseService {
	public void license(LicenseDto license);

	public void deleteLicense(LicenseDto license);
	
}
