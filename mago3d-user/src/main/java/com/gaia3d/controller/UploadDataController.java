package com.gaia3d.controller;

import static org.springframework.test.web.client.response.MockRestResponseCreators.withUnauthorizedRequest;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.LocaleResolver;

import com.gaia3d.config.PropertiesConfig;
import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.FileInfo;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.UploadData;
import com.gaia3d.domain.UploadDirectoryType;
import com.gaia3d.domain.UserSession;
import com.gaia3d.service.ConverterUploadService;
import com.gaia3d.util.FileUtil;
import com.gaia3d.util.UnZip;

import lombok.extern.slf4j.Slf4j;

/**
 * 사용자 업로드 정보
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/upload-data/")
public class UploadDataController {
	
	@Autowired
	private MessageSource messageSource;
	@Autowired
	private LocaleResolver localeResolver;
	@Autowired
	private PropertiesConfig propertiesConfig;
	
	@Autowired
	private ConverterUploadService converterUploadService;
	
	/**
	 * data upload 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "input-upload.do")
	public String inputUpload(HttpServletRequest request, Model model) {
		model.addAttribute("uploadData", new UploadData());
		return "/upload-data/input-upload";
	}
	
	/**
	 * TODO 비동기로 처리해야 할듯
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
			String errorCode = validate(request);
			if(!StringUtils.isEmpty(errorCode)) {
				log.info("@@@@@@@@@@@@ errorCode = {}", errorCode);
				map.put("result", errorCode);
				return map;
			}
			
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			String userId = userSession.getUser_id();
			List<FileInfo> fileList = new ArrayList<>();
			Map<String, MultipartFile> fileMap = request.getFileMap();
			Policy policy = CacheManager.getPolicy();
			
			Map<String, Object> resultMap = null;
			
			// 1 directory 생성
			String makedDirectory = FileUtil.makeDirectory(userId, UploadDirectoryType.YEAR_MONTH, propertiesConfig.getUploadData());
			log.info("@@@@@@@ = {}", makedDirectory);
			
			// 2 한건이면서 zip 의 경우
			int fileCount = fileMap.values().size();
			if(fileCount == 1) {
				for (MultipartFile multipartFile : fileMap.values()) {
					String[] divideNames = multipartFile.getOriginalFilename().split("\\.");
					String fileExtension = divideNames[divideNames.length - 1];
					if(UploadData.ZIP_EXTENSION.equals(fileExtension.toLowerCase())) {
						// zip 파일
						resultMap = UnZip.unzip(policy, userId, multipartFile, makedDirectory);
					}
				}
			}
//			
//			errorCode = (String)resultMap.get("errorCode");
//			if(!StringUtils.isEmpty(errorCode)) {
//				log.info("@@@@@@@@@@@@ errorCode = {}", errorCode);
//				map.put("result", errorCode);
//				return map;
//			}
//			
//			// 3 그 외의 경우는 재귀적으로 파일 복사
			
			
			
			
			
			
			
			
			
			
			
//			
//			String targetDirectory = propertiesConfig.getUploadData();
//			
//			
//			
//			
//			// 파일 복사
//			for (MultipartFile multipartFile : fileMap.values()) {
//				log.info("@@@@@@@@@@@@@@@ name = {}, original_name = {}", multipartFile.getName(), multipartFile.getOriginalFilename());
//				String[] divideNames = multipartFile.getOriginalFilename().split("\\.");
//					if(divideNames != null && divideNames.length > 0) {
//						String fileExtension = divideNames[divideNames.length - 1];
//						if(UploadData.ZIP_EXTENSION.equals(fileExtension.toLowerCase())) {
//							map.put("result", messageSource.getMessage("upload.data.multifile.zip.invalid", null, localeResolver.resolveLocale(request)));
//							return map;
//						}
//						
//						// 일반 파일 혹은 디렉토리
//					}
//				
//				
//				
//				
////	        	FileInfo fileInfo = FileUtil.userUpload(userId, FileUtil.SUBDIRECTORY_YEAR_MONTH_DAY, multipartFile, CacheManager.getPolicy(), propertiesConfig.getUserUploadDir());
////				if(fileInfo.getError_code() != null && !"".equals(fileInfo.getError_code())) {
////					log.info("@@@@@@@@@@@@@@@@@@@@ error_code = {}", fileInfo.getError_code());
////					result = fileInfo.getError_code();
////					break;
////				}
////				
////				fileInfo.setUser_id(userId);
////				fileList.add(fileInfo);
//	        }
//	        
//	        // TODO 예외가 발생하면 중단을 해야 하나? 아님 넘어 가야 하나?
//	        // 2개 중에 하나만 성공하고... 하나가 실패할 경우
//	        
//	        converterUploadService.insertFiles(fileList);       
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		map.put("result", result);
		return map;
	}
	
	/**
	 * validation 체크
	 * @param request
	 * @return
	 */
	private String validate(MultipartHttpServletRequest request) {
		
		if(StringUtils.isEmpty(request.getParameter("sharing_type"))) {
			return "sharing.type.empty";
		}
		if(StringUtils.isEmpty(request.getParameter("data_type"))) {
			return "data.type.empty";
		}
		if(StringUtils.isEmpty(request.getParameter("project_id"))) {
			return "project.id.empty";
		}
		if(StringUtils.isEmpty(request.getParameter("latitude"))) {
			return "latitude.empty";
		}
		if(StringUtils.isEmpty(request.getParameter("longitude"))) {
			return "longitude.empty";
		}
		if(StringUtils.isEmpty(request.getParameter("height"))) {
			return "height.empty";
		}
		
		Map<String, MultipartFile> fileMap = request.getFileMap();
		if(fileMap.isEmpty()) {
			return "file.empty";
		}
		
		return null;
	}
}