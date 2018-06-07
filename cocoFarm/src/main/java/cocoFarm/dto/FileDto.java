package cocoFarm.dto;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class FileDto {
//	private String fileImg;
//	private String mainImg;
//	private MultipartFile upload1;
//	private MultipartFile upload2;
	
	private List<MultipartFile> upload;

	public List<MultipartFile> getUpload() {
		return upload;
	}

	public void setUpload(List<MultipartFile> upload) {
		this.upload = upload;
	}
}
