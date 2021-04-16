package gaia3d.controller.rest;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.config.CacheConfig;
import gaia3d.controller.AuthorizationController;
import gaia3d.domain.cache.CacheName;
import gaia3d.domain.cache.CacheParams;
import gaia3d.domain.cache.CacheType;
import gaia3d.domain.user.UserGroup;
import gaia3d.domain.user.UserGroupMenu;
import gaia3d.domain.user.UserGroupRole;
import gaia3d.service.UserGroupService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/user-groups")
public class UserGroupRestController implements AuthorizationController {

	@Autowired
	private UserGroupService userGroupService;

	@Autowired
	private CacheConfig cacheConfig;

	/**
	 * 그룹Key 중복 체크
	 * @param request
	 * @param userGroup
	 * @return
	 */
	@GetMapping(value = "/duplication")
	public Map<String, Object> keyDuplicationCheck(HttpServletRequest request, UserGroup userGroup) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		// TODO @Valid 로 구현해야 함
		if(StringUtils.isEmpty(userGroup.getUserGroupKey())) {
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", "user.group.key.empty");
			result.put("message", message);

			return result;
		}

		Boolean duplication = userGroupService.isUserGroupKeyDuplication(userGroup);
		log.info("@@ duplication = {}", duplication);
		int statusCode = HttpStatus.OK.value();
		
		result.put("duplication", duplication);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);

		return result;
	}

	/**
	 * 사용자 그룹 정보
	 * @param userGroup
	 * @return
	 */
	@GetMapping(value = "/detail")
	public Map<String, Object> detail(UserGroup userGroup) {
		log.info("@@@@@ detail-group userGroup = {}", userGroup);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		if(userGroup.getUserGroupId() == null) {
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", "input.invalid");
			result.put("message", message);
			return result;
		}

		userGroup = userGroupService.getUserGroup(userGroup);
		int statusCode = HttpStatus.OK.value();
		
		result.put("userGroup", userGroup);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 사용자 그룹 등록
	 * @param request
	 * @param userGroup
	 * @param bindingResult
	 * @return
	 */
	@PostMapping(value = "/insert")
	public Map<String, Object> insert(HttpServletRequest request, @Valid @ModelAttribute UserGroup userGroup, BindingResult bindingResult) {
		log.info("@@@@@ insert userGroup = {}", userGroup);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		if(bindingResult.hasErrors()) {
			message = bindingResult.getAllErrors().get(0).getDefaultMessage();
			log.info("@@@@@ message = {}", message);
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", errorCode);
			result.put("message", message);
            return result;
		}

		//userGroup.setUserId(userSession.getUserId());

		userGroupService.insertUserGroup(userGroup);
		
		CacheParams cacheParams = new CacheParams();
		cacheParams.setCacheType(CacheType.BROADCAST);
		cacheParams.setCacheName(CacheName.USER_GROUP);
		cacheConfig.loadCache(cacheParams);
		int statusCode = HttpStatus.OK.value();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 사용자 그룹 수정
	 * @param request
	 * @param userGroup
	 * @param bindingResult
	 * @return
	 */
	@PostMapping(value = "/update")
	public Map<String, Object> update(HttpServletRequest request, @Valid UserGroup userGroup, BindingResult bindingResult) {
		log.info("@@ userGroup = {}", userGroup);
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		if(bindingResult.hasErrors()) {
			message = bindingResult.getAllErrors().get(0).getDefaultMessage();
			log.info("@@@@@ message = {}", message);
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", errorCode);
			result.put("message", message);
            return result;
		}

		userGroupService.updateUserGroup(userGroup);
		
		CacheParams cacheParams = new CacheParams();
		cacheParams.setCacheType(CacheType.BROADCAST);
		cacheParams.setCacheName(CacheName.USER_GROUP);
		cacheConfig.loadCache(cacheParams);
		
		int statusCode = HttpStatus.OK.value();

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 사용자 그룹 메뉴 수정
	 * @param request
	 * @param userGroupMenu
	 * @return
	 */
	@PostMapping(value = "/menu")
	public Map<String, Object> updateMenu(HttpServletRequest request, @ModelAttribute UserGroupMenu userGroupMenu) {
		log.info("@@ userGroupMenu = {}", userGroupMenu);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		userGroupService.updateUserGroupMenu(userGroupMenu);
		
        CacheParams cacheParams = new CacheParams();
		cacheParams.setCacheType(CacheType.BROADCAST);
		cacheParams.setCacheName(CacheName.MENU);
		cacheConfig.loadCache(cacheParams);
		int statusCode = HttpStatus.OK.value();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 사용자 그룹 Role 수정
	 * @param request
	 * @param userGroupRole
	 * @return
	 */
	@PostMapping(value = "/role")
	public Map<String, Object> updateRole(HttpServletRequest request, @ModelAttribute UserGroupRole userGroupRole) {
		log.info("@@ userGroupRole = {}", userGroupRole);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		userGroupService.updateUserGroupRole(userGroupRole);

        CacheParams cacheParams = new CacheParams();
		cacheParams.setCacheType(CacheType.BROADCAST);
		cacheParams.setCacheName(CacheName.ROLE);
		cacheConfig.loadCache(cacheParams);
		int statusCode = HttpStatus.OK.value();

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 사용자 그룹 트리 순서 수정 (up/down)
	 * @param request
	 * @param userGroupId
	 * @param userGroup
	 * @return
	 */
	@PostMapping(value = "/view-order/{userGroupId:[0-9]+}")
	public Map<String, Object> moveUserGroup(HttpServletRequest request, @PathVariable Integer userGroupId, @ModelAttribute UserGroup userGroup) {
		log.info("@@ userGroup = {}", userGroup);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		userGroup.setUserGroupId(userGroupId);

		int updateCount = userGroupService.updateUserGroupViewOrder(userGroup);
		int statusCode = HttpStatus.OK.value();
		if(updateCount == 0) {
			statusCode = HttpStatus.BAD_REQUEST.value();
			errorCode = "user.group.view-order.invalid";
		}

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
}
