package com.gaia3d.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gaia3d.config.PropertiesConfig;
import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.FileInfo;
import com.gaia3d.domain.UserSession;
import com.gaia3d.service.ConverterUploadService;
import com.gaia3d.service.ProjectService;
import com.gaia3d.util.FileUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * Data Upload
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/datafile/")
public class DataFileUploadController {
	
	@Autowired
	private PropertiesConfig propertiesConfig;
	@Autowired
	private ConverterUploadService converterUploadService;
	@Autowired
	private ProjectService projectService;
	
	/**
	 * data upload 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "input-upload.do")
	public String inputUpload(HttpServletRequest request, Model model) {
		model.addAttribute("dataInfo", new DataInfo());
		return "/datafile/input-upload";
	}
	
	/**
	 * data upload 처리
	 * @param model
	 * @return
	 */
	@PostMapping(value = "insert-upload.do")
	@ResponseBody
	public Map<String, Object> insertUpload(MultipartHttpServletRequest request, Model model) {
		
		// TODO 텍스처 파일 이름에 중복이 있을 수도 있음, 이전 이름을 백업 받아 두고 복사 하자.
		
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ userId = {}", request.getParameter("userId"));
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ userName = {}", request.getParameter("userName"));
		
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
	        
	        // TODO 예외가 발생하면 중단을 해야 하나? 아님 넘어 가야 하나?
	        // 2개 중에 하나만 성공하고... 하나가 실패할 경우
	        
	        converterUploadService.insertFiles(fileList);       
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		map.put("result", result);
		return map;
	}
}