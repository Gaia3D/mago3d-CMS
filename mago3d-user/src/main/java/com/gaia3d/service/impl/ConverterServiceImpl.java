package com.gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.ConverterJob;
import com.gaia3d.domain.ConverterJobFile;
import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.UploadData;
import com.gaia3d.domain.UploadDataFile;
import com.gaia3d.persistence.ConverterMapper;
import com.gaia3d.service.ConverterService;
import com.gaia3d.service.DataService;
import com.gaia3d.service.ProjectService;
import com.gaia3d.service.UploadDataService;

/**
 * f4d converter manager
 * @author jeongdae
 *
 */
@Service
public class ConverterServiceImpl implements ConverterService {

	@Autowired
	private DataService dataService;
	
	@Autowired
	private UploadDataService uploadDataService;
	
	@Autowired
	private ConverterMapper converterMapper;
	
	/**
	 * f4d converter job 총 건수
	 * @param converterJob
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getListConverterJobTotalCount(ConverterJob converterJob) {
		return converterMapper.getListConverterJobTotalCount(converterJob);
	}
	
	/**
	 * f4d converter job 목록
	 * @param converterLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<ConverterJob> getListConverterJob(ConverterJob converterJob) {
		return converterMapper.getListConverterJob(converterJob);
	}
	
	/**
	 * converter job 정보
	 * @param jobId
	 * @return
	 */
	@Transactional(readOnly=true)
	public ConverterJob getConverterJobByJobId(Long jobId) {
		return converterMapper.getConverterJobByJobId(jobId);
	}
	
	/**
	 * converter 변환
	 * @param userId
	 * @param checkIds
	 * @param converterJob
	 * @return
	 */
	@Transactional
	public Long insertConverter(String userId, String checkIds, ConverterJob converterJob) {
		String title = converterJob.getTitle();
		String converterType = converterJob.getConverter_type();
		
//		String[] uploadDataIds = checkIds.split(",");
//		for(String upload_data_id : uploadDataIds) {
//			// 1. job을 하나씩 등록
//			ConverterJob inConverterJob = new ConverterJob();
//			inConverterJob.setUpload_data_id(Long.valueOf(upload_data_id));
//			inConverterJob.setUser_id(userId);
//			inConverterJob.setTitle(title);
//			inConverterJob.setConverter_type(converterType);
//			
//			UploadData uploadData = new UploadData();
//			uploadData.setUser_id(userId);
//			uploadData.setUpload_data_id(Long.valueOf(upload_data_id));
//			List<UploadDataFile> uploadDataFileList = uploadDataService.getListUploadDataFile(uploadData);
//			
//			inConverterJob.setFile_count(uploadDataFileList.size());
//			converterMapper.insertConverterJob(inConverterJob);
//			
//			Long converter_job_id = converterJob.getConverter_job_id();
//			for(UploadDataFile uploadDataFile : uploadDataFileList) {
//				ConverterJobFile converterJobFile = new ConverterJobFile();
//				converterJobFile.setConverter_job_id(converter_job_id);
//				converterJobFile.setUpload_data_id(Long.valueOf(upload_data_id));
//				converterJobFile.setUpload_data_file_id(uploadDataFile.getUpload_data_file_id());
//				converterJobFile.setProject_id(uploadDataFile.getProject_id());
//				converterJobFile.setUser_id(userId);
//				
//				// 2. job file을 하나씩 등록
//				converterMapper.insertConverterJobFile(converterJobFile);
//				
//				// 3. 데이터를 등록
//				insertData(userId, uploadDataFile);
//				
//				// queue 를 실행
//				sendQueue();
//			}
//			
//			// 2 job 안에 파일이 n 개면...... n개를 queue 실행
//			// data_info 등록
//			// queue 실행
//			
//		}
//		
//		
//		
//		String userId = converterJob.getUser_id();
//		Long converterJobId = converterJob.getConverter_job_id();
//		
//		Long jobId = converterService.insertConverterJob(check_ids, converterJob);
//		
//		// input output 다 보내야 한다.
//		
//		StringBuffer buffer = new StringBuffer()
//				.append("host=" + propertiesConfig.getQueueServerHost())
//				.append("&")
//				.append("port=" + propertiesConfig.getQueueServerPort())
//				.append("&")
//				.append("jobId=" + jobId);
//		
//		// TODO
//		// 조금 미묘하다. transaction 처리를 할지, 관리자 UI 재 실행을 위해서는 여기가 맞는거 같기도 하고....
//		// 별도 기능으로 분리해야 하나?
//		try {
//			aMQPPublishService.send(buffer.toString());
//		} catch(Exception ex) {
//			converterJob.setStatus(ConverterJob.JOB_FAIL);
//			converterJob.setError_code(ex.getMessage());
//			converterService.updateConverterJob(converterJob);
//			throw ex;
//		}
//		
//		
//				
//		converterMapper.insertConverterJob(converterJob);
//		
		
		return null;
	}
	
	public int insertData(String userId, UploadDataFile uploadDataFile) {
//		#{data_id}, #{project_id}, #{data_key}, #{data_name}, #{user_id}, #{parent}, #{depth}, #{view_order}, 
//		ST_GeographyFromText(#{location}), #{latitude}, #{longitude}, #{height}, #{heading}, #{pitch}, #{roll}, #{description}
//		, #{mapping_type}
//		, TO_JSON(#{attributes}::json)
		
		DataInfo rootDataInfo = dataService.getRootDataByProjectId(uploadDataFile.getProject_id());
		int order = 1;
		// TODO nodeType 도 입력해야 함
		String attributes = "{\"isPhysical\": false}";
		
		// parent, depth, 
			
		DataInfo dataInfo = new DataInfo();
		dataInfo.setProject_id(uploadDataFile.getProject_id());
		dataInfo.setData_key(uploadDataFile.getFile_real_name().substring(0, uploadDataFile.getFile_real_name().lastIndexOf(".")));
		dataInfo.setData_name(uploadDataFile.getFile_name().substring(0, uploadDataFile.getFile_name().lastIndexOf(".")));
		dataInfo.setUser_id(userId);
		dataInfo.setParent(rootDataInfo.getData_id());
		dataInfo.setDepth(rootDataInfo.getDepth() + 1);
		dataInfo.setView_order(order);
		dataInfo.setAttributes(attributes);
		dataService.insertData(dataInfo);
			
		
		return 0;
	}
	
	/**
	 * update
	 * @param converterJob
	 */
	@Transactional
	public void updateConverterJob(ConverterJob converterJob) {
		converterMapper.updateConverterJob(converterJob);
	}
}
