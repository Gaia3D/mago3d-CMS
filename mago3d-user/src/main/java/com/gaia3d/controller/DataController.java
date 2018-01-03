package com.gaia3d.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.Pagination;
import com.gaia3d.domain.UserSession;
import com.gaia3d.service.DataService;
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
public class DataController {
	
	@Autowired
	private DataService dataService;
	
	/**
	 * 프로젝트에 등록된 Data 목록
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-project-data-by-project-id.do")
	@ResponseBody
	public Map<String, Object> ajaxProjectDataByProjectId(HttpServletRequest request, @RequestParam("project_id") Long project_id) {
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {		
			String projectDataJson =  CacheManager.getProjectDataJson(project_id);
			jSONObject.put("projectDataJson", projectDataJson);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		jSONObject.put("result", result);
		return jSONObject;
	}
	
	/**
	 * 데이터 검색
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "ajax-search-data.do")
	@ResponseBody
	public Map<String, Object> ajaxSearchData(HttpServletRequest request, DataInfo dataInfo, @RequestParam(defaultValue="1") String pageNo) {
		
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			if(userSession == null) {
				dataInfo.setUser_id("guest");
				dataInfo.setUser_name("guest");
			} else {
				dataInfo.setUser_id(userSession.getUser_id());
				dataInfo.setUser_name(userSession.getUser_name());
			}
			
			log.info("@@ dataInfo = {}", dataInfo);
			if(StringUtil.isNotEmpty(dataInfo.getStart_date())) {
				dataInfo.setStart_date(dataInfo.getStart_date().substring(0, 8) + DateUtil.START_TIME);
			}
			if(StringUtil.isNotEmpty(dataInfo.getEnd_date())) {
				dataInfo.setEnd_date(dataInfo.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
			}
			
			long totalCount = dataService.getDataTotalCount(dataInfo);
			
			long pageRows = 10l;
			if(dataInfo.getList_counter() != null && dataInfo.getList_counter().longValue() > 0) pageRows = dataInfo.getList_counter().longValue();
			Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(dataInfo), totalCount, Long.valueOf(pageNo).longValue(), pageRows);
			log.info("@@ pagination = {}", pagination);
			
			dataInfo.setOffset(pagination.getOffset());
			dataInfo.setLimit(pagination.getPageRows());
			List<DataInfo> dataInfoList = new ArrayList<DataInfo>();
			if(totalCount > 0l) {
				dataInfoList = dataService.getListData(dataInfo);
			}
			
			jSONObject.put("dataInfoList", dataInfoList);
			jSONObject.put("totalCount", totalCount);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		jSONObject.put("result", result);
		return jSONObject;
	}
	
	/**
	 * 검색 조건
	 * @param dataInfo
	 * @return
	 */
	private String getSearchParameters(DataInfo dataInfo) {
		StringBuilder builder = new StringBuilder(100);
		builder.append("&");
		builder.append("search_word=" + StringUtil.getDefaultValue(dataInfo.getSearch_word()));
		builder.append("&");
		builder.append("search_option=" + StringUtil.getDefaultValue(dataInfo.getSearch_option()));
		builder.append("&");
		try {
			builder.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(dataInfo.getSearch_value()), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			builder.append("search_value=");
		}
		builder.append("&");
		builder.append("start_date=" + StringUtil.getDefaultValue(dataInfo.getStart_date()));
		builder.append("&");
		builder.append("end_date=" + StringUtil.getDefaultValue(dataInfo.getEnd_date()));
		builder.append("&");
		builder.append("order_word=" + StringUtil.getDefaultValue(dataInfo.getOrder_word()));
		builder.append("&");
		builder.append("order_value=" + StringUtil.getDefaultValue(dataInfo.getOrder_value()));
		return builder.toString();
	}
}