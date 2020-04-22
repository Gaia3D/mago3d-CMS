package mago3d.controller.view;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zaxxer.hikari.HikariDataSource;

import lombok.extern.slf4j.Slf4j;
import mago3d.domain.ConverterJob;
import mago3d.domain.Policy;
import mago3d.domain.UserInfo;
import mago3d.domain.UserStatus;
import mago3d.domain.Widget;
import mago3d.service.ConverterService;
import mago3d.service.PolicyService;
import mago3d.service.UserService;
import mago3d.service.WidgetService;
import mago3d.support.SessionUserSupport;
import mago3d.utils.DateUtils;
import mago3d.utils.FormatUtils;


/**
 * 메인
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/main")
public class MainController {

	@Autowired
	private HikariDataSource dataSource;

	@Autowired
	private ConverterService converterService;

//	@Autowired
//	private MonitoringService monitoringService;

	@Autowired
	private UserService userService;

	@Autowired
	private WidgetService widgetService;

	@Autowired
	private PolicyService policyService;

	/**
	 * 메인 페이지
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/index")
	public String index(HttpServletRequest request, Model model) {
		Policy policy = policyService.getPolicy();
		boolean isActive = true;

		Widget widget = new Widget();
		widget.setLimit(policy.getContentMainWidgetCount());
		List<Widget> widgetList = widgetService.getListWidget(widget);

		String today = DateUtils.getToday(FormatUtils.VIEW_YEAR_MONTH_DAY_TIME);
		String yearMonthDay = today.substring(0, 4) + today.substring(5,7) + today.substring(8,10);
		String startDate = yearMonthDay + DateUtils.START_TIME;
		String endDate = yearMonthDay + DateUtils.END_TIME;

		boolean isDataGroupDraw = false;
		boolean isDataStatusDraw = false;
		boolean isDataAdjustLogDraw = false;
		boolean isUserStatusDraw = false;
		boolean isUserAccessLogDraw = false;
		boolean isCivilVoiceDraw = false;
		boolean isSystemUsageDraw = false;
		boolean isDbcpStatusDraw = false;
		boolean isDbSessionDraw = false;

		// widget-header
		converterWidget(startDate, endDate, model);

		// widget-contents
		for(Widget dbWidget : widgetList) {
			if("dataGroupWidget".equals(dbWidget.getName())) {
				isDataGroupDraw = true;
				dataGroupWidget(startDate, endDate, model);
			} else if("dataStatusWidget".equals(dbWidget.getName())) {
				isDataStatusDraw = true;
				dataStatusWidget(startDate, endDate, model);
			} else if("dataAdjustLogWidget".equals(dbWidget.getName())) {
				isDataAdjustLogDraw = true;
				dataAdjustLogWidget(startDate, endDate, model);
			} else if("userStatusWidget".equals(dbWidget.getName())) {
				isUserStatusDraw = true;
				userStatusWidget(startDate, endDate, model);
			} else if("civilVoiceWidget".equals(dbWidget.getName())) {
				isCivilVoiceDraw = true;
				civilVoiceWidget(startDate, endDate, model);
			} else if("userAccessLogWidget".equals(dbWidget.getName())) {
				isUserAccessLogDraw = true;
				userAccessLogWidget(startDate, endDate, model);
			} else if("systemUsageWidget".equals(dbWidget.getName())) {
				isSystemUsageDraw = true;
				systemUsageWidget(model);
			} else if("dbcpStatusWidget".equals(dbWidget.getName())) {
				isDbcpStatusDraw = true;
				dbcpStatusWidget(model);
//			} else if("dbSessionWidget".equals(dbWidget.getName())) {
//			isDbSessionDraw = true;
//			dbSessionWidget(model);
			}
		}

		model.addAttribute("today", today);
		model.addAttribute("yearMonthDay", today.subSequence(0, 10));
		model.addAttribute("thisYear", yearMonthDay.subSequence(0, 4));
		// 메인 페이지 갱신 속도
		model.addAttribute("widgetInterval", policy.getContentMainWidgetInterval());
		// 현재 접속자수
		model.addAttribute("userSessionCount", SessionUserSupport.signinUsersMap.size());
		model.addAttribute(widget);
		model.addAttribute("widgetList", widgetList);

		model.addAttribute("isActive", isActive);
		model.addAttribute("isDataGroupDraw", isDataGroupDraw);
		model.addAttribute("isDataStatusDraw", isDataStatusDraw);
		model.addAttribute("isDataAdjustLogDraw", isDataAdjustLogDraw);
		model.addAttribute("isUserStatusDraw", isUserStatusDraw);
		model.addAttribute("isUserAccessLogDraw", isUserAccessLogDraw);
		model.addAttribute("isCivilVoiceDraw", isCivilVoiceDraw);
		model.addAttribute("isSystemUsageDraw", isSystemUsageDraw);
		model.addAttribute("isDbcpStatusDraw", isDbcpStatusDraw);
		model.addAttribute("isDbSessionDraw", isDbSessionDraw);

		return "/main/index";
	}

	/**
	 * converter 현황
	 * @param startDate
	 * @param endDate
	 * @param model
	 */
	private void converterWidget(String startDate, String endDate, Model model) {
		ConverterJob converterJob = new ConverterJob();
		converterJob.setStartDate(startDate);
		converterJob.setEndDate(endDate);
		Long converterTotalCount = converterService.getConverterJobTotalCount(converterJob);

		converterJob.setStatus("success");
		Long converterSuccessCount = converterService.getConverterJobTotalCount(converterJob);

		converterJob.setStatus("fail");
		Long converterFailCount = converterService.getConverterJobTotalCount(converterJob);

		model.addAttribute("converterTotalCount", converterTotalCount);
		model.addAttribute("converterSuccessCount", converterSuccessCount);
		model.addAttribute("converterFailCount", converterFailCount);
	}

	/**
	 * dataGroup
	 * @param startDate
	 * @param endDate
	 * @param model
	 */
	private void dataGroupWidget(String startDate, String endDate, Model model) {
		// ajax 에서 처리 하기 위해서 여기는 공백
	}

	/**
	 * dataInfo
	 * @param startDate
	 * @param endDate
	 * @param model
	 */
	private void dataStatusWidget(String startDate, String endDate, Model model) {
		// ajax 에서 처리 하기 위해서 여기는 공백
	}

	/**
	 * dataInfoLog
	 * @param startDate
	 * @param endDate
	 * @param model
	 */
	private void dataAdjustLogWidget(String startDate, String endDate, Model model) {
		// ajax 에서 처리 하기 위해서 여기는 공백
	}

	/**
	 * 사용자 현황
	 * @param startDate
	 * @param endDate
	 * @param model
	 */
	private void userStatusWidget(String startDate, String endDate, Model model) {
		// 사용자 현황
		UserInfo userInfo = new UserInfo();
		userInfo.setStatus(UserStatus.USE.getValue());
		Long activeUserTotalCount = userService.getUserTotalCount(userInfo);
		userInfo.setStatus(UserStatus.FORBID.getValue());
		Long fobidUserTotalCount = userService.getUserTotalCount(userInfo);
		userInfo.setStatus(UserStatus.FAIL_LOGIN_COUNT_OVER.getValue());
		Long failUserTotalCount = userService.getUserTotalCount(userInfo);
		userInfo.setStatus(UserStatus.SLEEP.getValue());
		Long sleepUserTotalCount = userService.getUserTotalCount(userInfo);
		userInfo.setStatus(UserStatus.TERM_END.getValue());
		Long expireUserTotalCount = userService.getUserTotalCount(userInfo);
		userInfo.setStatus(UserStatus.TEMP_PASSWORD.getValue());
		Long tempPasswordUserTotalCount = userService.getUserTotalCount(userInfo);

		model.addAttribute("activeUserTotalCount", activeUserTotalCount);
		model.addAttribute("fobidUserTotalCount", fobidUserTotalCount);
		model.addAttribute("failUserTotalCount", failUserTotalCount);
		model.addAttribute("sleepUserTotalCount", sleepUserTotalCount);
		model.addAttribute("expireUserTotalCount", expireUserTotalCount);
		model.addAttribute("tempPasswordUserTotalCount", tempPasswordUserTotalCount);
	}

	/**
	 * 사용자 추적
	 * @param startDate
	 * @param endDate
	 * @param model
	 */
	private void userAccessLogWidget(String startDate, String endDate, Model model) {
	}

	/**
	 * DB Session 현황
	  * @param model
	 */
//	private void dbSessionWidget(Model model) {
//		List<PGStatActivity> dbSessionList = monitoringService.getListDBSession();
//		Integer dbSessionCount = dbSessionList.size();
//		if(dbSessionCount > 7) dbSessionList = dbSessionList.subList(0, 7);
//		model.addAttribute("dbSessionCount", dbSessionCount);
//		model.addAttribute("dbSessionList", dbSessionList);
//	}

	/**
	 * 시민 참여 현황 목록
	 * @param startDate
	 * @param endDate
	 * @param model
	 */
	private void civilVoiceWidget(String startDate, String endDate, Model model) {
		// ajax 에서 처리 하기 위해서 여기는 공백
	}

	/**
	 * 시스템 사용량
	 * @param model
	 */
	private void systemUsageWidget(Model model) {
		// ajax 에서 처리 하기 위해서 여기는 공백
	}

	/**
	 * DB Connection Pool 현황
	  * @param model
	 */
	private void dbcpStatusWidget(Model model) {
		model.addAttribute("userSessionCount", SessionUserSupport.signinUsersMap.size());

		model.addAttribute("initialSize", dataSource.getMaximumPoolSize());
//	model.addAttribute("maxIdle", dataSource.getMaxIdle());
		model.addAttribute("minIdle", dataSource.getMinimumIdle());
//	model.addAttribute("numActive", dataSource.getNumActive());
//	model.addAttribute("numIdle", dataSource.getNumIdle());

//		model.addAttribute("initialSize", dataSource.getInitialSize());
////		model.addAttribute("maxTotal", dataSource.getMaxTotal());
//		model.addAttribute("maxIdle", dataSource.getMaxIdle());
//		model.addAttribute("minIdle", dataSource.getMinIdle());
//		model.addAttribute("numActive", dataSource.getNumActive());
//		model.addAttribute("numIdle", dataSource.getNumIdle());

		// 사용자 dbcp 정보
		Map<String, Integer> userDbcp = getUserDbcp();
		model.addAttribute("userUserSessionCount", userDbcp.get("userSessionCount"));
		model.addAttribute("userInitialSize", userDbcp.get("initialSize"));
		model.addAttribute("userMaxTotal", userDbcp.get("maxTotal"));
		model.addAttribute("userMaxIdle", userDbcp.get("maxIdle"));
		model.addAttribute("userMinIdle", userDbcp.get("minIdle"));
		model.addAttribute("userNumActive", userDbcp.get("numActive"));
		model.addAttribute("userNumIdle", userDbcp.get("numIdle"));
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
