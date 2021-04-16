package gaia3d.controller.view;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import gaia3d.config.PropertiesConfig;
import gaia3d.domain.Key;
import gaia3d.domain.data.DataGroup;
import gaia3d.domain.policy.Policy;
import gaia3d.domain.user.UserSession;
import gaia3d.service.DataGroupService;
import gaia3d.service.PolicyService;
import gaia3d.support.SQLInjectSupport;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/data-group")
public class DataGroupController {

	@Autowired
	private DataGroupService dataGroupService;
	@Autowired
	private PolicyService policyService;
	@Autowired
	private PropertiesConfig propertiesConfig;
	
	/**
	 * 데이터 그룹 목록
	 * @param request
	 * @param dataGroup
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/list")
	public String list(HttpServletRequest request, @ModelAttribute DataGroup dataGroup, Model model) {
		dataGroup.setSearchWord(SQLInjectSupport.replaceSqlInection(dataGroup.getSearchWord()));
		dataGroup.setOrderWord(SQLInjectSupport.replaceSqlInection(dataGroup.getOrderWord()));
		
		log.info("@@ dataGroup = {}", dataGroup);
		
		// basic 디렉토리를 실수로 지웠거나 만들지 않았는지 확인
		File basicDirectory = new File(propertiesConfig.getAdminDataServiceDir() + "basic");
		if(!basicDirectory.exists()) {
			basicDirectory.mkdir();
		}
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		dataGroup.setUserId(userSession.getUserId());
		List<DataGroup> dataGroupList = dataGroupService.getListDataGroup(dataGroup);
		
		model.addAttribute("dataGroupList", dataGroupList);

		return "/data-group/list";
	}

	/**
	 * 데이터 그룹 등록 페이지 이동
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/input")
	public String input(HttpServletRequest request, Model model) {
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		// basic 디렉토리를 실수로 지웠거나 만들지 않았는지 확인
		File basicDirectory = new File(propertiesConfig.getAdminDataServiceDir() + "basic");
		if(!basicDirectory.exists()) {
			basicDirectory.mkdir();
		}

		DataGroup dataGroup = new DataGroup();
		dataGroup.setUserId(userSession.getUserId());
		List<DataGroup> dataGroupList = dataGroupService.getListDataGroup(dataGroup);
		
		Policy policy = policyService.getPolicy();
		dataGroup.setParentName(policy.getContentDataGroupRoot());
		dataGroup.setParent(0);
		dataGroup.setParentDepth(0);

		model.addAttribute("policy", policy);
		model.addAttribute("dataGroup", dataGroup);
		model.addAttribute("dataGroupList", dataGroupList);

		return "/data-group/input";
	}

	/**
	 * 데이터 그룹 수정 페이지 이동
	 * @param request
	 * @param dataGroupId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/modify")
	public String modify(HttpServletRequest request, @RequestParam("dataGroupId") Integer dataGroupId, Model model) {
		DataGroup dataGroup = new DataGroup();
		dataGroup.setDataGroupId(dataGroupId);
		dataGroup = dataGroupService.getDataGroup(dataGroup);
		
		if(StringUtils.isEmpty(dataGroup.getParentName())) {
			Policy policy = policyService.getPolicy();
			dataGroup.setParentName(policy.getContentDataGroupRoot());
		}
		dataGroup.setOldDataGroupKey(dataGroup.getDataGroupKey());
		
		model.addAttribute("dataGroup", dataGroup);
		
		return "/data-group/modify";
	}

	/**
	 * 데이터 그룹 삭제
	 * @param dataGroupId
	 * @return
	 */
	@GetMapping(value = "/delete")
	public String delete(@RequestParam("dataGroupId") Integer dataGroupId) {
		// TODO validation 체크 해야 함
		if(dataGroupId == null) {
			log.info("@@@ validation error dataGroupId = {}", dataGroupId);
			return "redirect:/data-group/list";
		}
		
		dataGroupService.deleteDataGroup(DataGroup.builder().dataGroupId(dataGroupId).build());
		
		return "redirect:/data-group/list";
	}
}
