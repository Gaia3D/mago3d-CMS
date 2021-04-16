package gaia3d.controller.view;

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

import gaia3d.domain.Key;
import gaia3d.domain.PageType;
import gaia3d.domain.common.Pagination;
import gaia3d.domain.data.DataGroup;
import gaia3d.domain.data.DataInfo;
import gaia3d.domain.policy.Policy;
import gaia3d.domain.uploaddata.UploadData;
import gaia3d.domain.user.UserSession;
import gaia3d.service.DataGroupService;
import gaia3d.service.DataService;
import gaia3d.service.PolicyService;
import gaia3d.support.SQLInjectSupport;
import gaia3d.utils.DateUtils;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/data")
public class DataController {

	@Autowired
	private DataGroupService dataGroupService;
	
	@Autowired
	private DataService dataService;
	
	@Autowired
	private PolicyService policyService;

	/**
	 * 데이터 목록
	 * @param request
	 * @param dataInfo
	 * @param pageNo
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/list")
	public String list(HttpServletRequest request, DataInfo dataInfo, @RequestParam(defaultValue="1") String pageNo, Model model) {
		DataGroup dataGroup = DataGroup.builder().available(true).build();
		List<DataGroup> dataGroupList = dataGroupService.getListDataGroup(dataGroup);
		
		dataInfo.setSearchWord(SQLInjectSupport.replaceSqlInection(dataInfo.getSearchWord()));
		dataInfo.setOrderWord(SQLInjectSupport.replaceSqlInection(dataInfo.getOrderWord()));
		
		log.info("@@ dataInfo = {}, pageNo = {}", dataInfo, pageNo);

//		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
//		dataInfo.setUserId(userSession.getUserId());

		if(!StringUtils.isEmpty(dataInfo.getStartDate())) {
			dataInfo.setStartDate(dataInfo.getStartDate().substring(0, 8) + DateUtils.START_TIME);
		}
		if(!StringUtils.isEmpty(dataInfo.getEndDate())) {
			dataInfo.setEndDate(dataInfo.getEndDate().substring(0, 8) + DateUtils.END_TIME);
		}

		long totalCount = dataService.getDataTotalCount(dataInfo);
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(PageType.LIST, dataInfo),
				totalCount, Long.parseLong(pageNo), dataInfo.getListCounter());
		dataInfo.setOffset(pagination.getOffset());
		dataInfo.setLimit(pagination.getPageRows());

		List<DataInfo> dataList = new ArrayList<>();
		if(totalCount > 0l) {
			dataList = dataService.getListData(dataInfo);
		}

		model.addAttribute("dataGroupList", dataGroupList);
		model.addAttribute(pagination);
		model.addAttribute("dataList", dataList);
		return "/data/list";
	}

	/**
	 * 데이터 등록 화면
	 */
	@GetMapping(value = "/input")
	public String input(HttpServletRequest request, Model model) {
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());

		Policy policy = policyService.getPolicy();
		UploadData uploadData = new UploadData();

		DataGroup dataGroup = new DataGroup();
		dataGroup.setUserId(userSession.getUserId());
		List<DataGroup> dataGroupList = dataGroupService.getListDataGroup(dataGroup);

		model.addAttribute("policy", policy);
		model.addAttribute("dataGroupList", dataGroupList);
		model.addAttribute("uploadData", uploadData);

		return "/data/input";
	}

	/**
	 * Data 정보
	 * @param dataInfo
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/detail")
	public String detail(HttpServletRequest request, DataInfo dataInfo, Model model) {
		log.info("@@@ detail-info dataInfo = {}", dataInfo);

		String listParameters = getSearchParameters(PageType.DETAIL, dataInfo);

		dataInfo =  dataService.getData(dataInfo);
		Policy policy = policyService.getPolicy();

		model.addAttribute("policy", policy);
		model.addAttribute("listParameters", listParameters);
		model.addAttribute("dataInfo", dataInfo);

		return "/data/detail-data";
	}

	/**
	 * 사용자 데이터 수정 화면
	 * @param request
	 * @param dataId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/modify")
	public String modify(HttpServletRequest request, @RequestParam("dataId") Long dataId, Model model) {
		//UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());

		DataInfo dataInfo = new DataInfo();
		//dataInfo.setUserId(userSession.getUserId());
		dataInfo.setDataId(dataId);

		dataInfo = dataService.getData(dataInfo);

		model.addAttribute("dataInfo", dataInfo);

		return "/data/modify";
	}

	/**
	 * 데이터 삭제
	 * @param dataId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/delete")
	public String delete(HttpServletRequest request, @RequestParam("dataId") Long dataId, Model model) {
		//UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());

		// TODO validation 체크 해야 함
		if(dataId == null) {
			log.info("@@@ validation error dataId is null");
			return "redirect:/data/list";
		}

		DataInfo dataInfo = new DataInfo();
		dataInfo.setDataId(dataId);
		//dataInfo.setUserId(userId);

		dataService.deleteData(dataInfo);

		return "redirect:/data/list";
	}

	/**
	 * 검색 조건
	 * @param pageType
	 * @param dataInfo
	 * @return
	 */
	private String getSearchParameters(PageType pageType, DataInfo dataInfo) {
		StringBuffer buffer = new StringBuffer(dataInfo.getParameters());
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
