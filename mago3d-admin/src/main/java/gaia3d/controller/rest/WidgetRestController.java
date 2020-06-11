package gaia3d.controller.rest;

import java.net.URI;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Consumer;
import java.util.stream.Stream;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.zaxxer.hikari.HikariDataSource;

import lombok.extern.slf4j.Slf4j;
import gaia3d.config.PropertiesConfig;
import gaia3d.domain.AccessLog;
import gaia3d.domain.CivilVoice;
import gaia3d.domain.ConverterJob;
import gaia3d.domain.ConverterJobStatus;
import gaia3d.domain.DataAdjustLog;
import gaia3d.domain.DataGroup;
import gaia3d.domain.DataInfo;
import gaia3d.domain.DataStatus;
import gaia3d.domain.DataType;
import gaia3d.domain.Key;
import gaia3d.domain.UploadData;
import gaia3d.domain.UserInfo;
import gaia3d.domain.UserSession;
import gaia3d.domain.UserStatus;
import gaia3d.service.AccessLogService;
import gaia3d.service.CivilVoiceService;
import gaia3d.service.ConverterService;
import gaia3d.service.DataAdjustLogService;
import gaia3d.service.DataGroupService;
import gaia3d.service.DataService;
import gaia3d.service.UploadDataService;
import gaia3d.service.UserService;
import gaia3d.support.SessionUserSupport;
import gaia3d.utils.DateUtils;
import gaia3d.utils.FormatUtils;

@Slf4j
@RestController
@RequestMapping("/widgets")
public class WidgetRestController {

	private static final long WIDGET_LIST_VIEW_COUNT = 6l;

	@Autowired
	private HikariDataSource dataSource;

	@Autowired
	private DataGroupService dataGroupService;

	@Autowired
	private DataService dataService;

	@Autowired
	private UploadDataService uploadDataService;

	@Autowired
	private ConverterService converterService;

	@Autowired
	private DataAdjustLogService dataAdjustLogService;

	@Autowired
	private AccessLogService logService;

	@Autowired
	private UserService userService;

	@Autowired
	private CivilVoiceService civilVoiceService;

	@Autowired
	private PropertiesConfig propertiesConfig;

	/**
	 * 데이터 그룹별 통계 정보
	 * @param request
	 * @return
	 */
	@GetMapping(value = "/data-group-statistics")
	public Map<String, Object> dataGroupStatistics(HttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		List<Map<String, Object>> dataGroupWidgetList = new ArrayList<>();

		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());

		DataGroup dataGroup = new DataGroup();
		dataGroup.setUserId(userSession.getUserId());
		List<DataGroup> dataGroupList = dataGroupService.getListDataGroup(dataGroup);

		for(DataGroup dbDataGroup : dataGroupList) {
			// get count
			DataInfo dataInfo = new DataInfo();
			dataInfo.setDataGroupId(dbDataGroup.getDataGroupId());
			Long dataTotalCount = dataService.getDataTotalCount(dataInfo);

			// set list
			Map<String, Object> tempMap = new HashMap<>();
			tempMap.put("name", dbDataGroup.getDataGroupName());
			tempMap.put("count", dataTotalCount);
			dataGroupWidgetList.add(tempMap);
		}

		// 건수를 기준으로 DESC 정렬
		Collections.sort(dataGroupWidgetList, new Comparator<Map<String, Object>>() {
			@Override
            public int compare(final Map<String, Object> o1, final Map<String, Object> o2) {
				Integer i1 = Math.toIntExact((long) o1.get("count"));
				Integer i2 = Math.toIntExact((long) o2.get("count"));
                return i2.compareTo(i1);
            }
        });
	
		int statusCode = HttpStatus.OK.value();

		result.put("dataGroupWidgetList", dataGroupWidgetList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 데이터 상태별 통계 정보
	 * @param request
	 * @return
	 */
	@GetMapping(value = "/data-status-statistics")
	public Map<String, Object> dataStatusStatistics(HttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		Map<String, Object> statistics = new HashMap<>();

		long useTotalCount = dataService.getDataTotalCountByStatus(DataStatus.USE.name().toLowerCase());
		long forbidTotalCount = dataService.getDataTotalCountByStatus(DataStatus.UNUSED.name().toLowerCase());
		long etcTotalCount = dataService.getDataTotalCountByStatus(DataStatus.DELETE.name().toLowerCase());

		statistics.put("useTotalCount", useTotalCount);
		statistics.put("forbidTotalCount", forbidTotalCount);
		statistics.put("etcTotalCount", etcTotalCount);
		int statusCode = HttpStatus.OK.value();

		result.put("statistics", statistics);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 데이터 변경 요청 목록
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/data-adjust-log")
	public Map<String, Object> dataAdjustLogList(HttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		List<DataAdjustLog> dataAdjustLogList = new ArrayList<>();

		
		String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY);
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DATE, -7);
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
		String searchDay = simpleDateFormat.format(calendar.getTime());
		String startDate = searchDay + DateUtils.START_TIME;
		String endDate = today + DateUtils.END_TIME;

		DataAdjustLog dataInfoAdjustLog = new DataAdjustLog();
		dataInfoAdjustLog.setStartDate(startDate);
		dataInfoAdjustLog.setEndDate(endDate);
		dataInfoAdjustLog.setOffset(0l);
		dataInfoAdjustLog.setLimit(WIDGET_LIST_VIEW_COUNT);
		dataAdjustLogList = dataAdjustLogService.getListDataAdjustLog(dataInfoAdjustLog);
		
		int statusCode = HttpStatus.OK.value();

		result.put("dataAdjustLogList", dataAdjustLogList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 사용자 상태별 통계 정보
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/user-status-statistics")
	public Map<String, Object> userStatusStatistics(HttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		Map<String, Object> statistics = new HashMap<>();
		
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

		statistics.put("activeUserTotalCount", activeUserTotalCount);
		statistics.put("fobidUserTotalCount", fobidUserTotalCount);
		statistics.put("failUserTotalCount", String.valueOf(failUserTotalCount));
		statistics.put("sleepUserTotalCount", sleepUserTotalCount);
		statistics.put("expireUserTotalCount", expireUserTotalCount);
		statistics.put("tempPasswordUserTotalCount", tempPasswordUserTotalCount);
	
		int statusCode = HttpStatus.OK.value();

		result.put("statistics", statistics);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 사용자 접근 이력 목록
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/user-access-log")
	public Map<String, Object> userAccessLogList(HttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		List<AccessLog> userAccessLogList = new ArrayList<>();
		
		String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY);
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DATE, -7);
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
		String searchDay = simpleDateFormat.format(calendar.getTime());
		String startDate = searchDay + DateUtils.START_TIME;
		String endDate = today + DateUtils.END_TIME;

		AccessLog accessLog = new AccessLog();
		accessLog.setStartDate(startDate);
		accessLog.setEndDate(endDate);
		accessLog.setOffset(0l);
		accessLog.setLimit(WIDGET_LIST_VIEW_COUNT);
		userAccessLogList = logService.getListAccessLog(accessLog);
		
		int statusCode = HttpStatus.OK.value();

		result.put("userAccessLogList", userAccessLogList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 시민 참여 현황
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/civil-voice-status")
	public Map<String, Object> civilVoiceStatus(HttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		List<CivilVoice> civilVoiceList = new ArrayList<>();

		String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY);
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DATE, -7);
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
		String searchDay = simpleDateFormat.format(calendar.getTime());
		String startDate = searchDay + DateUtils.START_TIME;
		String endDate = today + DateUtils.END_TIME;

		CivilVoice civilVoice = new CivilVoice();
		civilVoice.setStartDate(startDate);
		civilVoice.setEndDate(endDate);
		civilVoice.setOffset(0l);
		civilVoice.setLimit(WIDGET_LIST_VIEW_COUNT);
		civilVoice.setOrderWord("comment_count");
		civilVoice.setOrderValue("desc");
		civilVoiceList = civilVoiceService.getListCivilVoice(civilVoice);
	
		int statusCode = HttpStatus.OK.value();

		result.put("civilVoiceList", civilVoiceList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 시스템 사용 현황
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/system-usage-status")
	public Map<String, Object> systemUsageStatus(HttpServletRequest request) throws Exception {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		Map<String, Object> statistics = new HashMap<>();

		RestTemplate restTemplate = new RestTemplate();
		String serverHost = propertiesConfig.getRestServer();

		URI diskSpaceURI = new URI(serverHost + "/actuator/health/diskSpace");
		@SuppressWarnings("rawtypes")
		ResponseEntity<Map> response1 = restTemplate.getForEntity(diskSpaceURI, Map.class);
		@SuppressWarnings("unchecked")
		Map<String, Long> diskSpace = (Map<String, Long>) response1.getBody().get("details");

		URI memoryMax = new URI(serverHost + "/actuator/metrics/jvm.memory.max");
		@SuppressWarnings("rawtypes")
		ResponseEntity<Map> response2 = restTemplate.getForEntity(memoryMax, Map.class);
		@SuppressWarnings("unchecked")
		List<Map<String, Object>> jvmMemoryMax = (List<Map<String, Object>>) response2.getBody().get("measurements");

		URI memoryUsed = new URI(serverHost + "/actuator/metrics/jvm.memory.used");
		@SuppressWarnings("rawtypes")
		ResponseEntity<Map> response3 = restTemplate.getForEntity(memoryUsed, Map.class);
		@SuppressWarnings("unchecked")
		List<Map<String, Object>> jvmMemoryUsed = (List<Map<String, Object>>) response3.getBody().get("measurements");

		URI cpuMax = new URI(serverHost + "/actuator/metrics/system.cpu.usage");
		@SuppressWarnings("rawtypes")
		ResponseEntity<Map> response4 = restTemplate.getForEntity(cpuMax, Map.class);
		@SuppressWarnings("unchecked")
		List<Map<String, Object>> systemCpuUsage = (List<Map<String, Object>>) response4.getBody().get("measurements");

		URI cpuUsed = new URI(serverHost + "/actuator/metrics/process.cpu.usage");
		@SuppressWarnings("rawtypes")
		ResponseEntity<Map> response5 = restTemplate.getForEntity(cpuUsed, Map.class);
		@SuppressWarnings("unchecked")
		List<Map<String, Object>> processCpuUsage = (List<Map<String, Object>>) response5.getBody().get("measurements");

		statistics.put("diskSpaceTotal", diskSpace.get("total"));
		statistics.put("diskSpaceFree", diskSpace.get("free"));
		statistics.put("jvmMemoryMax", jvmMemoryMax);
		statistics.put("jvmMemoryUsed", jvmMemoryUsed);
		statistics.put("systemCpuUsage", systemCpuUsage);
		statistics.put("processCpuUsage", processCpuUsage);
		
		int statusCode = HttpStatus.OK.value();

		result.put("statistics", statistics);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * DB Connection Pool 현황
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/dbcp-status")
	public Map<String, Object> dbcpStatus(HttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		Map<String, Object> dbcp = new HashMap<>();

		dbcp.put("userSessionCount", SessionUserSupport.signinUsersMap.size());

		dbcp.put("initialSize", dataSource.getMaximumPoolSize());
		dbcp.put("minIdle", dataSource.getMinimumIdle());
		dbcp.put("numIdle", dataSource.getMaximumPoolSize());

//			dbcp.put("initialSize", dataSource.getInitialSize());
////			dbcp.put("maxTotal", dataSource.getMaxTotal());
//			dbcp.put("maxIdle", dataSource.getMaxIdle());
//			dbcp.put("minIdle", dataSource.getMinIdle());
//			dbcp.put("numActive", dataSource.getNumActive());
//			dbcp.put("numIdle", dataSource.getNumIdle());

		// 사용자 dbcp 정보
		Map<String, Integer> userDbcp = getUserDbcp();
		dbcp.put("userUserSessionCount", userDbcp.get("userSessionCount"));
		dbcp.put("userInitialSize", userDbcp.get("initialSize"));
		dbcp.put("userMaxTotal", userDbcp.get("maxTotal"));
		dbcp.put("userMaxIdle", userDbcp.get("maxIdle"));
		dbcp.put("userMinIdle", userDbcp.get("minIdle"));
		dbcp.put("userNumActive", userDbcp.get("numActive"));
		dbcp.put("userNumIdle", userDbcp.get("numIdle"));
	
		int statusCode = HttpStatus.OK.value();

		result.put("dbcp", dbcp);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);

		return result;
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

	/**
	 * 사용자 상태 집계
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/user-status")
	public Map<String, Object> userStatus(HttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		Map<String, Object> statistics;
		
		// 사용자 현황
		List<UserInfo> userInfoStatusList = userService.getUserStatusCount();

		statistics = UserStatus.toEnumHashMap();
		userInfoStatusList.stream().forEach(e -> {
			statistics.put(UserStatus.findByStatus(e.getStatus()).toString(), e.getUserStatusCount());
		});			

		int statusCode = HttpStatus.OK.value();

		result.put("statistics", statistics);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 데이터 공유 타입
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/data-sharing")
	public Map<String, Object> dataSharing(HttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		Map<String, Object> statistics = new HashMap<>();
		
		// 데이터 공유 타입
		DataInfo dataInfo = new DataInfo();
		List<DataInfo> dataSharingList = dataService.getDataSharing(dataInfo);
		dataSharingList.stream().forEach(e -> statistics.put(e.getSharing().toString(), e.getDataCount()));
		
		int statusCode = HttpStatus.OK.value();

		result.put("statistics", statistics);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	/**
	 * 데이터 변환 상태 집계
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/converter-status")
	public Map<String, Object> converterStatus(HttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		Map<String, Object> statistics = new HashMap<>();
		
		// 데이터 변환 상태
		ConverterJob converterJob = new ConverterJob();
		List<ConverterJob> converterJobList = converterService.getConverterJobStatus(converterJob);
		converterJobList.stream().forEach(e -> statistics.put(ConverterJobStatus.findByStatus(e.getStatus()).toString(), e.getStatusCount()));
		
		int statusCode = HttpStatus.OK.value();

		result.put("statistics", statistics);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 업로드 타입 집계
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/upload-type")
	public Map<String, Object> uploadDataType(HttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		Map<String, Object> statistics = new HashMap<>();
		
		// 데이터 변환 상태
		UploadData uploadData = new UploadData();
		List<UploadData> uploadDataList = uploadDataService.getUploadDataType(uploadData);
		uploadDataList.stream().forEach(e -> statistics.put(DataType.findByDataType(e.getDataType()).toString(), e.getDataCount()));

		int statusCode = HttpStatus.OK.value();

		result.put("statistics", statistics);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

}
