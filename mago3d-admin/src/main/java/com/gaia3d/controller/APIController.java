package com.gaia3d.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.domain.APILog;
import com.gaia3d.domain.ExternalService;
import com.gaia3d.domain.Pagination;
import com.gaia3d.security.Crypt;
import com.gaia3d.service.APIService;
import com.gaia3d.service.RoleService;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.FormatUtil;
import com.gaia3d.util.StringUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * API
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/api/")
public class APIController {
	
	@Autowired
	private MessageSource messageSource;
	
	@Autowired
	private APIService aPIService;
	@Autowired
	private RoleService roleService;
	
	/**
	 * API 호출 목록
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list-api-log.do")
	public String listAPILog(HttpServletRequest request, APILog aPILog, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		log.info("@@ aPILog = {}", aPILog);
		
		String today = DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY);
		if(StringUtil.isEmpty(aPILog.getStart_date())) {
			aPILog.setStart_date(today.substring(0,4) + DateUtil.START_DAY_TIME);
		} else {
			aPILog.setStart_date(aPILog.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isEmpty(aPILog.getEnd_date())) {
			aPILog.setEnd_date(today + DateUtil.END_TIME);
		} else {
			aPILog.setEnd_date(aPILog.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}
		
		long totalCount = aPIService.getAPILogTotalCount(aPILog);
		
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(aPILog), totalCount, Long.valueOf(pageNo).longValue());
		log.info("@@ pagination = {}", pagination);
		
		aPILog.setOffset(pagination.getOffset());
		aPILog.setLimit(pagination.getPageRows());
		List<APILog> aPILogList = new ArrayList<>();
		if(totalCount > 0l) {
			//aPILogList = aPIService.getListAPILog(aPILog);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("aPILog", aPILog);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("aPILogList",aPILogList);
		return "/api/list-api-log";
	}
	
	/**
	 * Ajax API 호출 목록
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "ajax-list-api-log.do")
	@ResponseBody
	public Map<String, Object> ajaxListApiLog(HttpServletRequest request, APILog aPILog, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		log.info("@@ aPILog = {}", aPILog);
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		List<APILog> aPILogList = new ArrayList<>();
		try {
			String today = DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY);
			if(StringUtil.isEmpty(aPILog.getStart_date())) {
				aPILog.setStart_date(today.substring(0,4) + DateUtil.START_DAY_TIME);
			} else {
				aPILog.setStart_date(aPILog.getStart_date().substring(0, 8) + DateUtil.START_TIME);
			}
			if(StringUtil.isEmpty(aPILog.getEnd_date())) {
				aPILog.setEnd_date(today + DateUtil.END_TIME);
			} else {
				aPILog.setEnd_date(aPILog.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
			}
			
			if(aPILog.getTotalCount() == null) aPILog.setTotalCount(0l);
			Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(aPILog), aPILog.getTotalCount().longValue(), Long.valueOf(pageNo).longValue());
			log.info("@@ pagination = {}", pagination);
			
			aPILog.setOffset(pagination.getOffset());
			aPILog.setLimit(pagination.getPageRows());
			if(aPILog.getTotalCount().longValue() > 0l) {
				aPILogList = aPIService.getListAPILog(aPILog);
			}
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		map.put("aPILogList", aPILogList);
		
		return map;
	}
	
	/**
	 * api 이력 상세 정보
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-api-log.do")
	@ResponseBody
	public Map<String, Object> ajaxUserGroupInfo(HttpServletRequest request, @RequestParam("api_log_id") Long api_log_id) {
		
		log.info("@@@@@@@ api_log_id = {}", api_log_id);
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		APILog aPILog = null;
		try {	
			aPILog = aPIService.getAPILog(api_log_id);
			log.info("@@@@@@@ aPILog = {}", aPILog);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		map.put("result", result);
		map.put("aPILog", aPILog);
		
		return map;
	}
	
	/**
	 * API 사용 가이드
	 * @param model
	 * @return
	 */
	@GetMapping(value = "api-guide.do")
	public String aPIGuide(Model model) {
		return "/api/api-guide";
	}
	
	/**
	 * Private API 목록
	 * @param model
	 * @return
	 */
	@GetMapping(value = "list-external-service.do")
	public String listExternalService(HttpServletRequest request, ExternalService externalService, Model model) {
		
		log.info("@@ externalService = {}", externalService);
		
		List<ExternalService> externalServiceList = aPIService.getListExternalService(externalService);
		long totalCount = externalServiceList.size();
		
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("externalServiceList", externalServiceList);
		return "/api/list-external-service";
	}
	
	/**
	 * Private API 수정 화면
	 * @param user_id
	 * @param model
	 * @return
	 */
	@GetMapping(value = "modify-external-service.do")
	public String modifyExternalService(@RequestParam("external_service_id") String external_service_id, Model model) {
		
		ExternalService externalService = aPIService.getExternalService(Long.valueOf(external_service_id));
		externalService.setApi_key(Crypt.decrypt(externalService.getApi_key()));

//		Server server = new Server();
//		List<Server> serverList = serverService.getListServer(server);
		
		model.addAttribute(externalService);
//		model.addAttribute("serverList", serverList);
		
		return "/api/modify-external-service";
	}
	
	/**
	 * Private API 수정
	 * @param request
	 * @param userInfo
	 * @return
	 */
	@PostMapping(value = "ajax-update-external-service.do")
	@ResponseBody
	public Map<String, Object> ajaxUpdateExternalService(HttpServletRequest request, ExternalService externalService) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			externalService.setMethod_mode("update");
			String errorcode = externalService.validate();
			if(errorcode != null) {
				result = errorcode;
				map.put("result", result);
				return map;
			}
						
			externalService.setApi_key(Crypt.encrypt(externalService.getApi_key()));
			aPIService.updateExternalService(externalService);
			
//			configCacheController.reloadExternalServiceCache();
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		
		return map;
	}
	
	private String getSearchParameters(APILog aPILog) {
		StringBuilder builder = new StringBuilder(100);
		builder.append("&");
		builder.append("search_word=" + StringUtil.getDefaultValue(aPILog.getSearch_word()));
		builder.append("&");
		builder.append("search_option=" + StringUtil.getDefaultValue(aPILog.getSearch_option()));
		builder.append("&");
		try {
			builder.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(aPILog.getSearch_value()), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			builder.append("search_value=");
		}
		builder.append("&");
		builder.append("success_yn=" + StringUtil.getDefaultValue(aPILog.getSuccess_yn()));
		builder.append("&");
		builder.append("start_date=" + StringUtil.getDefaultValue(aPILog.getStart_date()));
		builder.append("&");
		builder.append("end_date=" + StringUtil.getDefaultValue(aPILog.getEnd_date()));
		builder.append("&");
		builder.append("order_word=" + StringUtil.getDefaultValue(aPILog.getOrder_word()));
		builder.append("&");
		builder.append("order_value=" + StringUtil.getDefaultValue(aPILog.getOrder_value()));
		return builder.toString();
	}
}
