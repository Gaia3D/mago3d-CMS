package gaia3d.controller.rest;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import gaia3d.config.PropertiesConfig;
import gaia3d.domain.Key;
import gaia3d.domain.common.FileInfo;
import gaia3d.domain.data.DataAttribute;
import gaia3d.domain.data.DataAttributeFileInfo;
import gaia3d.domain.data.DataFileInfo;
import gaia3d.domain.data.DataInfo;
import gaia3d.domain.data.DataObjectAttribute;
import gaia3d.domain.data.DataObjectAttributeFileInfo;
import gaia3d.domain.data.DataSmartTilingFileInfo;
import gaia3d.domain.user.UserSession;
import gaia3d.service.DataAttributeService;
import gaia3d.service.DataObjectAttributeService;
import gaia3d.service.DataService;
import gaia3d.service.DataSmartTilingService;
import gaia3d.utils.FileUtils;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/datas")
public class DataRestController {
	
	@Autowired
	private DataService dataService;
	@Autowired
	private DataSmartTilingService dataSmartTilingService;
	@Autowired
	private DataAttributeService dataAttributeService;
	@Autowired
	private DataObjectAttributeService dataObjectAttributeService;
	@Autowired
	private PropertiesConfig propertiesConfig;
	
	/**
	 * 데이터 정보
	 * @param dataId
	 * @return
	 */
	@GetMapping("/{dataId:[0-9]+}")
	public Map<String, Object> detail(HttpServletRequest request, @PathVariable Long dataId) {
		log.info("@@@@@ dataId = {}", dataId);
		
		//UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
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
	 * @param dataId
	 * @param dataInfo
	 * @return
	 */
	@PostMapping("/{dataId:[0-9]+}")
	public Map<String, Object> update(HttpServletRequest request, @PathVariable Integer dataId, @ModelAttribute DataInfo dataInfo) {
		log.info("@@@@@ update dataInfo = {}, dataId = {}", dataInfo, dataId);
		
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		if(dataInfo.getLongitude() != null && dataInfo.getLatitude() != null) {
			dataInfo.setLocation("POINT(" + dataInfo.getLongitude() + " " + dataInfo.getLatitude() + ")");
		}
		
		dataService.updateData(dataInfo);
		int statusCode = HttpStatus.OK.value();
		
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
	 * 데이터 Object 속성 정보
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
	 * 데이터 파일 업로딩
	 * @param request
	 * @return
	 */
	@PostMapping(value = "/bulk-upload")
	public Map<String, Object> bulkUpload(MultipartHttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		Integer dataGroupId = Integer.valueOf(request.getParameter("dataGroupId"));
		MultipartFile multipartFile = request.getFile("dataFileName");
		// TODO
		FileInfo fileInfo = FileUtils.upload(userSession.getUserId(), multipartFile, FileUtils.DATA_FILE_UPLOAD, propertiesConfig.getDataBulkUploadDir());
		if(fileInfo.getErrorCode() != null && !"".equals(fileInfo.getErrorCode())) {
			log.info("@@@@@@@@@@@@@@@@@@@@ error_code = {}", fileInfo.getErrorCode());
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", fileInfo.getErrorCode());
			result.put("message", message);
			
			return result;
		}
		
		ModelMapper modelMapper = new ModelMapper();
		DataFileInfo dataFileInfo = modelMapper.map(fileInfo, DataFileInfo.class);
		dataFileInfo.setUserId(userSession.getUserId());
		dataFileInfo.setDataGroupId(dataGroupId);
		dataFileInfo = dataService.upsertBulkData(dataFileInfo);
		
		result.put("totalCount", dataFileInfo.getTotalCount());
		result.put("parseSuccessCount", dataFileInfo.getParseSuccessCount());
		result.put("parseErrorCount", dataFileInfo.getParseErrorCount());
		result.put("insertSuccessCount", dataFileInfo.getInsertSuccessCount());
		result.put("updateSuccessCount", dataFileInfo.getUpdateSuccessCount());
		result.put("insertErrorCount", dataFileInfo.getInsertErrorCount());
		
		// 파일 삭제
		File copyFile = new File(fileInfo.getFilePath() + fileInfo.getFileRealName());
		if(copyFile.exists()) {
			copyFile.delete();
		}
	
		int statusCode = HttpStatus.OK.value();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	/**
	 * Smart Tiling 데이터 수정
	 * @param request
	 * @return
	 */
	@PostMapping(value = "/smart-tiling")
	public Map<String, Object> upsertDataSmartTiling(MultipartHttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		Integer dataGroupId = Integer.valueOf(request.getParameter("smartTilingFileDataGroupId"));
		MultipartFile multipartFile = request.getFile("smartTilingFileName");
		// TODO
		FileInfo fileInfo = FileUtils.upload(userSession.getUserId(), multipartFile, FileUtils.DATA_SMART_TILING_FILE_UPLOAD, propertiesConfig.getDataSmartTilingDir());
		if(fileInfo.getErrorCode() != null && !"".equals(fileInfo.getErrorCode())) {
			log.info("@@@@@@@@@@@@@@@@@@@@ error_code = {}", fileInfo.getErrorCode());
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", fileInfo.getErrorCode());
			result.put("message", message);
			
			return result;
		}
		
		ModelMapper modelMapper = new ModelMapper();
		DataSmartTilingFileInfo dataSmartTilingFileInfo = modelMapper.map(fileInfo, DataSmartTilingFileInfo.class);
		dataSmartTilingFileInfo.setUserId(userSession.getUserId());
		dataSmartTilingFileInfo.setDataGroupId(dataGroupId);
		dataSmartTilingFileInfo = dataSmartTilingService.upsertDataSmartTiling(dataSmartTilingFileInfo);
		
		result.put("totalCount", dataSmartTilingFileInfo.getTotalCount());
		result.put("parseSuccessCount", dataSmartTilingFileInfo.getParseSuccessCount());
		result.put("parseErrorCount", dataSmartTilingFileInfo.getParseErrorCount());
		result.put("insertSuccessCount", dataSmartTilingFileInfo.getInsertSuccessCount());
		result.put("updateSuccessCount", dataSmartTilingFileInfo.getUpdateSuccessCount());
		result.put("insertErrorCount", dataSmartTilingFileInfo.getInsertErrorCount());
		
		// 파일 삭제
		File copyFile = new File(fileInfo.getFilePath() + fileInfo.getFileRealName());
		if(copyFile.exists()) {
			copyFile.delete();
		}
	
		int statusCode = HttpStatus.OK.value();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	/**
	 * Data Attribute 수정
	 * @param request
	 * @return
	 */
	@PostMapping(value = "/attributes")
	public Map<String, Object> insertDataAttribute(MultipartHttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		Long dataId = Long.valueOf(request.getParameter("attributeFileDataId"));
		MultipartFile multipartFile = request.getFile("attributeFileName");
		// TODO
		FileInfo fileInfo = FileUtils.upload(userSession.getUserId(), multipartFile, FileUtils.DATA_ATTRIBUTE_UPLOAD, propertiesConfig.getDataAttributeUploadDir());
		if(fileInfo.getErrorCode() != null && !"".equals(fileInfo.getErrorCode())) {
			log.info("@@@@@@@@@@@@@@@@@@@@ error_code = {}", fileInfo.getErrorCode());
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", fileInfo.getErrorCode());
			result.put("message", message);
			
			return result;
		}
		
		ModelMapper modelMapper = new ModelMapper();
		DataAttributeFileInfo dataAttributeFileInfo = modelMapper.map(fileInfo, DataAttributeFileInfo.class);
		dataAttributeFileInfo.setUserId(userSession.getUserId());
		dataAttributeFileInfo.setDataId(dataId);
		
		dataAttributeFileInfo = dataAttributeService.insertDataAttributeByFile(dataId, dataAttributeFileInfo);
		
		result.put("totalCount", dataAttributeFileInfo.getTotalCount());
		result.put("parseSuccessCount", dataAttributeFileInfo.getParseSuccessCount());
		result.put("parseErrorCount", dataAttributeFileInfo.getParseErrorCount());
		result.put("insertSuccessCount", dataAttributeFileInfo.getInsertSuccessCount());
		result.put("updateSuccessCount", dataAttributeFileInfo.getUpdateSuccessCount());
		result.put("insertErrorCount", dataAttributeFileInfo.getInsertErrorCount());
		
		// 파일 삭제
		File copyFile = new File(fileInfo.getFilePath() + fileInfo.getFileRealName());
		if(copyFile.exists()) {
			copyFile.delete();
		}
	
		int statusCode = HttpStatus.OK.value();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	/**
	 * Data object Attribute 수정
	 * @param request
	 * @return
	 */
	@PostMapping(value = "/object/attributes")
	public Map<String, Object> insertDataObjectAttribute(MultipartHttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		Long dataId = Long.valueOf(request.getParameter("objectAttributeFileDataId"));
		MultipartFile multipartFile = request.getFile("objectAttributeFileName");
		// TODO
		FileInfo fileInfo = FileUtils.upload(userSession.getUserId(), multipartFile, FileUtils.DATA_ATTRIBUTE_UPLOAD, propertiesConfig.getDataAttributeUploadDir());
		if(fileInfo.getErrorCode() != null && !"".equals(fileInfo.getErrorCode())) {
			log.info("@@@@@@@@@@@@@@@@@@@@ error_code = {}", fileInfo.getErrorCode());
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", fileInfo.getErrorCode());
			result.put("message", message);
			
			return result;
		}
		
		ModelMapper modelMapper = new ModelMapper();
		DataObjectAttributeFileInfo dataObjectAttributeFileInfo = modelMapper.map(fileInfo, DataObjectAttributeFileInfo.class);
		dataObjectAttributeFileInfo.setUserId(userSession.getUserId());
		dataObjectAttributeFileInfo.setDataId(dataId);
		
		dataObjectAttributeFileInfo = dataObjectAttributeService.insertDataObjectAttribute(dataId, dataObjectAttributeFileInfo);
		
		result.put("totalCount", dataObjectAttributeFileInfo.getTotalCount());
		result.put("parseSuccessCount", dataObjectAttributeFileInfo.getParseSuccessCount());
		result.put("parseErrorCount", dataObjectAttributeFileInfo.getParseErrorCount());
		result.put("insertSuccessCount", dataObjectAttributeFileInfo.getInsertSuccessCount());
		result.put("updateSuccessCount", dataObjectAttributeFileInfo.getUpdateSuccessCount());
		result.put("insertErrorCount", dataObjectAttributeFileInfo.getInsertErrorCount());
		
		// 파일 삭제
		File copyFile = new File(fileInfo.getFilePath() + fileInfo.getFileRealName());
		if(copyFile.exists()) {
			copyFile.delete();
		}
	
		int statusCode = HttpStatus.OK.value();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
}
