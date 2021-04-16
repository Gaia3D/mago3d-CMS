package gaia3d.controller.view;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import gaia3d.config.CacheConfig;
import gaia3d.controller.AuthorizationController;
import gaia3d.domain.cache.CacheName;
import gaia3d.domain.cache.CacheParams;
import gaia3d.domain.cache.CacheType;
import gaia3d.domain.menu.Menu;
import gaia3d.domain.menu.MenuTarget;
import gaia3d.domain.menu.MenuType;
import gaia3d.domain.policy.Policy;
import gaia3d.domain.role.Role;
import gaia3d.domain.user.UserGroup;
import gaia3d.domain.user.UserGroupMenu;
import gaia3d.domain.user.UserGroupRole;
import gaia3d.service.MenuService;
import gaia3d.service.PolicyService;
import gaia3d.service.RoleService;
import gaia3d.service.UserGroupService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user-group")
public class UserGroupController implements AuthorizationController {

	@Autowired
	private UserGroupService userGroupService;

	@Autowired
	private MenuService menuService;

	@Autowired
	private RoleService roleService;

	@Autowired
	private PolicyService policyService;

	@Autowired
	private ObjectMapper objectMapper;

	@Autowired
	private CacheConfig cacheConfig;

	/**
	 * 사용자 그룹 목록
	 * @param request
	 * @param userGroup
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/list")
	public String list(HttpServletRequest request, @ModelAttribute UserGroup userGroup, Model model) {
		List<UserGroup> userGroupList = userGroupService.getListUserGroup();

		model.addAttribute("userGroupList", userGroupList);

		return "/user-group/list";
	}

	/**
	 * 사용자 그룹 등록 페이지 이동
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/input")
	public String input(Model model) {
		Policy policy = policyService.getPolicy();

		List<UserGroup> userGroupList = userGroupService.getListUserGroup();

		UserGroup userGroup = new UserGroup();
		userGroup.setParentName(policy.getContentUserGroupRoot());
		userGroup.setParent(0);

		model.addAttribute("policy", policy);
		model.addAttribute("userGroup", userGroup);
		model.addAttribute("userGroupList", userGroupList);

		return "/user-group/input";
	}

	/**
	 * 사용자 그룹 수정 페이지 이동
	 * @param request
	 * @param userGroupId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/modify")
	public String modify(HttpServletRequest request, @RequestParam Integer userGroupId, Model model) {
		UserGroup userGroup = new UserGroup();
		userGroup.setUserGroupId(userGroupId);
		userGroup = userGroupService.getUserGroup(userGroup);
		Policy policy = policyService.getPolicy();

		if(userGroup.getParent() == 0) {
			userGroup.setParentName(policy.getContentUserGroupRoot());
		}

		model.addAttribute("policy", policy);
		model.addAttribute("userGroup", userGroup);

		return "/user-group/modify";
	}

    /**
	 * 사용자 그룹 삭제
	 * @param userGroupId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/delete")
	public String delete(@RequestParam("userGroupId") Integer userGroupId, Model model) {

		// TODO validation 체크 해야 함
		UserGroup userGroup = new UserGroup();
		userGroup.setUserGroupId(userGroupId);

		userGroupService.deleteUserGroup(userGroup);

		// 삭제 후 캐시 갱신
		CacheParams cacheParams = new CacheParams();
		cacheParams.setCacheType(CacheType.BROADCAST);
		cacheParams.setCacheName(CacheName.USER_GROUP);
		cacheConfig.loadCache(cacheParams);

		return "redirect:/user-group/list";
	}

	/**
	 * 사용자 그룹 메뉴 할당 페이지 이동
	 * @param request
	 * @param userGroupId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/menu")
	public String menu(HttpServletRequest request, @RequestParam Integer userGroupId, Model model) {
		Menu menu = new Menu();
		menu.setMenuTarget(MenuTarget.ADMIN.getValue());
		menu.setMenuType(MenuType.URL.getValue());
		List<Menu> menuList = menuService.getListMenu(menu);
		menu.setMenuTarget(MenuTarget.USER.getValue());
		menu.setMenuType(MenuType.HTMLID.getValue());
		menuList.addAll(menuService.getListMenu(menu));

		UserGroup userGroup = new UserGroup();
		userGroup.setUserGroupId(userGroupId);
		userGroup = userGroupService.getUserGroup(userGroup);

		String userGroupMenuJson = "";

		try {
			UserGroupMenu userGroupMenu = new UserGroupMenu();
			userGroupMenu.setUserGroupId(userGroupId);
			List<UserGroupMenu> userGroupMenuList = userGroupService.getListUserGroupMenu(userGroupMenu);
			userGroupMenuJson = objectMapper.writeValueAsString(userGroupMenuList);
		} catch(JsonProcessingException e) {
			log.info("@@@@@@@@@@@@ jsonProcessing exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
		} catch(RuntimeException e) {
			log.info("@@@@@@@@@@@@ runtime exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
		} catch(Exception e) {
			log.info("@@@@@@@@@@@@ exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
		}

		model.addAttribute("userGroup", userGroup);
		model.addAttribute("menuList", menuList);
		model.addAttribute("userGroupMenuJson", userGroupMenuJson);

		return "/user-group/menu";
	}

	/**
	 * 사용자 그룹 Role 할당 페이지 이동
	 * @param request
	 * @param userGroupId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/role")
	public String role(HttpServletRequest request, @RequestParam Integer userGroupId, Model model) {
		Role role = new Role();
		role.setOffset(0l);
		role.setLimit(1000l);
		role.setOrderWord("role_id");
		role.setOrderValue("ASC");
		List<Role> roleList = roleService.getListRole(role);

		UserGroup userGroup = new UserGroup();
		userGroup.setUserGroupId(userGroupId);
		userGroup = userGroupService.getUserGroup(userGroup);

		String userGroupRoleJson = "";

		try {
			UserGroupRole userGroupRole = new UserGroupRole();
			userGroupRole.setUserGroupId(userGroupId);
			List<UserGroupRole> userGroupRoleList = userGroupService.getListUserGroupRole(userGroupRole);
			userGroupRoleJson = objectMapper.writeValueAsString(userGroupRoleList);
		} catch(JsonProcessingException e) {
			log.info("@@@@@@@@@@@@ jsonProcessing exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
		} catch(RuntimeException e) {
			log.info("@@@@@@@@@@@@ runtime exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
		} catch(Exception e) {
			log.info("@@@@@@@@@@@@ exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
		}

		model.addAttribute("userGroup", userGroup);
		model.addAttribute("roleList", roleList);
		model.addAttribute("userGroupRoleJson", userGroupRoleJson);

		return "/user-group/role";
	}
}
