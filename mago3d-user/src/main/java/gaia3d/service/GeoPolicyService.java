package gaia3d.service;

import gaia3d.domain.policy.GeoPolicy;

/**
 * 2D, 3D 운영 정책
 * @author jeongdae
 *
 */
public interface GeoPolicyService {
	
	/**
	 * 운영 정책 정보
	 * @return
	 */
	GeoPolicy getGeoPolicy();
}
