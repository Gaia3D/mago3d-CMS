package com.gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gaia3d.domain.AccessLog;


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
	 * @param access_log_id
	 * @return
	 */
	AccessLog getAccessLog(Long access_log_id);

	/**
	 * 서비스 요청 이력 등록
	 * @param accessLog
	 * @return
	 */
	public int insertAccessLog(AccessLog accessLog);
}
