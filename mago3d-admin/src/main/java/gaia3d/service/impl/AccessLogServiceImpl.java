package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.AccessLog;
import gaia3d.persistence.AccessLogMapper;
import gaia3d.service.AccessLogService;

/**
 * 로그 처리
 * @author jeongdae
 *
 */
@Service
public class AccessLogServiceImpl implements AccessLogService {

	@Autowired
	private AccessLogMapper accessLogMapper;

	/**
	 * 서비스 요청 이력 총 건수
	 * @param accessLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getAccessLogTotalCount(AccessLog accessLog) {
		return accessLogMapper.getAccessLogTotalCount(accessLog);
	}
	
	/**
	 * 서비스 요청 이력 목록
	 * @param accessLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<AccessLog> getListAccessLog(AccessLog accessLog) {
		return accessLogMapper.getListAccessLog(accessLog);
	}
	
	/**
	 * 서비스 요청 이력 정보 취득
	 * @param accessLogId
	 * @return
	 */
	@Transactional(readOnly=true)
	public AccessLog getAccessLog(Long accessLogId) {
		return accessLogMapper.getAccessLog(accessLogId);
	}
	
	/**
	 * 모든 서비스 요청에 대한 이력
	 * @param accessLog
	 * @return
	 */
	@Transactional
	public int insertAccessLog(AccessLog accessLog) {
		return accessLogMapper.insertAccessLog(accessLog);
	}
}
