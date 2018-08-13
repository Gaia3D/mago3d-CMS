package com.gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gaia3d.domain.ConverterJob;
import com.gaia3d.domain.ConverterLog;
import com.gaia3d.domain.ConverterUploadLog;

/**
 * f4d converter manager
 * @author jeongdae
 *
 */
@Repository
public interface ConverterMapper {
	
	/**
	 * f4d converter job 총 건수
	 * @param converterJob
	 * @return
	 */
	public Long getListConverterJobTotalCount(ConverterJob converterJob);
	
	/**
	 * f4d converter 이력 목록
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
	 * insert converter job
	 * @param converterJob
	 * @return
	 */
	public Long insertConverterJob(ConverterJob converterJob);
	
	/**
	 * insert converter log
	 * @param converterLog
	 * @return
	 */
	public Long insertConverterLog(ConverterLog converterLog);
	
	/**
	 * update
	 * @param converterJob
	 */
	public void updateConverterJob(ConverterJob converterJob);
}
