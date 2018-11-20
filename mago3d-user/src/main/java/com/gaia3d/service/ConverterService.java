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
	 * @param userId
	 * @param checkIds
	 * @param converterJob
	 * @return
	 */
	public Long insertConverter(String userId, String checkIds, ConverterJob converterJob);
	
	/**
	 * update
	 * @param converterJob
	 */
	public void updateConverterJob(ConverterJob converterJob);
}
