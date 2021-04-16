package gaia3d.controller.rest;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.config.CacheConfig;
import gaia3d.domain.cache.CacheName;
import gaia3d.domain.cache.CacheParams;
import gaia3d.domain.cache.CacheType;
import gaia3d.domain.role.Role;
import gaia3d.service.RoleService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/role")
public class RoleRestController {

	@Autowired
	private CacheConfig cacheConfig;
	@Autowired
	private RoleService roleService;

	/**
	 * Role 등록
	 * @param role
	 * @param bindingResult
	 * @return
	 */
	@PostMapping(value = "/insert")
	public Map<String, Object> insert(@Valid Role role, BindingResult bindingResult) {
		log.info("@@ role = {}", role);
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

		roleService.insertRole(role);
		int statusCode = HttpStatus.OK.value();
		
		reloadCache();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * Role 정보 수정
	 * @param role
	 * @param bindingResult
	 * @return
	 */
	@PostMapping(value = "/update")
	public Map<String, Object> update(HttpServletRequest request, @Valid Role role, BindingResult bindingResult) {
		log.info("@@ role = {}", role);
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

		roleService.updateRole(role);
		int statusCode = HttpStatus.OK.value();
		
		reloadCache();
	
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * Role 삭제
	 * @param roleId
	 * @return
	 */
	@DeleteMapping(value = "/delete")
	public Map<String, Object> delete(@RequestParam Integer roleId) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		roleService.deleteRole(roleId);
		int statusCode = HttpStatus.OK.value();
		
		reloadCache();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	private void reloadCache() {
		CacheParams cacheParams = new CacheParams();
		cacheParams.setCacheName(CacheName.ROLE);
		cacheParams.setCacheType(CacheType.BROADCAST);
		cacheConfig.loadCache(cacheParams);
	}
}