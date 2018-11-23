package com.gaia3d.service;

import com.gaia3d.domain.Membership;

public interface MembershipService {

	/**
	 * membership 정보 취득
	 * @param userId
	 * @return
	 */
	Membership getMembership(String userId);
	
	/**
	 * membership 정보 수정
	 * @param membership
	 * @return
	 */
	int updateMembership(Membership membership);

}
