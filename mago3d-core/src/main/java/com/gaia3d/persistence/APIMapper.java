package com.gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gaia3d.domain.APILog;


/**
 * API
 * @author jeongdae
 *
 */
@Repository
public interface APIMapper {
	
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
