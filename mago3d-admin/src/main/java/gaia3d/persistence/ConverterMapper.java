package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.ConverterJob;
import gaia3d.domain.ConverterJobFile;

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
	public Long getConverterJobTotalCount(ConverterJob converterJob);
	
	/**
	 * converter job file 총 건수
	 * @param converterJobFile
	 * @return
	 */
	public Long getConverterJobFileTotalCount(ConverterJobFile converterJobFile);
	
	/**
	 * f4d converter job 목록
	 * @param converterJob
	 * @return
	 */
	public List<ConverterJob> getListConverterJob(ConverterJob converterJob);

	/**
	 * f4d converter job 목록
	 * @param converterJobFile
	 * @return
	 */
	public List<ConverterJobFile> getListConverterJobFile(ConverterJobFile converterJobFile);

	/**
	 * 데이터 변환 현황
	 * @return
	 */
	public List<ConverterJobFile> getConverterJobFileStatistics();
	
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
	public int updateConverterJob(ConverterJob converterJob);
}
