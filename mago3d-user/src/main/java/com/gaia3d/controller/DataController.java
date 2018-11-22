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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.CacheName;
import com.gaia3d.domain.CacheParams;
import com.gaia3d.domain.CacheType;
import com.gaia3d.domain.CommonCode;
import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.DataSharingType;
import com.gaia3d.domain.Pagination;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.Project;
import com.gaia3d.domain.UserSession;
import com.gaia3d.service.DataService;
import com.gaia3d.service.ProjectService;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.StringUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * Data
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/data/")
public class DataController {
	
	@Autowired
	private DataService dataService;
	@Autowired
	private ProjectService projectService;
	
	/**
	 * Data 목록
	 * @param request
	 * @param dataInfo
	 * @param pageNo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list-data.do")
	public String listData(HttpServletRequest request, DataInfo dataInfo, @RequestParam(defaultValue="1") String pageNo, Model model) {
		log.info("@@ dataInfo = {}", dataInfo);
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
		String userId = userSession.getUser_id();
		
//		Project project = new Project();
//		project.setUser_id(userId);
//		project.setUse_yn(Project.IN_USE);
//		List<Project> projectList = projectService.getListProject(project);
		
		dataInfo.setSharing_type(DataSharingType.PUBLIC.getValue());
		dataInfo.setUser_id(userId);
		if(StringUtil.isNotEmpty(dataInfo.getStart_date())) {
			dataInfo.setStart_date(dataInfo.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isNotEmpty(dataInfo.getEnd_date())) {
			dataInfo.setEnd_date(dataInfo.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}

		long totalCount = dataService.getDataTotalCount(dataInfo);
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(dataInfo), totalCount, Long.valueOf(pageNo).longValue(), dataInfo.getList_counter());
		log.info("@@ pagination = {}", pagination);
		
		dataInfo.setOffset(pagination.getOffset());
		dataInfo.setLimit(pagination.getPageRows());
		List<DataInfo> dataList = new ArrayList<>();
		if(totalCount > 0l) {
			dataList = dataService.getListData(dataInfo);
		}
		
		// TODO 다국어 처리를 여기서 해야 할거 같은데....
//		Map<String, String> statusMap = new HashMap<>();
//		String welcome = messageSource.getMessage("xxx.xxxx", new Object[]{}, locale);
		
		model.addAttribute(pagination);
//		model.addAttribute("projectList", projectList);
		model.addAttribute("dataList", dataList);
		return "/data/list-data";
	}
	
	/**
	 * Data 정보
	 * @param data_id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "detail-data.do")
	public String detailData(@RequestParam("data_id") String data_id, HttpServletRequest request, Model model) {
		
		String listParameters = getListParameters(request);
			
		DataInfo dataInfo =  dataService.getData(Long.valueOf(data_id));
		
		Policy policy = CacheManager.getPolicy();
		
		model.addAttribute("policy", policy);
		model.addAttribute("listParameters", listParameters);
		model.addAttribute("dataInfo", dataInfo);
		
		return "/data/detail-data";
	}
	
	/**
	 * Data 정보 수정 화면
	 * @param data_id
	 * @param model
	 * @return
	 */
	@GetMapping(value = "modify-data.do")
	public String modifyData(HttpServletRequest request, @RequestParam("data_id") Long data_id, Model model) {
		
		String listParameters = getListParameters(request);
		
		Project project = new Project();
		project.setUse_yn(Project.IN_USE);
		List<Project> projectList = projectService.getListProject(project);
		DataInfo dataInfo =  dataService.getData(data_id);
		dataInfo.setOld_data_key(dataInfo.getData_key());
		
		log.info("@@@@@@@@ dataInfo = {}", dataInfo);
		Policy policy = CacheManager.getPolicy();
		
		@SuppressWarnings("unchecked")
		List<CommonCode> dataRegisterTypeList = (List<CommonCode>)CacheManager.getCommonCode(CommonCode.DATA_REGISTER_TYPE);
		
		model.addAttribute("dataRegisterTypeList", dataRegisterTypeList);
		model.addAttribute("listParameters", listParameters);
		model.addAttribute("policy", policy);
		model.addAttribute("projectList", projectList);
		model.addAttribute(dataInfo);
		
		return "/data/modify-data";
	}
	
	/**
	 * Data 정보 수정
	 * @param request
	 * @param dataInfo
	 * @return
	 */
	@PostMapping(value = "ajax-update-data-info.do")
	@ResponseBody
	public Map<String, Object> ajaxUpdateDataInfo(HttpServletRequest request, DataInfo dataInfo) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		
		log.info("@@ dataInfo = {}", dataInfo);
		try {
//			dataInfo.setMethod_mode("update");
//			String errorcode = dataValidate(dataInfo);
//			if(errorcode != null) {
//				result = errorcode;
//				map.put("result", result);
//				return map;
//			}
//			
//			if(dataInfo.getParent() == 0l && dataInfo.getDepth() == 1) {
//				int rootCount = dataService.getRootParentCount(dataInfo);
//				if(rootCount > 0) {
//					result = "data.project.root.duplication";
//					map.put("result", result);
//					return map;
//				}
//			}

			if(dataInfo.getLatitude() != null && dataInfo.getLatitude().floatValue() != 0f &&
					dataInfo.getLongitude() != null && dataInfo.getLongitude().floatValue() != 0f) {
				dataInfo.setLocation("POINT(" + dataInfo.getLongitude() + " " + dataInfo.getLatitude() + ")");
			}
			log.info("@@@@@@@@ dataInfo = {}", dataInfo);
			
			dataService.updateData(dataInfo);
			
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
	
	/**
	 * 데이터 검색
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "ajax-search-data.do")
	@ResponseBody
	public Map<String, Object> ajaxSearchData(HttpServletRequest request, DataInfo dataInfo, @RequestParam(defaultValue="1") String pageNo) {
		log.info("@@ dataInfo = {}", dataInfo);
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			dataInfo.setUser_id(userSession.getUser_id());
			
			log.info("@@ dataInfo = {}", dataInfo);
			if(StringUtil.isNotEmpty(dataInfo.getStart_date())) {
				dataInfo.setStart_date(dataInfo.getStart_date().substring(0, 8) + DateUtil.START_TIME);
			}
			if(StringUtil.isNotEmpty(dataInfo.getEnd_date())) {
				dataInfo.setEnd_date(dataInfo.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
			}
			
			long totalCount = dataService.getDataTotalCount(dataInfo);
			
			long pageRows = 10l;
			if(dataInfo.getList_counter() != null && dataInfo.getList_counter().longValue() > 0) pageRows = dataInfo.getList_counter().longValue();
			Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(dataInfo), totalCount, Long.valueOf(pageNo).longValue(), pageRows);
			log.info("@@ pagination = {}", pagination);
			
			dataInfo.setOffset(pagination.getOffset());
			dataInfo.setLimit(pagination.getPageRows());
			List<DataInfo> dataInfoList = new ArrayList<>();
			if(totalCount > 0l) {
				dataInfoList = dataService.getListData(dataInfo);
			}
			
			map.put("dataInfoList", dataInfoList);
			map.put("totalCount", totalCount);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
	
	/**
	 * 검색 조건
	 * @param dataInfo
	 * @return
	 */
	private String getSearchParameters(DataInfo dataInfo) {
		StringBuffer buffer = new StringBuffer();
		buffer.append("&");
		buffer.append("search_word=" + StringUtil.getDefaultValue(dataInfo.getSearch_word()));
		buffer.append("&");
		buffer.append("search_option=" + StringUtil.getDefaultValue(dataInfo.getSearch_option()));
		buffer.append("&");
		try {
			buffer.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(dataInfo.getSearch_value()), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			buffer.append("search_value=");
		}
		buffer.append("&");
		buffer.append("start_date=" + StringUtil.getDefaultValue(dataInfo.getStart_date()));
		buffer.append("&");
		buffer.append("end_date=" + StringUtil.getDefaultValue(dataInfo.getEnd_date()));
		buffer.append("&");
		buffer.append("order_word=" + StringUtil.getDefaultValue(dataInfo.getOrder_word()));
		buffer.append("&");
		buffer.append("order_value=" + StringUtil.getDefaultValue(dataInfo.getOrder_value()));
		return buffer.toString();
	}
}