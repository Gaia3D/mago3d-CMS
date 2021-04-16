package gaia3d.controller.view;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import gaia3d.config.PropertiesConfig;
import gaia3d.domain.Key;
import gaia3d.domain.PageType;
import gaia3d.domain.common.Pagination;
import gaia3d.domain.converter.ConverterJob;
import gaia3d.domain.data.DataGroup;
import gaia3d.domain.uploaddata.UploadData;
import gaia3d.domain.uploaddata.UploadDataFile;
import gaia3d.domain.user.UserSession;
import gaia3d.service.DataGroupService;
import gaia3d.service.PolicyService;
import gaia3d.service.UploadDataService;
import gaia3d.support.SQLInjectSupport;
import gaia3d.utils.DateUtils;
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
	private PolicyService policyService;
	
	@Autowired
	private PropertiesConfig propertiesConfig;
	
	@Autowired
	private UploadDataService uploadDataService;
	
	/**
	 * 데이터 upload 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/input")
	public String input(HttpServletRequest request, Model model) {
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		DataGroup dataGroup = new DataGroup();
		dataGroup.setUserId(userSession.getUserId());
		List<DataGroup> dataGroupList = dataGroupService.getListDataGroup(dataGroup);
		DataGroup basicDataGroup = dataGroupService.getBasicDataGroup();
		
		// basic 디렉토리를 실수로 지웠거나 만들지 않았는지 확인
		File basicDirectory = new File(propertiesConfig.getAdminDataServiceDir() + "basic");
		if(!basicDirectory.exists()) {
			basicDirectory.mkdir();
		}
		
		UploadData uploadData = UploadData.builder().
											dataGroupId(basicDataGroup.getDataGroupId()).
											dataGroupName(basicDataGroup.getDataGroupName()).build();
		
		String acceptedFiles = policyService.getUserUploadType();
		
		model.addAttribute("uploadData", uploadData);
		model.addAttribute("dataGroupList", dataGroupList);
		model.addAttribute("acceptedFiles", acceptedFiles);
		
		return "/upload-data/input";
	}
	
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

//		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
//		uploadData.setUserId(userSession.getUserId());

		if(!StringUtils.isEmpty(uploadData.getStartDate())) {
			uploadData.setStartDate(uploadData.getStartDate().substring(0, 8) + DateUtils.START_TIME);
		}
		if(!StringUtils.isEmpty(uploadData.getEndDate())) {
			uploadData.setEndDate(uploadData.getEndDate().substring(0, 8) + DateUtils.END_TIME);
		}

		long totalCount = uploadDataService.getUploadDataTotalCount(uploadData);
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(PageType.LIST, uploadData),
				totalCount, Long.parseLong(pageNo), uploadData.getListCounter());
		uploadData.setOffset(pagination.getOffset());
		uploadData.setLimit(pagination.getPageRows());

		List<UploadData> uploadDataList = new ArrayList<>();
		if(totalCount > 0l) {
			uploadDataList = uploadDataService.getListUploadData(uploadData);
		}

		model.addAttribute(pagination);
		model.addAttribute("uploadData", uploadData);
		model.addAttribute("converterJobForm", new ConverterJob());
		model.addAttribute("uploadDataList", uploadDataList);

		return "/upload-data/list";
	}

	/**
	 * 데이터 upload 수정
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/modify")
	public String modify(HttpServletRequest request, UploadData uploadData, Model model) {
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
//		uploadData.setUserId(userSession.getUserId());
		
		uploadData = uploadDataService.getUploadData(uploadData);
		List<UploadDataFile> uploadDataFileList = uploadDataService.getListUploadDataFile(uploadData);
		
		DataGroup dataGroup = new DataGroup();
		dataGroup.setUserId(userSession.getUserId());
		List<DataGroup> dataGroupList = dataGroupService.getListDataGroup(dataGroup);
		
		model.addAttribute("uploadData", uploadData);
		model.addAttribute("uploadDataFileList", uploadDataFileList);
		model.addAttribute("dataGroupList", dataGroupList);
		
		return "/upload-data/modify";
	}
	
	/**
	 * 검색 조건
	 * @param uploadData
	 * @return
	 */
	private String getSearchParameters(PageType pageType, UploadData uploadData) {
		StringBuffer buffer = new StringBuffer(uploadData.getParameters());
		boolean isListPage = true;
		if(pageType == PageType.MODIFY || pageType == PageType.DETAIL) {
			isListPage = false;
		}
		
//		if(!isListPage) {
//			buffer.append("pageNo=" + request.getParameter("pageNo"));
//			buffer.append("&");
//			buffer.append("list_count=" + uploadData.getList_counter());
//		}
		
		return buffer.toString();
	}
}
