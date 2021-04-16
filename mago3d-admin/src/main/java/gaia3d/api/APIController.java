package gaia3d.api;

import gaia3d.domain.api.APIHeader;

public interface APIController {
	
	default void insertLog() {
		// TODO 귀찮아.
	}
	
//	default void insertLog(APILogService aPILogService, String requestIp, String userId, String url, Integer serverId, String serverName, Integer statusCode, String message) {
//		try {
//			APILog aPILog = new APILog();
//			aPILog.setServerId(serverId);
//			aPILog.setServerName(serverName);
//			aPILog.setRequestIp(requestIp);
//			aPILog.setUserId(userId);
//			aPILog.setUrl(url);
//			aPILog.setStatusCode(statusCode);
//			aPILog.setMessage(message);
//			
//			aPILogService.insertAPILog(aPILog);
//		} catch(Exception ex) {
//			//log.error("@@@@@@@@ API 이력 저장 중 오류가 발생했지만... 무시");
//		}
//	}

	/**
	 * 검증
	 * @return
	 */
	default String validate(APIHeader aPIHeader) {
		// TODO 확장 때문에 남겨둠
		return null;
	}
	
	/**
	 * header 복호화
	 * @return
	 */
	default APIHeader getHeader() {
		// TODO 확장 때문에 남겨둠
		return null;
	}
}
