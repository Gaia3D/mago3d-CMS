package gaia3d.controller.view;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import gaia3d.domain.accesslog.AccessLog;
import gaia3d.domain.common.Pagination;
import gaia3d.service.AccessLogService;
import gaia3d.utils.DateUtils;
import gaia3d.utils.FormatUtils;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/access")
@Controller
public class AccessLogController {
	
	@Autowired
	private AccessLogService accessLogService;
	
	/**
	 * Access Log 목록
	 */
	@GetMapping(value = "/list")
	public String list(HttpServletRequest request, @RequestParam(defaultValue="1") String pageNo, AccessLog accessLog, Model model) {
		log.info("@@ accessLog = {}", accessLog);
		
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
		
		Long totalCount = accessLogService.getAccessLogTotalCount(accessLog);
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(accessLog), totalCount, Long.parseLong(pageNo));
		log.info("@@ pagination = {}", pagination);
		
		accessLog.setOffset(pagination.getOffset());
		accessLog.setLimit(pagination.getPageRows());
		List<AccessLog> accessLogList = new ArrayList<>();
		if(totalCount > 0l) {
			//accessLogList = logService.getListAccessLog(accessLog);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("accessLog", accessLog);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("accessLogList", accessLogList);
		
		return "/access/list";
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
	 * @param search
	 * @return
	 */
	private String getSearchParameters(AccessLog accessLog) {
		return accessLog.getParameters();
	}
}
