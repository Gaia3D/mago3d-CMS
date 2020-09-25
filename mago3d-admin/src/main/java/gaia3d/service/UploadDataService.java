package gaia3d.service;

import gaia3d.domain.uploaddata.UploadData;
import gaia3d.domain.uploaddata.UploadDataFile;

import java.util.List;

public interface UploadDataService {

	/**
	 * 업로딩 데이터 총 건수
	 * @param uploadData
	 * @return
	 */
	Long getUploadDataTotalCount(UploadData uploadData);
	
	/**
	 * 업로딩 데이터 목록
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
	
//	/**
//	 * 업로딩 데이터 파일 총 건수
//	 * @param uploadDataFile
//	 * @return
//	 */
//	Long getUploadDataFileTotalCount(UploadDataFile uploadDataFile);
//
//	/**
//	 * 업로딩 데이터 파일 총 용량
//	 * @param uploadDataFile
//	 * @return
//	 */
//	Long getUploadDataFileTotalSize(UploadDataFile uploadDataFile);
	
	/**
	 * 업로딩 데이터 파일 목록
	 * @param uploadData
	 * @return
	 */
	List<UploadDataFile> getListUploadDataFile(UploadData uploadData);

	/**
	 * 업로딩 데이터 파일
	 * @param uploadDataFile
	 * @return	업로딩 데이터 파일
	 */
	UploadDataFile getUploadDataFile(UploadDataFile uploadDataFile);
	
	/**
	 * 업로드 데이터 타입 집계
	 * @return
	 */
	List<UploadData> getUploadDataType();
	
	/**
	 * 사용자 파일 정보 업로딩
	 * @param uploadData
	 * @param uploadDataFileList
	 * @return
	 */
	int insertUploadData(UploadData uploadData, List<UploadDataFile> uploadDataFileList);
	
	/**
	 * 사용자 파일 정보 수정
	 * @param uploadData
	 * @return
	 */
	int updateUploadData(UploadData uploadData);

	/**
	 * 업로딩 데이터 삭제
	 * @param uploadData
	 * @return
	 */
	int deleteUploadData(UploadData uploadData);

	/**
	 * 사용자 파일 정보 수정 및 업로드 파일 정보 수정
	 * @param uploadData
	 * @return
	 */
	int updateUploadDataAndFile(UploadData uploadData);

}
