package com.gaia3d.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.domain.AccessLog;
import com.gaia3d.domain.Pagination;
import com.gaia3d.service.AccessLogService;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.FormatUtil;
import com.gaia3d.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * 이력
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/access/")
public class AccessLogController {
	
	@Autowired
	private AccessLogService accessLogService;
	
	/**
	 * 모든 서비스 요청에 대한 이력
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list-access-log.do")
	public String listAccessLog(HttpServletRequest request, AccessLog accessLog, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		log.info("@@ accessLog = {}", accessLog);
		
		String today = DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY);
		if(StringUtil.isEmpty(accessLog.getStart_date())) {
			accessLog.setStart_date(today.substring(0,4) + DateUtil.START_DAY_TIME);
		} else {
			accessLog.setStart_date(accessLog.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isEmpty(accessLog.getEnd_date())) {
			accessLog.setEnd_date(today + DateUtil.END_TIME);
		} else {
			accessLog.setEnd_date(accessLog.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}
		
		long totalCount = accessLogService.getAccessLogTotalCount(accessLog);
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(accessLog), totalCount, Long.valueOf(pageNo).longValue());
		log.info("@@ pagination = {}", pagination);
		
		accessLog.setOffset(pagination.getOffset());
		accessLog.setLimit(pagination.getPageRows());
		List<AccessLog> accessLogList = new ArrayList<>();
		if(totalCount > 0l) {
			//accessLogList = logService.getListAccessLog(accessLog);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("accessLogList", accessLogList);
		return "/access/list-access-log";
	}
	
	/**
	 * 모든 서비스 요청에 대한 이력
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "ajax-list-access-log.do")
	@ResponseBody
	public Map<String, Object> ajaxListAccessLog(HttpServletRequest request, AccessLog accessLog, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		log.info("@@ accessLog = {}", accessLog);
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		List<AccessLog> accessLogList = new ArrayList<AccessLog>();
		try {
			String today = DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY);
			if(StringUtil.isEmpty(accessLog.getStart_date())) {
				accessLog.setStart_date(today.substring(0,4) + DateUtil.START_DAY_TIME);
			} else {
				accessLog.setStart_date(accessLog.getStart_date().substring(0, 8) + DateUtil.START_TIME);
			}
			if(StringUtil.isEmpty(accessLog.getEnd_date())) {
				accessLog.setEnd_date(today + DateUtil.END_TIME);
			} else {
				accessLog.setEnd_date(accessLog.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
			}
			
			if(accessLog.getTotalCount() == null) accessLog.setTotalCount(0l);
			Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(accessLog), accessLog.getTotalCount().longValue(), Long.valueOf(pageNo).longValue());
			log.info("@@ pagination = {}", pagination);
			
			accessLog.setOffset(pagination.getOffset());
			accessLog.setLimit(pagination.getPageRows());
			if(accessLog.getTotalCount().longValue() > 0l) {
				accessLogList = accessLogService.getListAccessLog(accessLog);
			}
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		map.put("accessLogList", accessLogList);
		
		return map;
	}
	
	/**
	 * 접속 이력 정보
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-access-log.do")
	@ResponseBody
	public Map<String, Object> ajaxUserGroupInfo(HttpServletRequest request, @RequestParam("access_log_id") Long access_log_id) {
		
		log.info("@@@@@@@ access_log_id = {}", access_log_id);
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		AccessLog accessLog = null;
		try {	
			accessLog = accessLogService.getAccessLog(access_log_id);
			log.info("@@@@@@@ accessLog = {}", accessLog);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		map.put("result", result);
		map.put("accessLog", accessLog);
		
		return map;
	}
	
	private String getSearchParameters(AccessLog accessLog) {
		StringBuffer buffer = new StringBuffer();
		buffer.append("&");
		buffer.append("search_word=" + StringUtil.getDefaultValue(accessLog.getSearch_word()));
		buffer.append("&");
		buffer.append("search_option=" + StringUtil.getDefaultValue(accessLog.getSearch_option()));
		buffer.append("&");
		try {
			buffer.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(accessLog.getSearch_value()), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			buffer.append("search_value=");
		}
		buffer.append("&");
		buffer.append("start_date=" + StringUtil.getDefaultValue(accessLog.getStart_date()));
		buffer.append("&");
		buffer.append("end_date=" + StringUtil.getDefaultValue(accessLog.getEnd_date()));
		buffer.append("&");
		buffer.append("order_word=" + StringUtil.getDefaultValue(accessLog.getOrder_word()));
		buffer.append("&");
		buffer.append("order_value=" + StringUtil.getDefaultValue(accessLog.getOrder_value()));
		return buffer.toString();
	}
}
