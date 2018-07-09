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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gaia3d.config.PropertiesConfig;
import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.FileInfo;
import com.gaia3d.domain.Pagination;
import com.gaia3d.domain.UploadLog;
import com.gaia3d.domain.UserSession;
import com.gaia3d.service.UploadService;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.FileUtil;
import com.gaia3d.util.StringUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * Data Upload
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/upload/")
public class UploadController {
	
	@Autowired
	private PropertiesConfig propertiesConfig;
	@Autowired
	private UploadService uploadService;
	
	/**
	 * data upload 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "input-upload.do")
	public String inputUpload(HttpServletRequest request, Model model) {
		return "/upload/input-upload";
	}
	
	/**
	 * data upload 처리
	 * @param model
	 * @return
	 */
	@PostMapping(value = "insert-upload.do")
	@ResponseBody
	public Map<String, Object> insertUpload(MultipartHttpServletRequest request, Model model) {
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			String userId = userSession.getUser_id();
			List<FileInfo> fileList = new ArrayList<>();
			Map<String, MultipartFile> fileMap = request.getFileMap();
	        for (MultipartFile multipartFile : fileMap.values()) {
	        	FileInfo fileInfo = FileUtil.userUpload(userId, FileUtil.SUBDIRECTORY_YEAR_MONTH_DAY, multipartFile, CacheManager.getPolicy(), propertiesConfig.getUserUploadDir());
				if(fileInfo.getError_code() != null && !"".equals(fileInfo.getError_code())) {
					log.info("@@@@@@@@@@@@@@@@@@@@ error_code = {}", fileInfo.getError_code());
					result = fileInfo.getError_code();
					break;
				}
				
				fileInfo.setUser_id(userId);
				fileList.add(fileInfo);
	        }
	        
	        uploadService.insertFiles(fileList);       
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		map.put("result", result);
		return map;
	}
	
	/**
	 * 사용자가 uploading 한 파일 목록
	 * @param request
	 * @param issue
	 * @param pageNo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list-upload-log.do")
	public String listUploadLog(HttpServletRequest request, UploadLog uploadLog, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
		uploadLog.setUser_id(userSession.getUser_id());
		
		log.info("@@ uploadLog = {}", uploadLog);
		if(StringUtil.isNotEmpty(uploadLog.getStart_date())) {
			uploadLog.setStart_date(uploadLog.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isNotEmpty(uploadLog.getEnd_date())) {
			uploadLog.setEnd_date(uploadLog.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}
		long totalCount = uploadService.getListUploadLogTotalCount(uploadLog);
		
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(uploadLog), totalCount, Long.valueOf(pageNo).longValue());
		log.info("@@ pagination = {}", pagination);
		
		uploadLog.setOffset(pagination.getOffset());
		uploadLog.setLimit(pagination.getPageRows());
		List<UploadLog> uploadLogList = new ArrayList<>();
		if(totalCount > 0l) {
			uploadLogList = uploadService.getListUploadLog(uploadLog);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("uploadLogList", uploadLogList);
		return "/upload/list-upload-log";
	}
	
	/**
	 * 검색 조건
	 * @param dataInfo
	 * @return
	 */
	private String getSearchParameters(UploadLog uploadLog) {
		StringBuilder builder = new StringBuilder(100);
		builder.append("&");
		builder.append("search_word=" + StringUtil.getDefaultValue(uploadLog.getSearch_word()));
		builder.append("&");
		builder.append("search_option=" + StringUtil.getDefaultValue(uploadLog.getSearch_option()));
		builder.append("&");
		try {
			builder.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(uploadLog.getSearch_value()), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			builder.append("search_value=");
		}
		builder.append("&");
		builder.append("start_date=" + StringUtil.getDefaultValue(uploadLog.getStart_date()));
		builder.append("&");
		builder.append("end_date=" + StringUtil.getDefaultValue(uploadLog.getEnd_date()));
		builder.append("&");
		builder.append("order_word=" + StringUtil.getDefaultValue(uploadLog.getOrder_word()));
		builder.append("&");
		builder.append("order_value=" + StringUtil.getDefaultValue(uploadLog.getOrder_value()));
		return builder.toString();
	}
}