package gaia3d.service;

import java.util.List;

import gaia3d.domain.accesslog.AccessLog;

/**
 * 로그 처리
 * @author jeongdae
 *
 */
public interface AccessLogService {
	
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
	 * 모든 서비스 요청에 대한 이력
	 * @param accessLog
	 * @return
	 */
	public int insertAccessLog(AccessLog accessLog);

	/**
	 * 스케줄러에 의한 다음년도 파티션 테이블 자동 생성
	 */
	public int createPartitionTable(String tableName, String startTime, String endTime);
}
