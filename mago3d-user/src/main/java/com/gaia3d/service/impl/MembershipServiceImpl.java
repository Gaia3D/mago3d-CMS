package com.gaia3d.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.Membership;
import com.gaia3d.persistence.MembershipMapper;
import com.gaia3d.service.MembershipService;

@Service
public class MembershipServiceImpl implements MembershipService {

	@Autowired
	private MembershipMapper membershipMapper;
	
	/**
	 * membership 정보 취득
	 * @param userId
	 * @return
	 */
	@Transactional(readOnly=true)
	public Membership getMembership(String userId) {
		return membershipMapper.getMembership(userId);
	}
	
	/**
	 * membership 정보 수정
	 * @param membership
	 * @return
	 */
	@Transactional
	public int updateMembership(Membership membership) {
		Membership dbMembership = membershipMapper.getMembership(membership.getUser_id());
		if(dbMembership == null) {
			return membershipMapper.insertMembership(membership);
		} else {
			return membershipMapper.updateMembership(membership);
		}
	}
}
