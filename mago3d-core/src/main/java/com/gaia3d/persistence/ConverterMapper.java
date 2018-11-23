package com.gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gaia3d.domain.ConverterJob;
import com.gaia3d.domain.ConverterJobFile;

/**
 * f4d converter manager
 * @author jeongdae
 *
 */
@Repository
public interface ConverterMapper {
	
	/**
	 * converter job 총 건수
	 * @param converterJob
	 * @return
	 */
	public Long getListConverterJobTotalCount(ConverterJob converterJob);
	
	/**
	 * converter job file 총 건수
	 * @param converterJobFile
	 * @return
	 */
	public Long getListConverterJobFileTotalCount(ConverterJobFile converterJobFile);
	
	/**
	 * f4d converter job 목록
	 * @param converterJob
	 * @return
	 */
	public List<ConverterJob> getListConverterJob(ConverterJob converterJob);
	
	/**
	 * f4d converter job 목록
	 * @param converterJob
	 * @return
	 */
	public List<ConverterJobFile> getListConverterJobFile(ConverterJobFile converterJobFile);
	
	/**
	 * insert converter job
	 * @param converterJob
	 * @return
	 */
	public Long insertConverterJob(ConverterJob converterJob);
	
	/**
	 * insert converter job file
	 * @param converterJobFile
	 * @return
	 */
	public Long insertConverterJobFile(ConverterJobFile converterJobFile);
	
	/**
	 * update
	 * @param converterJob
	 */
	public void updateConverterJob(ConverterJob converterJob);
}
