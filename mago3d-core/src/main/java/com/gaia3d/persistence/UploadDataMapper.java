package com.gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gaia3d.domain.UploadData;
import com.gaia3d.domain.UploadDataFile;

@Repository
public interface UploadDataMapper {

	/**
	 * 업로딩 총 건수
	 * @param uploadData
	 * @return
	 */
	Long getUploadDataTotalCount(UploadData uploadData);
	
	/**
	 * 업로딩 목록
	 * @param uploadData
	 * @return
	 */
	List<UploadData> getListUploadData(UploadData uploadData);
	
	/**
	 * 업로딩 정보
	 * @param uploadData
	 * @return
	 */
	UploadData getUploadData(UploadData uploadData);
	
	/**
	 * 업로딩한 파일 목록
	 * @param uploadData
	 * @return
	 */
	List<UploadDataFile> getListUploadDataFile(UploadData uploadData);
	
	/**
	 * 사용자 3차원 파일 정보 업로딩
	 * @param uploadData
	 * @return
	 */
	int insertUploadData(UploadData uploadData);
	
	/**
	 * 사용자 3차원 파일 업로딩
	 * @param uploadDataFile
	 * @return
	 */
	int insertUploadDataFile(UploadDataFile uploadDataFile);

	/**
	 * 업로딩 데이터 정보 삭제
	 * @param uploadData
	 * @return
	 */
	int deleteUploadData(UploadData uploadData);
	
	/**
	 * 업로딩 데이터 파일 삭제
	 * @param uploadData
	 * @return
	 */
	int deleteUploadDataFile(UploadData uploadData);
}
