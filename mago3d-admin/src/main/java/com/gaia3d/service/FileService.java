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
	 * @param file_info_id
	 * @return
	 */
	public FileInfo getFileInfo(Long file_info_id);
	
	/**
	 * 파일 파싱 로그 획득
	 * @param file_parse_log_id
	 * @return
	 */
	public FileParseLog getFileParseLog(Long file_parse_log_id);

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
	 * @param project_id
	 * @param fileInfo
	 * @return
	 */
	public FileInfo insertDataFile(Long project_id, FileInfo fileInfo, String userId);
	
}
