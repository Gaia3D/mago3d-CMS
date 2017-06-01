package com.gaia3d.service;

import java.util.List;

import com.gaia3d.domain.APILog;

/**
 * API 이력
 * @author jeongdae
 *
 */
public interface APIService {
	
	/**
	 * API 호출 총 건수
	 * @param aPILog
	 * @return
	 */
	Long getAPILogTotalCount(APILog aPILog);
	
	/**
	 * API 호출 목록
	 * @param aPILog
	 * @return
	 */
	List<APILog> getListAPILog(APILog aPILog);
	
	/**
	 * API 호출 정보
	 * @param api_log_id
	 * @return
	 */
	APILog getAPILog(Long api_log_id);
	
	/**
	 * API 호출 정보 등록
	 * @param aPILog
	 * @return
	 */
	int insertAPILog(APILog aPILog);
}
