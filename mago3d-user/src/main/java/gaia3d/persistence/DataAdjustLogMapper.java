package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.data.DataAdjustLog;

/**
 * 데이터 geometry 변경 이력
 * @author jeongdae
 *
 */
@Repository
public interface DataAdjustLogMapper {

	/**
	 * 데이터 geometry 변경 요청 수
	 * @param dataInfo
	 * @return
	 */
	Long getDataAdjustLogTotalCount(DataAdjustLog dataInfoAdjustLog);
	
	/**
	 * 데이터 geometry 변경 요청 목록
	 * @param dataInfoAdjustLog
	 * @return
	 */
	List<DataAdjustLog> getListDataAdjustLog(DataAdjustLog dataInfoAdjustLog);
	
	/**
	 * 데이터 geometry 변경 이력 조회
	 * @param dataAdjustLogId
	 * @return
	 */
	DataAdjustLog getDataAdjustLog(Long dataAdjustLogId);
	
	/**
	 * 데이터 geometry 변경 이력 저장
	 * @param dataInfoAdjustLog
	 * @return
	 */
	int insertDataAdjustLog(DataAdjustLog dataInfoAdjustLog);	
}
