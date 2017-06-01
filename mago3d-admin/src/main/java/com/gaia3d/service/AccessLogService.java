package com.gaia3d.service;

import java.util.List;

import com.gaia3d.domain.AccessLog;

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
	 * @param access_log_id
	 * @return
	 */
	AccessLog getAccessLog(Long access_log_id);

	/**
	 * 모든 서비스 요청에 대한 이력
	 * @param accessLog
	 * @return
	 */
	public int insertAccessLog(AccessLog accessLog);
}
