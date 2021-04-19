package gaia3d.controller.view;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import gaia3d.config.PropertiesConfig;
import gaia3d.domain.Key;
import gaia3d.domain.PageType;
import gaia3d.domain.SharingType;
import gaia3d.domain.cache.CacheManager;
import gaia3d.domain.common.Pagination;
import gaia3d.domain.converter.ConverterJob;
import gaia3d.domain.data.DataGroup;
import gaia3d.domain.role.RoleKey;
import gaia3d.domain.uploaddata.UploadData;
import gaia3d.domain.uploaddata.UploadDataFile;
import gaia3d.domain.user.UserSession;
import gaia3d.service.DataGroupService;
import gaia3d.service.PolicyService;
import gaia3d.service.UploadDataService;
import gaia3d.support.RoleSupport;
import gaia3d.support.SQLInjectSupport;
import gaia3d.utils.DateUtils;
import gaia3d.utils.FileUtils;
import lombok.extern.slf4j.Slf4j;

/**
 * 3D 데이터 파일 업로더
 * TODO 설계 파일 안의 texture 의 경우 설계 파일에서 참조하는 경우가 있으므로 이름 변경 불가.
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/upload-data")
public class UploadDataController {
	
	// 파일 copy 시 버퍼 사이즈
	public static final int BUFFER_SIZE = 8192;
	
	@Autowired
	private DataGroupService dataGroupService;

	@Autowired
	private MessageSource messageSource;

	@Autowired
	private PolicyService policyService;
	
	@Autowired
	private PropertiesConfig propertiesConfig;
	
	@Autowired
	private UploadDataService uploadDataService;
	
	/**
	 * 업로딩 파일 목록
	 * @param request
	 * @param uploadData
	 * @param pageNo
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/list")
	public String list(HttpServletRequest request, UploadData uploadData, @RequestParam(defaultValue="1") String pageNo, Model model) {
		uploadData.setSearchWord(SQLInjectSupport.replaceSqlInection(uploadData.getSearchWord()));
		uploadData.setOrderWord(SQLInjectSupport.replaceSqlInection(uploadData.getOrderWord()));
		
		log.info("@@ uploadData = {}", uploadData);
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		String roleCheckResult = roleValidator(request, userSession.getUserGroupId(), RoleKey.USER_DATA_CREATE.name());
		if(roleCheckResult != null) return roleCheckResult;
		
		uploadData.setUserId(userSession.getUserId());
		
		if(!StringUtils.isEmpty(uploadData.getStartDate())) {
			uploadData.setStartDate(uploadData.getStartDate().substring(0, 8) + DateUtils.START_TIME);
		}
		if(!StringUtils.isEmpty(uploadData.getEndDate())) {
			uploadData.setEndDate(uploadData.getEndDate().substring(0, 8) + DateUtils.END_TIME);
		}
		
		long totalCount = uploadDataService.getUploadDataTotalCount(uploadData);
		
		Pagination pagination = new Pagination(	request.getRequestURI(), 
												getSearchParameters(PageType.LIST, uploadData), 
												totalCount, 
												Long.parseLong(pageNo),
												uploadData.getListCounter());
		log.info("@@ pagination = {}", pagination);
		
		uploadData.setOffset(pagination.getOffset());
		uploadData.setLimit(pagination.getPageRows());
		List<UploadData> uploadDataList = new ArrayList<>();
		if(totalCount > 0L) {
			uploadDataList = uploadDataService.getListUploadData(uploadData);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("uploadData", uploadData);
		model.addAttribute("converterJobForm", new ConverterJob());
		model.addAttribute("uploadDataList", uploadDataList);
		
		return "/upload-data/list";
	}
	
	/**
	 * 데이터 upload 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/input")
	public String input(HttpServletRequest request, Model model) {
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		String roleCheckResult = roleValidator(request, userSession.getUserGroupId(), RoleKey.USER_DATA_CREATE.name());
		if(roleCheckResult != null) return roleCheckResult;
		
		DataGroup dataGroup = new DataGroup();
		dataGroup.setUserId(userSession.getUserId());
		
		String dataGroupPath = userSession.getUserId() + "/basic/";
		DataGroup basicDataGroup = dataGroupService.getBasicDataGroup(dataGroup);
		if(basicDataGroup == null) {
			dataGroup.setDataGroupKey("basic");
			dataGroup.setDataGroupName(messageSource.getMessage("common.basic", null, getUserLocale(request)));
			dataGroup.setDataGroupPath(propertiesConfig.getUserDataServicePath() + dataGroupPath);
			dataGroup.setSharing(SharingType.PUBLIC.name().toLowerCase());
			dataGroup.setMetainfo("{\"isPhysical\": false}");
			
			dataGroupService.insertBasicDataGroup(dataGroup);
		}
		
		FileUtils.makeDirectoryByPath(propertiesConfig.getUserDataServiceDir(), dataGroupPath);
		
		// 자기것만 나와야 해서 dataGroupId가 필요 없음
		List<DataGroup> dataGroupList = dataGroupService.getAllListDataGroupForBasic(dataGroup);
		
		UploadData uploadData = UploadData.builder().
											dataGroupId(dataGroup.getDataGroupId()).
											dataGroupName(dataGroup.getDataGroupName()).build();
		
		String acceptedFiles = policyService.getUserUploadType();
		
		model.addAttribute("uploadData", uploadData);
		model.addAttribute("dataGroupList", dataGroupList);
		model.addAttribute("acceptedFiles", acceptedFiles);
		
		return "/upload-data/input";
	}
	
	/**
	 * 데이터 upload 수정
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/modify")
	public String modify(HttpServletRequest request, UploadData uploadData, Model model) {
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		uploadData.setUserId(userSession.getUserId());
		
		uploadData = uploadDataService.getUploadData(uploadData);
		List<UploadDataFile> uploadDataFileList = uploadDataService.getListUploadDataFile(uploadData);
		
		DataGroup dataGroup = new DataGroup();
		dataGroup.setUserId(userSession.getUserId());
		// 자기것만 나와야 해서 dataGroupId가 필요 없음
		List<DataGroup> dataGroupList = dataGroupService.getAllListDataGroupForBasic(dataGroup);
		
		model.addAttribute("uploadData", uploadData);
		model.addAttribute("uploadDataFileList", uploadDataFileList);
		model.addAttribute("dataGroupList", dataGroupList);
		
		return "/upload-data/modify";
	}
	
	/**
	 * 검색 조건
	 * @param pageType
	 * @param uploadData
	 * @return
	 */
	private String getSearchParameters(PageType pageType, UploadData uploadData) {
		StringBuilder builder = new StringBuilder(uploadData.getParameters());
		boolean isListPage = true;
		if(pageType == PageType.MODIFY || pageType == PageType.DETAIL) {
			isListPage = false;
		}
		
//		if(!isListPage) {
//			builder.append("pageNo=" + request.getParameter("pageNo"));
//			builder.append("&");
//			builder.append("list_count=" + uploadData.getList_counter());
//		}
		
		return builder.toString();
	}
	
	private String roleValidator(HttpServletRequest request, Integer userGroupId, String roleName) {
		List<String> userGroupRoleKeyList = CacheManager.getUserGroupRoleKeyList(userGroupId);
        if(!RoleSupport.isUserGroupRoleValid(userGroupRoleKeyList, roleName)) {
			log.info("---- Role 이 존재하지 않습니다. 확인 하세요. ");
			request.setAttribute("httpStatusCode", 403);
			return "/error/error";
		}
		return null;
	}

	/**
	 * request.getLocale을 하면 브라우저 local을 타서, select box 로 lang을 선택할 경우 정상적으로 동작하지 않음
	 * @param request
	 * @return
	 */
	private Locale getUserLocale(HttpServletRequest request) {
		String lang = (String)request.getSession().getAttribute(Key.LANG.name());
		log.info("@@@@@@@@@@@ lang = {}", lang);
		if(lang == null || "".equals(lang)) {
			Locale myLocale = request.getLocale();
			lang = myLocale.getLanguage();
		}
		return new Locale(lang);
	}
}
