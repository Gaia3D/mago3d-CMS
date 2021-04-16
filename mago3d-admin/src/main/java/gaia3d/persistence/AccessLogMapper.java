package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.accesslog.AccessLog;


/**
 * 로그 처리
 * @author jeongdae
 *
 */
@Repository
public interface AccessLogMapper {
	
	/**
	 * 서비스 요청 이력 총 건수
	 * @param accessLog
	 * @return
	 */
	Long getAccessLogTotalCount(AccessLog accessLog);
	
	/**
	 * 서비스 요청 이력 목록
	 * @param accessLog
	 * @return
	 */
	List<AccessLog> getListAccessLog(AccessLog accessLog);
	
	/**
	 * 서비스 요청 이력 정보 취득
	 * @param accessLogId
	 * @return
	 */
	AccessLog getAccessLog(Long accessLogId);

	/**
	 * 서비스 요청 이력 등록
	 * @param accessLog
	 * @return
	 */
	int insertAccessLog(AccessLog accessLog);

	/**
	 * 스케줄러에 의한 다음년도 파티션 테이블 자동 생성
	 * @param tableName
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	int createPartitionTable(String tableName, String startTime, String endTime);
}
