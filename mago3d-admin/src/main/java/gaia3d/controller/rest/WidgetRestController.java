package gaia3d.controller.rest;

import static java.util.stream.Collectors.toList;

import java.net.URI;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.MessageSource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import gaia3d.config.PropertiesConfig;
import gaia3d.domain.Key;
import gaia3d.domain.converter.ConverterJobFile;
import gaia3d.domain.data.DataAdjustLog;
import gaia3d.domain.data.DataInfo;
import gaia3d.domain.data.DataType;
import gaia3d.domain.issue.Issue;
import gaia3d.domain.user.UserInfo;
import gaia3d.domain.user.UserSession;
import gaia3d.domain.user.UserStatus;
import gaia3d.domain.widget.Widget;
import gaia3d.service.ConverterService;
import gaia3d.service.DataAdjustLogService;
import gaia3d.service.DataService;
import gaia3d.service.IssueService;
import gaia3d.service.UserService;
import gaia3d.service.WidgetService;
import gaia3d.utils.LocaleUtils;
import io.micrometer.core.instrument.util.StringUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/widgets")
public class WidgetRestController {

	private static final long WIDGET_LIST_VIEW_COUNT = 6L;

	private final MessageSource messageSource;
	private final PropertiesConfig propertiesConfig;

	private final ConverterService converterService;
	private final DataService dataService;
	private final DataAdjustLogService dataAdjustLogService;
	private final IssueService issueService;
	private final RestTemplate restTemplate;
	private final UserService userService;
	private final WidgetService widgetService;

	/**
	 * 사용자 현황
	 * @param request
	 * @return
	 */
	@GetMapping("/user-status")
	public Map<String, Object> userStatus(HttpServletRequest request) {
		log.info("@@@@@ userStatus widget start.");

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		// 사용자 상태
		Map<String, Long> statusMap = UserStatus.getStatisticsMap();

		// 사용자 현황
		List<UserInfo> userInfoStatusList = userService.getUserStatusCount();
		// TODO 다른 걸로 바꿔야 함
		userInfoStatusList.stream()
			.filter(u -> {
				if(statusMap.containsKey(u.getStatus())) {
					statusMap.put(u.getStatus(), u.getStatusCount());
					return true;
				}
				return false;
			})
			.collect(toList());

		List<String> userStatusKeys = new ArrayList<>();
		List<Long> userStatusValues = new ArrayList<>();
		Locale locale = LocaleUtils.getUserLocale(request);
		for(Map.Entry<String, Long> entry : statusMap.entrySet()) {
			String key = entry.getKey();
			Long value = entry.getValue();
			String status = null;
			if(UserStatus.USE == UserStatus.findBy(key)) {
				status = messageSource.getMessage("user.status.use", null, locale);
			} else if(UserStatus.FORBID == UserStatus.findBy(key)) {
				status = messageSource.getMessage("user.status.forbid", null, locale);
			} else if(UserStatus.FAIL_SIGNIN_COUNT_OVER == UserStatus.findBy(key)) {
				status = messageSource.getMessage("user.status.fail.signin.count.over", null, locale);
			} else if(UserStatus.SLEEP == UserStatus.findBy(key)) {
				status = messageSource.getMessage("user.status.sleep", null, locale);
			} else if(UserStatus.TERM_END == UserStatus.findBy(key)) {
				status = messageSource.getMessage("user.status.term.end", null, locale);
			} else if(UserStatus.LOGICAL_DELETE == UserStatus.findBy(key)) {
				status = messageSource.getMessage("user.status.logical.delete", null, locale);
			} else if(UserStatus.TEMP_PASSWORD == UserStatus.findBy(key)) {
				status = messageSource.getMessage("user.status.temp.password", null, locale);
			} else if (UserStatus.WAITING_APPROVAL == UserStatus.findBy(key)) {
				status = messageSource.getMessage("user.status.waiting.approval", null, locale);
			}

			userStatusKeys.add(status);
			userStatusValues.add(value);
		}

		int statusCode = HttpStatus.OK.value();

		result.put("userStatusKeys", userStatusKeys);
		result.put("userStatusValues", userStatusValues);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 데이터 현황
	 * @param request
	 * @return
	 */
	@GetMapping("/data-types")
	public Map<String, Object> dataTypes(HttpServletRequest request) {
		log.info("@@@@@ dataTypes widget start.");

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		// 데이터 타입
		Map<String, Long> dataTypeMap = DataType.getStatisticsMap();
		List<DataInfo> dataInfoStatusList = dataService.getDataTypeCount();
		// TODO 다른 걸로 바꿔야 함
		dataInfoStatusList.stream()
				.filter(d -> {
					if(dataTypeMap.containsKey(d.getDataType())) {
						dataTypeMap.put(d.getDataType(), d.getDataTypeCount());
						return true;
					}
					return false;
				})
				.collect(toList());

		List<String> dataTypeKeys = new ArrayList<>();
		List<Long> dataTypeValues = new ArrayList<>();
		for(Map.Entry<String, Long> entry : dataTypeMap.entrySet()) {
			String key = entry.getKey();
			Long value = entry.getValue();

			dataTypeKeys.add(key);
			dataTypeValues.add(value);
		}

		int statusCode = HttpStatus.OK.value();

		result.put("dataTypeKeys", dataTypeKeys);
		result.put("dataTypeValues", dataTypeValues);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 데이터 변환 현황
	 * @param request
	 * @return
	 */
	@GetMapping("/converters")
	public Map<String, Object> converters(HttpServletRequest request) {
		log.info("@@@@@ converters widget start.");

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		// 데이터 변환 현황
		List<ConverterJobFile> converterJobFileList = converterService.getConverterJobFileStatistics();
		List<String> converterJobFileKeys = new ArrayList<>();
		List<Long> converterJobFileValues = new ArrayList<>();
		String hyphen = "-";
		converterJobFileList.forEach(x -> {
			converterJobFileKeys.add(x.getYear() + hyphen + x.getMonth() + hyphen + x.getDay());
			converterJobFileValues.add(x.getCount());
		});

		int statusCode = HttpStatus.OK.value();

		result.put("converterJobFileKeys", converterJobFileKeys);
		result.put("converterJobFileValues", converterJobFileValues);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 최신 이슈
	 * @param request
	 * @return
	 */
	@GetMapping("/issues")
	public Map<String, Object> issues(HttpServletRequest request) {
		log.info("@@@@@ issues widget start.");

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		// 최근 이슈 목록
		List<Issue> issueList = issueService.getListRecentIssue();

		int statusCode = HttpStatus.OK.value();

		result.put("issueList", issueList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 데이터 변경 요청 목록
	 * @param request
	 * @return
	 */
	@GetMapping(value = "/data-adjust-logs")
	public Map<String, Object> dataAdjustLogs(HttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		List<DataAdjustLog> dataAdjustLogList = dataAdjustLogService.getListRecentDataAdjustLog();

		int statusCode = HttpStatus.OK.value();

		result.put("dataAdjustLogList", dataAdjustLogList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 시스템 현황
	 * TODO 쓸만한 정보가 없음. OS 전체에 대한 디스크 사용량, 메모리 등이 나와야 함.
	 * @param request
	 * @return
	 */
	@GetMapping(value = "/system-resources")
	public Map<String, Object> systemResources(HttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		String serverHost = propertiesConfig.getRestServer();

		Long diskSpaceTotal = 0L;
		Long diskSpaceFree = 0L;
		Long diskSpaceUsed = 0L;
		Long diskSpacePercent = 0L;

		String jvmMemoryMax = "";
		String jvmMemoryUsed = "";
		String systemCpuUsage = "";
		String processCpuUsage = "";

		try {
			@SuppressWarnings("rawtypes")
			ResponseEntity<Map> response = restTemplate.getForEntity(new URI(serverHost + "/actuator/health/diskSpace"), Map.class);
			@SuppressWarnings("unchecked")
			Map<String, Long> diskSpace = (Map<String, Long>) response.getBody().get("details");
			diskSpaceTotal = diskSpace.get("total");
			diskSpaceFree = diskSpace.get("free");
			diskSpaceUsed = diskSpaceTotal - diskSpaceFree;
			diskSpacePercent = diskSpaceUsed / diskSpaceTotal * 100L;

//			response = restTemplate.getForEntity(new URI(serverHost + "/actuator/metrics/jvm.memory.max"), Map.class);
//			@SuppressWarnings("unchecked")
//			List<Map<String, Object>> jvmMemoryMax = (List<Map<String, Object>>) response.getBody().get("measurements");
//
//			@SuppressWarnings("rawtypes")
//			ResponseEntity<Map> response3 = restTemplate.getForEntity(new URI(serverHost + "/actuator/metrics/jvm.memory.used"), Map.class);
//			@SuppressWarnings("unchecked")
//			List<Map<String, Object>> jvmMemoryUsed = (List<Map<String, Object>>) response3.getBody().get("measurements");
//
//			URI cpuMax = new URI(serverHost + "/actuator/metrics/system.cpu.usage");
//			@SuppressWarnings("rawtypes")
//			ResponseEntity<Map> response4 = restTemplate.getForEntity(cpuMax, Map.class);
//			@SuppressWarnings("unchecked")
//			List<Map<String, Object>> systemCpuUsage = (List<Map<String, Object>>) response4.getBody().get("measurements");
//
//			URI cpuUsed = new URI(serverHost + "/actuator/metrics/process.cpu.usage");
//			@SuppressWarnings("rawtypes")
//			ResponseEntity<Map> response5 = restTemplate.getForEntity(cpuUsed, Map.class);
//			@SuppressWarnings("unchecked")
//			List<Map<String, Object>> processCpuUsage = (List<Map<String, Object>>) response5.getBody().get("measurements");
		} catch(Exception e) {
			e.printStackTrace();
		}

		int statusCode = HttpStatus.OK.value();

		result.put("diskSpaceTotal", diskSpaceTotal);
		result.put("diskSpaceFree", diskSpaceFree);
		result.put("diskSpaceUsed", diskSpaceUsed);
		result.put("diskSpacePercent", diskSpacePercent);

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 스케줄 실행 결과
	 * @param request
	 * @return
	 */
	@GetMapping(value = "/schedules")
	public Map<String, Object> schedules(HttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;


		int statusCode = HttpStatus.OK.value();

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * api 요청 이력
	 * @param request
	 * @return
	 */
	@GetMapping(value = "/api-logs")
	public Map<String, Object> apiLogs(HttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;


		int statusCode = HttpStatus.OK.value();

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 위젯 수정
	 * @param widget
	 * @return
	 */
	@PostMapping(value = "/order")
	public Map<String, Object> order(HttpServletRequest request, Widget widget) {
		log.info("@@@@@@@@@@@@@@@@@@@@ widget = {}", widget);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		String userId = userSession.getUserId();

		if(StringUtils.isEmpty(widget.getWidgetOrder())) {
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", "widget.invalid");
			result.put("message", message);
			return result;
		}

		List<Widget> widgetList = new ArrayList<>();
		String[] orders = widget.getWidgetOrder().split(",");
		int count = orders.length;
		for(int i=1; i<count; i++) {
			Widget tempWidget = new Widget();
			tempWidget.setUserId(userId);
			tempWidget.setWidgetId(Long.valueOf(orders[i]));
			tempWidget.setViewOrder(i);
			widgetList.add(tempWidget);
		}

		widgetService.updateWidget(widgetList);

		int statusCode = HttpStatus.OK.value();

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
}
