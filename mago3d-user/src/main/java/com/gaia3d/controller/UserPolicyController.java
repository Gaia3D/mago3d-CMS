package com.gaia3d.controller;

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

import com.gaia3d.config.CacheConfig;
import com.gaia3d.domain.CacheType;
import com.gaia3d.domain.DataSharingType;
import com.gaia3d.domain.CacheName;
import com.gaia3d.domain.CacheParams;
import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.Project;
import com.gaia3d.domain.UserPolicy;
import com.gaia3d.domain.UserSession;
import com.gaia3d.security.Crypt;
import com.gaia3d.service.PolicyService;
import com.gaia3d.service.ProjectService;
import com.gaia3d.service.UserPolicyService;

import lombok.extern.slf4j.Slf4j;

/**
 * 운영 정책
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/user-policy/")
public class UserPolicyController {
	
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private UserPolicyService userPolicyService;
	
	/**
	 * 운영 정책 수정 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "modify-user-policy.do")
	public String modifyUserPolicy(HttpServletRequest request, Model model) {
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
		UserPolicy userPolicy = userPolicyService.getUserPolicy(userSession.getUser_id());
		log.info("@@@@@@@@@@ userPolicy = {}", userPolicy);
		
//		String defaultProjects = userPolicy.getGeo_data_default_projects();
//		if(defaultProjects != null && !"".equals(defaultProjects)) {
//			String[] projectIds = defaultProjects.split(",");
//			List<Project> projectList = projectService.getListDefaultProject(projectIds);
//			
//			
//			Map<Integer, Project> projectMap = new HashMap<>();
//			for(Project project : projectList) {
//				projectMap.put(project.getProject_id(), project);
//			}
//			
//			
//			
//			
//			
//			
//			
//			
//			
//			
//			
//			Map<Integer, Project> projectMap = CacheManager.getProjectMap();
//			String defaultProjectsView = "";
//			for(String projectId : projectIds) {
//				log.info(" --------------  projectId = {}", projectId);
//				Project project = projectMap.get(Integer.valueOf(projectId));
//				if("".equals(defaultProjectsView)) {
//					defaultProjectsView += project.getProject_name();
//				} else {
//					defaultProjectsView += "," + project.getProject_name();
//				}
//			}
//			userPolicy.setGeo_data_default_projects_view(defaultProjectsView);
//			
//		}
		
		model.addAttribute("policy", userPolicy);
		
		return "/user-policy/modify-user-policy";
	}
	
	/**
	 * Geo
	 * @param request
	 * @param policy
	 * @return
	 */
	@PostMapping(value = "ajax-update-user-policy-geo.do")
	@ResponseBody
	public Map<String, String> ajaxUpdateUserPolicyGeo(HttpServletRequest request, UserPolicy userPolicy) {
		Map<String, String> map = new HashMap<>();
		String result = "success";
		try {
			log.info("@@ userPolicy = {} ", userPolicy);
//			if(userPolicy.getPolicy_id() == null || userPolicy.getPolicy_id().intValue() <= 0) {
//				result = "policy.geo.invalid";
//				map.put("result", result);
//				return map;
//			}
//			
//			userPolicyService.updateUserPolicyGeo(userPolicy);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
}
