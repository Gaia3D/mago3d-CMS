package com.gaia3d.service;

import java.util.List;

import com.gaia3d.domain.UploadData;
import com.gaia3d.domain.UploadDataFile;

public interface UploadDataService {

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
	 * 업로딩 파일 총 건수
	 * @param uploadDataFile
	 * @return
	 */
	Long getUploadDataFileTotalCount(UploadDataFile uploadDataFile);

	/**
	 * 업로딩 파일 총 용량
	 * @param uploadDataFile
	 * @return
	 */
	Long getUploadDataFileTotalSize(UploadDataFile uploadDataFile);

	/**
	 * 업로딩 파일 정보 목록
	 * @param uploadData
	 * @return
	 */
	List<UploadDataFile> getListUploadDataFile(UploadData uploadData);
	
	/**
	 * 사용자 3차원 파일 업로딩
	 * @param uploadData
	 * @param uploadDataFileList
	 * @return
	 */
	int insertUploadData(UploadData uploadData, List<UploadDataFile> uploadDataFileList);
	
	/**
	 * 업로딩 데이터 삭제
	 * @param userId
	 * @param checkIds
	 * @return
	 */
	int deleteUploadDatas(String userId, String checkIds);
}
