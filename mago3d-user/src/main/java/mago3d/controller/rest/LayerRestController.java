package mago3d.controller.rest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import mago3d.domain.Key;
import mago3d.domain.LayerGroup;
import mago3d.domain.UserSession;
import mago3d.service.LayerGroupService;
import mago3d.service.UserPolicyService;
import mago3d.support.LayerDisplaySupport;

@RestController
@RequestMapping("/layers")
public class LayerRestController {

	private final LayerGroupService layerGroupService;
	private final UserPolicyService userPolicyService;
	
	public LayerRestController(LayerGroupService layerGroupService, UserPolicyService userPolicyService) {
		this.layerGroupService = layerGroupService;
		this.userPolicyService = userPolicyService;
	}

	/**
	 * 레이어 그룹 목록
	 * @param request
	 * @param layerGroup
	 * @param model
	 * @return
	 */
	@GetMapping
	public Map<String, Object> list(HttpServletRequest request, Model model) {
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		String baseLayers = userPolicyService.getUserPolicy(userSession.getUserId()).getBaseLayers();
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		List<LayerGroup> layerGroupList = layerGroupService.getListLayerGroupAndLayer();
		int statusCode = HttpStatus.OK.value();
		
		result.put("layerGroupList", LayerDisplaySupport.getListDisplayLayer(layerGroupList, baseLayers));
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		
		return result;
	}
}
