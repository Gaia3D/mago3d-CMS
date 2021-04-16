package gaia3d.service;

import java.util.List;

import gaia3d.domain.data.DataInfoLog;

/**
 * Data 변경 이력 관리
 * @author jeongdae
 *
 */
public interface DataLogService {
	
	/**
	 * 데이터 변경 요청 총건 수
	 * @param dataInfoLog
	 * @return
	 */
	Long getDataInfoLogTotalCount(DataInfoLog dataInfoLog);
	
	/**
	 * 데이터 변경 요청 이력 목록
	 * @param dataInfoLog
	 * @return
	 */
	List<DataInfoLog> getListDataInfoLog(DataInfoLog dataInfoLog);
	
	/**
	 * data info log 조회
	 * @param dataInfoLogId
	 * @return
	 */
	DataInfoLog getDataInfoLog(Long dataInfoLogId);

	/**
	 * 스케줄러에 의한 다음년도 파티션 테이블 자동 생성
	 */
	public int createPartitionTable(String tableName, String startTime, String endTime);
	
	/**
	 * 데이터 변경 이력 등록
	 * @param dataInfoLog
	 * @return
	 */
	int insertDataInfoLog(DataInfoLog dataInfoLog);
}
