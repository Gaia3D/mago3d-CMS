package gaia3d.domain.common;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

import org.springframework.format.annotation.DateTimeFormat;

/**
 * 파일 기본 정보 관리 클래스
 * @author Cheon JeongDae
 *
 */

public class FileInfo {
	
	public FileInfo() {
	}
	
	// 에러 코드
	private String errorCode;
	// 에러 메시지 
	private String errorMessage;
	
	// 업무 유형
	private String jobType;
	// 사용자 ID
	private String userId;
	// 파일명 : 실제파일명 + date
	private String fileName;
	// 실제 파일명
	private String fileRealName;
	// 파일 경로
	private String filePath;
	// 파일 용량
	private String fileSize;
	// 파일 확장자
	private String fileExt;
	
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime updateDate;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime insertDate;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private LocalDateTime viewUpdateDate;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private LocalDateTime viewInsertDate;
	
	public String getErrorCode() {
		return errorCode;
	}
	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}
	public String getErrorMessage() {
		return errorMessage;
	}
	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
	public String getJobType() {
		return jobType;
	}
	public void setJobType(String jobType) {
		this.jobType = jobType;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileRealName() {
		return fileRealName;
	}
	public void setFileRealName(String fileRealName) {
		this.fileRealName = fileRealName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getFileSize() {
		return fileSize;
	}
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	public String getFileExt() {
		return fileExt;
	}
	public void setFileExt(String fileExt) {
		this.fileExt = fileExt;
	}
	public LocalDateTime getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(LocalDateTime updateDate) {
		this.updateDate = updateDate;
	}
	public LocalDateTime getInsertDate() {
		return insertDate;
	}
	public void setInsertDate(LocalDateTime insertDate) {
		this.insertDate = insertDate;
	}
	
	public LocalDateTime getViewUpdateDate() {
		return this.updateDate;
	}
	public LocalDateTime getViewInsertDate() {
		return this.insertDate;
	}
	
	@Override
	public String toString() {
		return "FileInfo [errorCode=" + errorCode + ", errorMessage=" + errorMessage + ", jobType=" + jobType + ", userId=" + userId 
				+ ", fileName=" + fileName + ", fileRealName=" + fileRealName + ", filePath=" + filePath + ", fileSize=" + fileSize 
				+ ", fileExt=" + fileExt + ", updateDate=" + updateDate + ", insertDate=" + insertDate + "]";
	}
}
