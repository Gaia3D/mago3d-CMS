package com.gaia3d.service;

import java.util.List;

import com.gaia3d.domain.ConverterJob;
import com.gaia3d.domain.ConverterJobFile;

/**
 * f4d converting manager
 * @author Cheon JeongDae
 *
 */
public interface ConverterService {
	
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
	 * @param userId
	 * @param checkIds
	 * @param converterJob
	 * @return
	 */
	public int insertConverter(String userId, String checkIds, ConverterJob converterJob);
	
	/**
	 * update
	 * @param converterJob
	 */
	public void updateConverterJob(ConverterJob converterJob);
}
