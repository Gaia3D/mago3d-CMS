package com.gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.ConverterJob;
import com.gaia3d.domain.ConverterLog;
import com.gaia3d.persistence.ConverterMapper;
import com.gaia3d.service.ConverterService;
import com.gaia3d.service.UploadService;

/**
 * f4d converter manager
 * @author jeongdae
 *
 */
@Service
public class ConverterServiceImpl implements ConverterService {

	@Autowired
	private UploadService uploadService;
	
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
	 * f4d converter job register
	 * @param dataInfoLog
	 * @return
	 */
	@Transactional
	public Long insertConverterJob(String check_ids, ConverterJob converterJob) {
		converterMapper.insertConverterJob(converterJob);
		
		String[] uploadLogIds = check_ids.split(",");
		String userId = converterJob.getUser_id();
		Long converterJobId = converterJob.getConverter_job_id();
		for(String upload_log_id : uploadLogIds) {
			ConverterLog converterLog = new ConverterLog();
			converterLog.setUser_id(userId);
			converterLog.setConverter_job_id(converterJobId);
			converterLog.setUpload_log_id(new Long(upload_log_id));
			converterMapper.insertConverterLog(converterLog);
			uploadService.updateConverterCount(converterLog);
		}

		return converterJobId;
	}
}
