package com.gaia3d.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.UserPolicy;
import com.gaia3d.persistence.UserMapper;
import com.gaia3d.persistence.UserPolicyMapper;
import com.gaia3d.service.UserPolicyService;

/**
 * 사용자 정책
 * @author Cheon JeongDae
 *
 */
@Service
public class UserPolicyServiceImpl implements UserPolicyService {
	
	@Autowired
	private UserPolicyMapper userPolicyMapper;

	/**
	 * 사용자 정책
	 * @param user_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public UserPolicy getUserPolicy(String user_id) {
		return userPolicyMapper.getUserPolicy(user_id);
	}
	
	/**
	 * 사용자 정책 등록
	 * @param userPolicy
	 * @return
	 */
	@Transactional
	public int insertUserPolicy(UserPolicy userPolicy) {
		return userPolicyMapper.insertUserPolicy(userPolicy);
	}
	
	/**
	 * 사용자 정책 수정
	 * @param userPolicy
	 * @return
	 */
	@Transactional
	public int updateUserPolicy(UserPolicy userPolicy) {
		return userPolicyMapper.updateUserPolicy(userPolicy);
	}
	
	/**
	 * 사용자 정책 삭제
	 * @param user_id
	 * @return
	 */
	@Transactional
	public int deleteUserPolicy(String user_id) {
		return userPolicyMapper.deleteUserPolicy(user_id);
	}
}
