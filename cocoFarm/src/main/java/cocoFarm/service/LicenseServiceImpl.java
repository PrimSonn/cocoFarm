package cocoFarm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cocoFarm.dao.LicenseDao;
import cocoFarm.dto.LicenseDto;

@Service
public class LicenseServiceImpl implements LicenseService {

	@Autowired
	LicenseDao licenseDao;
	
	@Override
	public void license(LicenseDto license) {
		
		licenseDao.insertLicense(license);
	}
	
	@Override
	public void deleteLicense(LicenseDto license) {
		
		licenseDao.deleteLicense(license);
		
	}
	
	@Override
	public void updateAccType(LicenseDto license) {
		licenseDao.updateAccType(license);
	}
	
	@Override
	public void updateSaleIsdel(LicenseDto license) {
		licenseDao.updateSaleIsdel(license);
	}
}
