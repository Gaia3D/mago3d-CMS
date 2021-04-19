package gaia3d.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.cache.CacheManager;
import gaia3d.domain.policy.GeoPolicy;
import gaia3d.domain.user.UserPolicy;
import gaia3d.persistence.UserPolicyMapper;
import gaia3d.service.GeoPolicyService;
import gaia3d.service.UserPolicyService;
import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
public class UserPolicyServiceImpl implements UserPolicyService {

	@Autowired
	private UserPolicyMapper userPolicyMapper;
	@Autowired
	private GeoPolicyService geoPolicyService;
//	@Autowired
//	private LayerService layerService;
//	@Autowired
//	private LayerGroupMapper layerGroupMapper;

    @Transactional(readOnly = true)
    public UserPolicy getUserPolicy(String userId) {
        UserPolicy userPolicy = userPolicyMapper.getUserPolicy(userId);
        GeoPolicy geoPolicy = CacheManager.getGeoPolicy();
        if(userPolicy == null) {
        	userPolicy = UserPolicy.builder()
        				.initLongitude(geoPolicy.getInitLongitude())
        				.initLatitude(geoPolicy.getInitLatitude())
        				.initAltitude(geoPolicy.getInitAltitude())
        				.initDuration(geoPolicy.getInitDuration())
        				.initDefaultFov(geoPolicy.getInitDefaultFov())
        				.lod0(geoPolicy.getLod0())
        				.lod1(geoPolicy.getLod1())
        				.lod2(geoPolicy.getLod2())
        				.lod3(geoPolicy.getLod3())
        				.lod4(geoPolicy.getLod4())
        				.lod5(geoPolicy.getLod5())
        				.ssaoRadius(geoPolicy.getSsaoRadius())
//        				.baseLayers(defaultLayers())
        				.build();
        } else {
        	if(userPolicy.getInitLongitude() == null) userPolicy.setInitLongitude(geoPolicy.getInitLongitude());
        	if(userPolicy.getInitLatitude() == null) userPolicy.setInitLatitude(geoPolicy.getInitLatitude());
        	if(userPolicy.getInitAltitude() == null) userPolicy.setInitAltitude(geoPolicy.getInitAltitude());
        	if(userPolicy.getInitDuration() == null) userPolicy.setInitDuration(geoPolicy.getInitDuration());
        	if(userPolicy.getInitDefaultFov() == null) userPolicy.setInitDefaultFov(geoPolicy.getInitDefaultFov());
        	if(userPolicy.getLod0() == null) userPolicy.setLod0(geoPolicy.getLod0());
        	if(userPolicy.getLod1() == null) userPolicy.setLod1(geoPolicy.getLod1());
        	if(userPolicy.getLod2() == null) userPolicy.setLod2(geoPolicy.getLod2());
        	if(userPolicy.getLod3() == null) userPolicy.setLod3(geoPolicy.getLod3());
        	if(userPolicy.getLod4() == null) userPolicy.setLod4(geoPolicy.getLod4());
        	if(userPolicy.getLod5() == null) userPolicy.setLod5(geoPolicy.getLod5());
        	if(userPolicy.getSsaoRadius() == null) userPolicy.setSsaoRadius(geoPolicy.getSsaoRadius());
//        	if(userPolicy.getBaseLayers() == null) userPolicy.setBaseLayers(defaultLayers());
        }

        return userPolicy;
    }

    @Transactional
    public int updateUserPolicy(UserPolicy userPolicy) {
    	UserPolicy dbUserPolicy = userPolicyMapper.getUserPolicy(userPolicy.getUserId());

		if(dbUserPolicy == null) {
			return userPolicyMapper.insertUserPolicy(userPolicy);
		} else {
			return userPolicyMapper.updateUserPolicy(userPolicy);
		}
    }
    
    /**
	 * 사용자 기본 레이어 수정 
	 * @param userPolicy
	 * @return
	 */
    @Transactional
	public int updateBaseLayers(UserPolicy userPolicy) {
    	UserPolicy dbUserPolicy = userPolicyMapper.getUserPolicy(userPolicy.getUserId());

		if(dbUserPolicy == null) {
			return userPolicyMapper.insertUserPolicy(userPolicy);
		} else {
			return userPolicyMapper.updateBaseLayers(userPolicy);
		}
	}
    
//    private String defaultLayers() {
//    	List<LayerGroup> layerGroupList = layerGroupMapper.getListLayerGroup();
//    	List<String> baseLayerList = new ArrayList<>();
//    	String dataStore = geoPolicyService.getGeoPolicy().getGeoserverDataStore();
//		layerGroupList.stream()
//						.forEach(group -> {
//							Layer layer = Layer.builder()
//											.layerGroupId(group.getLayerGroupId())
//											.build();
//							baseLayerList.addAll(layerService.getListDefaultDisplayLayer(layer));
//						});
//		
//		String baseLayers = baseLayerList.stream()
//				.map(layerKey -> String.valueOf(dataStore + ":" + layerKey))
//				.collect(Collectors.joining(","));
//		
//    	return baseLayers;
//    }
}
