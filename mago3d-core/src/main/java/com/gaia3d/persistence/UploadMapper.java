package com.gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gaia3d.domain.FileInfo;
import com.gaia3d.domain.UploadLog;

/**
 * 사용자
 * @author jeongdae
 *
 */
@Repository
public interface UploadMapper {
	
	/**
	 * 사용자가 업로드 완료한 파일 총 건수
	 * @param uploadLog
	 * @return
	 */
	public Long getListUploadCompleteTotalCount(UploadLog uploadLog);
	
	/**
	 * 사용자가 업로드 완료한 파일 목록
	 * @param uploadLog
	 * @return
	 */
	public List<UploadLog> getListUploadComplete(UploadLog uploadLog);

	/**
	 * 사용자가 업로딩한 파일 목록을 저장
	 * @param fileInfo
	 */
	public void insertFileInfo(FileInfo fileInfo);
}
