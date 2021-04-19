package gaia3d.service;

import gaia3d.domain.apilog.ApiLog;

/**
 * 로그 처리
 *
 * @author hansang
 */
public interface ApiLogService {

    /**
     * 모든 API 요청에 대한 이력
     *
     * @param apiLog
     * @return
     */
    int insertApiLog(ApiLog apiLog);
}
