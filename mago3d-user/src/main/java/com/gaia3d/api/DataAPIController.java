package com.gaia3d.api;

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

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.DataInfoLog;
import com.gaia3d.domain.DataInfoObjectAttribute;
import com.gaia3d.domain.Pagination;
import com.gaia3d.domain.Project;
import com.gaia3d.domain.UserSession;
import com.gaia3d.service.DataService;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.StringUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * Data Rest API 전용
 * TODO /data F4D 파일을 저장하는 폴더가 url이 같은 형태라서 현재는 임시적으로 *.do를 사용하고 있음
 * @author Cheon JeongDae
 *
 */
@Slf4j
@RestController
@RequestMapping("/data/")
public class DataAPIController {

	@Autowired
	private DataService dataService;
	
	/**
	 * 데이터 정보를 취득
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-data-by-data-id.do")
	@ResponseBody
	public Map<String, Object> ajaxDataByDataId(HttpServletRequest request, @RequestParam("data_id") Long data_id) {
		
		log.info("@@@@@@@@@ data_id = {}", data_id);
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			map.put("dataInfo", dataService.getData(data_id));
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
	/**
	 * 데이터 속성 정보를 취득
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-data-attribute-by-data-id.do")
	@ResponseBody
	public Map<String, Object> ajaxDataAttributeByDataId(HttpServletRequest request, @RequestParam("data_id") Long data_id) {
		
		log.info("@@@@@@@@@ data_id = {}", data_id);
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			map.put("dataInfoAttribute", dataService.getDataAttribute(data_id));
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
	/**
	 * Data Object Attribute 검색
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-list-data-object-attribute.do")
	@ResponseBody
	public Map<String, Object> ajaxListDataObjectAttribute(HttpServletRequest request, DataInfoObjectAttribute dataInfoObjectAttribute, @RequestParam(defaultValue="1") String pageNo) {
		log.info("@@ dataInfoObjectAttribute = {}", dataInfoObjectAttribute);
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			if(StringUtil.isNotEmpty(dataInfoObjectAttribute.getStart_date())) {
				dataInfoObjectAttribute.setStart_date(dataInfoObjectAttribute.getStart_date().substring(0, 8) + DateUtil.START_TIME);
			}
			if(StringUtil.isNotEmpty(dataInfoObjectAttribute.getEnd_date())) {
				dataInfoObjectAttribute.setEnd_date(dataInfoObjectAttribute.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
			}
			
			DataInfo dataInfo = new DataInfo();
			dataInfo.setProject_id(dataInfoObjectAttribute.getProject_id());
			dataInfo.setData_key(dataInfoObjectAttribute.getData_key());
			dataInfo = dataService.getDataByDataKey(dataInfo);
			if(dataInfo == null) {
				map.put("result", "data.key.invalid");
				log.info("validate error 발생: {} ", map.toString());
				return map;
			}
			
			dataInfoObjectAttribute.setData_id(dataInfo.getData_id());
			long totalCount = dataService.getDataObjectAttributeTotalCount(dataInfoObjectAttribute);
			
			long pageRows = 10l;
			if(dataInfoObjectAttribute.getList_counter() != null && dataInfoObjectAttribute.getList_counter().longValue() > 0) pageRows = dataInfoObjectAttribute.getList_counter().longValue();
//			Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(dataInfoObjectAttribute), totalCount, Long.valueOf(pageNo).longValue(), pageRows);
//			log.info("@@ pagination = {}", pagination);
			
//			dataInfoObjectAttribute.setOffset(pagination.getOffset());
//			dataInfoObjectAttribute.setLimit(pagination.getPageRows());
			dataInfoObjectAttribute.setOffset(0l);
			dataInfoObjectAttribute.setLimit(50l);
			
			List<DataInfoObjectAttribute> dataInfoObjectAttributeList = new ArrayList<>();
			if(totalCount > 0l) {
				dataInfoObjectAttributeList = dataService.getListDataObjectAttribute(dataInfoObjectAttribute);
			}
			
			map.put("dataInfoObjectAttributeList", dataInfoObjectAttributeList);
			map.put("totalCount", totalCount);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
	
	/**
	 * 데이터 Object 속성 정보를 취득
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-data-object-attribute.do")
	@ResponseBody
	public Map<String, Object> ajaxDataObjectAttribute(HttpServletRequest request, @RequestParam("data_object_attribute_id") Long data_object_attribute_id) {
		
		log.info("@@@@@@@@@ data_object_attribute_id = {}", data_object_attribute_id);
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			map.put("dataInfoObjectAttribute", dataService.getDataObjectAttribute(data_object_attribute_id));
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
	/**
	 * 프로젝트별 데이터 건수에 대한 통계
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-project-data-statistics.do")
	@ResponseBody
	public Map<String, Object> ajaxProjectDataStatistics(HttpServletRequest request) {
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			List<Project> projectList = CacheManager.getProjectList();
			List<String> projectNameList = new ArrayList<>();
			List<Integer> dataTotalCountList = new ArrayList<>();
			for(Project project : projectList) {
				projectNameList.add(project.getProject_name());
				List<DataInfo> dataInfoList = CacheManager.getProjectDataList(project.getProject_id());
				dataTotalCountList.add(dataInfoList.size() - 1);
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
	@RequestMapping(value = "ajax-data-status-statistics.do")
	@ResponseBody
	public Map<String, Object> ajaxDataStatusStatistics(HttpServletRequest request) {
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			long useTotalCount = dataService.getDataTotalCountByStatus(DataInfo.STATUS_USE);
			long forbidTotalCount = dataService.getDataTotalCountByStatus(DataInfo.STATUS_FORBID);
			long etcTotalCount = dataService.getDataTotalCountByStatus(DataInfo.STATUS_ETC);
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
	 * 데이터 Location And Rotation 변경 요청
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-update-data-location-and-rotation.do")
	@ResponseBody
	public Map<String, Object> ajaxUpdateDataLocationAndRotation(HttpServletRequest request, DataInfoLog dataInfoLog) {
		
		log.info("@@@@@@@@@ dataInfoLog = {}", dataInfoLog);
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			if(userSession == null) {
				dataInfoLog.setUser_id("guest");
			} else {
				dataInfoLog.setUser_id(userSession.getUser_id());
			}
			
			dataInfoLog.setMethod_mode("insert");
			String errorcode = dataInfoLog.validate();
			if(errorcode != null) {
				result = errorcode;
				map.put("result", result);
				log.info("validate error 발생: {} ", map.toString());
				return map;
			}
			
			DataInfo dataInfo = new DataInfo();
			dataInfo.setProject_id(dataInfoLog.getProject_id());
			dataInfo.setData_key(dataInfoLog.getData_key());
			dataInfo = dataService.getDataByDataKey(dataInfo);
			
			dataInfoLog.setData_id(dataInfo.getData_id());
			dataInfoLog.setBefore_latitude(dataInfo.getLatitude());
			dataInfoLog.setBefore_longitude(dataInfo.getLongitude());
			dataInfoLog.setBefore_height(dataInfo.getHeight());
			dataInfoLog.setBefore_heading(dataInfo.getHeading());
			dataInfoLog.setBefore_pitch(dataInfo.getPitch());
			dataInfoLog.setBefore_roll(dataInfo.getRoll());
			dataService.updateDataLocationAndRotation(dataInfoLog);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
}
