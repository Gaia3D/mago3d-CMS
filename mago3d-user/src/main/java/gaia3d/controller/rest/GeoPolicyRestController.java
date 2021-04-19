package gaia3d.controller.rest;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.domain.Key;
import gaia3d.domain.cache.CacheManager;
import gaia3d.domain.data.DataInfo;
import gaia3d.domain.layer.LayerGroup;
import gaia3d.domain.policy.GeoPolicy;
import gaia3d.domain.user.UserPolicy;
import gaia3d.domain.user.UserSession;
import gaia3d.service.DataService;
import gaia3d.service.LayerGroupService;
import gaia3d.service.UserPolicyService;
import gaia3d.support.LayerDisplaySupport;
import lombok.extern.slf4j.Slf4j;

/**
 * 초기 로딩 policy init
 * @author PSH
 *
 */
@Slf4j
@RestController
@RequestMapping("/geopolicies")
public class GeoPolicyRestController {
	
	private final UserPolicyService userPolicyService;
	private final LayerGroupService layerGroupService;
	private final DataService dataService;
	
	public GeoPolicyRestController(UserPolicyService userPolicyService, LayerGroupService layerGroupService, DataService dataService) {
		this.userPolicyService = userPolicyService;
		this.layerGroupService = layerGroupService;
		this.dataService = dataService;
	}
	
	@GetMapping
	public Map<String, Object> getGeoPolicy(HttpServletRequest request) {
		log.info("@@ user GeoPolicy");
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		int statusCode = HttpStatus.OK.value();
		
		result.put("geoPolicy", CacheManager.getGeoPolicy());
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	@GetMapping("/user")
	public Map<String, Object> getUserGeoPolicy(HttpServletRequest request, @RequestParam String dataId) {
		log.info("@@ default Policy");
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		String userId = userSession.getUserId();
		GeoPolicy geoPolicy = CacheManager.getGeoPolicy();
		UserPolicy userPolicy = userPolicyService.getUserPolicy(userSession.getUserId());
		if(userId != null) {
			if(dataId != null && !"".equals(dataId.trim())) {
				// dataId가 있을경우 data 위치로 가기 위해 위치값을 변경해줌 
				DataInfo data = DataInfo.builder().dataId(Long.parseLong(dataId)).build();
				DataInfo dataInfo = dataService.getData(data);
				geoPolicy.setInitCameraEnable(false);
				geoPolicy.setInitLongitude(dataInfo.getLongitude().toString());
				geoPolicy.setInitLatitude(dataInfo.getLatitude().toString());
				BigDecimal altitude = new BigDecimal(dataInfo.getAltitude().toString());
				geoPolicy.setInitAltitude(altitude.add(new BigDecimal("10")).toString());
			} else {
				geoPolicy.setInitCameraEnable(true);
				geoPolicy.setInitLatitude(userPolicy.getInitLatitude());
				geoPolicy.setInitLongitude(userPolicy.getInitLongitude());
				geoPolicy.setInitAltitude(userPolicy.getInitAltitude());
			}
			geoPolicy.setInitDuration(userPolicy.getInitDuration());
			geoPolicy.setInitDefaultFov(userPolicy.getInitDefaultFov());
			geoPolicy.setLod0(userPolicy.getLod0());
			geoPolicy.setLod1(userPolicy.getLod1());
			geoPolicy.setLod2(userPolicy.getLod2());
			geoPolicy.setLod3(userPolicy.getLod3());
			geoPolicy.setLod4(userPolicy.getLod4());
			geoPolicy.setLod5(userPolicy.getLod5());
			geoPolicy.setSsaoRadius(userPolicy.getSsaoRadius());
		}
		
		LayerGroup layerGroup = LayerGroup.builder().userGroupId(userSession.getUserGroupId()).build();
		List<LayerGroup> baseLayers = LayerDisplaySupport.getListDisplayLayer(layerGroupService.getListLayerGroupAndLayer(layerGroup), userPolicy.getBaseLayers());
		int statusCode = HttpStatus.OK.value();
		
		result.put("geoPolicy", geoPolicy);
		result.put("baseLayers", baseLayers);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
}
