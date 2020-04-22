package mago3d.controller.view;

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
import mago3d.config.PropertiesConfig;
import mago3d.domain.CacheManager;
import mago3d.domain.DataGroup;
import mago3d.domain.Key;
import mago3d.domain.Policy;
import mago3d.domain.SharingType;
import mago3d.domain.UserSession;
import mago3d.service.DataGroupService;
import mago3d.utils.FileUtils;

/**
 * 사용자 데이터 그룹 관리
 * @author Jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/data-group")
public class DataGroupController {
	
//	private static final long PAGE_ROWS = 5l;
//	private static final long PAGE_LIST_COUNT = 5l;
	
	@Autowired
	private DataGroupService dataGroupService;
//	@Autowired
//	private GeoPolicyService geoPolicyService;
//	@Autowired
//	private ObjectMapper objectMapper;
	@Autowired
	private PropertiesConfig propertiesConfig;
	
	/**
	 * 사용자 데이터 그룹 관리
	 */
	@GetMapping(value = "/list")
	public String list(	HttpServletRequest request, 
						Model model) throws Exception {
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		DataGroup dataGroup = new DataGroup();
		dataGroup.setUserId(userSession.getUserId());
		// 자기것만 나와야 해서 dataGroupId가 필요 없음
		List<DataGroup> dataGroupList = dataGroupService.getAllListDataGroup(dataGroup);
		if(dataGroupList == null || dataGroupList.isEmpty()) {
			String dataGroupPath = userSession.getUserId() + "/basic/";
			dataGroup.setDataGroupKey("basic");
			dataGroup.setDataGroupName("기본");
			dataGroup.setDataGroupPath(propertiesConfig.getUserDataServicePath() + dataGroupPath);
			dataGroup.setSharing(SharingType.PUBLIC.name().toLowerCase());
			dataGroup.setMetainfo("{\"isPhysical\": false}");
			
			FileUtils.makeDirectoryByPath(propertiesConfig.getUserDataServiceDir(), dataGroupPath);
			dataGroupService.insertBasicDataGroup(dataGroup);
			
			dataGroupList = dataGroupService.getListDataGroup(dataGroup);
		}
		
		model.addAttribute("dataGroupList", dataGroupList);
		
		return "/data-group/list";
	}
	
	/**
	 * 사용자 데이터 그룹 등록 화면
	 * @param request
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/input")
	public String input(HttpServletRequest request, Model model) {
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
				
		Policy policy = CacheManager.getPolicy();
		
		DataGroup dataGroup = new DataGroup();
		dataGroup.setUserId(userSession.getUserId());
		// 자기것만 나와야 해서 dataGroupId가 필요 없음
		List<DataGroup> dataGroupList = dataGroupService.getAllListDataGroup(dataGroup);
		if(dataGroupList == null || dataGroupList.isEmpty()) {
			String dataGroupPath = userSession.getUserId() + "/basic/";
			dataGroup.setDataGroupKey("basic");
			dataGroup.setDataGroupName("기본");
			dataGroup.setDataGroupPath(propertiesConfig.getUserDataServicePath() + dataGroupPath);
			dataGroup.setSharing(SharingType.PUBLIC.name().toLowerCase());
			dataGroup.setMetainfo("{\"isPhysical\": false}");
			
			FileUtils.makeDirectoryByPath(propertiesConfig.getUserDataServiceDir(), dataGroupPath);
			dataGroupService.insertBasicDataGroup(dataGroup);
			
			dataGroupList = dataGroupService.getListDataGroup(dataGroup);
		}
		
		dataGroup.setParentName(policy.getContentDataGroupRoot());
		dataGroup.setParent(0);
		dataGroup.setParentDepth(0);
		
		model.addAttribute("policy", policy);
		model.addAttribute("dataGroup", dataGroup);
		model.addAttribute("dataGroupList", dataGroupList);
		
		return "/data-group/input";
	}
	
	/**
	 * 사용자 데이터 그룹 수정 화면
	 * @param request
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/modify")
	public String modify(HttpServletRequest request, @RequestParam("dataGroupId") Integer dataGroupId, Model model) {
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		DataGroup dataGroup = new DataGroup();
		dataGroup.setUserId(userSession.getUserId());
		dataGroup.setDataGroupId(dataGroupId);
		
		dataGroup = dataGroupService.getDataGroup(dataGroup);
		if(StringUtils.isEmpty(dataGroup.getParentName())) {
			Policy policy = CacheManager.getPolicy();
			dataGroup.setParentName(policy.getContentDataGroupRoot());
		}
		dataGroup.setOldDataGroupKey(dataGroup.getDataGroupKey());
		
		model.addAttribute("dataGroup", dataGroup);
		
		return "/data-group/modify";
	}
	
	/**
	 * 사용자 데이터 그룹 삭제
	 * @param dataGroupId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/delete")
	public String deleteData(HttpServletRequest request, @RequestParam("dataGroupId") Integer dataGroupId, Model model) {
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		if(dataGroupId == null) {
			log.info("@@@ validation error dataGroupId = {}", dataGroupId);
			return "redirect:/data-group/list";
		}
		
		DataGroup dataGroup = new DataGroup();
		dataGroup.setUserId(userSession.getUserId());
		dataGroup.setDataGroupId(dataGroupId);
		
		dataGroupService.deleteDataGroup(dataGroup);
		
		return "redirect:/data-group/list";
	}
}
