package gaia3d.persistence;

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
	 * 서비스 요청 이력 등록
	 * @param accessLog
	 * @return
	 */
	public int insertAccessLog(AccessLog accessLog);
}
