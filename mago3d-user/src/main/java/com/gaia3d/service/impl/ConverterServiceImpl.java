package com.gaia3d.service.impl;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.config.PropertiesConfig;
import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.ConverterJob;
import com.gaia3d.domain.ConverterJobFile;
import com.gaia3d.domain.ConverterTarget;
import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.Project;
import com.gaia3d.domain.QueueMessage;
import com.gaia3d.domain.UploadData;
import com.gaia3d.domain.UploadDataFile;
import com.gaia3d.persistence.ConverterMapper;
import com.gaia3d.service.AMQPPublishService;
import com.gaia3d.service.ConverterService;
import com.gaia3d.service.DataService;
import com.gaia3d.service.ProjectService;
import com.gaia3d.service.UploadDataService;

import lombok.extern.slf4j.Slf4j;

/**
 * converter manager
 * @author jeongdae
 *
 */
@Slf4j
@Service
public class ConverterServiceImpl implements ConverterService {

	@Autowired
	private AMQPPublishService aMQPPublishService;
	
	@Autowired
	private DataService dataService;
	
	@Autowired
	private ProjectService projectService;
	@Autowired
	private PropertiesConfig propertiesConfig;
	@Autowired
	private UploadDataService uploadDataService;
	
	@Autowired
	private ConverterMapper converterMapper;
	
	/**
	 * converter job 총 건수
	 * @param converterJob
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getListConverterJobTotalCount(ConverterJob converterJob) {
		return converterMapper.getListConverterJobTotalCount(converterJob);
	}
	
	/**
	 * converter job file 총 건수
	 * @param converterJobFile
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getListConverterJobFileTotalCount(ConverterJobFile converterJobFile) {
		return converterMapper.getListConverterJobFileTotalCount(converterJobFile);
	}
	
	/**
	 * converter job 목록
	 * @param converterLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<ConverterJob> getListConverterJob(ConverterJob converterJob) {
		return converterMapper.getListConverterJob(converterJob);
	}
	
	/**
	 * converter job file 목록
	 * @param converterJobFile
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<ConverterJobFile> getListConverterJobFile(ConverterJobFile converterJobFile) {
		return converterMapper.getListConverterJobFile(converterJobFile);
	}
	
	/**
	 * converter 변환
	 * @param userId
	 * @param checkIds
	 * @param converterJob
	 * @return
	 */
	@Transactional
	public int insertConverter(String userId, String checkIds, ConverterJob converterJob) {
		
		String projectRootPath = CacheManager.getPolicy().getGeo_data_path() + File.separator;
		String title = converterJob.getTitle();
		String converterType = converterJob.getConverter_type();
		
		String[] uploadDataIds = checkIds.split(",");
		for(String upload_data_id : uploadDataIds) {
			// 1. job을 하나씩 등록
			ConverterJob inConverterJob = new ConverterJob();
			inConverterJob.setUpload_data_id(Long.valueOf(upload_data_id));
			inConverterJob.setUser_id(userId);
			inConverterJob.setTitle(title);
			inConverterJob.setConverter_type(converterType);
			
			UploadData uploadData = new UploadData();
			uploadData.setUser_id(userId);
			uploadData.setUpload_data_id(Long.valueOf(upload_data_id));
			uploadData.setConverter_target_yn(ConverterTarget.Y.name());
			List<UploadDataFile> uploadDataFileList = uploadDataService.getListUploadDataFile(uploadData);
			
			inConverterJob.setFile_count(uploadDataFileList.size());
			converterMapper.insertConverterJob(inConverterJob);
			
			Long converter_job_id = inConverterJob.getConverter_job_id();
			for(UploadDataFile uploadDataFile : uploadDataFileList) {
				ConverterJobFile converterJobFile = new ConverterJobFile();
				converterJobFile.setConverter_job_id(converter_job_id);
				converterJobFile.setUpload_data_id(Long.valueOf(upload_data_id));
				converterJobFile.setUpload_data_file_id(uploadDataFile.getUpload_data_file_id());
				converterJobFile.setProject_id(uploadDataFile.getProject_id());
				converterJobFile.setUser_id(userId);
				
				// 2. job file을 하나씩 등록
				converterMapper.insertConverterJobFile(converterJobFile);
				
				// 3. 데이터를 등록
				insertData(userId, uploadDataFile);
				
				// queue 를 실행
				executeConverter(projectRootPath, converterJobFile, uploadDataFile);
			}
			
			Project project = new Project();
			//project.setProject_id(project_id);
			projectService.updateProject(project);
		}
		
		return uploadDataIds.length;
	}
	
	private void executeConverter(String projectRootPath, ConverterJobFile converterJobFile, UploadDataFile uploadDataFile) {
		Project project = new Project();
		project.setProject_id(uploadDataFile.getProject_id());
		project = projectService.getProject(project);
		
		QueueMessage queueMessage = new QueueMessage();
		queueMessage.setConverter_job_id(converterJobFile.getConverter_job_id());
		queueMessage.setInput_folder(uploadDataFile.getFile_path());
		queueMessage.setOutput_folder(projectRootPath + project.getProject_path());
		queueMessage.setMesh_type("0");
		queueMessage.setLog_path(projectRootPath + project.getProject_path() + "logTest.txt");
		queueMessage.setIndexing("y");
		
		// TODO
		// 조금 미묘하다. transaction 처리를 할지, 관리자 UI 재 실행을 위해서는 여기가 맞는거 같기도 하고....
		// 별도 기능으로 분리해야 하나?
		try {
			aMQPPublishService.send(queueMessage);
		} catch(Exception ex) {
			ConverterJob converterJob = new ConverterJob();
			converterJob.setConverter_job_id(converterJobFile.getConverter_job_id());
			converterJob.setStatus(ConverterJob.JOB_CONFIRM);
			converterJob.setError_code(ex.getMessage());
			converterMapper.updateConverterJob(converterJob);
			
			ex.printStackTrace();
		}
	}
	
	private void insertData(String userId, UploadDataFile uploadDataFile) {
		DataInfo rootDataInfo = dataService.getRootDataByProjectId(uploadDataFile.getProject_id());
		int order = 1;
		// TODO nodeType 도 입력해야 함
		String attributes = "{\"isPhysical\": true}";
		
		DataInfo dataInfo = new DataInfo();
		dataInfo.setProject_id(uploadDataFile.getProject_id());
		dataInfo.setData_key(uploadDataFile.getFile_real_name().substring(0, uploadDataFile.getFile_real_name().lastIndexOf(".")));
		dataInfo.setData_name(uploadDataFile.getFile_name().substring(0, uploadDataFile.getFile_name().lastIndexOf(".")));
		dataInfo.setUser_id(userId);
		dataInfo.setParent(rootDataInfo.getData_id());
		dataInfo.setDepth(rootDataInfo.getDepth() + 1);
		dataInfo.setLatitude(uploadDataFile.getLatitude());
		dataInfo.setLongitude(uploadDataFile.getLongitude());
		dataInfo.setHeight(uploadDataFile.getHeight());
		dataInfo.setLocation("POINT(" + dataInfo.getLongitude() + " " + dataInfo.getLatitude() + ")");
		dataInfo.setView_order(order);
		dataInfo.setAttributes(attributes);
		dataService.insertData(dataInfo);
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
