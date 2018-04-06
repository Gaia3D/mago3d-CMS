package com.gaia3d.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.domain.Pagination;
import com.gaia3d.domain.Role;
import com.gaia3d.domain.UserGroupRole;
import com.gaia3d.service.RoleService;
import com.gaia3d.util.StringUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * Role 정책
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/role/")
public class RoleController {
	
	@Autowired
	private RoleService roleService;
	
	/**
	 * Role 목록
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list-role.do")
	public String listRole(HttpServletRequest request, Role role, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		log.info("@@ role = {}", role);
		
		long totalCount = roleService.getRoleTotalCount(role);
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(role), totalCount, Long.valueOf(pageNo).longValue());
		log.info("@@ pagination = {}", pagination);
		
		role.setOffset(pagination.getOffset());
		role.setLimit(pagination.getPageRows());
		List<Role> roleList = new ArrayList<>();
		if(totalCount > 0l) {
			roleList = roleService.getListRole(role);
		}

		model.addAttribute(pagination);
		model.addAttribute("roleList", roleList);
		model.addAttribute("roleListSize", roleList.size());
		return "/role/list-role";
	}
	
	/**
	 * Role 등록 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "input-role.do")
	public String inputRole(Model model) {
		Role role = new Role();
		role.setMethod_mode("insert");
		
		model.addAttribute("role", role);
		return "/role/input-role";
	}
	
	/**
	 * Role 등록
	 * @param request
	 * @param userDevice
	 * @return
	 */
	@PostMapping(value = "ajax-insert-role.do")
	@ResponseBody
	public Map<String, Object> ajaxInsertRole(HttpServletRequest request, Role role) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			log.info("@@@@@@ role = {}", role);
			// 등록, 수정 화면의 validation 항목이 다를 경우를 위한 변수
			role.setMethod_mode("insert");
			String errorcode = role.validate();
			if(errorcode != null) {
				result = errorcode;
				map.put("result", result);
				log.info("validate error 발생: {} ", errorcode);
				return map;
			}			
			roleService.insertRole(role);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		
		return map;
	}
	
	/**
	 * 수정 페이지로 이동
	 * @param role
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "modify-role.do")
	public String modifyRole(@RequestParam("role_id") String role_id, HttpServletRequest request, @RequestParam(defaultValue="1") String pageNo, Model model) {		
		
		Role role = roleService.getRole(Long.valueOf(role_id));
		//role.setMethod_mode("update");
		
		long totalCount = roleService.getRoleTotalCount(role);
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(role), totalCount, Long.valueOf(pageNo).longValue());
		role.setOffset(pagination.getOffset());
		role.setLimit(pagination.getPageRows());

		model.addAttribute(pagination);
		model.addAttribute(role);
		return "/role/modify-role";
	}
	
	/**
	 * Role 정보 수정
	 * @param request
	 * @param userDevice
	 * @return
	 */
	@PostMapping(value = "ajax-update-role.do")
	@ResponseBody
	public Map<String, Object> ajaxUpdateRole(HttpServletRequest request, Role role) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			log.info("@@@@@@ role = {}", role);
			// 등록, 수정 화면의 validation 항목이 다를 경우를 위한 변수
			role.setMethod_mode("update");
			String errorcode = role.validate();
			if(errorcode != null) {
				result = errorcode;
				map.put("result", result);
				log.info("validate error 발생: {}", errorcode);
				return map;
			}			
			roleService.updateRole(role);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		
		return map;
	}
	
	/**
	 * role 삭제
	 * @param request
	 * @return
	 */
	@PostMapping(value = "ajax-delete-role.do")
	@ResponseBody
	public Map<String, Object> ajaxDeleteRole(HttpServletRequest request, @RequestParam("role_id") String role_id) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			log.info("@@@@@@ role_id = {}", role_id);
			if(role_id == null || "".equals(role_id)) {
				map.put("result", "role.role_id.required");
				log.info("validate error 발생: {}", "role.role_id.required");
				return map;
			}
			roleService.deleteRole(Long.valueOf(role_id));
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		
		return map;
	}
	
	/**
	 * Role 등록, 수정, 삭제 결과 페이지
	 * @param role_id
	 * @param method_mode
	 * @param model
	 * @return
	 */
	@GetMapping(value = "result-role.do")
	public String resultRole(HttpServletRequest request, @RequestParam("method_mode") String method_mode, Model model) {
		
		if("insert".equals(method_mode) || "update".equals(method_mode)) {
			String role_id = request.getParameter("role_id");
			if(role_id == null || "".equals(role_id)) {
				log.error("@@ Invalid role_id. role_id = {}", role_id);
				return "redirect:/role/list-role";
			}
			Role role = roleService.getRole(Long.valueOf(role_id));
			model.addAttribute(role);
		}
		model.addAttribute("method_mode", method_mode);
		
		return "/role/result-role";
	}
	
	/**
	 * role 정보
	 * @param role_id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "detail-role.do")
	public String detailRole(@RequestParam("role_id") Long role_id, HttpServletRequest request, Model model) {
		
		String listParameters = getListParameters(request);
			
		Role role =  roleService.getRole(role_id);
		
		model.addAttribute("listParameters", listParameters);
		model.addAttribute("role", role);
		
		return "/role/detail-role";
	}
	
	/**
	 * 사용자 그룹 등록된 Role 목록
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-list-user-group-role.do")
	@ResponseBody
	public Map<String, Object> ajaxListUserGroupRole(HttpServletRequest request, @RequestParam("user_group_id") Long user_group_id, @RequestParam(defaultValue="1") String pageNo) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		List<UserGroupRole> listUserGroupRole = new ArrayList<>();
		Pagination pagination = null;
		try {			
			UserGroupRole userGroupRole = new UserGroupRole();
			userGroupRole.setRole_type(UserGroupRole.ROLE_TYPE_USER);
			userGroupRole.setUser_group_id(user_group_id);
			
			long totalCount = roleService.getListUserGroupRoleCount(userGroupRole);
			
			pagination = new Pagination(request.getRequestURI(), "", totalCount, Long.valueOf(pageNo).longValue());
			
			userGroupRole.setOffset(pagination.getOffset());
			userGroupRole.setLimit(pagination.getPageRows());
			
			if(totalCount > 0l) {			
				listUserGroupRole = roleService.getListUserGroupRole(userGroupRole);
			}
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		map.put("result", result);
		map.put("pagination", pagination);
		map.put("listUserGroupRole", listUserGroupRole);
		return map;
	}
	
	/**
	 * 계정 그룹 등록된 Role 목록
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-list-account-group-role.do")
	@ResponseBody
	public Map<String, Object> ajaxListAccountGroupRole(HttpServletRequest request, @RequestParam("account_group_id") Long account_group_id) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		//List<UserGroupRole> listUserGroupRole = new ArrayList<>();
		try {			
			
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		map.put("result", result);
		//map.put("listUserGroupRole", listUserGroupRole);
		return map;
	}
	
	/**
	 * 사용자 그룹 전체 Role 에서 선택한 사용자 그룹에 등록된 Role 을 제외한 Role 목록
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-list-except-user-group-role-for-update.do")
	@ResponseBody
	public Map<String, Object> ajaxListExceptUserGroupRoleForUpdate(HttpServletRequest request, UserGroupRole userGroupRole, @RequestParam(defaultValue="1") String pageNo) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		List<UserGroupRole> listExceptUserGroupRoleByGroupId = new ArrayList<>();
		Pagination pagination = null;
		try {		
			userGroupRole.setRole_type(UserGroupRole.ROLE_TYPE_USER);
			long totalCount = roleService.getListExceptUserGroupRoleByGroupIdCount(userGroupRole);
			
			pagination = new Pagination(request.getRequestURI(), "", totalCount, Long.valueOf(pageNo).longValue());
			
			userGroupRole.setOffset(pagination.getOffset());
			userGroupRole.setLimit(pagination.getPageRows());
			
			if(totalCount > 0l) {
				listExceptUserGroupRoleByGroupId = roleService.getListExceptUserGroupRoleByGroupId(userGroupRole);
			}
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		map.put("result", result);
		map.put("pagination", pagination);
		map.put("listExceptUserGroupRoleByGroupId", listExceptUserGroupRoleByGroupId);
		return map;
	}
	
	/**
	 * 선택한 사용자 그룹에 등록된 Role 목록
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-list-user-group-role-for-update.do")
	@ResponseBody
	public Map<String, Object> ajaxListUserGroupRoleForUpdate(HttpServletRequest request, UserGroupRole userGroupRole, @RequestParam(defaultValue="1") String pageNo) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		List<UserGroupRole> listUserGroupRole = new ArrayList<>();
		Pagination pagination = null;
		try {
			userGroupRole.setRole_type(UserGroupRole.ROLE_TYPE_USER);
			long totalCount = roleService.getListUserGroupRoleCount(userGroupRole);
			
			pagination = new Pagination(request.getRequestURI(), "", totalCount, Long.valueOf(pageNo).longValue());
			
			userGroupRole.setOffset(pagination.getOffset());
			userGroupRole.setLimit(pagination.getPageRows());
			
			if(totalCount > 0l) {
				listUserGroupRole = roleService.getListUserGroupRole(userGroupRole);
			}
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		map.put("result", result);
		map.put("pagination", pagination);
		map.put("listUserGroupRole", listUserGroupRole);
		return map;
	}
	
	/**
	 * 선택 사용자 그룹내 Role 등록
	 * @param request
	 * @param role_all_id
	 * @param user_group_id
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-insert-user-group-role.do")
	@ResponseBody
	public Map<String, Object> ajaxInsertUserGroupRole(HttpServletRequest request,
			@RequestParam("user_group_id") Long user_group_id,
			@RequestParam("role_all_id") Long[] role_all_id) {
		
		log.info("@@@ user_group_id = {}, role_all_id = {}", user_group_id, role_all_id);
		Map<String, Object> map = new HashMap<>();
		List<UserGroupRole> listExceptUserGroupRoleByGroupId = new ArrayList<>();
		List<UserGroupRole> listUserGroupRole = new ArrayList<>();
		String result = "success";
		try {
			if(user_group_id == null || user_group_id.longValue() == 0l ||				
					role_all_id == null || role_all_id.length < 1) {
				result = "input.invalid";
				map.put("result", result);
				return map;
			}
			
			UserGroupRole userGroupRole = new UserGroupRole();
			userGroupRole.setRole_type(UserGroupRole.ROLE_TYPE_USER);
			userGroupRole.setUser_group_id(user_group_id);
			userGroupRole.setRole_all_id(role_all_id);
			
			roleService.insertUserGroupRole(userGroupRole);
			
			listExceptUserGroupRoleByGroupId = roleService.getListExceptUserGroupRoleByGroupId(userGroupRole);
			listUserGroupRole = roleService.getListUserGroupRole(userGroupRole);
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result", "db.exception");
		}
		
		map.put("result", result);
		map.put("listExceptUserGroupRoleByGroupId", listExceptUserGroupRoleByGroupId);
		map.put("listUserGroupRole", listUserGroupRole);
		return map;
	}
	
	/**
	 * 선택 사용자 그룹내 Role 삭제
	 * @param request
	 * @param role_group_id
	 * @param user_group_id
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-delete-user-group-role.do")
	@ResponseBody
	public Map<String, Object> ajaxDeleteUserGroupRole(HttpServletRequest request,
			@RequestParam("user_group_id") Long user_group_id,
			@RequestParam("role_select_id") Long[] role_select_id) {
		
		log.info("@@@ user_group_id = {}, role_select_id = {}", user_group_id, role_select_id);
		Map<String, Object> map = new HashMap<>();
		List<UserGroupRole> listExceptUserGroupRoleByGroupId = new ArrayList<>();
		List<UserGroupRole> listUserGroupRole = new ArrayList<>();
		String result = "success";
		try {
			if(user_group_id == null || user_group_id.longValue() == 0l ||				
					role_select_id == null || role_select_id.length < 1) {
				result = "input.invalid";
				map.put("result", result);
				return map;
			}
			
			UserGroupRole userGroupRole = new UserGroupRole();
			userGroupRole.setRole_type(UserGroupRole.ROLE_TYPE_USER);
			userGroupRole.setUser_group_id(user_group_id);
			userGroupRole.setRole_select_id(role_select_id);
			
			roleService.deleteUserGroupRole(userGroupRole);
			
			listExceptUserGroupRoleByGroupId = roleService.getListExceptUserGroupRoleByGroupId(userGroupRole);
			listUserGroupRole = roleService.getListUserGroupRole(userGroupRole);
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result", "db.exception");
		}
		
		map.put("result", result);
		map.put("listExceptUserGroupRoleByGroupId", listExceptUserGroupRoleByGroupId);
		map.put("listUserGroupRole", listUserGroupRole);
		return map;
	}
	
	/**
	 * 검색 조건
	 * @param role
	 * @return
	 */
	private String getSearchParameters(Role role) {
		StringBuilder builder = new StringBuilder(100);
		builder.append("&");
		builder.append("role_type=" + StringUtil.getDefaultValue(role.getRole_type()));
		builder.append("&");
		builder.append("use_yn=" + StringUtil.getDefaultValue(role.getUse_yn()));
		builder.append("&");
		builder.append("order_word=" + StringUtil.getDefaultValue(role.getOrder_word()));
		builder.append("&");
		builder.append("order_value=" + StringUtil.getDefaultValue(role.getOrder_value()));
		return builder.toString();
	}
	
	/**
	 * 목록 페이지 이동 검색 조건
	 * @param request
	 * @return
	 */
	private String getListParameters(HttpServletRequest request) {
		StringBuilder builder = new StringBuilder(100);
		String pageNo = request.getParameter("pageNo");
		builder.append("pageNo=" + pageNo);
		builder.append("&");
		builder.append("role_type=" + StringUtil.getDefaultValue(request.getParameter("role_type")));
		builder.append("&");
		builder.append("use_yn=" + StringUtil.getDefaultValue(request.getParameter("use_yn")));
		builder.append("&");
		builder.append("order_word=" + StringUtil.getDefaultValue(request.getParameter("order_word")));
		builder.append("&");
		builder.append("order_value=" + StringUtil.getDefaultValue(request.getParameter("order_value")));
		return builder.toString();
	}
}
