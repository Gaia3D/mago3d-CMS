package gaia3d.persistence;

import gaia3d.domain.converter.ConverterJob;
import gaia3d.domain.converter.ConverterJobFile;
import org.springframework.stereotype.Repository;

import java.util.List;

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
	Long getConverterJobTotalCount(ConverterJob converterJob);

	/**
	 * converter job file 총 건수
	 * @param converterJobFile
	 * @return
	 */
	Long getConverterJobFileTotalCount(ConverterJobFile converterJobFile);

	/**
	 * f4d converter job 목록
	 * @param converterJob
	 * @return
	 */
	List<ConverterJob> getListConverterJob(ConverterJob converterJob);

	/**
	 * f4d converter job 파일 목록
	 * @param converterJobFile
	 * @return
	 */
	List<ConverterJobFile> getListConverterJobFile(ConverterJobFile converterJobFile);

	/**
	 * converter job에 해당하는 f4d converter job 파일 목록
	 * @param converterJob
	 * @return converter job에 해당하는 f4d converter job 파일 목록
	 */
	List<ConverterJobFile> getListConverterJobFileByConverterJob(ConverterJob converterJob);

	/**
	 * insert converter job
	 * @param converterJob
	 * @return
	 */
	Long insertConverterJob(ConverterJob converterJob);

	/**
	 * insert converter job file
	 * @param converterJobFile
	 * @return
	 */
	Long insertConverterJobFile(ConverterJobFile converterJobFile);

	/**
	 * update converter job
	 * @param converterJob
	 * @return 갱신된 converter job 아이디
	 */
	int updateConverterJob(ConverterJob converterJob);

	/**
	 * update converter job file
	 * @param converterJobFile
	 * @return 갱신된 converter job file 아이디
	 */
	int updateConverterJobFile(ConverterJobFile converterJobFile);
}
