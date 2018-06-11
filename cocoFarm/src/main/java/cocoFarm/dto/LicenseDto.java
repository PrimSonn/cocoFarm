package cocoFarm.dto;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

public class LicenseDto {

	private int idx;							// 사업자등록 DB의 idx 번호
	private int acc_idx;						// 회원 idx(등록증을 신청한 회원)
	private long business_license_code;			// 사업자등록번호
	private String business_reg_date;			// 개업연월일
	private String corporation_name;			// 법인명(단체명)
	private String representative;				// 대표자
	private String business_addr;				// 사업장소재지 : 주소
	private String business_detailed_addr;		// 사업장소재지 : 상세주소
	private String headhquarter_addr;			// 본점소재지 : 주소
	private String headhquarter_detailed_addr;	// 본점소재지 : 상세주소
	private String business_category;			// 사업의종류 : 업태
	private String business_type;				// 사업의종류 : 종류
	private MultipartFile license_img;			// 사업자등록증 이미지
	private String license_storedName;			// 사업자등록증 이미지 이름(db에 들어가는 uuid 붙은 이름)
	private Timestamp info_reg_date;			// 홈페이지에 등록한 일자
	private String name;						// DB에서 조회해온 회원의 이름
	
	




	public String getBusiness_reg_date() {
		return business_reg_date;
	}

	public void setBusiness_reg_date(String business_geg_date) {
		this.business_reg_date = business_geg_date;
	}

	public int getAcc_idx() {
		return acc_idx;
	}

	public void setAcc_idx(int acc_idx) {
		this.acc_idx = acc_idx;
	}

	public String getLicense_storedName() {
		return license_storedName;
	}

	public void setLicense_storedName(String license_storedName) {
		this.license_storedName = license_storedName;
	}

	public MultipartFile getLicense_img() {
		return license_img;
	}

	public void setLicense_img(MultipartFile license_img) {
		this.license_img = license_img;
	}

	public long getBusiness_license_code() {
		return business_license_code;
	}

	public void setBusiness_license_code(long business_license_code) {
		this.business_license_code = business_license_code;
	}

	public String getCorporation_name() {
		return corporation_name;
	}

	public void setCorporation_name(String corporation_name) {
		this.corporation_name = corporation_name;
	}

	public String getRepresentative() {
		return representative;
	}

	public void setRepresentative(String representative) {
		this.representative = representative;
	}

	public String getBusiness_addr() {
		return business_addr;
	}

	public void setBusiness_addr(String business_addr) {
		this.business_addr = business_addr;
	}

	public String getBusiness_detailed_addr() {
		return business_detailed_addr;
	}

	public void setBusiness_detailed_addr(String business_detailed_addr) {
		this.business_detailed_addr = business_detailed_addr;
	}

	public String getHeadhquarter_addr() {
		return headhquarter_addr;
	}

	public void setHeadhquarter_addr(String headhquarter_addr) {
		this.headhquarter_addr = headhquarter_addr;
	}

	public String getHeadhquarter_detailed_addr() {
		return headhquarter_detailed_addr;
	}

	public void setHeadhquarter_detailed_addr(String headhquarter_detailed_addr) {
		this.headhquarter_detailed_addr = headhquarter_detailed_addr;
	}

	public String getBusiness_category() {
		return business_category;
	}

	public void setBusiness_category(String business_category) {
		this.business_category = business_category;
	}

	public String getBusiness_type() {
		return business_type;
	}

	public void setBusiness_type(String business_type) {
		this.business_type = business_type;
	}

	public Timestamp getInfo_reg_date() {
		return info_reg_date;
	}
	
	public void setInfo_reg_date(Timestamp info_reg_date) {
		this.info_reg_date = info_reg_date;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "[License = acc_idx : " + acc_idx
				+ ", business_license_code : " + business_license_code
				+ ", business_reg_date : " + business_reg_date
				+ ", corporation_name : " + corporation_name
				+ ", representative : " + representative
				+ ", business_addr : " + business_addr
				+ ", business_detailed_addr : " + business_detailed_addr
				+ ", headquarter_addr : " + headhquarter_addr
				+ ", headquarter_detailed_addr : " + headhquarter_detailed_addr
				+ ", business_category : " + business_category
				+ ", business_type : " + business_type
				+ ", license_storedName : " + license_storedName
				+ ", info_reg_date : " + info_reg_date
				+ ", name : " + name
				+ " ]";
		
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}



	
}
