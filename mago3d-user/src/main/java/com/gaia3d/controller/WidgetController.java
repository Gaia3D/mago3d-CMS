package com.gaia3d.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.config.PropertiesConfig;
import com.gaia3d.domain.AccessLog;
import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.DataInfoLog;
import com.gaia3d.domain.Project;
import com.gaia3d.domain.ScheduleLog;
import com.gaia3d.domain.UserSession;
import com.gaia3d.domain.Widget;
import com.gaia3d.service.DataLogService;
import com.gaia3d.service.DataService;
import com.gaia3d.service.IssueService;
import com.gaia3d.service.ProjectService;
import com.gaia3d.service.UserService;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.FormatUtil;
import com.zaxxer.hikari.HikariDataSource;

import lombok.extern.slf4j.Slf4j;


/**
 * 위젯 관리
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/config/")
public class WidgetController {
	
	private static final long WIDGET_LIST_VIEW_COUNT = 7l;
	
	@Autowired
	private PropertiesConfig propertiesConfig;
	
	@Autowired
	private HikariDataSource dataSource;
	@Autowired
	private ProjectService projectService;
	@Autowired
	private DataService dataService;
	@Autowired
	private DataLogService dataLogService;
	@Autowired
	private IssueService issueService;
	@Autowired
	private UserService userService;
	
	
	
	
	
	/**
	 * 프로젝트별 데이터 건수
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-project-data-widget.do")
	@ResponseBody
	public Map<String, Object> ajaxProjectDataWidget(HttpServletRequest request) {
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			Project defaultProject = new Project();
			defaultProject.setUse_yn(Project.IN_USE);
			List<Project> projectList = projectService.getListProject(defaultProject);
			List<String> projectNameList = new ArrayList<>();
			List<Long> dataTotalCountList = new ArrayList<>();
			for(Project project : projectList) {
				projectNameList.add(project.getProject_name());
				DataInfo dataInfo = new DataInfo();
				dataInfo.setProject_id(project.getProject_id());
				Long dataTotalCount = dataService.getDataTotalCount(dataInfo);
				dataTotalCountList.add(dataTotalCount);
			}
			
			map.put("projectNameList", projectNameList);
			map.put("dataTotalCountList", dataTotalCountList);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
	/**
	 * 데이터 상태별 통계 정보
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-data-status-widget.do")
	@ResponseBody
	public Map<String, Object> ajaxDataStatusStatistics(HttpServletRequest request) {
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			DataInfo dataInfo = new DataInfo();
			dataInfo.setStatus(DataInfo.STATUS_USE);
			long useTotalCount = dataService.getDataTotalCountByStatus(dataInfo);
			dataInfo.setStatus(DataInfo.STATUS_FORBID);
			long forbidTotalCount = dataService.getDataTotalCountByStatus(dataInfo);
			dataInfo.setStatus(DataInfo.STATUS_ETC);
			long etcTotalCount = dataService.getDataTotalCountByStatus(dataInfo);
						
			map.put("useTotalCount", useTotalCount);
			map.put("forbidTotalCount", forbidTotalCount);
			map.put("etcTotalCount", etcTotalCount);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
	/**
	 * 데이터 변경 요청 목록
	 * @param model
	 * @return
	 */
	@GetMapping(value = "ajax-data-info-log-widget.do")
	@ResponseBody
	public Map<String, Object> ajaxDataInfoLogWidget(HttpServletRequest request) {
		log.info("------------ data info log widget");
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			String today = DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY);
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.DATE, -7);
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
			String searchDay = simpleDateFormat.format(calendar.getTime());
			String startDate = searchDay + DateUtil.START_TIME;
			String endDate = today + DateUtil.END_TIME;
			
			DataInfoLog dataInfoLog = new DataInfoLog();
			dataInfoLog.setStart_date(startDate);
			dataInfoLog.setEnd_date(endDate);
			dataInfoLog.setOffset(0l);
			dataInfoLog.setLimit(WIDGET_LIST_VIEW_COUNT);
			List<DataInfoLog> dataInfoLogList = dataLogService.getListDataInfoLog(dataInfoLog);
			
			map.put("dataInfoLogList", dataInfoLogList);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
	
	/**
	 * 사용자 추적 이력 목록
	 * @param model
	 * @return
	 */
	@GetMapping(value = "ajax-access-log-widget.do")
	@ResponseBody
	public Map<String, Object> ajaxAccessLogWidget(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			String today = DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY);
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.DATE, -7);
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
			String searchDay = simpleDateFormat.format(calendar.getTime());
			String startDate = searchDay + DateUtil.START_TIME;
			String endDate = today + DateUtil.END_TIME;
			
			AccessLog accessLog = new AccessLog();
			accessLog.setStart_date(startDate);
			accessLog.setEnd_date(endDate);
			accessLog.setOffset(0l);
			accessLog.setLimit(WIDGET_LIST_VIEW_COUNT);
			List<AccessLog> accessLogList = new ArrayList<>();
			
			map.put("accessLogList", accessLogList);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
	
	/**
	 * 스케줄 실행 이력 목록
	 * @param model
	 * @return
	 */
	@GetMapping(value = "ajax-schedule-log-list-widget.do")
	@ResponseBody
	public Map<String, Object> ajaxScheduleLogListWidget(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			String today = DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY);
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.DATE, -7);
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
			String searchDay = simpleDateFormat.format(calendar.getTime());
			String startDate = searchDay + DateUtil.START_TIME;
			String endDate = today + DateUtil.END_TIME;
			
			ScheduleLog scheduleLog = new ScheduleLog();
			scheduleLog.setStart_date(startDate);
			scheduleLog.setEnd_date(endDate);
			scheduleLog.setOffset(0l);
			scheduleLog.setLimit(WIDGET_LIST_VIEW_COUNT);
//			List<ScheduleLog> scheduleLogList = scheduleService.getListScheduleLog(scheduleLog);
			
			List<ScheduleLog> scheduleLogList = new ArrayList<>();
			
			map.put("scheduleLogList", scheduleLogList);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
	
	/**
	 * 사용자 페이지 DBCP 정보
	 * @return
	 */
	private Map<String, Integer> getUserDbcp() {
		// 사용자 페이지에서 API로 가져와야 함
		Map<String, Integer> userDbcp = new HashMap<>();
		String success_yn = null;
		String result_message = "";
		Integer userSessionCount = 0;
		Integer initialSize = 0;
		Integer maxTotal = 0;
		Integer maxIdle = 0;
		Integer minIdle = 0;
		Integer numActive = 0;
		Integer numIdle = 0;
		
		userDbcp.put("userSessionCount", userSessionCount);
		userDbcp.put("initialSize", initialSize);
		userDbcp.put("maxTotal", maxTotal);
		userDbcp.put("maxIdle", maxIdle);
		userDbcp.put("minIdle", minIdle);
		userDbcp.put("numActive", numActive);
		userDbcp.put("numIdle", numIdle);
		
		return userDbcp;
	}
}
