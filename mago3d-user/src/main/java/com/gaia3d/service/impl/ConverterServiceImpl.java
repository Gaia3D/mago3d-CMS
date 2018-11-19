package com.gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.ConverterJob;
import com.gaia3d.domain.ConverterLog;
import com.gaia3d.persistence.ConverterMapper;
import com.gaia3d.service.ConverterService;
import com.gaia3d.service.DataService;

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
	 * f4d converter 이력 총 건수
	 * @param converterLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getListConverterLogTotalCount(ConverterLog converterLog) {
		return converterMapper.getListConverterLogTotalCount(converterLog);
	}
	
	/**
	 * f4d converter 이력 목록
	 * @param converterLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<ConverterLog> getListConverterLog(ConverterLog converterLog) {
		return converterMapper.getListConverterLog(converterLog);
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
	 * converter job file list
	 * @param jobId
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<ConverterLog> getAllListConverterLog(Long jobId) {
		return converterMapper.getAllListConverterLog(jobId);
	}
	
	/**
	 * f4d converter job register
	 * @param dataInfoLog
	 * @return
	 */
	@Transactional
	public Long insertConverterJob(String check_ids, ConverterJob converterJob) {
		converterMapper.insertConverterJob(converterJob);
		
		String[] converterUploadLogIds = check_ids.split(",");
		String userId = converterJob.getUser_id();
		Long converterJobId = converterJob.getConverter_job_id();
		
//		for(String converter_upload_log_id : converterUploadLogIds) {
//			
//			ConverterLog converterLog = new ConverterLog();
//			converterLog.setUser_id(userId);
//			converterLog.setConverter_job_id(converterJobId);
//			converterLog.setConverter_upload_log_id(new Long(converter_upload_log_id));
//			converterLog.setData_key(converterUploadLog.getFile_real_name().substring(0, converterUploadLog.getFile_real_name().lastIndexOf(".")));
//			converterLog.setData_name(converterUploadLog.getFile_name().substring(0, converterUploadLog.getFile_name().lastIndexOf(".")));
//			converterMapper.insertConverterLog(converterLog);
//			
//			// TODO 이건 굳이 안해도 될거 같음
//			converterUploadService.updateConverterCount(converterLog);
//		}

		return converterJobId;
	}
	
	/**
	 * f4d converter job register
	 * @param dataInfoLog
	 * @return
	 */
	@Transactional
	public Long insertData(String check_ids, ConverterJob converterJob) {
//		converterMapper.insertConverterJob(converterJob);
//		
//		String[] converterUploadLogIds = check_ids.split(",");
//		String userId = converterJob.getUser_id();
//		Long converterJobId = converterJob.getConverter_job_id();
//		
//		Long projectId = converterJob.getProject_id();
//		DataInfo rootDataInfo = dataService.getRootDataByProjectId(projectId);
//		int order = 1;
//		String attributes = "{\"isPhysical\": false}";
//		for(String converter_upload_log_id : converterUploadLogIds) {
//			ConverterLog converterLog = new ConverterLog();
//			converterLog.setUser_id(userId);
//			converterLog.setConverter_job_id(converterJobId);
//			converterLog.setConverter_upload_log_id(new Long(converter_upload_log_id));
//			converterMapper.insertConverterLog(converterLog);
//			
//			ConverterUploadLog converterUploadLog = converterUploadService.getConverterUploadLog(Long.valueOf(converter_upload_log_id));
//			// TODO 이건 굳이 안해도 될거 같음
//			converterUploadService.updateConverterCount(converterLog);
//			
//			// data_info 테이블을 조회 후 데이터가 존재하면 패스, 존재하지 않으면 등록
//			
//			DataInfo dataInfo = new DataInfo();
//			dataInfo.setProject_id(projectId);
//			dataInfo.setData_key(converterUploadLog.getFile_real_name().substring(0, converterUploadLog.getFile_real_name().lastIndexOf(".")));
//			dataInfo.setData_name(converterUploadLog.getFile_name().substring(0, converterUploadLog.getFile_name().lastIndexOf(".")));
//			dataInfo.setUser_id(userId);
//			dataInfo.setParent(rootDataInfo.getData_id());
//			dataInfo.setDepth(rootDataInfo.getDepth() + 1);
//			dataInfo.setView_order(order);
//			dataInfo.setAttributes(attributes);
//			dataService.insertData(dataInfo);
//			
//			order++;
//		}

		return 0l;
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
