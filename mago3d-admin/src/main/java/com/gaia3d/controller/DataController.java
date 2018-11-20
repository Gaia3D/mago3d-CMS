package com.gaia3d.controller;

import java.io.File;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gaia3d.config.CacheConfig;
import com.gaia3d.config.PropertiesConfig;
import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.CacheName;
import com.gaia3d.domain.CacheParams;
import com.gaia3d.domain.CacheType;
import com.gaia3d.domain.CommonCode;
import com.gaia3d.domain.DataAttributeFilter;
import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.DataInfoAttribute;
import com.gaia3d.domain.DataInfoObjectAttribute;
import com.gaia3d.domain.DataObjectAttributeFilter;
import com.gaia3d.domain.FileInfo;
import com.gaia3d.domain.FileParseLog;
import com.gaia3d.domain.Pagination;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.Project;
import com.gaia3d.domain.UserSession;
import com.gaia3d.service.DataService;
import com.gaia3d.service.FileService;
import com.gaia3d.service.ProjectService;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.FileUtil;
import com.gaia3d.util.StringUtil;
import com.gaia3d.validator.DataValidator;

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
	private PropertiesConfig propertiesConfig;
	@Autowired
	private MessageSource messageSource;
	
	@Autowired
	private CacheConfig cacheConfig;
	
	@Resource(name="dataValidator")
	private DataValidator dataValidator;
	
	@Autowired
	private ProjectService projectService;
	@Autowired
	private DataService dataService;
	@Autowired
	private FileService fileService;
	
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
		Project project = new Project();
		project.setUse_yn(Project.IN_USE);
		List<Project> projectList = projectService.getListProject(project);
		if(dataInfo.getProject_id() == null) {
			dataInfo.setProject_id(Integer.valueOf(0));
		}
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
		
		boolean txtDownloadFlag = false;
		if(totalCount > 60000l) {
			txtDownloadFlag = true;
		}
		
		@SuppressWarnings("unchecked")
		List<CommonCode> dataRegisterTypeList = (List<CommonCode>)CacheManager.getCommonCode(CommonCode.DATA_REGISTER_TYPE);
		
		// TODO 다국어 처리를 여기서 해야 할거 같은데....
//		Map<String, String> statusMap = new HashMap<>();
//		String welcome = messageSource.getMessage("xxx.xxxx", new Object[]{}, locale);
		
		model.addAttribute(pagination);
		model.addAttribute("dataRegisterTypeList", dataRegisterTypeList);
		model.addAttribute("projectList", projectList);
		model.addAttribute("txtDownloadFlag", Boolean.valueOf(txtDownloadFlag));
		model.addAttribute("dataList", dataList);
		model.addAttribute("excelDataInfo", dataInfo);
		return "/data/list-data";
	}
	
	/**
	 * 프로젝트에 등록된 Data 목록
	 * @param request
	 * @return
	 */
	@GetMapping(value = "ajax-detail-data.do")
	@ResponseBody
	public Map<String, Object> ajaxDetailData(HttpServletRequest request, @RequestParam("data_id") Long data_id) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {		
			DataInfo dataInfo = dataService.getData(data_id);
			map.put("dataInfo", dataInfo);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
	/**
	 * 프로젝트에 등록된 Data 목록
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-list-data-by-project-id.do")
	@ResponseBody
	public Map<String, Object> ajaxListDataByProjectId(HttpServletRequest request, @RequestParam("project_id") Integer project_id) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		List<DataInfo> dataList = new ArrayList<>();
		try {		
			DataInfo dataInfo = new DataInfo();
			dataInfo.setProject_id(project_id);
			dataList = dataService.getListDataByProjectId(dataInfo);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		map.put("dataList", dataList);
		
		return map;
	}
	
	/**
	 * Data 등록 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "input-data.do")
	public String inputData(Model model) {
		Project project = new Project();
		project.setUse_yn(Project.IN_USE);
		List<Project> projectList = projectService.getListProject(project);
		
		Policy policy = CacheManager.getPolicy();
		DataInfo dataInfo = new DataInfo();
		
		model.addAttribute(dataInfo);
		model.addAttribute("policy", policy);
		model.addAttribute("projectList", projectList);
		return "/data/input-data";
	}
	
	/**
	 * Data 등록
	 * @param request
	 * @param dataInfo
	 * @return
	 */
	@PostMapping(value = "ajax-insert-data-info.do")
	@ResponseBody
	public Map<String, Object> ajaxInsertDataInfo(HttpServletRequest request, DataInfo dataInfo) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		
		log.info("@@@@@@@@@@@@@@@@@@ before dataInfo = {}", dataInfo);
		try {
			dataInfo.setMethod_mode("insert");
			String errorcode = dataValidate(dataInfo);
			if(errorcode != null) {
				result = errorcode;
				map.put("result", result);
				return map;
			}
			
			int count = dataService.getDuplicationKeyCount(dataInfo);
			if(count > 0) {
				result = "data.key.duplication";
				map.put("result", result);
				return map;
			}
			
			if(dataInfo.getLatitude() != null && dataInfo.getLatitude().floatValue() != 0f &&
					dataInfo.getLongitude() != null && dataInfo.getLongitude().floatValue() != 0f) {
				dataInfo.setLocation("POINT(" + dataInfo.getLongitude() + " " + dataInfo.getLatitude() + ")");
			}
			
			if(dataInfo.getParent().longValue() == 0l) {
				dataInfo.setDepth(1);
			} else {
				dataInfo.setDepth(dataInfo.getParent_depth() + 1);
			}
			
			if(dataInfo.getParent() == 0l && dataInfo.getDepth() == 1) {
				int rootCount = dataService.getRootParentCount(dataInfo);
				if(rootCount > 0) {
					result = "data.project.root.duplication";
					map.put("result", result);
					return map;
				}
			}
			
			dataInfo.setView_order(dataService.getViewOrderByParent(dataInfo));
			log.info("@@@@@@@@@@@@@@@@@@ after dataInfo = {}", dataInfo);
			
			dataService.insertData(dataInfo);
			
			CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheName(CacheName.DATA_INFO);
			cacheParams.setCacheType(CacheType.BROADCAST);
			cacheParams.setProject_id(dataInfo.getProject_id());
			cacheConfig.loadCache(cacheParams);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		
		return map;
	}
	
	/**
	 * ajax 용 Data validation 체크
	 * @param dataInfo
	 * @return
	 */
	private String dataValidate(DataInfo dataInfo) {
		if(dataInfo.getData_key() == null || "".equals(dataInfo.getData_key())) {
			return "data.input.invalid";
		}
			
		if(dataInfo.getProject_id() == null || dataInfo.getProject_id().longValue() <= 0
				|| dataInfo.getData_name() == null || "".equals(dataInfo.getData_name())) {
			return "data.project.id.invalid";
		}
		
		return null;
	}
	
	/**
	 * Data key 중복 체크
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-data-key-duplication-check.do")
	@ResponseBody
	public Map<String, Object> ajaxDataKeyDuplicationCheck(HttpServletRequest request, DataInfo dataInfo) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		String duplication_value = "";
		try {
			if(dataInfo.getProject_id() == null || dataInfo.getProject_id().longValue() < 0) {
				result = "project.id.empty";
				map.put("result", result);
				return map;
			}
			else if(dataInfo.getData_key() == null || "".equals(dataInfo.getData_key())) {
				result = "data.key.empty";
				map.put("result", result);
				return map;
			} else if(dataInfo.getOld_data_key() != null && !"".equals(dataInfo.getOld_data_key())) {
				if(dataInfo.getData_key().equals(dataInfo.getOld_data_key())) {
					result = "data.key.same";
					map.put("result", result);
					return map;
				}
			}
			
			int count = dataService.getDuplicationKeyCount(dataInfo);
			log.info("@@ duplication_value = {}", count);
			duplication_value = String.valueOf(count);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		map.put("duplication_value", duplication_value);
		
		return map;
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
			dataInfo.setMethod_mode("update");
			String errorcode = dataValidate(dataInfo);
			if(errorcode != null) {
				result = errorcode;
				map.put("result", result);
				return map;
			}
			
			if(dataInfo.getParent() == 0l && dataInfo.getDepth() == 1) {
				int rootCount = dataService.getRootParentCount(dataInfo);
				if(rootCount > 0) {
					result = "data.project.root.duplication";
					map.put("result", result);
					return map;
				}
			}

			if(dataInfo.getLatitude() != null && dataInfo.getLatitude().floatValue() != 0f &&
					dataInfo.getLongitude() != null && dataInfo.getLongitude().floatValue() != 0f) {
				dataInfo.setLocation("POINT(" + dataInfo.getLongitude() + " " + dataInfo.getLatitude() + ")");
			}
			log.info("@@@@@@@@ dataInfo = {}", dataInfo);
			
			dataService.updateData(dataInfo);
			
			CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheName(CacheName.DATA_INFO);
			cacheParams.setCacheType(CacheType.BROADCAST);
			cacheParams.setProject_id(dataInfo.getProject_id());
			cacheConfig.loadCache(cacheParams);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
	
	/**
	 * Data 삭제
	 * @param data_id
	 * @param model
	 * @return
	 */
	@GetMapping(value = "delete-data.do")
	public String deleteData(@RequestParam("data_id") String data_id, Model model) {
		
		// validation 체크 해야 함
		
		DataInfo dataInfo = new DataInfo();
		dataInfo.setData_id(Long.valueOf(data_id));
		
		dataService.deleteData(dataInfo);
		CacheParams cacheParams = new CacheParams();
		cacheParams.setCacheName(CacheName.DATA_INFO);
		cacheParams.setCacheType(CacheType.BROADCAST);
		cacheConfig.loadCache(cacheParams);
		return "redirect:/data/list-data.do";
	}
	
	/**
	 * 선택 Data 삭제
	 * @param request
	 * @param data_select_id
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-delete-datas.do")
	@ResponseBody
	public Map<String, Object> ajaxDeleteDatas(HttpServletRequest request, @RequestParam("check_ids") String check_ids) {
		
		log.info("@@@@@@@ check_ids = {}", check_ids);
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			if(check_ids.length() <= 0) {
				map.put("result", "check.value.required");
				return map;
			}
			
			dataService.deleteDataList(check_ids);
			
			CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheName(CacheName.DATA_INFO);
			cacheParams.setCacheType(CacheType.BROADCAST);
			cacheConfig.loadCache(cacheParams);
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result", "db.exception");
		}
		
		map.put("result", result	);
		return map;
	}
	
	/**
	 * Data 일괄 등록
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-insert-data-file.do")
	@ResponseBody
	public Map<String, Object> ajaxInsertDataFile(MultipartHttpServletRequest request) {
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			Integer project_id = Integer.valueOf(request.getParameter("project_id"));
			MultipartFile multipartFile = request.getFile("data_file_name");
			FileInfo fileInfo = FileUtil.upload(multipartFile, FileUtil.DATA_FILE_UPLOAD, propertiesConfig.getDataUploadDir());
			if(fileInfo.getError_code() != null && !"".equals(fileInfo.getError_code())) {
				map.put("result", fileInfo.getError_code());
				return map;
			}
			
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			fileInfo.setUser_id(userSession.getUser_id());
			
			fileInfo = fileService.insertDataFile(project_id, fileInfo);
			
			map.put("total_count", fileInfo.getTotal_count());
			map.put("parse_success_count", fileInfo.getParse_success_count());
			map.put("parse_error_count", fileInfo.getParse_error_count());
			map.put("insert_success_count", fileInfo.getInsert_success_count());
			map.put("insert_error_count", fileInfo.getInsert_error_count());
			map.put("update_success_count", fileInfo.getUpdate_success_count());
			map.put("update_error_count", fileInfo.getUpdate_error_count());
			
			// 파일 삭제
			File copyFile = new File(fileInfo.getFile_path() + fileInfo.getFile_real_name());
			if(copyFile.exists()) {
				copyFile.delete();
			}
			
			CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheName(CacheName.DATA_INFO);
			cacheParams.setCacheType(CacheType.BROADCAST);
			cacheConfig.loadCache(cacheParams);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		
		return map;
	}
	
	/**
	 * 데이터 attribute 취득
	 * @param request
	 * @param data_id
	 * @return
	 */
	@GetMapping(value = "ajax-detail-data-attribute.do")
	@ResponseBody
	public Map<String, Object> ajaxDetailDataAttribute(HttpServletRequest request, @RequestParam("data_id") Long data_id) {
		log.info("@@@@@@@@@@@@@@@@@@@@ data_id = {}", data_id);
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {		
			DataInfoAttribute dataInfoAttribute = dataService.getDataAttribute(data_id);
			map.put("dataInfoAttribute", dataInfoAttribute);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
	/**
	 * Data Origin Attribute 한건 수정
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-insert-data-attribute-file.do")
	@ResponseBody
	public Map<String, Object> ajaxInsertDataAttributeFile(MultipartHttpServletRequest request) {
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			Long data_id = Long.valueOf(request.getParameter("attribute_file_data_id"));
			MultipartFile multipartFile = request.getFile("attribute_file_name");
			// TODO
			FileInfo fileInfo = FileUtil.upload(multipartFile, FileUtil.DATA_ATTRIBUTE_UPLOAD, propertiesConfig.getDataAttributeUploadDir());
			if(fileInfo.getError_code() != null && !"".equals(fileInfo.getError_code())) {
				log.info("@@@@@@@@@@@@@@@@@@@@ error_code = {}", fileInfo.getError_code());
				map.put("result", fileInfo.getError_code());
				return map;
			}
			
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			fileInfo.setUser_id(userSession.getUser_id());
			
			fileInfo = fileService.insertDataAttributeFile(data_id, fileInfo);
			
			map.put("total_count", fileInfo.getTotal_count());
			map.put("parse_success_count", fileInfo.getParse_success_count());
			map.put("parse_error_count", fileInfo.getParse_error_count());
			map.put("insert_success_count", fileInfo.getInsert_success_count());
			map.put("insert_error_count", fileInfo.getInsert_error_count());
			
			// 파일 삭제
			File copyFile = new File(fileInfo.getFile_path() + fileInfo.getFile_real_name());
			if(copyFile.exists()) {
				copyFile.delete();
			}
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		
		return map;
	}
	
	/**
	 * Data Object Attribute 한건 등록
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-insert-data-object-attribute-file.do")
	@ResponseBody
	public Map<String, Object> ajaxInsertDataObjectAttributeFile(MultipartHttpServletRequest request) {
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			Long data_id = Long.valueOf(request.getParameter("object_attribute_file_data_id"));
			MultipartFile multipartFile = request.getFile("object_attribute_file_name");
			// TODO
			FileInfo fileInfo = FileUtil.upload(multipartFile, FileUtil.DATA_OBJECT_ATTRIBUTE_UPLOAD, propertiesConfig.getDataObjectAttributeUploadDir());
			if(fileInfo.getError_code() != null && !"".equals(fileInfo.getError_code())) {
				log.info("@@@@@@@@@@@@@@@@@@@@ error_code = {}", fileInfo.getError_code());
				map.put("result", fileInfo.getError_code());
				return map;
			}
			
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			fileInfo.setUser_id(userSession.getUser_id());
			
			fileInfo = fileService.insertDataObjectAttributeFile(data_id, fileInfo);
			
			map.put("total_count", fileInfo.getTotal_count());
			map.put("parse_success_count", fileInfo.getParse_success_count());
			map.put("parse_error_count", fileInfo.getParse_error_count());
			map.put("insert_success_count", fileInfo.getInsert_success_count());
			map.put("insert_error_count", fileInfo.getInsert_error_count());
			
			// 파일 삭제
			File copyFile = new File(fileInfo.getFile_path() + fileInfo.getFile_real_name());
			if(copyFile.exists()) {
				copyFile.delete();
			}
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		
		return map;
	}
	
	/**
	 * data attribute 일괄 등록
	 * @param request
	 * @param dataInfoAttribute
	 * @return
	 */
	@PostMapping(value = "ajax-insert-project-data-attribute.do")
	@ResponseBody
	public Map<String, Object> ajaxInsertProjectDataAttribute(HttpServletRequest request, DataInfoAttribute dataInfoAttribute) {
		
		log.info("@@ dataInfoAttribute = {}", dataInfoAttribute);
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			
			int totalCount = 0;
			int insertSuccessCount = 0;
			int updateSuccessCount = 0;
			int insertErrorCount = 0;
			
			FileParseLog fileParseLog = new FileParseLog();
			fileParseLog.setFile_info_id(0l);
			fileParseLog.setLog_type(FileParseLog.DB_INSERT_LOG);
			
			FileInfo fileInfo = new FileInfo();
			fileInfo.setUser_id(userSession.getUser_id());
			
			File dataAttributeDirFile = new File(dataInfoAttribute.getProject_data_attribute_path());
			if(!dataAttributeDirFile.exists()) {
				log.info("@@@ Data Attribute Directory doest not Exist. path = {}", dataInfoAttribute.getProject_data_attribute_path());
				result = "data.attribute.dir.invalid";
				map.put("result", result);
				return map;
			}
			
			File[] fileList = dataAttributeDirFile.listFiles(new DataAttributeFilter());
			totalCount = fileList.length;
			for(File file : fileList) {
				try {
					String fileName = file.getName();
					int startIndex = 0;
					if(fileName.indexOf("F4D_") >= 0) startIndex = fileName.indexOf("F4D_") + 4;
					int endIndex = fileName.toLowerCase().indexOf("_attribute");
					String dataKey = fileName.substring(startIndex, endIndex);
					
					DataInfoAttribute dbDataInfoAttribute = dataService.getDataIdAndDataAttributeIDByDataKey(dataKey);
					if(dbDataInfoAttribute == null) {
						log.info("@@@ data_id does not exist. data_key = {}", dataKey);
						continue;
					}
					
					dataInfoAttribute.setData_attribute_id(dbDataInfoAttribute.getData_attribute_id());
					dataInfoAttribute.setData_id(dbDataInfoAttribute.getData_id());
					
					byte[] jsonData = Files.readAllBytes(Paths.get(file.getAbsolutePath()));
					String attributes = new String(jsonData);
					dataInfoAttribute.setAttributes(attributes);
					
					if(dataInfoAttribute.getData_attribute_id() == null || dataInfoAttribute.getData_attribute_id() == 0l) {
						dataService.insertDataAttribute(dataInfoAttribute);
						insertSuccessCount++;
					} else {
						dataService.updateDataAttribute(dataInfoAttribute);
						updateSuccessCount++;
					}
				} catch(Exception e1) {
					e1.printStackTrace();
					fileParseLog.setIdentifier_value(fileInfo.getUser_id());
					fileParseLog.setError_code(e1.getMessage());
					fileService.insertFileParseLog(fileParseLog);
					insertErrorCount++;
				}
			}
		
			fileInfo.setTotal_count(totalCount);
			fileInfo.setInsert_success_count(insertSuccessCount);
			fileInfo.setUpdate_success_count(updateSuccessCount);
			fileInfo.setInsert_error_count(insertErrorCount);
			fileService.updateFileInfo(fileInfo);
			
			map.put("total_count", fileInfo.getTotal_count());
			map.put("insert_success_count", fileInfo.getInsert_success_count());
			map.put("update_success_count", fileInfo.getUpdate_success_count());
			map.put("insert_error_count", fileInfo.getInsert_error_count());
			
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		
		return map;
	}
	
	/**
	 * Data Object Attribute 일괄 등록
	 * @param request
	 * @return
	 */
	@PostMapping(value = "ajax-insert-project-data-object-attribute.do")
	@ResponseBody
	public Map<String, Object> ajaxInsertProjectDataObjectAttribute(HttpServletRequest request, DataInfoObjectAttribute dataInfoObjectAttribute) {
		
		log.info("@@ dataInfoObjectAttribute = {}", dataInfoObjectAttribute);
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			
			int totalCount = 0;
			int insertSuccessCount = 0;
			int updateSuccessCount = 0;
			int insertErrorCount = 0;
			
			FileParseLog fileParseLog = new FileParseLog();
			fileParseLog.setFile_info_id(0l);
			fileParseLog.setLog_type(FileParseLog.DB_INSERT_LOG);
			
			FileInfo fileInfo = new FileInfo();
			fileInfo.setUser_id(userSession.getUser_id());
			
			File dataObjectAttributeDirFile = new File(dataInfoObjectAttribute.getProject_data_object_attribute_path());
			if(!dataObjectAttributeDirFile.exists()) {
				log.info("@@@ Data Object Attribute Directory doest not Exist. path = {}", dataInfoObjectAttribute.getProject_data_object_attribute_path());
				result = "data.object.attribute.dir.invalid";
				map.put("result", result);
				return map;
			}
				
			File[] fileList = dataObjectAttributeDirFile.listFiles(new DataObjectAttributeFilter());
			totalCount = fileList.length;
			log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ totalCount = {}", totalCount);
			int i=0;
			for(File file : fileList) {
				try {
					String fileName = file.getName();
					int startIndex = 0;
					if(fileName.indexOf("F4D_") >= 0) startIndex = fileName.indexOf("F4D_") + 4;
					int endIndex = fileName.toLowerCase().indexOf("_object");
					String dataKey = fileName.substring(startIndex, endIndex);
					log.info("@@@@@@@@@@ dataKey = {}", dataKey);
					
					DataInfo dataInfo = new DataInfo();
					dataInfo.setProject_id(dataInfoObjectAttribute.getProject_id());
					dataInfo.setData_key(dataKey);
					dataInfo = dataService.getDataByDataKey(dataInfo);
					if(dataInfo == null) {
						log.info("@@@@@@@@@@ data_info is null dataKey = {}", dataKey);
						continue;
					}
					
					// 모든 object id를 삭제 후 등록
					dataService.deleteDataObjects(dataInfo.getData_id());
					
					byte[] jsonData = Files.readAllBytes(Paths.get(file.getAbsolutePath()));
					ObjectMapper objectMapper = new ObjectMapper();
					//read JSON like DOM Parser
					JsonNode rootNode = objectMapper.readTree(jsonData);
					JsonNode objectsNode = rootNode.path("objects");
					Long dataId = dataInfo.getData_id();
					if(objectsNode.isArray() && objectsNode.size() != 0) {
						for(JsonNode node : objectsNode) {
							DataInfoObjectAttribute jsonDataInfoObjectAttribute = new DataInfoObjectAttribute();
							jsonDataInfoObjectAttribute.setData_id(dataId);
							jsonDataInfoObjectAttribute.setObject_id(node.path("guid").asText());
							jsonDataInfoObjectAttribute.setAttributes(node.path("propertySets").toString());
							dataService.insertDataObjectAttribute(jsonDataInfoObjectAttribute);
							totalCount++;
							insertSuccessCount++;
						}
					}
				} catch(Exception e1) {
					e1.printStackTrace();
					fileParseLog.setIdentifier_value(fileInfo.getUser_id());
					fileParseLog.setError_code(e1.getMessage());
					fileService.insertFileParseLog(fileParseLog);
					insertErrorCount++;
				}
				log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ i = {}", i);
				i++;
			}
			
			fileInfo.setTotal_count(totalCount);
			fileInfo.setInsert_success_count(insertSuccessCount);
			fileInfo.setUpdate_success_count(updateSuccessCount);
			fileInfo.setInsert_error_count(insertErrorCount);
			fileService.updateFileInfo(fileInfo);
			
			map.put("total_count", fileInfo.getTotal_count());
			map.put("insert_success_count", fileInfo.getInsert_success_count());
			map.put("update_success_count", fileInfo.getUpdate_success_count());
			map.put("insert_error_count", fileInfo.getInsert_error_count());
			
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
		// TODO 아래 메소드랑 통합
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
		buffer.append("project_id=" + dataInfo.getProject_id());
		buffer.append("&");
		buffer.append("status=" + StringUtil.getDefaultValue(dataInfo.getStatus()));
		buffer.append("&");
		buffer.append("start_date=" + StringUtil.getDefaultValue(dataInfo.getStart_date()));
		buffer.append("&");
		buffer.append("end_date=" + StringUtil.getDefaultValue(dataInfo.getEnd_date()));
		buffer.append("&");
		buffer.append("order_word=" + StringUtil.getDefaultValue(dataInfo.getOrder_word()));
		buffer.append("&");
		buffer.append("order_value=" + StringUtil.getDefaultValue(dataInfo.getOrder_value()));
		buffer.append("&");
		buffer.append("list_count=" + dataInfo.getList_counter());
		return buffer.toString();
	}
	
	/**
	 * 목록 페이지 이동 검색 조건
	 * @param request
	 * @return
	 */
	private String getListParameters(HttpServletRequest request) {
		StringBuffer buffer = new StringBuffer();
		String pageNo = request.getParameter("pageNo");
		buffer.append("pageNo=" + pageNo);
		buffer.append("&");
		buffer.append("search_word=" + StringUtil.getDefaultValue(request.getParameter("search_word")));
		buffer.append("&");
		buffer.append("search_option=" + StringUtil.getDefaultValue(request.getParameter("search_option")));
		buffer.append("&");
		try {
			buffer.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(request.getParameter("search_value")), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			buffer.append("search_value=");
		}
		buffer.append("&");
		buffer.append("project_id=" + request.getParameter("project_id"));
		buffer.append("&");
		buffer.append("status=" + StringUtil.getDefaultValue(request.getParameter("status")));
		buffer.append("&");
		buffer.append("start_date=" + StringUtil.getDefaultValue(request.getParameter("start_date")));
		buffer.append("&");
		buffer.append("end_date=" + StringUtil.getDefaultValue(request.getParameter("end_date")));
		buffer.append("&");
		buffer.append("order_word=" + StringUtil.getDefaultValue(request.getParameter("order_word")));
		buffer.append("&");
		buffer.append("order_value=" + StringUtil.getDefaultValue(request.getParameter("order_value")));
		buffer.append("&");
		buffer.append("list_count=" + StringUtil.getDefaultValue(request.getParameter("list_count")));
		return buffer.toString();
	}
}