package cocoFarm.dto;

import java.util.Date;

public class BoardFile {
	
	private Integer acc_idx;
	private String original_filename;
	private String stored_filename;
	private Date upload_date;

	public Integer getAcc_idx() {
		return acc_idx;
	}

	public void setAcc_idx(Integer acc_idx) {
		this.acc_idx = acc_idx;
	}

	public String getOriginal_filename() {
		return original_filename;
	}

	public void setOriginal_filename(String original_filename) {
		this.original_filename = original_filename;
	}

	public String getStored_filename() {
		return stored_filename;
	}

	public void setStored_filename(String stored_filename) {
		this.stored_filename = stored_filename;
	}

	public Date getUpload_date() {
		return upload_date;
	}

	public void setUpload_date(Date upload_date) {
		this.upload_date = upload_date;
	}

	@Override
	public String toString() {
		
		return "UploadFile [acc_idx="	+ acc_idx
				+ ", ORIGINAL_FILENAME" + original_filename
				+ ", STORED_FILENAME"	+ stored_filename
				+ ", UPLOAD_DATE"		+ upload_date + "]";
		
	}	

}
