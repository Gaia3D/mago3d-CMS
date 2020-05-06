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

import lombok.extern.slf4j.Slf4j;
import gaia3d.domain.CacheManager;
import gaia3d.domain.DataGroup;
import gaia3d.domain.DataInfo;
import gaia3d.domain.Key;
import gaia3d.domain.PageType;
import gaia3d.domain.Pagination;
import gaia3d.domain.RoleKey;
import gaia3d.domain.SharingType;
import gaia3d.domain.UserPolicy;
import gaia3d.domain.UserSession;
import gaia3d.service.DataGroupService;
import gaia3d.service.DataService;
import gaia3d.service.UserPolicyService;
import gaia3d.support.RoleSupport;
import gaia3d.support.SQLInjectSupport;
import gaia3d.utils.DateUtils;

@Slf4j
@Controller
@RequestMapping("/data")
public class DataController {

	private static final long PAGE_ROWS = 5l;
	private static final long PAGE_LIST_COUNT = 5l;

	@Autowired
	private DataGroupService dataGroupService;
	@Autowired
	private DataService dataService;

	@Autowired
	private UserPolicyService userPolicyService;
	
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
		dataInfo.setSearchWord(SQLInjectSupport.replaceSqlInection(dataInfo.getSearchWord()));
		dataInfo.setOrderWord(SQLInjectSupport.replaceSqlInection(dataInfo.getOrderWord()));
		
		log.info("@@ dataInfo = {}, pageNo = {}", dataInfo, pageNo);

		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		dataInfo.setUserGroupId(userSession.getUserGroupId());
		dataInfo.setUserId(userSession.getUserId());

		if(!StringUtils.isEmpty(dataInfo.getStartDate())) {
			dataInfo.setStartDate(dataInfo.getStartDate().substring(0, 8) + DateUtils.START_TIME);
		}
		if(!StringUtils.isEmpty(dataInfo.getEndDate())) {
			dataInfo.setEndDate(dataInfo.getEndDate().substring(0, 8) + DateUtils.END_TIME);
		}

		long totalCount = dataService.getDataTotalCount(dataInfo);

		Pagination pagination = new Pagination(	request.getRequestURI(), 
												getSearchParameters(PageType.LIST, dataInfo), 
												totalCount, 
												Long.parseLong(pageNo),
												dataInfo.getListCounter());
		log.info("@@ pagination = {}", pagination);

		dataInfo.setOffset(pagination.getOffset());
		dataInfo.setLimit(pagination.getPageRows());
		List<DataInfo> dataInfoList = new ArrayList<>();
		if(totalCount > 0l) {
			dataInfoList = dataService.getListData(dataInfo);
		}

		model.addAttribute(pagination);
		model.addAttribute("owner", userSession.getUserId());
		model.addAttribute("dataInfoList", dataInfoList);
		
		return "/data/list";
	}

	/**
	 * converter job 목록
	 * @param request
	 * @param membership_id
	 * @param pageNo
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/map")
	public String map(	HttpServletRequest request,
						DataInfo dataInfo,
						@RequestParam(defaultValue="1") String pageNo,
						Model model) {

		log.info("@@ DataController list dataInfo = {}, pageNo = {}", dataInfo, pageNo);

		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		String roleCheckResult = roleValidator(request, userSession.getUserGroupId(), RoleKey.USER_DATA_READ.name());
		if(roleCheckResult != null) return roleCheckResult;

		UserPolicy userPolicy = userPolicyService.getUserPolicy(userSession.getUserId());
		Long commonDataCount = 0l;
		Long publicDataCount = 0l;
		Long privateDataCount = 0l;
		Long groupDataCount = 0l;
		dataInfo.setUserId(userSession.getUserId());
		dataInfo.setUserGroupId(userSession.getUserGroupId());
		// 그룹별 통계
		List<DataInfo> groupDataCountList = dataService.getDataTotalCountBySharing(dataInfo);
		for(DataInfo statisticDataInfo : groupDataCountList) {
			if(SharingType.COMMON == SharingType.valueOf(statisticDataInfo.getSharing().toUpperCase())) {
				commonDataCount = statisticDataInfo.getDataCount();
			} else if(SharingType.PUBLIC == SharingType.valueOf(statisticDataInfo.getSharing().toUpperCase())) {
				publicDataCount = statisticDataInfo.getDataCount();
			} else if(SharingType.PRIVATE == SharingType.valueOf(statisticDataInfo.getSharing().toUpperCase())) {
				privateDataCount = statisticDataInfo.getDataCount();
			} else if(SharingType.GROUP == SharingType.valueOf(statisticDataInfo.getSharing().toUpperCase())) {
				groupDataCount = statisticDataInfo.getDataCount();
			}
		}

		dataInfo.setUserGroupId(userSession.getUserGroupId());
		dataInfo.setUserId(userSession.getUserId());
		if(!StringUtils.isEmpty(dataInfo.getStartDate())) {
			dataInfo.setStartDate(dataInfo.getStartDate().substring(0, 8) + DateUtils.START_TIME);
		}
		if(!StringUtils.isEmpty(dataInfo.getEndDate())) {
			dataInfo.setEndDate(dataInfo.getEndDate().substring(0, 8) + DateUtils.END_TIME);
		}

		long totalCount = dataService.getDataTotalCount(dataInfo);

		Pagination pagination = new Pagination(	request.getRequestURI(),
												getSearchParameters(PageType.LIST, dataInfo),
												totalCount,
												Long.parseLong(pageNo),
												PAGE_ROWS,
												PAGE_LIST_COUNT);
		log.info("@@ pagination = {}", pagination);

		dataInfo.setOffset(pagination.getOffset());
		dataInfo.setLimit(pagination.getPageRows());
		List<DataInfo> dataList = new ArrayList<>();
		if(totalCount > 0l) {
			dataList = dataService.getListData(dataInfo);
		}

		// 데이터 그룹
		DataGroup dataGroup = new DataGroup();
		dataGroup.setUserId(userSession.getUserId());
		dataGroup.setUserGroupId(userSession.getUserGroupId());
		List<DataGroup> dataGroupList = dataGroupService.getAllListDataGroup(dataGroup);

		model.addAttribute(pagination);

		model.addAttribute("totalCount", totalCount);

		model.addAttribute("dataGroupTotalCount", groupDataCountList.size());
		model.addAttribute("commonDataCount", commonDataCount);
		model.addAttribute("publicDataCount", publicDataCount);
		model.addAttribute("privateDataCount", privateDataCount);
		model.addAttribute("groupDataCount", groupDataCount);

		model.addAttribute("dataList", dataList);
		model.addAttribute("dataGroupList", dataGroupList);
		model.addAttribute("userPolicy", userPolicy);
		model.addAttribute("owner", userSession.getUserId());

		return "/data/map";
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
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		DataInfo dataInfo = new DataInfo();
		//dataInfo.setUserId(userSession.getUserId());
		dataInfo.setDataId(dataId);

		dataInfo = dataService.getData(dataInfo);
/*
		if(!userSession.getUserId().equals(dataInfo.getUserId())) {
			// 자신이 등록한 데이터가 아니면 수정할 수 없음
			return "redirect:/data-adjust-log/modify?dataId=" + dataInfo.getDataId();
		}
*/
		model.addAttribute("dataInfo", dataInfo);

		return "/data/modify";
	}

	/**
	 * 검색 조건
	 * @param search
	 * @return
	 */
	private String getSearchParameters(PageType pageType, DataInfo dataInfo) {
		StringBuffer buffer = new StringBuffer(dataInfo.getParameters());
//		buffer.append("&");
//		try {
//			buffer.append("dataName=" + URLEncoder.encode(getDefaultValue(dataInfo.getDataName()), "UTF-8"));
//		} catch(Exception e) {
//			buffer.append("dataName=");
//		}
		
		if (dataInfo.getStatus() != null) {
			buffer.append("&");
			buffer.append("status=");
			buffer.append(dataInfo.getStatus());
		}
		if (dataInfo.getDataType() != null) {
			buffer.append("&");
			buffer.append("dataType=");
			buffer.append(dataInfo.getDataType());
		}
		if (dataInfo.getDataGroupId() != null) {
			buffer.append("&");
			buffer.append("dataGroupId=");
			buffer.append(dataInfo.getDataGroupId());
		}
		return buffer.toString();
	}
	
	private String roleValidator(HttpServletRequest request, Integer userGroupId, String roleName) {
		List<String> userGroupRoleKeyList = CacheManager.getUserGroupRoleKeyList(userGroupId);
        if(!RoleSupport.isUserGroupRoleValid(userGroupRoleKeyList, roleName)) {
			request.setAttribute("httpStatusCode", 403);
			return "/error/error";
		}
		return null;
	}
}
