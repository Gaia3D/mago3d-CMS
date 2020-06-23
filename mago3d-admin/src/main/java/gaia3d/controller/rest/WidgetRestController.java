package gaia3d.controller.rest;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import gaia3d.domain.*;
import gaia3d.service.DataService;
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
//	 * 사용자 상태별 통계 정보
//	 * @param request
//	 * @return
//	 */
//	@GetMapping(value = "/user-status-statistics")
//	public Map<String, Object> userStatusStatistics(HttpServletRequest request) {
//		Map<String, Object> result = new HashMap<>();
//		String errorCode = null;
//		String message = null;
//		Map<String, Object> statistics = new HashMap<>();
//
//		// 사용자 현황
//		UserInfo userInfo = new UserInfo();
//		userInfo.setStatus(UserStatus.USE.getValue());
//		Long activeUserTotalCount = userService.getUserTotalCount(userInfo);
//		userInfo.setStatus(UserStatus.FORBID.getValue());
//		Long fobidUserTotalCount = userService.getUserTotalCount(userInfo);
//		userInfo.setStatus(UserStatus.FAIL_LOGIN_COUNT_OVER.getValue());
//		Long failUserTotalCount = userService.getUserTotalCount(userInfo);
//		userInfo.setStatus(UserStatus.SLEEP.getValue());
//		Long sleepUserTotalCount = userService.getUserTotalCount(userInfo);
//		userInfo.setStatus(UserStatus.TERM_END.getValue());
//		Long expireUserTotalCount = userService.getUserTotalCount(userInfo);
//		userInfo.setStatus(UserStatus.TEMP_PASSWORD.getValue());
//		Long tempPasswordUserTotalCount = userService.getUserTotalCount(userInfo);
//
//		statistics.put("activeUserTotalCount", activeUserTotalCount);
//		statistics.put("fobidUserTotalCount", fobidUserTotalCount);
//		statistics.put("failUserTotalCount", String.valueOf(failUserTotalCount));
//		statistics.put("sleepUserTotalCount", sleepUserTotalCount);
//		statistics.put("expireUserTotalCount", expireUserTotalCount);
//		statistics.put("tempPasswordUserTotalCount", tempPasswordUserTotalCount);
//
//		int statusCode = HttpStatus.OK.value();
//
//		result.put("statistics", statistics);
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
//
//	/**
//	 * 시민 참여 현황
//	 * @param request
//	 * @return
//	 */
//	@GetMapping(value = "/civil-voice-status")
//	public Map<String, Object> civilVoiceStatus(HttpServletRequest request) {
//		Map<String, Object> result = new HashMap<>();
//		String errorCode = null;
//		String message = null;
//		List<CivilVoice> civilVoiceList = new ArrayList<>();
//
//		String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY);
//		Calendar calendar = Calendar.getInstance();
//		calendar.add(Calendar.DATE, -7);
//		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
//		String searchDay = simpleDateFormat.format(calendar.getTime());
//		String startDate = searchDay + DateUtils.START_TIME;
//		String endDate = today + DateUtils.END_TIME;
//
//		CivilVoice civilVoice = new CivilVoice();
//		civilVoice.setStartDate(startDate);
//		civilVoice.setEndDate(endDate);
//		civilVoice.setOffset(0l);
//		civilVoice.setLimit(WIDGET_LIST_VIEW_COUNT);
//		civilVoice.setOrderWord("comment_count");
//		civilVoice.setOrderValue("desc");
//		civilVoiceList = civilVoiceService.getListCivilVoice(civilVoice);
//
//		int statusCode = HttpStatus.OK.value();
//
//		result.put("civilVoiceList", civilVoiceList);
//		result.put("statusCode", statusCode);
//		result.put("errorCode", errorCode);
//		result.put("message", message);
//		return result;
//	}
//
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
//
//	/**
//	 * DB Connection Pool 현황
//	 * @param request
//	 * @return
//	 */
//	@GetMapping(value = "/dbcp-status")
//	public Map<String, Object> dbcpStatus(HttpServletRequest request) {
//		Map<String, Object> result = new HashMap<>();
//		String errorCode = null;
//		String message = null;
//		Map<String, Object> dbcp = new HashMap<>();
//
//		dbcp.put("userSessionCount", SessionUserSupport.signinUsersMap.size());
//
//		dbcp.put("initialSize", dataSource.getMaximumPoolSize());
//		dbcp.put("minIdle", dataSource.getMinimumIdle());
//		dbcp.put("numIdle", dataSource.getMaximumPoolSize());
//
////			dbcp.put("initialSize", dataSource.getInitialSize());
//////			dbcp.put("maxTotal", dataSource.getMaxTotal());
////			dbcp.put("maxIdle", dataSource.getMaxIdle());
////			dbcp.put("minIdle", dataSource.getMinIdle());
////			dbcp.put("numActive", dataSource.getNumActive());
////			dbcp.put("numIdle", dataSource.getNumIdle());
//
//		// 사용자 dbcp 정보
//		Map<String, Integer> userDbcp = getUserDbcp();
//		dbcp.put("userUserSessionCount", userDbcp.get("userSessionCount"));
//		dbcp.put("userInitialSize", userDbcp.get("initialSize"));
//		dbcp.put("userMaxTotal", userDbcp.get("maxTotal"));
//		dbcp.put("userMaxIdle", userDbcp.get("maxIdle"));
//		dbcp.put("userMinIdle", userDbcp.get("minIdle"));
//		dbcp.put("userNumActive", userDbcp.get("numActive"));
//		dbcp.put("userNumIdle", userDbcp.get("numIdle"));
//
//		int statusCode = HttpStatus.OK.value();
//
//		result.put("dbcp", dbcp);
//		result.put("statusCode", statusCode);
//		result.put("errorCode", errorCode);
//		result.put("message", message);
//
//		return result;
//	}
//
//	/**
//	 * 사용자 페이지 DBCP 정보
//	 * @return
//	 */
//	private Map<String, Integer> getUserDbcp() {
//		// 사용자 페이지에서 API로 가져와야 함
//		Map<String, Integer> userDbcp = new HashMap<>();
//		String success_yn = null;
//		String result_message = "";
//		Integer userSessionCount = 0;
//		Integer initialSize = 0;
//		Integer maxTotal = 0;
//		Integer maxIdle = 0;
//		Integer minIdle = 0;
//		Integer numActive = 0;
//		Integer numIdle = 0;
//
//		userDbcp.put("userSessionCount", userSessionCount);
//		userDbcp.put("initialSize", initialSize);
//		userDbcp.put("maxTotal", maxTotal);
//		userDbcp.put("maxIdle", maxIdle);
//		userDbcp.put("minIdle", minIdle);
//		userDbcp.put("numActive", numActive);
//		userDbcp.put("numIdle", numIdle);
//
//		return userDbcp;
//	}
//
//	/**
//	 * 데이터 공유 타입
//	 * @param request
//	 * @return
//	 */
//	@GetMapping(value = "/data-sharing")
//	public Map<String, Object> dataSharing(HttpServletRequest request) {
//		Map<String, Object> result = new HashMap<>();
//		String errorCode = null;
//		String message = null;
//		Map<String, Object> statistics = new HashMap<>();
//
//		// 데이터 공유 타입
//		List<DataInfo> dataSharingList = dataService.getDataSharing();
//		dataSharingList.stream().forEach(e -> statistics.put(e.getSharing().toString(), e.getDataCount()));
//
//		int statusCode = HttpStatus.OK.value();
//
//		result.put("statistics", statistics);
//		result.put("statusCode", statusCode);
//		result.put("errorCode", errorCode);
//		result.put("message", message);
//		return result;
//	}
//
//	/**
//	 * 데이터 변환 상태 집계
//	 * @param request
//	 * @return
//	 */
//	@GetMapping(value = "/converter-status")
//	public Map<String, Object> converterStatus(HttpServletRequest request) {
//		Map<String, Object> result = new HashMap<>();
//		String errorCode = null;
//		String message = null;
//		Map<String, Object> statistics;
//
//		// 데이터 변환 상태
//		List<ConverterJob> converterJobList = converterService.getConverterJobStatus();
//		statistics = ConverterJobStatus.toEnumHashMap();
//		converterJobList.stream().forEach(e -> {
//			statistics.put(ConverterJobStatus.findByStatus(e.getStatus()).toString(), e.getStatusCount());
//		});
//
//		int statusCode = HttpStatus.OK.value();
//
//		result.put("statistics", statistics);
//		result.put("statusCode", statusCode);
//		result.put("errorCode", errorCode);
//		result.put("message", message);
//		return result;
//	}
//
//	/**
//	 * 업로드 타입 집계
//	 * @param request
//	 * @return
//	 */
//	@GetMapping(value = "/upload-type")
//	public Map<String, Object> uploadDataType(HttpServletRequest request) {
//		Map<String, Object> result = new HashMap<>();
//		String errorCode = null;
//		String message = null;
//		Map<String, Object> statistics;
//
//		// 데이터 변환 상태
//		List<UploadData> uploadDataList = uploadDataService.getUploadDataType();
//		statistics = DataType.toEnumHashMap();
//		uploadDataList.stream().forEach(e -> {
//			statistics.put(DataType.findByDataType(e.getDataType()).toString(), e.getDataCount());
//		});
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
