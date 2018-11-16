package com.gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	
	@Transactional
	public int insertUploadData(UploadData uploadData, List<UploadDataFile> uploadDataFileList) {
		int result = uploadDataMapper.insertUploadData(uploadData);
		
		Long upload_data_id = uploadData.getUpload_data_id();
		Integer project_id = uploadData.getProject_id();
		String sharing_type = uploadData.getSharing_type();
		String data_type = uploadData.getData_type();
		for(UploadDataFile uploadDataFile : uploadDataFileList) {
			uploadDataFile.setUpload_data_id(upload_data_id);
			uploadDataFile.setProject_id(project_id);
			uploadDataFile.setSharing_type(sharing_type);
			uploadDataFile.setData_type(data_type);
			uploadDataMapper.insertUploadDataFile(uploadDataFile);
			result++;
		}
		return result;
	}
}
