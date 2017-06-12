package com.gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gaia3d.domain.APILog;
import com.gaia3d.domain.ExternalService;


/**
 * API
 * @author jeongdae
 *
 */
@Repository
public interface APIMapper {
	
	/**
	 * external_service_id 최대값
	 * @return
	 */
	Long getMaxExternalServiceId();
	
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
	 * Private API 목록
	 * @param externalService
	 * @return
	 */
	List<ExternalService> getListExternalService(ExternalService externalService);
	
	/**
	 * 제휴 서비스 정보
	 * @param external_service_id
	 * @return
	 */
	ExternalService getExternalService(Long external_service_id);

	/**
	 * API 호출 정보 등록
	 * @param aPILog
	 * @return
	 */
	int insertAPILog(APILog aPILog);
	
	/**
	 * 제휴 서비스 등록
	 * @param externalService
	 * @return
	 */
	int insertExternalService(ExternalService externalService);
	
	/**
	 * 제휴 서비스 수정
	 * @param externalService
	 * @return
	 */
	int updateExternalService(ExternalService externalService);
}
