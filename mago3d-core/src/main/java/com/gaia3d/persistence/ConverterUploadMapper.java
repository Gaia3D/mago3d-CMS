package com.gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gaia3d.domain.ConverterLog;
import com.gaia3d.domain.ConverterUploadLog;
import com.gaia3d.domain.FileInfo;

/**
 * 사용자
 * @author jeongdae
 *
 */
@Repository
public interface ConverterUploadMapper {
	
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
	 * @param fileInfo
	 */
	public void insertFileInfo(FileInfo fileInfo);
	
	/**
	 * f4d converter 변환 횟수 업데이트
	 * @param converterLog
	 */
	public void updateConverterCount(ConverterLog converterLog);
}
