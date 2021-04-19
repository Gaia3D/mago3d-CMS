package gaia3d.persistence;

import org.springframework.stereotype.Repository;

import gaia3d.domain.apilog.ApiLog;


/**
 * 로그 처리
 * @author jeongdae
 *
 */
@Repository
public interface ApiLogMapper {
	
	/**
	 * API 요청 이력 등록
	 * @param apiLog
	 * @return
	 */
	int insertApiLog(ApiLog apiLog);
}
