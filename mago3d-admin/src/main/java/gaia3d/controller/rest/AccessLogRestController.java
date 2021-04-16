package gaia3d.controller.rest;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.domain.accesslog.AccessLog;
import gaia3d.domain.common.Pagination;
import gaia3d.service.AccessLogService;
import gaia3d.utils.DateUtils;
import gaia3d.utils.FormatUtils;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/access")
public class AccessLogRestController {
	
	@Autowired
	private AccessLogService accessLogService;
	
	/**
	 * 모든 서비스 요청에 대한 이력
	 * @param request
	 * @param accessLog
	 * @param pageNo
	 * @return
	 */
	@GetMapping(value = "/accesses")
	public Map<String, Object> listAccessLog(HttpServletRequest request, AccessLog accessLog, @RequestParam(defaultValue="1") String pageNo) {
		log.info("@@ accessLog = {}", accessLog);
		
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		List<AccessLog> accessLogList = new ArrayList<>();
		
		String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY);
		if(StringUtils.isEmpty(accessLog.getStartDate())) {
			accessLog.setStartDate(today.substring(0,4) + DateUtils.START_DAY_TIME);
		} else {
			accessLog.setStartDate(accessLog.getStartDate().substring(0, 8) + DateUtils.START_TIME);
		}
		if(StringUtils.isEmpty(accessLog.getEndDate())) {
			accessLog.setEndDate(today + DateUtils.END_TIME);
		} else {
			accessLog.setEndDate(accessLog.getEndDate().substring(0, 8) + DateUtils.END_TIME);
		}
		
		if(accessLog.getTotalCount() == null) accessLog.setTotalCount(0L);
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(accessLog), accessLog.getTotalCount(), Long.parseLong(pageNo));
		log.info("@@ pagination = {}", pagination);
		
		accessLog.setOffset(pagination.getOffset());
		accessLog.setLimit(pagination.getPageRows());
		if(accessLog.getTotalCount() > 0L) {
			accessLogList = accessLogService.getListAccessLog(accessLog);
		}
			
		int statusCode = HttpStatus.OK.value();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		result.put("accessLogList", accessLogList);
		return result;
	}
	
	/**
	 *  Access Log 상세
	 */
	@GetMapping(value = "/accesses/{accessLogId:[0-9]+}")
	public Map<String, Object>  detail(@PathVariable Long accessLogId) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		AccessLog accessLog = accessLogService.getAccessLog(accessLogId);
		int statusCode = HttpStatus.OK.value();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		result.put("accessLog", accessLog);
		return result;
	}
	
//	private String roleValidate(HttpServletRequest request) {
//    	UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
//		int httpStatusCode = getRoleStatusCode(userSession.getUserGroupId(), RoleKey.ADMIN_LAYER_MANAGE.name());
//		if(httpStatusCode > 200) {
//			log.info("@@ httpStatusCode = {}", httpStatusCode);
//			request.setAttribute("httpStatusCode", httpStatusCode);
//			return "/error/error";
//		}
//		
//		return null;
//    }
	
	/**
	 * 검색 조건
	 * @param accessLog
	 * @return
	 */
	private String getSearchParameters(AccessLog accessLog) {
		return accessLog.getParameters();
	}
}
