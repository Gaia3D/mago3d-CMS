package gaia3d.controller.rest;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.config.CacheConfig;
import gaia3d.domain.Key;
import gaia3d.domain.cache.CacheName;
import gaia3d.domain.cache.CacheParams;
import gaia3d.domain.cache.CacheType;
import gaia3d.domain.data.DataInfo;
import gaia3d.domain.layer.LayerGroup;
import gaia3d.domain.policy.GeoPolicy;
import gaia3d.domain.user.UserPolicy;
import gaia3d.domain.user.UserSession;
import gaia3d.service.DataService;
import gaia3d.service.GeoPolicyService;
import gaia3d.service.LayerGroupService;
import gaia3d.service.UserPolicyService;
import gaia3d.support.LayerDisplaySupport;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/geopolicies")
public class GeoPolicyRestController {

	@Autowired
	private CacheConfig cacheConfig;
	@Autowired
	private GeoPolicyService geoPolicyService;
	@Autowired
	private UserPolicyService userPolicyService;
	@Autowired
	private DataService dataService;
	@Autowired
	private LayerGroupService layerGroupService;
	
	@GetMapping
	public Map<String, Object> getGeoPolicy(HttpServletRequest request) {
		log.info("@@ user GeoPolicy");
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		int statusCode = HttpStatus.OK.value();
		
		result.put("geoPolicy", geoPolicyService.getGeoPolicy());
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
		GeoPolicy geoPolicy = geoPolicyService.getGeoPolicy();
		UserPolicy userPolicy = userPolicyService.getUserPolicy(userSession.getUserId());
		
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
		
		List<LayerGroup> baseLayers = LayerDisplaySupport.getListDisplayLayer(layerGroupService.getListLayerGroupAndLayer(), userPolicy.getBaseLayers());
		int statusCode = HttpStatus.OK.value();
		
		result.put("geoPolicy", geoPolicy);
		result.put("baseLayers", baseLayers);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	@PostMapping(value = "/{geoPolicyId:[0-9]+}")
    public Map<String, Object> updateGeoPolicy(@Valid GeoPolicy geoPolicy, @PathVariable Long geoPolicyId, BindingResult bindingResult) {
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
		
		geoPolicy.setGeoPolicyId(geoPolicyId);
		geoPolicyService.updateGeoPolicy(geoPolicy);
		int statusCode = HttpStatus.OK.value();
		
		reloadCache();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
    }

	@PostMapping(value = "/geoserver/{geoPolicyId:[0-9]+}")
    public Map<String, Object> updateGeoServer(@Valid GeoPolicy geoPolicy, @PathVariable Long geoPolicyId, BindingResult bindingResult) {
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
		geoPolicy.setGeoPolicyId(geoPolicyId);
		geoPolicyService.updateGeoPolicyGeoServer(geoPolicy);
		int statusCode = HttpStatus.OK.value();

		reloadCache();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
    }

	private void reloadCache() {
		CacheParams cacheParams = new CacheParams();
		cacheParams.setCacheName(CacheName.GEO_POLICY);
		cacheParams.setCacheType(CacheType.BROADCAST);
		cacheConfig.loadCache(cacheParams);
	}
}
