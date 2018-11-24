package com.gaia3d.service.impl;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.FileType;
import com.gaia3d.domain.UploadData;
import com.gaia3d.domain.UploadDataFile;
import com.gaia3d.persistence.UploadDataMapper;
import com.gaia3d.service.UploadDataService;

/**
 * @author Cheon JeongDae
 *
 */
@Service
public class UploadDataServiceImpl implements UploadDataService {

	@Autowired
	private UploadDataMapper uploadDataMapper;
	
	/**
	 * 업로딩 총 건수
	 * @param uploadData
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getUploadDataTotalCount(UploadData uploadData) {
		return uploadDataMapper.getUploadDataTotalCount(uploadData);
	}
	
	/**
	 * 업로딩 목록
	 * @param uploadData
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<UploadData> getListUploadData(UploadData uploadData) {
		return uploadDataMapper.getListUploadData(uploadData);
	}
	
	/**
	 * 업로딩 정보
	 * @param uploadData
	 * @return
	 */
	@Transactional(readOnly=true)
	public UploadData getUploadData(UploadData uploadData) {
		return uploadDataMapper.getUploadData(uploadData);
	}
	
	/**
	 * 업로딩 파일 총 건수
	 * @param uploadDataFile
	 * @return
	 */
	public Long getUploadDataFileTotalCount(UploadDataFile uploadDataFile) {
		return uploadDataMapper.getUploadDataFileTotalCount(uploadDataFile);
	}

	/**
	 * 업로딩 파일 총 용량
	 * @param uploadDataFile
	 * @return
	 */
	public Long getUploadDataFileTotalSize(UploadDataFile uploadDataFile) {
		return uploadDataMapper.getUploadDataFileTotalSize(uploadDataFile);
	}
	
	/**
	 * 업로딩 파일 정보 목록
	 * @param uploadData
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<UploadDataFile> getListUploadDataFile(UploadData uploadData) {
		return uploadDataMapper.getListUploadDataFile(uploadData);
	}
	
	@Transactional
	public int insertUploadData(UploadData uploadData, List<UploadDataFile> uploadDataFileList) {
		int result = uploadDataMapper.insertUploadData(uploadData);
		
		Long upload_data_id = uploadData.getUpload_data_id();
		Integer project_id = uploadData.getProject_id();
		String sharing_type = uploadData.getSharing_type();
		String data_type = uploadData.getData_type();
		String user_id = uploadData.getUser_id();
		for(UploadDataFile uploadDataFile : uploadDataFileList) {
			uploadDataFile.setUpload_data_id(upload_data_id);
			uploadDataFile.setProject_id(project_id);
			uploadDataFile.setSharing_type(sharing_type);
			uploadDataFile.setData_type(data_type);
			uploadDataFile.setUser_id(user_id);
			uploadDataMapper.insertUploadDataFile(uploadDataFile);
			result++;
		}
		return result;
	}
	
	/**
	 * 업로딩 데이터 삭제
	 * @param check_ids
	 * @return
	 */
	@Transactional
	public int deleteUploadDatas(String userId, String checkIds) {
		String[] uploadDatas = checkIds.split(",");
		
		for(String upload_data_id : uploadDatas) {
			UploadData uploadData = new UploadData();
			uploadData.setUser_id(userId);
			uploadData.setUpload_data_id(Long.valueOf(upload_data_id));
			uploadData.setOrder_word("depth");
			uploadData.setOrder_value("DESC");
			
			List<UploadDataFile> uploadDataFileList = uploadDataMapper.getListUploadDataFile(uploadData);
			uploadDataMapper.deleteUploadDataFile(uploadData);
			// 2 upload_data 삭제
			uploadDataMapper.deleteUploadData(uploadData);
			
			for(UploadDataFile deleteUploadDataFile : uploadDataFileList) {
				String fileName = null;
				if(FileType.DIRECTORY.getValue().equals(deleteUploadDataFile.getFile_type())) {
					fileName = deleteUploadDataFile.getFile_path();
				} else {
					fileName = deleteUploadDataFile.getFile_path() + deleteUploadDataFile.getFile_real_name();
				}
				
				File file = new File(fileName);
				if(file.exists()) {
					file.delete();
				}
			}
		}
			
		return uploadDatas.length;
	}
}
