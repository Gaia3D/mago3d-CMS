package com.gaia3d.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.Policy;
import com.gaia3d.service.PolicyService;

import com.gaia3d.persistence.PolicyMapper;

/**
 * mago3d 운영 정책
 * @author jeongdae
 *
 */
@Service
public class PolicyServiceImpl implements PolicyService {

	@Autowired
	private PolicyMapper policyMapper;
	
	/**
	 * 운영 정책 정보
	 * @return
	 */
	@Transactional(readOnly=true)
	public Policy getPolicy() {
		return policyMapper.getPolicy();
	}
}
