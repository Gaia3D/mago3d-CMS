package gaia3d.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.policy.GeoPolicy;
import gaia3d.domain.user.UserPolicy;
import gaia3d.persistence.UserPolicyMapper;
import gaia3d.service.GeoPolicyService;
import gaia3d.service.UserPolicyService;


@Service
public class UserPolicyServiceImpl implements UserPolicyService {

	@Autowired
	private UserPolicyMapper userPolicyMapper;
	@Autowired
	private GeoPolicyService geoPolicyService;

    @Transactional(readOnly = true)
    public UserPolicy getUserPolicy(String userId) {
        UserPolicy userPolicy = userPolicyMapper.getUserPolicy(userId);
        GeoPolicy geoPolicy = geoPolicyService.getGeoPolicy();
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
}
