package com.gaia3d.persistence;

import org.springframework.stereotype.Repository;

import com.gaia3d.domain.Membership;

@Repository
public interface MembershipMapper {

	/**
	 * membership 정보 취득
	 * @param userId
	 * @return
	 */
	Membership getMembership(String userId);
	
	/**
	 * membership 정보 등록
	 * @param membership
	 * @return
	 */
	int insertMembership(Membership membership);
	
	/**
	 * membership 정보 수정
	 * @param membership
	 * @return
	 */
	int updateMembership(Membership membership);
}
