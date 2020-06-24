package gaia3d.controller.rest;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import gaia3d.domain.*;
import gaia3d.service.ConverterService;
import gaia3d.service.DataService;
import gaia3d.utils.DateUtils;
import gaia3d.utils.FormatUtils;
import gaia3d.utils.LocaleUtils;
import lombok.RequiredArgsConstructor;
import org.opengis.metadata.Datatype;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import gaia3d.config.PropertiesConfig;
import gaia3d.service.UserService;

import static java.util.stream.Collectors.toList;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/widgets")
public class WidgetRestController {

	private static final long WIDGET_LIST_VIEW_COUNT = 6l;

	private final MessageSource messageSource;
	private final PropertiesConfig propertiesConfig;

	private final ConverterService converterService;
	private final DataService dataService;
	private final UserService userService;

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

		String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY);
		ConverterJobFile converterJobFile = new ConverterJobFile();
		converterJobFile.setStartDate(today);

		// 데이터 변환 현황
		List<ConverterJobFile> converterJobFileList = converterService.getConverterJobFileStatus(converterJobFile);
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

//	/**
//	 * 데이터 변경 요청 목록
//	 * @param model
//	 * @return
//	 */
//	@GetMapping(value = "/data-adjust-log")
//	public Map<String, Object> dataAdjustLogList(HttpServletRequest request) {
//		Map<String, Object> result = new HashMap<>();
//		String errorCode = null;
//		String message = null;
//		List<DataAdjustLog> dataAdjustLogList = new ArrayList<>();
//
//
//		String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY);
//		Calendar calendar = Calendar.getInstance();
//		calendar.add(Calendar.DATE, -7);
//		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
//		String searchDay = simpleDateFormat.format(calendar.getTime());
//		String startDate = searchDay + DateUtils.START_TIME;
//		String endDate = today + DateUtils.END_TIME;
//
//		DataAdjustLog dataInfoAdjustLog = new DataAdjustLog();
//		dataInfoAdjustLog.setStartDate(startDate);
//		dataInfoAdjustLog.setEndDate(endDate);
//		dataInfoAdjustLog.setOffset(0l);
//		dataInfoAdjustLog.setLimit(WIDGET_LIST_VIEW_COUNT);
//		dataAdjustLogList = dataAdjustLogService.getListDataAdjustLog(dataInfoAdjustLog);
//
//		int statusCode = HttpStatus.OK.value();
//
//		result.put("dataAdjustLogList", dataAdjustLogList);
//		result.put("statusCode", statusCode);
//		result.put("errorCode", errorCode);
//		result.put("message", message);
//		return result;
//	}
//

//	/**
//	 * 사용자 접근 이력 목록
//	 * @param request
//	 * @return
//	 */
//	@GetMapping(value = "/user-access-log")
//	public Map<String, Object> userAccessLogList(HttpServletRequest request) {
//		Map<String, Object> result = new HashMap<>();
//		String errorCode = null;
//		String message = null;
//		List<AccessLog> userAccessLogList = new ArrayList<>();
//
//		String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY);
//		Calendar calendar = Calendar.getInstance();
//		calendar.add(Calendar.DATE, -7);
//		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
//		String searchDay = simpleDateFormat.format(calendar.getTime());
//		String startDate = searchDay + DateUtils.START_TIME;
//		String endDate = today + DateUtils.END_TIME;
//
//		AccessLog accessLog = new AccessLog();
//		accessLog.setStartDate(startDate);
//		accessLog.setEndDate(endDate);
//		accessLog.setOffset(0l);
//		accessLog.setLimit(WIDGET_LIST_VIEW_COUNT);
//		userAccessLogList = logService.getListAccessLog(accessLog);
//
//		int statusCode = HttpStatus.OK.value();
//
//		result.put("userAccessLogList", userAccessLogList);
//		result.put("statusCode", statusCode);
//		result.put("errorCode", errorCode);
//		result.put("message", message);
//		return result;
//	}

//	/**
//	 * 시스템 사용 현황
//	 * @param request
//	 * @return
//	 */
//	@GetMapping(value = "/system-usage-status")
//	public Map<String, Object> systemUsageStatus(HttpServletRequest request) throws Exception {
//		Map<String, Object> result = new HashMap<>();
//		String errorCode = null;
//		String message = null;
//		Map<String, Object> statistics = new HashMap<>();
//
//		RestTemplate restTemplate = new RestTemplate();
//		String serverHost = propertiesConfig.getRestServer();
//
//		URI diskSpaceURI = new URI(serverHost + "/actuator/health/diskSpace");
//		@SuppressWarnings("rawtypes")
//		ResponseEntity<Map> response1 = restTemplate.getForEntity(diskSpaceURI, Map.class);
//		@SuppressWarnings("unchecked")
//		Map<String, Long> diskSpace = (Map<String, Long>) response1.getBody().get("details");
//
//		URI memoryMax = new URI(serverHost + "/actuator/metrics/jvm.memory.max");
//		@SuppressWarnings("rawtypes")
//		ResponseEntity<Map> response2 = restTemplate.getForEntity(memoryMax, Map.class);
//		@SuppressWarnings("unchecked")
//		List<Map<String, Object>> jvmMemoryMax = (List<Map<String, Object>>) response2.getBody().get("measurements");
//
//		URI memoryUsed = new URI(serverHost + "/actuator/metrics/jvm.memory.used");
//		@SuppressWarnings("rawtypes")
//		ResponseEntity<Map> response3 = restTemplate.getForEntity(memoryUsed, Map.class);
//		@SuppressWarnings("unchecked")
//		List<Map<String, Object>> jvmMemoryUsed = (List<Map<String, Object>>) response3.getBody().get("measurements");
//
//		URI cpuMax = new URI(serverHost + "/actuator/metrics/system.cpu.usage");
//		@SuppressWarnings("rawtypes")
//		ResponseEntity<Map> response4 = restTemplate.getForEntity(cpuMax, Map.class);
//		@SuppressWarnings("unchecked")
//		List<Map<String, Object>> systemCpuUsage = (List<Map<String, Object>>) response4.getBody().get("measurements");
//
//		URI cpuUsed = new URI(serverHost + "/actuator/metrics/process.cpu.usage");
//		@SuppressWarnings("rawtypes")
//		ResponseEntity<Map> response5 = restTemplate.getForEntity(cpuUsed, Map.class);
//		@SuppressWarnings("unchecked")
//		List<Map<String, Object>> processCpuUsage = (List<Map<String, Object>>) response5.getBody().get("measurements");
//
//		statistics.put("diskSpaceTotal", diskSpace.get("total"));
//		statistics.put("diskSpaceFree", diskSpace.get("free"));
//		statistics.put("jvmMemoryMax", jvmMemoryMax);
//		statistics.put("jvmMemoryUsed", jvmMemoryUsed);
//		statistics.put("systemCpuUsage", systemCpuUsage);
//		statistics.put("processCpuUsage", processCpuUsage);
//
//		int statusCode = HttpStatus.OK.value();
//
//		result.put("statistics", statistics);
//		result.put("statusCode", statusCode);
//		result.put("errorCode", errorCode);
//		result.put("message", message);
//		return result;
//	}

}
