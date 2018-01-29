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
import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.CacheName;
import com.gaia3d.domain.CacheParams;
import com.gaia3d.domain.CacheType;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.Project;
import com.gaia3d.service.ProjectService;

import lombok.extern.slf4j.Slf4j;

/**
 * Project
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/data/")
public class ProjectController {
	
	@Autowired
	CacheConfig cacheConfig;
	@Autowired
	private ProjectService projectService;
	
	/**
	 * Project 목록
	 * @param model
	 * @return
	 */
	@GetMapping(value = "list-project.do")
	public String projectList(Model model) {
		List<Project> projectList = projectService.getListProject(new Project());
		
		model.addAttribute("projectListSize", projectList.size());
		model.addAttribute("projectList", projectList);
		
		return "/data/list-project";
	}
	
	/**
	 * Ajax Project 목록
	 * @param request
	 * @return
	 */
	@PostMapping(value = "ajax-list-project.do")
	@ResponseBody
	public Map<String, Object> ajaxListProject(HttpServletRequest request) {
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {
			List<Project> projectList = projectService.getListProject(new Project());
			jSONObject.put("projectList", projectList);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		jSONObject.put("result", result);
		return jSONObject;
	}
	
	/**
	 * Project 정보
	 * @param projectId
	 * @return
	 */
	@GetMapping(value = "ajax-project.do")
	@ResponseBody
	public Map<String, Object> ajaxProject(Long projectId) {
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {
						
			log.info("@@ projectId = {} ", projectId);
			if(projectId == null) {
				result = "input.invalid";
				jSONObject.put("result", result);
				return jSONObject;
			}
			
			Project project = projectService.getProject(projectId);
			jSONObject.put("project", project);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		jSONObject.put("result", result);
		return jSONObject;
	}
	
	/**
	 * Project 등록 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "input-project.do")
	public String inputProject(Model model) {
		Policy policy = CacheManager.getPolicy();
		
		model.addAttribute("policy", policy);
		model.addAttribute("project", new Project());
		
		return "/data/input-project";
	}
	
	/**
	 * Project key 중복 체크
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-project-key-duplication-check.do")
	@ResponseBody
	public Map<String, Object> ajaxProjectKeyDuplicationCheck(HttpServletRequest request, Project project) {
		
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		String duplication_value = "";
		
		log.info("@@ project = {}", project);
		try {
			if(project.getProject_key() == null || "".equals(project.getProject_key())) {
				result = "project.key.empty";
				jSONObject.put("result", result);
				return jSONObject;
			} else if(project.getOld_project_key() != null && !"".equals(project.getOld_project_key())) {
				if(project.getProject_key().equals(project.getOld_project_key())) {
					result = "project.key.same";
					jSONObject.put("result", result);
					return jSONObject;
				}
			}
			
			int count = projectService.getDuplicationKeyCount(project.getProject_key());
			log.info("@@ duplication_value = {}", count);
			duplication_value = String.valueOf(count);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		jSONObject.put("result", result);
		jSONObject.put("duplication_value", duplication_value);
		
		return jSONObject;
	}
	
	/**
	 * Project 추가
	 * @param request
	 * @param project
	 * @return
	 */
	@PostMapping(value = "ajax-insert-project.do")
	@ResponseBody
	public Map<String, Object> ajaxInsertProject(HttpServletRequest request, Project project) {
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {
			log.info("@@ project = {} ", project);
			
			if(project.getProject_key() == null || "".equals(project.getProject_key())
					|| project.getProject_name() == null || "".equals(project.getProject_name())) {
				result = "input.invalid";
				jSONObject.put("result", result);
				return jSONObject;
			}
			
			projectService.insertProject(project);
			
			CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheName(CacheName.PROJECT);
			cacheParams.setCacheType(CacheType.BROADCAST);
			cacheConfig.loadCache(cacheParams);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		jSONObject.put("result", result);
		return jSONObject;
	}
	
	/**
	 * Project 수정 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "modify-project.do")
	public String modifyProject(Model model, Long project_id) {
		
		Project project = projectService.getProject(project_id);
		project.setOld_project_key(project.getProject_key());
		
		model.addAttribute("project", project);
		
		return "/data/modify-project";
	}
	
	/**
	 * Project 수정
	 * @param request
	 * @param project
	 * @return
	 */
	@PostMapping(value = "ajax-update-project.do")
	@ResponseBody
	public Map<String, Object> ajaxUpdateProject(HttpServletRequest request, Project project) {
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {
						
			log.info("@@ project = {} ", project);
			if(project.getProject_id() == null || project.getProject_id().longValue() == 0l
					|| project.getProject_name() == null || "".equals(project.getProject_name())) {
				
				result = "input.invalid";
				jSONObject.put("result", result);
				return jSONObject;
			}
			
			projectService.updateProject(project);
			
			CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheName(CacheName.PROJECT);
			cacheParams.setCacheType(CacheType.BROADCAST);
			cacheConfig.loadCache(cacheParams);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		jSONObject.put("result", result);
		return jSONObject;
	}
	
	/**
	 * Project 삭제
	 * @param request
	 * @param project
	 * @return
	 */
	@PostMapping(value = "ajax-delete-project.do")
	@ResponseBody
	public Map<String, Object> ajaxDeleteProject(HttpServletRequest request, Project project) {
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {
			log.info("@@ project = {} ", project);
//			if(dataGroup.getData_group_id() == null || dataGroup.getData_group_id().longValue() == 0l) {				
//				dataGroupList.addAll(projectService.getListDataGroup(new Project()));
//				
//				result = "input.invalid";
//				return JSONUtil.getResultTreeString(result, dataGroupTree);
//			}
//			
//			projectService.deleteDataGroup(dataGroup.getData_group_id());
//			dataGroupList.addAll(projectService.getListDataGroup(new Project()));
			
			CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheName(CacheName.PROJECT);
			cacheParams.setCacheType(CacheType.BROADCAST);
			cacheConfig.loadCache(cacheParams);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		jSONObject.put("result", result);
		return jSONObject;
	}
}
