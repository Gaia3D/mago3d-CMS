package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.data.DataInfoLog;

/**
 * Data Info 변경 이력
 * @author jeongdae
 *
 */
@Repository
public interface DataLogMapper {

	/**
	 * 데이터 변경 요청 수
	 * @param dataInfoLog
	 * @return
	 */
	Long getDataInfoLogTotalCount(DataInfoLog dataInfoLog);
	
	/**
	 * 데이터 변경 요청 로그
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
	 * @param tableName
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	int createPartitionTable(String tableName, String startTime, String endTime);
	
	/**
	 * Data Info 변경 이력을 저장
	 * @param dataInfoLog
	 * @return
	 */
	int insertDataInfoLog(DataInfoLog dataInfoLog);
	
	/**
	 * 데이터 로그 상태 변경
	 * @param dataInfoLog
	 * @return
	 */
	int updateDataInfoLogStatus(DataInfoLog dataInfoLog);
}
