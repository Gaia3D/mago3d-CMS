package mago3d.controller.rest;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import mago3d.domain.DataAttribute;
import mago3d.domain.DataInfo;
import mago3d.domain.DataObjectAttribute;
import mago3d.domain.Key;
import mago3d.domain.PageType;
import mago3d.domain.Pagination;
import mago3d.domain.ServerTarget;
import mago3d.domain.UserSession;
import mago3d.service.DataAttributeService;
import mago3d.service.DataObjectAttributeService;
import mago3d.service.DataService;
import mago3d.support.SQLInjectSupport;
import mago3d.utils.DateUtils;

@Slf4j
@RestController
@RequestMapping("/datas")
public class DataRestController {
	private static final long PAGE_ROWS = 5l;
	private static final long PAGE_LIST_COUNT = 5l;
	
	@Autowired
	private DataService dataService;
	
	@Autowired
	private DataAttributeService dataAttributeService;
	
	@Autowired
	private DataObjectAttributeService dataObjectAttributeService;
	
	/**
	 * 데이터 그룹에 속하는 전체 데이터 목록
	 * @param projectId
	 * @return
	 */
	@GetMapping(value = "/{dataGroupId:[0-9]+}/list")
	public Map<String, Object> allList(HttpServletRequest request, @PathVariable Integer dataGroupId) {
		log.info("@@@@@ list dataGroupId = {}", dataGroupId);
		
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		DataInfo dataInfo = new DataInfo();
		//dataInfo.setUserId(userSession.getUserId());
		dataInfo.setDataGroupId(dataGroupId);
		List<DataInfo> dataInfoList = dataService.getAllListData(dataInfo);
		result.put("dataInfoList", dataInfoList);
		int statusCode = HttpStatus.OK.value();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	/**
	 * 데이터 목록
	 * @param request
	 * @param dataInfo
	 * @param pageNo
	 * @return
	 */
	@GetMapping
	public Map<String, Object> list(HttpServletRequest request, DataInfo dataInfo, @RequestParam(defaultValue="1") String pageNo) throws Exception {
		dataInfo.setSearchWord(SQLInjectSupport.replaceSqlInection(dataInfo.getSearchWord()));
		dataInfo.setOrderWord(SQLInjectSupport.replaceSqlInection(dataInfo.getOrderWord()));
		
		log.info("@@@@@ list dataInfo = {}, pageNo = {}", dataInfo, pageNo);
		
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		dataInfo.setUserGroupId(userSession.getUserGroupId());
		dataInfo.setUserId(userSession.getUserId());
		if(!StringUtils.isEmpty(dataInfo.getStartDate())) {
			dataInfo.setStartDate(dataInfo.getStartDate().substring(0, 8) + DateUtils.START_TIME);
		}
		if(!StringUtils.isEmpty(dataInfo.getEndDate())) {
			dataInfo.setEndDate(dataInfo.getEndDate().substring(0, 8) + DateUtils.END_TIME);
		}
		
		long totalCount = dataService.getDataTotalCount(dataInfo);
		
		Pagination pagination = new Pagination(	request.getRequestURI(), 
												getSearchParameters(PageType.LIST, dataInfo), 
												totalCount, 
												Long.parseLong(pageNo),
												PAGE_ROWS,
												PAGE_LIST_COUNT);
		log.info("@@ pagination = {}", pagination);
		
		dataInfo.setOffset(pagination.getOffset());
		dataInfo.setLimit(pagination.getPageRows());
		List<DataInfo> dataList = new ArrayList<>();
		if(totalCount > 0l) {
			dataList = dataService.getListData(dataInfo);
		}
		
		int statusCode = HttpStatus.OK.value();
		
		result.put("pagination", pagination);
		result.put("owner", userSession.getUserId());
		result.put("dataList", dataList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	/**
	 * 데이터 정보
	 * @param projectId
	 * @return
	 */
	@GetMapping("/{dataId:[0-9]+}")
	public Map<String, Object> detail(HttpServletRequest request, @PathVariable Long dataId) {
		log.info("@@@@@ dataId = {}", dataId);
		
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		DataInfo dataInfo = new DataInfo();
		//dataInfo.setUserId(userSession.getUserId());
		dataInfo.setDataId(dataId);
		dataInfo = dataService.getData(dataInfo);
		int statusCode = HttpStatus.OK.value();
		
		result.put("dataInfo", dataInfo);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	/**
	 * 사용자 데이터 수정
	 * @param request
	 * @param dataGroup
	 * @param bindingResult
	 * @return
	 */
	@PostMapping("/{dataId:[0-9]+}")
	public Map<String, Object> update(HttpServletRequest request, @PathVariable Long dataId, @ModelAttribute DataInfo dataInfo) {
		log.info("@@@@@ update dataInfo = {}, dataId = {}", dataInfo, dataId);
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		DataInfo preDataInfo = new DataInfo();
		//dataInfo.setUserId(userSession.getUserId());
		dataInfo.setDataId(dataId);
		preDataInfo = dataService.getData(dataInfo);
		String groupTarget = preDataInfo.getDataGroupTarget();
		
		// 관리자가 업로드 한 경우
		if (ServerTarget.ADMIN == ServerTarget.valueOf(groupTarget.toUpperCase())) {
			if(preDataInfo.getTiling()) {
				result.put("statusCode", HttpStatus.FORBIDDEN.value());
				result.put("errorCode", "data.smart.tiling");
				result.put("message", null);
				return result;
			} else {
				// 변경요청
				return createUpdateRequestResult(result);
			}
		} else if (ServerTarget.USER == ServerTarget.valueOf(groupTarget.toUpperCase())) {
			// 로그인한 아이디와 요청한 아이디가 같을 경우
			if (userSession.getUserId().equals(preDataInfo.getUserId())) {
				BigDecimal longitude = dataInfo.getLongitude();
				BigDecimal latitude = dataInfo.getLatitude();
				if(longitude != null && latitude != null) {
					dataInfo.setLocation("POINT(" + longitude + " " + latitude + ")");
				}
				dataService.updateData(dataInfo);
			} else {
				// 다를 경우 변경 요청
				return createUpdateRequestResult(result);
			}
		}
			
		int statusCode = HttpStatus.OK.value();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	private Map<String, Object> createUpdateRequestResult(Map<String, Object> result) {
		result.put("statusCode", HttpStatus.PRECONDITION_REQUIRED.value());
		result.put("errorCode", "data.update.request.check");
		result.put("message", null);
		return result;
	}
	
	/**
	 * 데이터 속성 정보
	 * @param dataId
	 * @return
	 */
	@GetMapping("/attributes/{dataId:[0-9]+}")
	public Map<String, Object> detailAttribute(HttpServletRequest request, @PathVariable Long dataId) {
		log.info("@@@@@ dataId = {}", dataId);
		
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		DataAttribute dataAttribute = dataAttributeService.getDataAttribute(dataId);
		int statusCode = HttpStatus.OK.value();
		
		result.put("dataAttribute", dataAttribute);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	/**
	 * 데이터 속성 정보
	 * @param dataId
	 * @return
	 */
	@GetMapping("/object/attributes/{dataId:[0-9]+}")
	public Map<String, Object> detailObjectAttribute(HttpServletRequest request, @PathVariable Long dataId) {
		log.info("@@@@@ dataId = {}", dataId);
		
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		DataObjectAttribute dataObjectAttribute = dataObjectAttributeService.getDataObjectAttribute(dataId);
		int statusCode = HttpStatus.OK.value();
		
		result.put("dataObjectAttribute", dataObjectAttribute);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	/**
	 * 검색 조건
	 * @param search
	 * @return
	 */
	private String getSearchParameters(PageType pageType, DataInfo dataInfo) {
		StringBuffer buffer = new StringBuffer(dataInfo.getParameters());
//		buffer.append("&");
//		try {
//			buffer.append("dataName=" + URLEncoder.encode(getDefaultValue(dataInfo.getDataName()), "UTF-8"));
//		} catch(Exception e) {
//			buffer.append("dataName=");
//		}
		
		if (dataInfo.getStatus() != null) {
			buffer.append("&");
			buffer.append("status=");
			buffer.append(dataInfo.getStatus());
		}
		if (dataInfo.getDataType() != null) {
			buffer.append("&");
			buffer.append("dataType=");
			buffer.append(dataInfo.getDataType());
		}
		if (dataInfo.getDataGroupId() != null) {
			buffer.append("&");
			buffer.append("dataGroupId=");
			buffer.append(dataInfo.getDataGroupId());
		}
		return buffer.toString();
	}
	
	private String getDefaultValue(String value) {
		if(value == null || "".equals(value.trim())) {
			return "";
		}
		
		return value;
	}
}
