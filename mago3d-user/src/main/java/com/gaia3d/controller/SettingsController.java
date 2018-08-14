package com.gaia3d.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.config.PropertiesConfig;
import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.Project;
import com.gaia3d.domain.UserPolicy;
import com.gaia3d.domain.UserSession;
import com.gaia3d.service.UserPolicyService;

import lombok.extern.slf4j.Slf4j;

/**
 * 설정 관련
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/settings/")
public class SettingsController {
	
	@Autowired
	private PropertiesConfig propertiesConfig;
	@Autowired
	private UserPolicyService userPolicyService;
	
	/**
	 * userPolicy 수정화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "modify-membership.do")
	public String modifyMemberShip(HttpServletRequest request, Model model) {
		return "/settings/modify-membership";
	}
	
	/**
	 * userPolicy 수정화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "modify-user-policy.do")
	public String modifyUserPolicy(HttpServletRequest request, Model model) {
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
		UserPolicy userPolicy = userPolicyService.getUserPolicy(userSession.getUser_id());
		
		String defaultProjects = userPolicy.getGeo_data_default_projects();
		if(defaultProjects != null && !"".equals(defaultProjects)) {
			String[] projectIds = defaultProjects.split(",");
			Map<Long, Project> projectMap = CacheManager.getProjectMap();
			String defaultProjectsView = "";
			for(String projectId : projectIds) {
				Project project = projectMap.get(Long.valueOf(projectId));
				if("".equals(defaultProjectsView)) {
					defaultProjectsView += project.getProject_name();
				} else {
					defaultProjectsView += "," + project.getProject_name();
				}
			}
			userPolicy.setGeo_data_default_projects_view(defaultProjectsView);
			
		}
		
		model.addAttribute("userPolicy", userPolicy);
		
		return "/settings/modify-user-policy";
	}
	
	/**
	 * userPolicy update
	 * @param request
	 * @param userPolicy
	 * @return
	 */
	@PostMapping(value = "ajax-update-user-policy.do")
	@ResponseBody
	public Map<String, String> ajaxUpdateUserPolicy(HttpServletRequest request, UserPolicy userPolicy) {
		log.info("@@ userPolicy = {} ", userPolicy);
		
		Map<String, String> map = new HashMap<>();
		String result = "success";
		try {
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			userPolicy.setUser_id(userSession.getUser_id());
						
			userPolicyService.updateUserPolicy(userPolicy);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
	
}