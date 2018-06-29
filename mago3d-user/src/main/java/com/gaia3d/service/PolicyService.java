package com.gaia3d.service;

import com.gaia3d.domain.Policy;

/**
 * 위젯
 * @author jeongdae
 *
 */
public interface PolicyService {
	
	/**
	 * 운영 정책 정보
	 * @return
	 */
	Policy getPolicy();
}
