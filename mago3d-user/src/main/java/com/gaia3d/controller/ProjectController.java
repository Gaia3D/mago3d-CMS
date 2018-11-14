package com.gaia3d.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.LocaleResolver;

import com.gaia3d.config.CacheConfig;
import com.gaia3d.domain.DataSharingType;
import com.gaia3d.domain.Issue;
import com.gaia3d.domain.Pagination;
import com.gaia3d.domain.Project;
import com.gaia3d.domain.UserGroupRole;
import com.gaia3d.domain.UserSession;
import com.gaia3d.helper.GroupRoleHelper;
import com.gaia3d.service.IssueService;
import com.gaia3d.service.ProjectService;
import com.gaia3d.service.RoleService;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.StringUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * Project
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/project/")
public class ProjectController {
	
	@Autowired
	private LocaleResolver localeResolver;
	
	@Autowired
	CacheConfig cacheConfig;
	@Autowired
	private IssueService issueService;
	@Autowired
	private ProjectService projectService;
	@Autowired
	private RoleService roleService;
	
	/**
	 * Project 목록
	 * @param model
	 * @return
	 */
	@GetMapping(value = "list-project.do")
	public String listProject(HttpServletRequest request, Project project, @RequestParam(defaultValue="1") String pageNo, Model model) {
		log.info("@@ project = {}", project);
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
		project.setUser_id(userSession.getUser_id());
		project.setUse_yn(Project.IN_USE);
		if(StringUtils.isEmpty(project.getSharing_type())) {
			project.setSharing_type(DataSharingType.PUBLIC.getValue());
		}
		
		if(!StringUtils.isEmpty(project.getStart_date())) {
			project.setStart_date(project.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(!StringUtils.isEmpty(project.getEnd_date())) {
			project.setEnd_date(project.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}

		long totalCount = projectService.getProjectTotalCount(project);
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(project), totalCount, Long.valueOf(pageNo).longValue(), project.getList_counter());
		log.info("@@ pagination = {}", pagination);
		
		project.setOffset(pagination.getOffset());
		project.setLimit(pagination.getPageRows());
		List<Project> projectList = new ArrayList<>();
		if(totalCount > 0l) {
			projectList = projectService.getListProject(project);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("projectList", projectList);
		return "/project/list-project";
	}
	
	/**
	 * Project map
	 * @param model
	 * @return
	 */
	@GetMapping(value = "map-project.do")
	public String mapProject(HttpServletRequest request, HttpServletResponse response, Project project, 
			@RequestParam(defaultValue="1") String pageNo, @RequestParam(defaultValue="cesium") String viewLibrary, Model model) throws Exception {
		
		log.info("@@ viewLibrary = {}", viewLibrary);
		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
		project.setUser_id(userSession.getUser_id());
		project.setUse_yn(Project.IN_USE);
		if(StringUtils.isEmpty(project.getSharing_type())) {
			project.setSharing_type(DataSharingType.PUBLIC.getValue());
		}
		
		if(!StringUtils.isEmpty(project.getStart_date())) {
			project.setStart_date(project.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(!StringUtils.isEmpty(project.getEnd_date())) {
			project.setEnd_date(project.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}
		
		long totalCount = projectService.getProjectTotalCount(project);
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(project), totalCount, Long.valueOf(pageNo).longValue(), project.getList_counter());
		log.info("@@ pagination = {}", pagination);
		
		project.setOffset(pagination.getOffset());
		project.setLimit(pagination.getPageRows());
		List<Project> projectList = new ArrayList<>();
		if(totalCount > 0l) {
			projectList = projectService.getListProject(project);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("projectList", projectList);
		
		return "/project/map-project";
	}
	
	/**
	 * Project 목록
	 * @param request
	 * @return
	 */
	@PostMapping(value = "ajax-list-project.do")
	@ResponseBody
	public Map<String, Object> ajaxListProject(HttpServletRequest request, Project project) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			project.setUse_yn(Project.IN_USE);
			List<Project> projectList = projectService.getListProject(project);
			map.put("projectList", projectList);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
	/**
	 * Project 정보
	 * @param projectId
	 * @return
	 */
	@GetMapping(value = "ajax-project.do")
	@ResponseBody
	public Map<String, Object> ajaxProject(HttpServletRequest request, Project project) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			log.info("@@ project = {} ", project);
			if(project.getProject_id() == null) {
				result = "input.invalid";
				map.put("result", result);
				return map;
			}
			
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			project.setUser_id(userSession.getUser_id());
			project.setUse_yn(Project.IN_USE);
			project = projectService.getProject(project);
			
			map.put("project", project);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
	/**
	 * Project 등록 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "input-project.do")
	public String inputProject(HttpServletRequest request, Model model) {
		model.addAttribute("project", new Project());
		
		return "/project/input-project";
	}
	
	/**
	 * Project key 중복 체크
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-project-key-duplication-check.do")
	@ResponseBody
	public Map<String, Object> ajaxProjectKeyDuplicationCheck(HttpServletRequest request, Project project) {
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		String duplication_value = "";
		
		log.info("@@ project = {}", project);
		try {
			if(project.getProject_key() == null || "".equals(project.getProject_key())) {
				result = "project.key.empty";
				map.put("result", result);
				return map;
			} else if(project.getOld_project_key() != null && !"".equals(project.getOld_project_key())) {
				if(project.getProject_key().equals(project.getOld_project_key())) {
					result = "project.key.same";
					map.put("result", result);
					return map;
				}
			}
			
			int count = projectService.getDuplicationKeyCount(project.getProject_key());
			log.info("@@ duplication_value = {}", count);
			duplication_value = String.valueOf(count);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		map.put("duplication_value", duplication_value);
		
		return map;
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
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			log.info("@@ project = {} ", project);
			
			if(project.getProject_name() == null || "".equals(project.getProject_name())) {
				result = "input.invalid";
				map.put("result", result);
				return map;
			}
			
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			project.setUser_id(userSession.getUser_id());
			projectService.insertProject(project);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
	/**
	 * Project 수정 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "modify-project.do")
	public String modifyProject(HttpServletRequest request, Project project, Model model) {
		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
		project.setUser_id(userSession.getUser_id());
		project.setUse_yn(Project.IN_USE);
		project = projectService.getProject(project);
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
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
						
			log.info("@@ project = {} ", project);
			if(project.getProject_id() == null || project.getProject_id().longValue() == 0l
					|| project.getProject_name() == null || "".equals(project.getProject_name())) {
				
				result = "input.invalid";
				map.put("result", result);
				return map;
			}
			
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			project.setUser_id(userSession.getUser_id());
			project.setUse_yn(Project.IN_USE);
			projectService.updateProject(project);
			
			// TODO 개인용 캐시 갱신은 어떻게 하지?
//			CacheParams cacheParams = new CacheParams();
//			cacheParams.setCacheName(CacheName.PROJECT);
//			cacheParams.setCacheType(CacheType.BROADCAST);
//			cacheConfig.loadCache(cacheParams);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
	/**
	 * Project 삭제
	 * @param request
	 * @param project_id
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-delete-project.do")
	@ResponseBody
	public Map<String, Object> ajaxDeleteProject(HttpServletRequest request, Project project) {
		log.info("@@@@@@@ project = {}", project);
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			if(project.getProject_id() == null || project.getProject_id().longValue() <=0) {
				map.put("result", "project.project_id.empty");
				return map;
			}
			
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			// 사용자 그룹 ROLE 확인
			UserGroupRole userGroupRole = new UserGroupRole();
			userGroupRole.setUser_id(userSession.getUser_id());
			
			// TODO get 방식으로 권한 오류를 넘겨준다.
			if(!GroupRoleHelper.isUserGroupRoleValid(roleService.getListUserGroupRoleByUserId(userGroupRole), UserGroupRole.PROJECT_DELETE)) {
				log.info("@@ 접근 권한이 없어 실행할 수 없습니다. RoleName = {}",  UserGroupRole.PROJECT_DELETE);
				map.put("result", "user.group.role.invalid");
				return map;
			}
	
			project.setUser_id(userSession.getUser_id());
			project.setUse_yn(Project.IN_USE);
			projectService.deleteProject(project);
				
			// TODO 개인용 캐시 갱신은 어떻게 하지?
//			CacheParams cacheParams = new CacheParams();
//			cacheParams.setCacheName(CacheName.PROJECT);
//			cacheParams.setCacheType(CacheType.BROADCAST);
//			cacheConfig.loadCache(cacheParams);
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result", "db.exception");
		}
		
		map.put("result", result	);
		return map;
	}
	
	/**
	 * 검색 조건
	 * @param project
	 * @return
	 */
	private String getSearchParameters(Project project) {
		StringBuffer buffer = new StringBuffer();
		buffer.append("&");
		buffer.append("search_word=" + StringUtil.getDefaultValue(project.getSearch_word()));
		buffer.append("&");
		buffer.append("search_option=" + StringUtil.getDefaultValue(project.getSearch_option()));
		buffer.append("&");
		try {
			buffer.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(project.getSearch_value()), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			buffer.append("search_value=");
		}
		buffer.append("&");
		buffer.append("start_date=" + StringUtil.getDefaultValue(project.getStart_date()));
		buffer.append("&");
		buffer.append("end_date=" + StringUtil.getDefaultValue(project.getEnd_date()));
		buffer.append("&");
		buffer.append("order_word=" + StringUtil.getDefaultValue(project.getOrder_word()));
		buffer.append("&");
		buffer.append("order_value=" + StringUtil.getDefaultValue(project.getOrder_value()));
		return buffer.toString();
	}
	
	/**
	 * 검색 조건
	 * @param issue
	 * @return
	 */
	private String getSearchIssueParameters(Issue issue) {
		StringBuffer buffer = new StringBuffer();
		buffer.append("&");
		buffer.append("search_word=" + StringUtil.getDefaultValue(issue.getSearch_word()));
		buffer.append("&");
		buffer.append("search_option=" + StringUtil.getDefaultValue(issue.getSearch_option()));
		buffer.append("&");
		try {
			buffer.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(issue.getSearch_value()), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			buffer.append("search_value=");
		}
		buffer.append("&");
		buffer.append("start_date=" + StringUtil.getDefaultValue(issue.getStart_date()));
		buffer.append("&");
		buffer.append("end_date=" + StringUtil.getDefaultValue(issue.getEnd_date()));
		buffer.append("&");
		buffer.append("order_word=" + StringUtil.getDefaultValue(issue.getOrder_word()));
		buffer.append("&");
		buffer.append("order_value=" + StringUtil.getDefaultValue(issue.getOrder_value()));
		return buffer.toString();
	}
}
