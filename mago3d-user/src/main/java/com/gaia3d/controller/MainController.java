package com.gaia3d.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.Issue;
import com.gaia3d.domain.Pagination;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.UserSession;
import com.gaia3d.domain.Widget;
import com.gaia3d.helper.SessionUserHelper;
import com.gaia3d.service.IssueService;
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
//		String yearMonthDay = today.substring(0, 4) + today.substring(5,7) + today.substring(8,10);
//		String startDate = yearMonthDay + DateUtil.START_TIME;
//		String endDate = yearMonthDay + DateUtil.END_TIME;
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
//		model.addAttribute("yearMonthDay", today.subSequence(0, 10));
//		model.addAttribute("thisYear", yearMonthDay.subSequence(0, 4));
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
	
	private String getSearchParameters(Issue issue) {
		StringBuilder builder = new StringBuilder(100);
		builder.append("&");
		builder.append("search_word=" + StringUtil.getDefaultValue(issue.getSearch_word()));
		builder.append("&");
		try {
			builder.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(issue.getSearch_value()), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			builder.append("search_value=");
		}
		builder.append("&");
		builder.append("start_date=" + StringUtil.getDefaultValue(issue.getStart_date()));
		builder.append("&");
		builder.append("end_date=" + StringUtil.getDefaultValue(issue.getEnd_date()));
		return builder.toString();
	}
}
