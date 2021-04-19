package gaia3d.api;

import gaia3d.domain.api.APIHeader;
import gaia3d.domain.apilog.ApiLog;
import gaia3d.service.ApiLogService;

public interface APIController {
	
	default void insertLog() {
		// TODO 귀찮아.
	}
	
    default void insertLog(ApiLogService apiLogService, String requestIp, String url, Integer statusCode, String message) {
        try {
            apiLogService.insertApiLog(ApiLog.builder()
                    .clientIp(requestIp)
                    .requestUri(url)
                    .statusCode(statusCode)
                    .resultMessage(message)
                    .build());
        } catch (Exception ex) {
            //log.error("@@@@@@@@ API 이력 저장 중 오류가 발생했지만... 무시");
        }
    }

	/**
	 * 검증
     *
	 * @return
	 */
	default String validate(APIHeader aPIHeader) {
		// TODO 확장 때문에 남겨둠
		return null;
	}
	
	/**
	 * header 복호화
     *
	 * @return
	 */
	default APIHeader getHeader() {
		// TODO 확장 때문에 남겨둠
		return null;
	}
}
