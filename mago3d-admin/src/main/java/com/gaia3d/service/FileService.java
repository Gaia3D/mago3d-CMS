package com.gaia3d.service;

import com.gaia3d.domain.FileInfo;
import com.gaia3d.domain.FileParseLog;

/**
 * 로그 처리
 * @author jeongdae
 *
 */
public interface FileService {
	
	/**
	 * 파일 정보 획득
	 * @param fileInfoId
	 * @return
	 */
	public FileInfo getFileInfo(Long fileInfoId);
	
	/**
	 * 파일 파싱 로그 획득
	 * @param fileParseLogId
	 * @return
	 */
	public FileParseLog getFileParseLog(Long fileParseLogId);

	/**
	 * 파일 정보 등록
	 * @param fileInfo
	 * @return
	 */
	public int insertFileInfo(FileInfo fileInfo);
	
	/**
	 * 사용자 일괄 등록
	 * @param fileInfo
	 * @return
	 */
	public FileInfo insertExcelUser(FileInfo fileInfo);
	
	/**
	 * Data 일괄 등록
	 * @param projectId
	 * @param fileInfo
	 * @return
	 */
	public FileInfo insertDataFile(Long projectId, FileInfo fileInfo);
	
	/**
	 * Data Attribute 등록
	 * @param dataId
	 * @param fileInfo
	 * @return
	 */
	public FileInfo insertDataAttributeFile(Long dataId, FileInfo fileInfo);
	
	/**
	 * Data Object Attribute 등록
	 * @param dataId
	 * @param fileInfo
	 * @return
	 */
	public FileInfo insertDataObjectAttributeFile(Long dataId, FileInfo fileInfo);
}
