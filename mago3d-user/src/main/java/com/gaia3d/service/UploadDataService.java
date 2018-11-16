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
	 * 사용자 3차원 파일 업로딩
	 * @param uploadData
	 * @param uploadDataFileList
	 * @return
	 */
	int insertUploadData(UploadData uploadData, List<UploadDataFile> uploadDataFileList);
}
