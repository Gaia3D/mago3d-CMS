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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.Issue;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.Project;
import com.gaia3d.domain.UserInfo;
import com.gaia3d.service.DataLogService;
import com.gaia3d.service.DataService;
import com.gaia3d.service.IssueService;
import com.gaia3d.service.ProjectService;
import com.gaia3d.service.UserService;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.FormatUtil;
import com.gaia3d.util.StringUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * 메인
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/main/")
public class MainController {
	@Autowired
	private ProjectService projectService;
	@Autowired
	private DataService dataService;
	@Autowired
	private DataLogService dataLogService;
	@Autowired
	private UserService userService;
	
	@Autowired
	private IssueService issueService;
	
	/**
	 * 사용자 메인 페이지에서 Issue 조회
	 * @param model
	 * @return
	 *
	 */	
	@RequestMapping(value = "index.do")
	public String index(HttpServletRequest request, Model model) {
		Policy policy = CacheManager.getPolicy();
		boolean isActive = true;
//		if("UNIX".equals(OS_TYPE)) {
//			SystemConfig systemConfig = loadBalancingService.getSystemConfig();
//			String hostname = ConfigCache.getHostname();
//			if(hostname == null || "".equals(hostname)) {
//				hostname = WebUtil.getHostName();
//			}
//			if(systemConfig == null 
//					|| !SystemConfig.ACTIVE.equals(systemConfig.getLoad_balancing_status()) 
//					|| !hostname.equals(systemConfig.getHostname())) {
//				log.error("@@@@@@@@@ hostname = {}, load_balancing_status = {}", hostname, systemConfig);
//				isActive = false;
//			}
//		}
		
//		Widget widget = new Widget();
//		widget.setLimit(policy.getContent_main_widget_count());
//		List<Widget> widgetList = widgetService.getListWidget(widget);
//		
		String today = DateUtil.getToday(FormatUtil.VIEW_YEAR_MONTH_DAY_TIME);
		String yearMonthDay = today.substring(0, 4) + today.substring(5,7) + today.substring(8,10);
		String startDate = yearMonthDay + DateUtil.START_TIME;
		String endDate = yearMonthDay + DateUtil.END_TIME;
//		
//		boolean isProjectDraw = false;
//		boolean isDataInfoDraw = false;
//		boolean isDataInfoLogListDraw = false;
//		boolean isIssueDraw = false;
//		boolean isUserDraw = false;
//		boolean isScheduleLogListDraw = false;
//		boolean isAccessLogDraw = false;
//		boolean isDbcpDraw = false;
//		boolean isDbSessionDraw = false;
//		for(Widget dbWidget : widgetList) {
//			if("projectWidget".equals(dbWidget.getName())) {
//				isProjectDraw = true;
//				projectWidget(startDate, endDate, model);
//			} else if("dataInfoWidget".equals(dbWidget.getName())) {
//				isDataInfoDraw = true;
//				dataInfoWidget(startDate, endDate, model);
//			} else if("dataInfoLogListWidget".equals(dbWidget.getName())) {
//				isDataInfoLogListDraw = true;
//				dataInfoLogListWidget(startDate, endDate, model);
//			} else if("issueWidget".equals(dbWidget.getName())) {
//				isIssueDraw = true;
//				issueWidget(startDate, endDate, model);
//			} else if("userWidget".equals(dbWidget.getName())) {
//				isUserDraw = true;
//				userWidget(startDate, endDate, model);
//			} else if("scheduleLogListWidget".equals(dbWidget.getName())) {
//				isScheduleLogListDraw = true;
//				scheduleLogListWidget(startDate, endDate, model);
//			} else if("accessLogWidget".equals(dbWidget.getName())) {
//				isAccessLogDraw = true;
//				accessLogWidget(startDate, endDate, model);
//			} else if("dbcpWidget".equals(dbWidget.getName())) {
//				isDbcpDraw = true;
//				dbcpWidget(model);
//			} else if("dbSessionWidget".equals(dbWidget.getName())) {
//				isDbSessionDraw = true;
//				dbSessionWidget(model);	
//			}
//		}
		
		model.addAttribute("today", today);
		model.addAttribute("yearMonthDay", today.subSequence(0, 10));
		model.addAttribute("thisYear", yearMonthDay.subSequence(0, 4));
		// 메인 페이지 갱신 속도
		model.addAttribute("widgetInterval", policy.getContent_main_widget_interval());
//		// 현재 접속자수
//		model.addAttribute("userSessionCount", SessionUserHelper.loginUsersMap.size());
//		model.addAttribute(widget);
//		model.addAttribute(widgetList);
//		
//		model.addAttribute("isActive", isActive);
//		model.addAttribute("isProjectDraw", isProjectDraw);
//		model.addAttribute("isDataInfoDraw", isDataInfoDraw);
//		model.addAttribute("isDataInfoLogListDraw", isDataInfoLogListDraw);
//		model.addAttribute("isIssueDraw", isIssueDraw);
//		model.addAttribute("isUserDraw", isUserDraw);
//		model.addAttribute("isScheduleLogListDraw", isScheduleLogListDraw);
//		model.addAttribute("isAccessLogDraw", isAccessLogDraw);
//		model.addAttribute("isDbcpDraw", isDbcpDraw);
//		model.addAttribute("isDbSessionDraw", isDbSessionDraw);
		
		return "/main/index";
	}
	
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
	 * 사용자 현황
	 * @param model
	 * @return
	 */
	@GetMapping(value = "ajax-user-widget.do")
	@ResponseBody
	public Map<String, Object> ajaxUserWidget(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			// 사용자 현황
			UserInfo userInfo = new UserInfo();
			userInfo.setStatus(UserInfo.STATUS_USE);
			Long activeUserTotalCount = userService.getUserTotalCount(userInfo);
			userInfo.setStatus(UserInfo.STATUS_FORBID);
			Long fobidUserTotalCount = userService.getUserTotalCount(userInfo);
			userInfo.setStatus(UserInfo.STATUS_FAIL_LOGIN_COUNT_OVER);
			Long failUserTotalCount = userService.getUserTotalCount(userInfo);
			userInfo.setStatus(UserInfo.STATUS_SLEEP);
			Long sleepUserTotalCount = userService.getUserTotalCount(userInfo);
			userInfo.setStatus(UserInfo.STATUS_TERM_END);
			Long expireUserTotalCount = userService.getUserTotalCount(userInfo);
			userInfo.setStatus(UserInfo.STATUS_TEMP_PASSWORD);
			Long tempPasswordUserTotalCount = userService.getUserTotalCount(userInfo);
			
			map.put("activeUserTotalCount", activeUserTotalCount);
			map.put("fobidUserTotalCount", fobidUserTotalCount);
			map.put("failUserTotalCount", String.valueOf(failUserTotalCount));
			map.put("sleepUserTotalCount", sleepUserTotalCount);
			map.put("expireUserTotalCount", expireUserTotalCount);
			map.put("tempPasswordUserTotalCount", tempPasswordUserTotalCount);
			
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		
		return map;
	}
	
	private String getSearchParameters(Issue issue) {
		StringBuffer buffer = new StringBuffer();
		buffer.append("&");
		buffer.append("search_word=" + StringUtil.getDefaultValue(issue.getSearch_word()));
		buffer.append("&");
		try {
			buffer.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(issue.getSearch_value()), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			buffer.append("search_value=");
		}
		buffer.append("&");
		buffer.append("start_date=" + StringUtil.getDefaultValue(issue.getStart_date()));
		buffer.append("&");
		buffer.append("end_date=" + StringUtil.getDefaultValue(issue.getEnd_date()));
		return buffer.toString();
	}
}
