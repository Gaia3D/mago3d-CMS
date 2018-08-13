package com.gaia3d.service;

import java.util.List;

import com.gaia3d.domain.ConverterLog;
import com.gaia3d.domain.ConverterUploadLog;
import com.gaia3d.domain.FileInfo;

/**
 * Data Upload 관리
 * @author jeongdae
 *
 */
public interface ConverterUploadService {
	
	/**
	 * 사용자가 업로드 완료한 파일 총 건수
	 * @param converterUploadLog
	 * @return
	 */
	public Long getListConverterUploadLogTotalCount(ConverterUploadLog converterUploadLog);
	
	/**
	 * 사용자가 업로드 완료한 파일 목록
	 * @param converterUploadLog
	 * @return
	 */
	public List<ConverterUploadLog> getListConverterUploadLog(ConverterUploadLog converterUploadLog);
	
	/**
	 * 사용자가 업로딩한 파일 목록을 저장
	 * @param fileList
	 */
	public void insertFiles(List<FileInfo> fileList);
	
	/**
	 * f4d converter 변환 횟수 업데이트
	 * @param converterLog
	 */
	public void updateConverterCount(ConverterLog converterLog);
}
