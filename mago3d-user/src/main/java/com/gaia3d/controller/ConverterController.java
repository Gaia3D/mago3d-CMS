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

import com.gaia3d.config.PropertiesConfig;
import com.gaia3d.domain.ConverterJob;
import com.gaia3d.domain.ConverterLog;
import com.gaia3d.domain.Pagination;
import com.gaia3d.domain.UserSession;
import com.gaia3d.service.ConverterService;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.StringUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * Data Converter
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/converter/")
public class ConverterController {
	
	@Autowired
	private PropertiesConfig propertiesConfig;
	@Autowired
	private ConverterService converterService;
	
	/**
	 * 이슈 목록
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "ajax-insert-converter-job.do")
	@ResponseBody
	public Map<String, Object> ajaxInsertConverterJob(HttpServletRequest request, ConverterJob converterJob, @RequestParam("check_ids") String check_ids) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			if(check_ids.length() <= 0) {
				map.put("result", "check.value.required");
				return map;
			}
			if(converterJob.getTitle() == null || converterJob.getTitle().isEmpty()) {
				map.put("result", "input.invalid");
				return map;
			}
			
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			converterJob.setUser_id(userSession.getUser_id());
			
			converterService.insertConverterJob(check_ids, converterJob);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
	
	/**
	 * f4d converter job 목록
	 * @param request
	 * @param converterLog
	 * @param pageNo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list-converter-job.do")
	public String listConverterJob(HttpServletRequest request, ConverterJob converterJob, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
		converterJob.setUser_id(userSession.getUser_id());
		
		log.info("@@ converterJob = {}", converterJob);
		if(StringUtil.isNotEmpty(converterJob.getStart_date())) {
			converterJob.setStart_date(converterJob.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isNotEmpty(converterJob.getEnd_date())) {
			converterJob.setEnd_date(converterJob.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}
		long totalCount = converterService.getListConverterJobTotalCount(converterJob);
		
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(converterJob), totalCount, Long.valueOf(pageNo).longValue());
		log.info("@@ pagination = {}", pagination);
		
		converterJob.setOffset(pagination.getOffset());
		converterJob.setLimit(pagination.getPageRows());
		List<ConverterJob> converterJobList = new ArrayList<>();
		if(totalCount > 0l) {
			converterJobList = converterService.getListConverterJob(converterJob);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("converterJobList", converterJobList);
		return "/converter/list-converter-job";
	}
	
	/**
	 * 각 파일별 f4d converter log 목록
	 * @param request
	 * @param converterLog
	 * @param pageNo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list-converter-log.do")
	public String listConverterLog(HttpServletRequest request, ConverterLog converterLog, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
		converterLog.setUser_id(userSession.getUser_id());
		
		log.info("@@ converterLog = {}", converterLog);
		if(StringUtil.isNotEmpty(converterLog.getStart_date())) {
			converterLog.setStart_date(converterLog.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isNotEmpty(converterLog.getEnd_date())) {
			converterLog.setEnd_date(converterLog.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}
		long totalCount = converterService.getListConverterLogTotalCount(converterLog);
		
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(converterLog), totalCount, Long.valueOf(pageNo).longValue());
		log.info("@@ pagination = {}", pagination);
		
		converterLog.setOffset(pagination.getOffset());
		converterLog.setLimit(pagination.getPageRows());
		List<ConverterLog> converterLogList = new ArrayList<>();
		if(totalCount > 0l) {
			converterLogList = converterService.getListConverterLog(converterLog);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("converterLogList", converterLogList);
		return "/converter/list-converter-log";
	}
	
	/**
	 * 검색 조건
	 * @param dataInfo
	 * @return
	 */
	private String getSearchParameters(ConverterJob converterJob) {
		StringBuilder builder = new StringBuilder(100);
		builder.append("&");
		builder.append("search_word=" + StringUtil.getDefaultValue(converterJob.getSearch_word()));
		builder.append("&");
		builder.append("search_option=" + StringUtil.getDefaultValue(converterJob.getSearch_option()));
		builder.append("&");
		try {
			builder.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(converterJob.getSearch_value()), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			builder.append("search_value=");
		}
		builder.append("&");
		builder.append("start_date=" + StringUtil.getDefaultValue(converterJob.getStart_date()));
		builder.append("&");
		builder.append("end_date=" + StringUtil.getDefaultValue(converterJob.getEnd_date()));
		builder.append("&");
		builder.append("order_word=" + StringUtil.getDefaultValue(converterJob.getOrder_word()));
		builder.append("&");
		builder.append("order_value=" + StringUtil.getDefaultValue(converterJob.getOrder_value()));
		return builder.toString();
	}
	
	/**
	 * 검색 조건
	 * @param dataInfo
	 * @return
	 */
	private String getSearchParameters(ConverterLog converterLog) {
		StringBuilder builder = new StringBuilder(100);
		builder.append("&");
		builder.append("search_word=" + StringUtil.getDefaultValue(converterLog.getSearch_word()));
		builder.append("&");
		builder.append("search_option=" + StringUtil.getDefaultValue(converterLog.getSearch_option()));
		builder.append("&");
		try {
			builder.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(converterLog.getSearch_value()), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			builder.append("search_value=");
		}
		builder.append("&");
		builder.append("start_date=" + StringUtil.getDefaultValue(converterLog.getStart_date()));
		builder.append("&");
		builder.append("end_date=" + StringUtil.getDefaultValue(converterLog.getEnd_date()));
		builder.append("&");
		builder.append("order_word=" + StringUtil.getDefaultValue(converterLog.getOrder_word()));
		builder.append("&");
		builder.append("order_value=" + StringUtil.getDefaultValue(converterLog.getOrder_value()));
		return builder.toString();
	}
}