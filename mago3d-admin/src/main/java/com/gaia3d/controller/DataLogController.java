package com.gaia3d.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.config.CacheConfig;
import com.gaia3d.domain.CacheName;
import com.gaia3d.domain.CacheParams;
import com.gaia3d.domain.CacheType;
import com.gaia3d.domain.DataInfoLog;
import com.gaia3d.domain.Pagination;
import com.gaia3d.domain.Project;
import com.gaia3d.service.DataLogService;
import com.gaia3d.service.ProjectService;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.StringUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * Data
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/data/")
public class DataLogController {
	
	@Autowired
	private CacheConfig cacheConfig;
	
	@Autowired
	private ProjectService projectService;
	@Autowired
	private DataLogService dataLogService;
	
	/**
	 * Data 목록
	 * @param request
	 * @param dataInfo
	 * @param pageNo
	 * @param list_counter
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list-data-log.do")
	public String listDataLog(Locale locale, HttpServletRequest request, DataInfoLog dataInfoLog, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		log.info("@@ dataInfoLog = {}", dataInfoLog);
		Project project = new Project();
		project.setUse_yn(Project.IN_USE);
		List<Project> projectList = projectService.getListProject(project);
		if(dataInfoLog.getProject_id() == null) {
			dataInfoLog.setProject_id(Long.valueOf(0l));
		}
		if(StringUtil.isNotEmpty(dataInfoLog.getStart_date())) {
			dataInfoLog.setStart_date(dataInfoLog.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isNotEmpty(dataInfoLog.getEnd_date())) {
			dataInfoLog.setEnd_date(dataInfoLog.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}

		long totalCount = dataLogService.getDataInfoLogTotalCount(dataInfoLog);
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(dataInfoLog), totalCount, Long.valueOf(pageNo).longValue(), dataInfoLog.getList_counter());
		log.info("@@ pagination = {}", pagination);
		
		dataInfoLog.setOffset(pagination.getOffset());
		dataInfoLog.setLimit(pagination.getPageRows());
		List<DataInfoLog> dataInfoLogList = new ArrayList<>();
		if(totalCount > 0l) {
			dataInfoLogList = dataLogService.getListDataInfoLog(dataInfoLog);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("projectList", projectList);
		model.addAttribute("dataInfoLogList", dataInfoLogList);
		return "/data/list-data-log";
	}
	
	/**
	 * Data Info Log 상태 수정
	 * @param request
	 * @param dataInfo
	 * @return
	 */
	@PostMapping(value = "ajax-update-data-log-status.do")
	@ResponseBody
	public Map<String, Object> ajaxUpdateDataInfoLogStatus(HttpServletRequest request, DataInfoLog dataInfoLog) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		
		log.info("@@ dataInfoLog = {}", dataInfoLog);
		try {
			dataInfoLog.setMethod_mode("update");
			String errorcode = dataInfoLog.validate();
			if(errorcode != null) {
				result = errorcode;
				map.put("result", result);
				return map;
			}
			
			if(DataInfoLog.STATUS_LEVEL_CONFIRM.equals(dataInfoLog.getStatus_level())) {
				dataInfoLog.setStatus(DataInfoLog.STATUS_COMPLETE);
			} else if(DataInfoLog.STATUS_LEVEL_REJECT.equals(dataInfoLog.getStatus_level())) {
				dataInfoLog.setStatus(DataInfoLog.STATUS_REJECT);
			} else if(DataInfoLog.STATUS_LEVEL_RESET.equals(dataInfoLog.getStatus_level())) {
				dataInfoLog.setStatus(DataInfoLog.STATUS_RESET);
			}
			
			dataLogService.updateDataInfoLogStatus(dataInfoLog);
			
			if(DataInfoLog.STATUS_LEVEL_CONFIRM.equals(dataInfoLog.getStatus_level())
					|| DataInfoLog.STATUS_LEVEL_RESET.equals(dataInfoLog.getStatus_level())) {
				CacheParams cacheParams = new CacheParams();
				cacheParams.setCacheName(CacheName.DATA_INFO);
				cacheParams.setCacheType(CacheType.BROADCAST);
				cacheParams.setProject_id(dataInfoLog.getProject_id());
				cacheConfig.loadCache(cacheParams);
			}
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
		
	/**
	 * 검색 조건
	 * @param dataInfo
	 * @return
	 */
	private String getSearchParameters(DataInfoLog dataInfoLog) {
		// TODO 아래 메소드랑 통합
		StringBuffer buffer = new StringBuffer();
		buffer.append("&");
		buffer.append("search_word=" + StringUtil.getDefaultValue(dataInfoLog.getSearch_word()));
		buffer.append("&");
		buffer.append("search_option=" + StringUtil.getDefaultValue(dataInfoLog.getSearch_option()));
		buffer.append("&");
		try {
			buffer.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(dataInfoLog.getSearch_value()), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			buffer.append("search_value=");
		}
		buffer.append("&");
		buffer.append("project_id=" + dataInfoLog.getProject_id());
		buffer.append("&");
		buffer.append("status=" + StringUtil.getDefaultValue(dataInfoLog.getStatus()));
		buffer.append("&");
		buffer.append("start_date=" + StringUtil.getDefaultValue(dataInfoLog.getStart_date()));
		buffer.append("&");
		buffer.append("end_date=" + StringUtil.getDefaultValue(dataInfoLog.getEnd_date()));
		buffer.append("&");
		buffer.append("order_word=" + StringUtil.getDefaultValue(dataInfoLog.getOrder_word()));
		buffer.append("&");
		buffer.append("order_value=" + StringUtil.getDefaultValue(dataInfoLog.getOrder_value()));
		buffer.append("&");
		buffer.append("list_count=" + dataInfoLog.getList_counter());
		return buffer.toString();
	}
	
	/**
	 * 목록 페이지 이동 검색 조건
	 * @param request
	 * @return
	 */
	private String getListParameters(HttpServletRequest request) {
		StringBuffer buffer = new StringBuffer();
		String pageNo = request.getParameter("pageNo");
		buffer.append("pageNo=" + pageNo);
		buffer.append("&");
		buffer.append("search_word=" + StringUtil.getDefaultValue(request.getParameter("search_word")));
		buffer.append("&");
		buffer.append("search_option=" + StringUtil.getDefaultValue(request.getParameter("search_option")));
		buffer.append("&");
		try {
			buffer.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(request.getParameter("search_value")), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			buffer.append("search_value=");
		}
		buffer.append("&");
		buffer.append("project_id=" + request.getParameter("project_id"));
		buffer.append("&");
		buffer.append("status=" + StringUtil.getDefaultValue(request.getParameter("status")));
		buffer.append("&");
		buffer.append("start_date=" + StringUtil.getDefaultValue(request.getParameter("start_date")));
		buffer.append("&");
		buffer.append("end_date=" + StringUtil.getDefaultValue(request.getParameter("end_date")));
		buffer.append("&");
		buffer.append("order_word=" + StringUtil.getDefaultValue(request.getParameter("order_word")));
		buffer.append("&");
		buffer.append("order_value=" + StringUtil.getDefaultValue(request.getParameter("order_value")));
		buffer.append("&");
		buffer.append("list_count=" + StringUtil.getDefaultValue(request.getParameter("list_count")));
		return buffer.toString();
	}
}