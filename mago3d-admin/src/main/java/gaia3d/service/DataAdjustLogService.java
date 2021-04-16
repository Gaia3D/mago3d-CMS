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
	 * @param dataAdjustLog
	 * @return
	 */
	Long getDataAdjustLogTotalCount(DataAdjustLog dataAdjustLog);
	
	/**
	 * 데이터 geometry 변경 요청 목록
	 * @param dataAdjustLog
	 * @return
	 */
	List<DataAdjustLog> getListDataAdjustLog(DataAdjustLog dataAdjustLog);
	
	/**
	 * 데이터 geometry 변경 이력 조회
	 * @param dataAdjustLogId
	 * @return
	 */
	DataAdjustLog getDataAdjustLog(Long dataAdjustLogId);

	/**
	 * 최근 데이터 geometry 변경 요청 목록
	 * @return
	 */
	List<DataAdjustLog> getListRecentDataAdjustLog();

	/**
	 * 스케줄러에 의한 다음년도 파티션 테이블 자동 생성
	 */
	public int createPartitionTable(String tableName, String startTime, String endTime);
	
	/**
	 * 데이터 geometry 변경 요청 상태 변경
	 * @param dataAdjustLog
	 * @return
	 */
	int updateDataAdjustLogStatus(DataAdjustLog dataAdjustLog);
}
