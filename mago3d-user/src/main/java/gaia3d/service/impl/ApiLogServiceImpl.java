package gaia3d.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.apilog.ApiLog;
import gaia3d.persistence.ApiLogMapper;
import gaia3d.service.ApiLogService;
import lombok.extern.slf4j.Slf4j;

/**
 * 로그 처리
 * @author hansang
 *
 */
@Slf4j
@Service
public class ApiLogServiceImpl implements ApiLogService {

	@Autowired
	private ApiLogMapper apiLogMapper;

	/**
	 * 모든 API 요청에 대한 이력
	 * @param apiLog
	 * @return
	 */
	@Transactional
	public int insertApiLog(ApiLog apiLog) {
		return apiLogMapper.insertApiLog(apiLog);
	}
}
