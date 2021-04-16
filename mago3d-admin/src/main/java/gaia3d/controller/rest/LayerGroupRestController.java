package gaia3d.controller.rest;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.domain.Key;
import gaia3d.domain.layer.LayerGroup;
import gaia3d.domain.user.UserSession;
import gaia3d.service.LayerGroupService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/layer-groups")
public class LayerGroupRestController {

	@Autowired
	private LayerGroupService layerGroupService;

	/**
	 * 레이어 그룹 등록
	 * @param request
	 * @param layerGroup
	 * @param bindingResult
	 * @return
	 */
	@PostMapping(value = "/insert")
	public Map<String, Object> insert(HttpServletRequest request, @Valid @ModelAttribute LayerGroup layerGroup, BindingResult bindingResult) {
		log.info("@@@@@ insert layerGroup = {}", layerGroup);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());

		if(bindingResult.hasErrors()) {
			message = bindingResult.getAllErrors().get(0).getDefaultMessage();
			log.info("@@@@@ message = {}", message);
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", errorCode);
			result.put("message", message);
            return result;
		}

		layerGroup.setUserId(userSession.getUserId());

		layerGroupService.insertLayerGroup(layerGroup);
		int statusCode = HttpStatus.OK.value();
			
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 레이어 그룹 수정
	 * @param request
	 * @param layerGroup
	 * @param bindingResult
	 * @return
	 */
	@PostMapping(value = "/update")
	public Map<String, Object> update(HttpServletRequest request, @Valid LayerGroup layerGroup, BindingResult bindingResult) {
		log.info("@@ layerGroup = {}", layerGroup);
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

		layerGroupService.updateLayerGroup(layerGroup);
		int statusCode = HttpStatus.OK.value();

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 레이어 그룹 트리 순서 수정 (up/down)
	 * @param request
	 * @param layerGroupId
	 * @param layerGroup
	 * @return
	 */
	@PostMapping(value = "/view-order/{layerGroupId:[0-9]+}")
	public Map<String, Object> moveLayerGroup(HttpServletRequest request, @PathVariable Integer layerGroupId, @ModelAttribute LayerGroup layerGroup) {
		log.info("@@ layerGroup = {}", layerGroup);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		layerGroup.setLayerGroupId(layerGroupId);

		int updateCount = layerGroupService.updateLayerGroupViewOrder(layerGroup);
		int statusCode = HttpStatus.OK.value();
		if(updateCount == 0) {
			statusCode = HttpStatus.BAD_REQUEST.value();
			errorCode = "layer.group.view-order.invalid";
		}
			
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
}
