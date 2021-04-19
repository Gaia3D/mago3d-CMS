package gaia3d.service;

import java.util.List;

import gaia3d.domain.data.DataAdjustLog;

/**
 * 데이터 geometry 변경 이력 관리
 * @author jeongdae
 *
 */
public interface DataAdjustLogService {
	
	/**
	 * 데이터 geometry 변경 요청 수
	 * @param dataInfoAdjustLog
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
