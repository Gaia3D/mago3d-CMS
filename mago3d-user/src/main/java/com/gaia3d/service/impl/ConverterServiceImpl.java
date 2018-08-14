package com.gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.ConverterJob;
import com.gaia3d.domain.ConverterLog;
import com.gaia3d.domain.ConverterUploadLog;
import com.gaia3d.domain.DataInfo;
import com.gaia3d.persistence.ConverterMapper;
import com.gaia3d.service.ConverterService;
import com.gaia3d.service.ConverterUploadService;

/**
 * f4d converter manager
 * @author jeongdae
 *
 */
@Service
public class ConverterServiceImpl implements ConverterService {

	@Autowired
	private ConverterUploadService converterUploadService;
	
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
		
		Long projectId = converterJob.getProject_id();
		for(String converter_upload_log_id : converterUploadLogIds) {
			ConverterLog converterLog = new ConverterLog();
			converterLog.setUser_id(userId);
			converterLog.setConverter_job_id(converterJobId);
			converterLog.setConverter_upload_log_id(new Long(converter_upload_log_id));
			converterMapper.insertConverterLog(converterLog);
			
			ConverterUploadLog converterUploadLog = converterUploadService.getConverterUploadLog(Long.valueOf(converter_upload_log_id));
			// TODO 이건 굳이 안해도 될거 같음
			converterUploadService.updateConverterCount(converterLog);
			
			DataInfo dataInfo = new DataInfo();
			dataInfo.setProject_id(projectId);
			dataInfo.setData_key(converterUploadLog.getFile_name());
		}

		return converterJobId;
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
