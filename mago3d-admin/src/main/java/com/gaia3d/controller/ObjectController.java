package com.gaia3d.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.CommonCode;
import com.gaia3d.domain.FileInfo;
import com.gaia3d.domain.ObjectGroup;
import com.gaia3d.domain.ObjectInfo;
import com.gaia3d.domain.Pagination;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.UserSession;
import com.gaia3d.service.FileService;
import com.gaia3d.service.ObjectGroupService;
import com.gaia3d.service.ObjectService;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.FileUtil;
import com.gaia3d.util.StringUtil;
import com.gaia3d.validator.ObjectValidator;
import com.google.gson.Gson;

import lombok.extern.slf4j.Slf4j;

/**
 * Object
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/object/")
public class ObjectController {
	
	// Object 일괄 등록
	private String EXCEL_OBJECT_UPLOAD_DIR;
	// Object 샘플 다운로드
	private String EXCEL_SAMPLE_DIR;
	
	@Resource(name="objectValidator")
	private ObjectValidator objectValidator;
	
	@Autowired
	private ObjectGroupService objectGroupService;
	@Autowired
	private ObjectService objectService;
	@Autowired
	private FileService fileService;
	
	/**
	 * Object 목록
	 * @param request
	 * @param objectInfo
	 * @param pageNo
	 * @param list_counter
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list-object.do")
	public String listObject(	HttpServletRequest request, ObjectInfo objectInfo, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		log.info("@@ objectInfo = {}", objectInfo);
		ObjectGroup objectGroup = new ObjectGroup();
		objectGroup.setUse_yn(ObjectGroup.IN_USE);
		List<ObjectGroup> objectGroupList = objectGroupService.getListObjectGroup(objectGroup);
		if(objectInfo.getObject_group_id() == null) {
			objectInfo.setObject_group_id(Long.valueOf(0l));
		}
		if(StringUtil.isNotEmpty(objectInfo.getStart_date())) {
			objectInfo.setStart_date(objectInfo.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isNotEmpty(objectInfo.getEnd_date())) {
			objectInfo.setEnd_date(objectInfo.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}

		long totalCount = objectService.getObjectTotalCount(objectInfo);
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(objectInfo), totalCount, Long.valueOf(pageNo).longValue(), objectInfo.getList_counter());
		log.info("@@ pagination = {}", pagination);
		
		objectInfo.setOffset(pagination.getOffset());
		objectInfo.setLimit(pagination.getPageRows());
		List<ObjectInfo> objectList = new ArrayList<ObjectInfo>();
		if(totalCount > 0l) {
			objectList = objectService.getListObject(objectInfo);
		}
		
		boolean txtDownloadFlag = false;
		if(totalCount > 60000l) {
			txtDownloadFlag = true;
		}
		
		CommonCode objectInsertType = CacheManager.getCommonCode(CommonCode.OBJECT_REGISTER);
		CommonCode externalObjectInsertType = CacheManager.getCommonCode(CommonCode.EXTERNAL_OBJECT_REGISTER);
		
		model.addAttribute(pagination);
		model.addAttribute("objectInsertType", objectInsertType);
		model.addAttribute("externalObjectInsertType", externalObjectInsertType);
		model.addAttribute("objectGroupList", objectGroupList);
		model.addAttribute("txtDownloadFlag", Boolean.valueOf(txtDownloadFlag));
		model.addAttribute("objectList", objectList);
		model.addAttribute("excelObjectInfo", objectInfo);
		return "/object/list-object";
	}
	
	/**
	 * Object 그룹 등록된 Object 목록
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-list-object-group-object.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public String ajaxListObjectGroupObject(HttpServletRequest request, @RequestParam("object_group_id") Long object_group_id, @RequestParam(defaultValue="1") String pageNo) {
		Gson gson = new Gson();
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		Pagination pagination = null;
		List<ObjectInfo> objectList = new ArrayList<ObjectInfo>();
		try {		
			ObjectInfo objectInfo = new ObjectInfo();
			objectInfo.setObject_group_id(object_group_id);
			
			long totalCount = objectService.getObjectTotalCount(objectInfo);
			pagination = new Pagination(request.getRequestURI(), getSearchParameters(objectInfo), totalCount, Long.valueOf(pageNo).longValue());
			
			objectInfo.setOffset(pagination.getOffset());
			objectInfo.setLimit(pagination.getPageRows());
			if(totalCount > 0l) {
				objectList = objectService.getListObject(objectInfo);
			}
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		jSONObject.put("result", result);
		jSONObject.put("pagination", pagination);
		jSONObject.put("objectList", objectList);
		
		log.info(">>>>>>>>>>>>>>>>>> objectlist = {}", gson.toJson(jSONObject));
		
		return gson.toJson(jSONObject);
	}
	
	/**
	 * Object 그룹 전체 Object 에서 선택한 Object 그룹에 등록된 Object 를 제외한 Object 목록
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-list-except-object-group-object-by-group-id.do")
	@ResponseBody
	public String ajaxListExceptObjectGroupObjectByGroupId(HttpServletRequest request, ObjectInfo objectInfo, @RequestParam(defaultValue="1") String pageNo) {
		Gson gson = new Gson();
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		Pagination pagination = null;
		List<ObjectInfo> objectList = new ArrayList<ObjectInfo>();
		try {
			long totalCount = objectService.getExceptObjectGroupObjectByGroupIdTotalCount(objectInfo);
			pagination = new Pagination(request.getRequestURI(), getSearchParameters(objectInfo), totalCount, Long.valueOf(pageNo).longValue());
			
			objectInfo.setOffset(pagination.getOffset());
			objectInfo.setLimit(pagination.getPageRows());
			if(totalCount > 0l) {
				objectList = objectService.getListExceptObjectGroupObjectByGroupId(objectInfo);
			}
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		jSONObject.put("result", result);
		jSONObject.put("pagination", pagination);
		jSONObject.put("objectList", objectList);
		return gson.toJson(jSONObject);
	}
	
	/**
	 * 선택한 Object 그룹에 등록된 Object 목록
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-list-object-group-object-by-group-id.do")
	@ResponseBody
	public String ajaxListObjectGroupObjectByGroupId(HttpServletRequest request, ObjectInfo objectInfo, @RequestParam(defaultValue="1") String pageNo) {
		Gson gson = new Gson();
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		Pagination pagination = null;
		List<ObjectInfo> objectList = new ArrayList<ObjectInfo>();
		try {
			
			long totalCount = objectService.getObjectTotalCount(objectInfo);
			pagination = new Pagination(request.getRequestURI(), getSearchParameters(objectInfo), totalCount, Long.valueOf(pageNo).longValue());
			
			objectInfo.setOffset(pagination.getOffset());
			objectInfo.setLimit(pagination.getPageRows());
			if(totalCount > 0l) {
				objectList = objectService.getListObject(objectInfo);
			}
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		jSONObject.put("result", result);
		jSONObject.put("pagination", pagination);
		jSONObject.put("objectList", objectList);
		return gson.toJson(jSONObject);
	}
	
	/**
	 * Object 등록 화면
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "input-object.do", method = RequestMethod.GET)
	public String inputObject(Model model) {
		
		ObjectGroup objectGroup = new ObjectGroup();
		objectGroup.setUse_yn(ObjectGroup.IN_USE);
		List<ObjectGroup> objectGroupList = objectGroupService.getListObjectGroup(objectGroup);
		
		Policy policy = CacheManager.getPolicy();
		ObjectInfo objectInfo = new ObjectInfo();
		
		model.addAttribute(objectInfo);
		model.addAttribute("policy", policy);
		model.addAttribute("objectGroupList", objectGroupList);
		return "/object/input-object";
	}
	
	/**
	 * Object 등록
	 * @param request
	 * @param objectInfo
	 * @return
	 */
	@RequestMapping(value = "ajax-insert-object-info.do", method = RequestMethod.POST)
	@ResponseBody
	public String ajaxInsertObjectInfo(HttpServletRequest request, ObjectInfo objectInfo) {
		Gson gson = new Gson();
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {
			objectInfo.setMethod_mode("insert");
			String errorcode = objectValidate(CacheManager.getPolicy(), objectInfo);
			if(errorcode != null) {
				result = errorcode;
				jSONObject.put("result", result);
				return jSONObject.toString();
			}
			
			int count = objectService.getDuplicationIdCount(objectInfo.getObject_id());
			if(count > 0) {
				result = "object.id.duplication";
				jSONObject.put("result", result);
				return jSONObject.toString();
			}
			
			objectService.insertObject(objectInfo);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		jSONObject.put("result", result);
		
		return gson.toJson(jSONObject);
	}
	
	/**
	 * 선택 Object 그룹내 Object 등록
	 * @param request
	 * @param object_all_id
	 * @param object_group_id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "ajax-insert-object-group-object.do", method = RequestMethod.POST)
	@ResponseBody
	public String ajaxInsertObjectGroupObject(HttpServletRequest request,
			@RequestParam("object_group_id") Long object_group_id,
			@RequestParam("object_all_id") String[] object_all_id) {
		
		log.info("@@@ object_group_id = {}, object_all_id = {}", object_group_id, object_all_id);
		Gson gson = new Gson();
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		List<ObjectInfo> exceptObjectList = new ArrayList<ObjectInfo>();
		List<ObjectInfo> objectList = new ArrayList<ObjectInfo>();
		String result = "success";
		try {
			if(object_group_id == null || object_group_id.longValue() == 0l ||				
					object_all_id == null || object_all_id.length < 1) {
				result = "input.invalid";
				jSONObject.put("result", result);
				return jSONObject.toString();
			}
			
			ObjectInfo objectInfo = new ObjectInfo();
			objectInfo.setObject_group_id(object_group_id);
			objectInfo.setObject_all_id(object_all_id);
			
			objectService.updateObjectGroupObject(objectInfo);
			
			objectList = objectService.getListObject(objectInfo);
			exceptObjectList = objectService.getListExceptObjectGroupObjectByGroupId(objectInfo);
		} catch(Exception e) {
			e.printStackTrace();
			jSONObject.put("result", "db.exception");
		}
		
		jSONObject.put("result", result	);
		jSONObject.put("exceptObjectList", exceptObjectList);
		jSONObject.put("objectList", objectList);
		return gson.toJson(jSONObject);
	}
	
	/**
	 * ajax 용 Object validation 체크
	 * @param objectInfo
	 * @return
	 */
	private String objectValidate(Policy policy, ObjectInfo objectInfo) {
		
		// 비밀번호 변경이 아닐경우
		if(!"updatePassword".equals(objectInfo.getMethod_mode())) {
			if(objectInfo.getObject_id() == null || "".equals(objectInfo.getObject_id())) {
				return "object.input.invalid";
			}
			
			if(objectInfo.getObject_group_id() == null || objectInfo.getObject_group_id() <= 0
					|| objectInfo.getObject_name() == null || "".equals(objectInfo.getObject_name())) {
				return "object.input.invalid";
			}
		}
		
		return null;
	}
	
	/**
	 * Object 아이디 중복 체크
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "ajax-object-id-duplication-check.do", method = RequestMethod.POST)
	@ResponseBody
	public String ajaxObjectIdDuplicationCheck(HttpServletRequest request, ObjectInfo objectInfo) {
		Gson gson = new Gson();
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		String duplication_value = "";
		try {
			if(objectInfo.getObject_id() == null || "".equals(objectInfo.getObject_id())) {
				result = "object.id.empty";
				jSONObject.put("result", result);
				return jSONObject.toString();
			}
			
			int count = objectService.getDuplicationIdCount(objectInfo.getObject_id());
			log.info("@@ duplication_value = {}", count);
			duplication_value = String.valueOf(count);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		jSONObject.put("result", result);
		jSONObject.put("duplication_value", duplication_value);
		
		return gson.toJson(jSONObject);
	}
	
	/**
	 * Object 정보
	 * @param object_id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "detail-object.do")
	public String detailObject(@RequestParam("object_id") String object_id, HttpServletRequest request, Model model) {
		
		String listParameters = getListParameters(request);
			
		ObjectInfo objectInfo =  objectService.getObject(Long.valueOf(object_id));
		
		Policy policy = CacheManager.getPolicy();
		
		model.addAttribute("policy", policy);
		model.addAttribute("listParameters", listParameters);
		model.addAttribute("objectInfo", objectInfo);
		
		return "/object/detail-object";
	}
	
	/**
	 * Object 정보 수정 화면
	 * @param object_id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "modify-object.do", method = RequestMethod.GET)
	public String modifyObject(@RequestParam("object_id") String object_id, HttpServletRequest request, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		String listParameters = getListParameters(request);
		
		ObjectGroup objectGroup = new ObjectGroup();
		objectGroup.setUse_yn(ObjectGroup.IN_USE);
		List<ObjectGroup> objectGroupList = objectGroupService.getListObjectGroup(objectGroup);
		ObjectInfo objectInfo =  objectService.getObject(Long.valueOf(object_id));
		
		log.info("@@@@@@@@ objectInfo = {}", objectInfo);
		Policy policy = CacheManager.getPolicy();
		
		model.addAttribute("externalObjectRegister", CacheManager.getCommonCode(CommonCode.EXTERNAL_OBJECT_REGISTER));
		model.addAttribute("listParameters", listParameters);
		model.addAttribute("policy", policy);
		model.addAttribute("objectGroupList", objectGroupList);
		model.addAttribute(objectInfo);
		
		return "/object/modify-object";
	}
	
	/**
	 * Object 정보 수정
	 * @param request
	 * @param objectInfo
	 * @return
	 */
	@RequestMapping(value = "ajax-update-object-info.do", method = RequestMethod.POST)
	@ResponseBody
	public String ajaxUpdateObjectInfo(HttpServletRequest request, ObjectInfo objectInfo) {
		Gson gson = new Gson();
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {
			Policy policy = CacheManager.getPolicy();
			objectInfo.setMethod_mode("update");
			String errorcode = objectValidate(policy,objectInfo);
			if(errorcode != null) {
				result = errorcode;
				jSONObject.put("result", result);
				return jSONObject.toString();
			}
						
			objectService.updateObject(objectInfo);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		jSONObject.put("result", result);
		
		return gson.toJson(jSONObject);
	}
	
	/**
	 * Object 상태 수정(패스워드 실패 잠금, 해제 등)
	 * @param request
	 * @param objectInfo
	 * @return
	 */
	@RequestMapping(value = "ajax-update-object-status.do", method = RequestMethod.POST)
	@ResponseBody
	public String ajaxUpdateObjectStatus(	HttpServletRequest request, 
										@RequestParam("check_ids") String check_ids, 
										@RequestParam("business_type") String business_type, 
										@RequestParam("status_value") String status_value) {
		
		log.info("@@@@@@@ check_ids = {}, business_type = {}, status_value = {}", check_ids, business_type, status_value);
		Gson gson = new Gson();
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		String result_message = "";
		try {
			if(check_ids.length() <= 0) {
				jSONObject.put("result", "check.value.required");
				return jSONObject.toString();
			}
			List<String> objectList = objectService.updateObjectStatus(business_type, status_value, check_ids);
			if(!objectList.isEmpty()) {
				int count = objectList.size();
				int i = 1;
				for(String objectId : objectList) {
					if(count == i) {
						result_message = result_message + objectId;
					} else {
						result_message = result_message + objectId + ", ";
					}
					i++;
				}
				
				String[] objectIds = check_ids.split(",");
				jSONObject.put("update_count", objectIds.length - objectList.size());
				jSONObject.put("business_type", business_type);
				jSONObject.put("result_message", result_message);
			}
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		jSONObject.put("result", result);
		
		return gson.toJson(jSONObject);
	}
	
	/**
	 * Object 삭제
	 * @param object_id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "delete-object.do", method = RequestMethod.GET)
	public String deleteObject(@RequestParam("object_id") String object_id, Model model) {
		
		// validation 체크 해야 함
		objectService.deleteObject(Long.valueOf(object_id));
		return "redirect:/object/list-object.do";
	}
	
	/**
	 * 선택 Object 삭제
	 * @param request
	 * @param object_select_id
	 * @param object_group_id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "ajax-delete-objects.do", method = RequestMethod.POST)
	@ResponseBody
	public String ajaxDeleteObjects(HttpServletRequest request, @RequestParam("check_ids") String check_ids) {
		
		log.info("@@@@@@@ check_ids = {}", check_ids);
		Gson gson = new Gson();
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {
			if(check_ids.length() <= 0) {
				jSONObject.put("result", "check.value.required");
				return jSONObject.toString();
			}
			
			objectService.deleteObjectList(check_ids);
		} catch(Exception e) {
			e.printStackTrace();
			jSONObject.put("result", "db.exception");
		}
		
		jSONObject.put("result", result	);
		return gson.toJson(jSONObject);
	}
	
	/**
	 * 선택 Object 그룹내 Object 삭제
	 * @param request
	 * @param object_select_id
	 * @param object_group_id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "ajax-delete-object-group-object.do", method = RequestMethod.POST)
	@ResponseBody
	public String ajaxDeleteObjectGroupObject(HttpServletRequest request,
			@RequestParam("object_group_id") Long object_group_id,
			@RequestParam("object_select_id") String[] object_select_id) {
		
		log.info("@@@ object_group_id = {}, object_select_id = {}", object_group_id, object_select_id);
		Gson gson = new Gson();
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		List<ObjectInfo> exceptObjectList = new ArrayList<ObjectInfo>();
		List<ObjectInfo> objectList = new ArrayList<ObjectInfo>();
		String result = "success";
		try {
			if(object_group_id == null || object_group_id.longValue() == 0l ||				
					object_select_id == null || object_select_id.length < 1) {
				result = "input.invalid";
				jSONObject.put("result", result);
				return jSONObject.toString();
			}
			
			ObjectInfo objectInfo = new ObjectInfo();
			objectInfo.setObject_group_id(object_group_id);
			objectInfo.setObject_select_id(object_select_id);
			
			objectService.updateObjectGroupObject(objectInfo);
			
			// UPDATE 문에서 object_group_id 를 temp 그룹으로 변경
			objectInfo.setObject_group_id(object_group_id);
			
			objectList = objectService.getListObject(objectInfo);
			exceptObjectList = objectService.getListExceptObjectGroupObjectByGroupId(objectInfo);
		} catch(Exception e) {
			e.printStackTrace();
			jSONObject.put("result", "db.exception");
		}
		
		jSONObject.put("result", result	);
		jSONObject.put("exceptObjectList", exceptObjectList);
		jSONObject.put("objectList", objectList);
		return gson.toJson(jSONObject);
	}
	
	/**
	 * Object 일괄 등록 화면
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "popup-input-excel-object.do", method = RequestMethod.GET)
	public String popupInputExcelObject(Model model) {
		
		FileInfo fileInfo = new FileInfo();
		
		model.addAttribute("fileInfo", fileInfo);
		
		return "/object/popup-input-excel-object";
	}
	
	/**
	 * Object 일괄 등록
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "ajax-insert-excel-object.do", method = RequestMethod.POST)
	@ResponseBody
	public String ajaxInsertExcelObject(MultipartHttpServletRequest request) {
		
		Gson gson = new Gson();
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {
			MultipartFile multipartFile = request.getFile("file_name");
			FileInfo fileInfo = FileUtil.uploadExcel(multipartFile, FileUtil.EXCEL_USER_UPLOAD, EXCEL_OBJECT_UPLOAD_DIR);
			if(fileInfo.getError_code() != null && !"".equals(fileInfo.getError_code())) {
				jSONObject.put("result", fileInfo.getError_code());
				return jSONObject.toString();
			}
			
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			fileInfo.setUser_id(userSession.getUser_id());
			
//			fileInfo = fileService.insertExcelObject(fileInfo);
			
			jSONObject.put("total_count", fileInfo.getTotal_count());
			jSONObject.put("parse_success_count", fileInfo.getParse_success_count());
			jSONObject.put("parse_error_count", fileInfo.getParse_error_count());
			jSONObject.put("insert_success_count", fileInfo.getInsert_success_count());
			jSONObject.put("insert_error_count", fileInfo.getInsert_error_count());
			
			// 파일 삭제
			File copyFile = new File(fileInfo.getFile_path() + fileInfo.getFile_real_name());
			if(copyFile.exists()) {
				copyFile.delete();
			}
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		jSONObject.put("result", result);
		
		return gson.toJson(jSONObject);
	}
	
	/**
	 * Object Excel 다운로드
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "download-excel-object.do")
	public ModelAndView downloadExcelObject(HttpServletRequest request, HttpServletResponse response, ObjectInfo objectInfo, Model model) {
		log.info("@@ objectInfo = {}", objectInfo);
		if(objectInfo.getObject_group_id() == null) {
			objectInfo.setObject_group_id(Long.valueOf(0l));
		}
		if(StringUtil.isNotEmpty(objectInfo.getStart_date())) {
			objectInfo.setStart_date(objectInfo.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isNotEmpty(objectInfo.getEnd_date())) {
			objectInfo.setEnd_date(objectInfo.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}
		
		long totalCount = 0l;
		List<ObjectInfo> objectList = new ArrayList<ObjectInfo>();
		try {
			// 논리적 삭제는 SELECT에서 제외
//			objectInfo.setDelete_flag(ObjectInfo.STATUS_LOGICAL_DELETE);
			totalCount = objectService.getObjectTotalCount(objectInfo);
			long pageNo = 1l;
			long lastPage = 0l;
			long pagePerCount = 1000l;
			long pageListCount = 1000l;
			if(totalCount > 0l) {
				Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(objectInfo), totalCount, pageNo, pagePerCount, pageListCount);
				lastPage = pagination.getLastPage();
				for(; pageNo<= lastPage; pageNo++) {
					pagination = new Pagination(request.getRequestURI(), getSearchParameters(objectInfo), totalCount, pageNo, pagePerCount, pageListCount);
					log.info("@@ pagination = {}", pagination);
					
					objectInfo.setOffset(pagination.getOffset());
					objectInfo.setLimit(pagination.getPageRows());
					List<ObjectInfo> subObjectList = objectService.getListObject(objectInfo);
					
					objectList.addAll(subObjectList);
					
					Thread.sleep(3000);
				}
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
	
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("pOIExcelView");
		modelAndView.addObject("fileType", "USER_LIST");
		modelAndView.addObject("fileName", "USER_LIST");
		modelAndView.addObject("objectList", objectList);	
		return modelAndView;
	}
	
	/**
	 * Object Txt 다운로드
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "download-txt-object.do")
	@ResponseBody
	public String downloadTxtObject(HttpServletRequest request, HttpServletResponse response, ObjectInfo objectInfo, Model model) {
		
		response.setContentType("application/force-download");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Content-Disposition", "attachment; filename=\"object_info.txt\"");
		
		log.info("@@ objectInfo = {}", objectInfo);
		if(objectInfo.getObject_group_id() == null) {
			objectInfo.setObject_group_id(Long.valueOf(0l));
		}
		if(StringUtil.isNotEmpty(objectInfo.getStart_date())) {
			objectInfo.setStart_date(objectInfo.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isNotEmpty(objectInfo.getEnd_date())) {
			objectInfo.setEnd_date(objectInfo.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}
		
		long totalCount = 0l;
		try {
			// 논리적 삭제는 SELECT에서 제외
//			objectInfo.setDelete_flag(ObjectInfo.STATUS_LOGICAL_DELETE);
			totalCount = objectService.getObjectTotalCount(objectInfo);
			long pageNo = 1l;
			long lastPage = 0l;
			long pagePerCount = 1000l;
			long pageListCount = 1000l;
			long number = 1l;
			String SEPARATE = "|";
			String NEW_LINE = "\n";
			if(totalCount > 0l) {
				Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(objectInfo), totalCount, pageNo, pagePerCount, pageListCount);
				lastPage = pagination.getLastPage();
				for(; pageNo<= lastPage; pageNo++) {
					pagination = new Pagination(request.getRequestURI(), getSearchParameters(objectInfo), totalCount, pageNo, pagePerCount, pageListCount);
					log.info("@@ pagination = {}", pagination);
					
					objectInfo.setOffset(pagination.getOffset());
					objectInfo.setLimit(pagination.getPageRows());
					List<ObjectInfo> objectList = objectService.getListObject(objectInfo);
					
					int count = objectList.size();
					for(int j=0; j<count; j++) {
						ObjectInfo dbObjectInfo = objectList.get(j);
						String data = number 
									+ SEPARATE + dbObjectInfo.getObject_group_name() + SEPARATE + dbObjectInfo.getObject_id()
									+ SEPARATE + dbObjectInfo.getObject_name()+ SEPARATE + dbObjectInfo.getViewStatus()
									+ NEW_LINE;
						response.getWriter().write(data);
						number++;
					}
					Thread.sleep(3000);
				}
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
	
		return null;
	}
	
	/**
	 * Object 다운로드 Sample
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "download-excel-object-sample.do")
	@ResponseBody
	public void downloadExcelObjectSample(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		File rootDirectory = new File(EXCEL_SAMPLE_DIR);
		if(!rootDirectory.exists()) {
			rootDirectory.mkdir();
		}
				
		File file = new File(EXCEL_SAMPLE_DIR + "sample.xlsx");
		if(file.exists()) {
			String mimetype = "application/x-msdownload";
			response.setContentType(mimetype);
			String dispositionPrefix = "attachment; filename=";
			String encodedFilename = "sample.xlsx";

			response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);
			response.setContentLength((int)file.length());

			try (BufferedInputStream in = new BufferedInputStream(new FileInputStream(file)); BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream())) {
				FileCopyUtils.copy(in, out);
				out.flush();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			response.setContentType("application/x-msdownload");
			try (PrintWriter printwriter = response.getWriter()) {
				printwriter.println("샘플 파일이 존재하지 않습니다.");
				printwriter.flush();
				printwriter.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * Object 그룹 정보
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-object-group-info.do")
	@ResponseBody
	public String ajaxObjectGroupInfo(HttpServletRequest request, @RequestParam("object_group_id") Long object_group_id) {
		
		log.info("@@@@@@@ object_group_id = {}", object_group_id);
		
		Gson gson = new Gson();
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		ObjectGroup objectGroup = null;
		try {	
			objectGroup = objectGroupService.getObjectGroup(object_group_id);
			log.info("@@@@@@@ objectGroup = {}", objectGroup);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		jSONObject.put("result", result);
		jSONObject.put("objectGroup", objectGroup);
		
		return gson.toJson(jSONObject);
	}
	
	/**
	 * 검색 조건
	 * @param objectInfo
	 * @return
	 */
	private String getSearchParameters(ObjectInfo objectInfo) {
		// TODO 아래 메소드랑 통합
		StringBuilder builder = new StringBuilder(100);
		builder.append("&");
		builder.append("search_word=" + StringUtil.getDefaultValue(objectInfo.getSearch_word()));
		builder.append("&");
		builder.append("search_option=" + StringUtil.getDefaultValue(objectInfo.getSearch_option()));
		builder.append("&");
		try {
			builder.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(objectInfo.getSearch_value()), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			builder.append("search_value=");
		}
		builder.append("&");
		builder.append("object_group_id=" + objectInfo.getObject_group_id());
		builder.append("&");
		builder.append("status=" + StringUtil.getDefaultValue(objectInfo.getStatus()));
		builder.append("&");
		builder.append("start_date=" + StringUtil.getDefaultValue(objectInfo.getStart_date()));
		builder.append("&");
		builder.append("end_date=" + StringUtil.getDefaultValue(objectInfo.getEnd_date()));
		builder.append("&");
		builder.append("order_word=" + StringUtil.getDefaultValue(objectInfo.getOrder_word()));
		builder.append("&");
		builder.append("order_value=" + StringUtil.getDefaultValue(objectInfo.getOrder_value()));
		builder.append("&");
		builder.append("list_count=" + objectInfo.getList_counter());
		return builder.toString();
	}
	
	/**
	 * 목록 페이지 이동 검색 조건
	 * @param request
	 * @return
	 */
	private String getListParameters(HttpServletRequest request) {
		StringBuilder builder = new StringBuilder(100);
		String pageNo = request.getParameter("pageNo");
		builder.append("pageNo=" + pageNo);
		builder.append("&");
		builder.append("search_word=" + StringUtil.getDefaultValue(request.getParameter("search_word")));
		builder.append("&");
		builder.append("search_option=" + StringUtil.getDefaultValue(request.getParameter("search_option")));
		builder.append("&");
		try {
			builder.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(request.getParameter("search_value")), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			builder.append("search_value=");
		}
		builder.append("&");
		builder.append("object_group_id=" + request.getParameter("object_group_id"));
		builder.append("&");
		builder.append("status=" + StringUtil.getDefaultValue(request.getParameter("status")));
		builder.append("&");
		builder.append("start_date=" + StringUtil.getDefaultValue(request.getParameter("start_date")));
		builder.append("&");
		builder.append("end_date=" + StringUtil.getDefaultValue(request.getParameter("end_date")));
		builder.append("&");
		builder.append("order_word=" + StringUtil.getDefaultValue(request.getParameter("order_word")));
		builder.append("&");
		builder.append("order_value=" + StringUtil.getDefaultValue(request.getParameter("order_value")));
		builder.append("&");
		builder.append("list_count=" + StringUtil.getDefaultValue(request.getParameter("list_count")));
		return builder.toString();
	}
}