package com.gaia3d.service;

import java.util.List;

import com.gaia3d.domain.ConverterJob;
import com.gaia3d.domain.ConverterLog;
import com.gaia3d.domain.UploadLog;

/**
 * f4d converting manager
 * @author Cheon JeongDae
 *
 */
public interface ConverterService {
	
	/**
	 * f4d converter job 총 건수
	 * @param converterJob
	 * @return
	 */
	public Long getListConverterJobTotalCount(ConverterJob converterJob);
	
	/**
	 * f4d converter job 목록
	 * @param converterJob
	 * @return
	 */
	public List<ConverterJob> getListConverterJob(ConverterJob converterJob);

	/**
	 * f4d converter 이력 총 건수
	 * @param converterLog
	 * @return
	 */
	public Long getListConverterLogTotalCount(ConverterLog converterLog);
	
	/**
	 * f4d converter 이력 목록
	 * @param converterLog
	 * @return
	 */
	public List<ConverterLog> getListConverterLog(ConverterLog converterLog);
	
	/**
	 * converter job 정보
	 * @param jobId
	 * @return
	 */
	public ConverterJob getConverterJobByJobId(Long jobId);
	
	/**
	 * converter job file list
	 * @param jobId
	 * @return
	 */
	public List<ConverterLog> getAllListConverterLog(Long jobId);
	
	/**
	 * 
	 * @param check_ids
	 * @param converterJob
	 * @return
	 */
	public Long insertConverterJob(String check_ids, ConverterJob converterJob);
	
	/**
	 * update
	 * @param converterJob
	 */
	public void updateConverterJob(ConverterJob converterJob);
}
