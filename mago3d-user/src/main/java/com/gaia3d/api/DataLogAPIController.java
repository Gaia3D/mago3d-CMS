package com.gaia3d.api;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.gaia3d.domain.DataInfoLog;
import com.gaia3d.domain.Pagination;
import com.gaia3d.domain.UserSession;
import com.gaia3d.service.DataLogService;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.StringUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * Data Log Rest API 전용
 * TODO /data F4D 파일을 저장하는 폴더가 url이 같은 형태라서 현재는 임시적으로 *.do를 사용하고 있음
 * @author Cheon JeongDae
 *
 */
@Slf4j
@RestController
@RequestMapping("/data/")
public class DataLogAPIController {

	@Autowired
	private DataLogService dataLogService;
	
	/**
	 * 프로젝트별 데이터 건수에 대한 통계
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-list-data-change-request-log.do")
	@ResponseBody
	public Map<String, Object> ajaxListDataChangeRequestLog(HttpServletRequest request, DataInfoLog dataInfoLog, @RequestParam(defaultValue="1") String pageNo) {
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			if(userSession == null) {
				dataInfoLog.setUser_id("guest");
			} else {
				dataInfoLog.setUser_id(userSession.getUser_id());
			}
			
			log.info("@@ dataInfoLog = {}", dataInfoLog);
			if(StringUtil.isNotEmpty(dataInfoLog.getStart_date())) {
				dataInfoLog.setStart_date(dataInfoLog.getStart_date().substring(0, 8) + DateUtil.START_TIME);
			}
			if(StringUtil.isNotEmpty(dataInfoLog.getEnd_date())) {
				dataInfoLog.setEnd_date(dataInfoLog.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
			}
			
			long totalCount = dataLogService.getDataInfoLogTotalCount(dataInfoLog);
			
			long pageRows = 10l;
			if(dataInfoLog.getList_counter() != null && dataInfoLog.getList_counter().longValue() > 0) pageRows = dataInfoLog.getList_counter().longValue();
			Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(dataInfoLog), totalCount, Long.valueOf(pageNo).longValue(), pageRows);
			log.info("@@ pagination = {}", pagination);
			
			dataInfoLog.setOffset(pagination.getOffset());
			dataInfoLog.setLimit(pagination.getPageRows());
			List<DataInfoLog> dataInfoLogList = new ArrayList<>();
			if(totalCount > 0l) {
				dataInfoLogList = dataLogService.getListDataInfoLog(dataInfoLog);
			}
			map.put("dataInfoLogList", dataInfoLogList);
			map.put("totalCount", totalCount);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
	/**
	 * Data info Log 조회
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-data-info-log.do")
	@ResponseBody
	public Map<String, Object> ajaxDataInfoLog(HttpServletRequest request, @RequestParam Long data_info_log_id) {
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			DataInfoLog dataInfoLog = dataLogService.getDataInfoLog(data_info_log_id);
			map.put("dataInfoLog", dataInfoLog);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
		
	/**
	 * 검색 조건
	 * @param issue
	 * @return
	 */
	private String getSearchParameters(DataInfoLog dataInfoLog) {
		StringBuilder builder = new StringBuilder(100);
		builder.append("&");
		builder.append("search_word=" + StringUtil.getDefaultValue(dataInfoLog.getSearch_word()));
		builder.append("&");
		builder.append("search_option=" + StringUtil.getDefaultValue(dataInfoLog.getSearch_option()));
		builder.append("&");
		try {
			builder.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(dataInfoLog.getSearch_value()), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			builder.append("search_value=");
		}
		builder.append("&");
		builder.append("start_date=" + StringUtil.getDefaultValue(dataInfoLog.getStart_date()));
		builder.append("&");
		builder.append("end_date=" + StringUtil.getDefaultValue(dataInfoLog.getEnd_date()));
		builder.append("&");
		builder.append("order_word=" + StringUtil.getDefaultValue(dataInfoLog.getOrder_word()));
		builder.append("&");
		builder.append("order_value=" + StringUtil.getDefaultValue(dataInfoLog.getOrder_value()));
		return builder.toString();
	}
}
