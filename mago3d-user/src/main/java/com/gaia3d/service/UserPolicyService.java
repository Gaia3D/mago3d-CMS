package com.gaia3d.service;

import com.gaia3d.domain.UserPolicy;

public interface UserPolicyService {

	/**
	 * 사용자 정책
	 * @param user_id
	 * @return
	 */
	UserPolicy getUserPolicy(String user_id);
	
	/**
	 * 사용자 정책 등록
	 * @param userPolicy
	 * @return
	 */
	int insertUserPolicy(UserPolicy userPolicy);
	
	/**
	 * 사용자 정책 수정
	 * @param userPolicy
	 * @return
	 */
	int updateUserPolicy(UserPolicy userPolicy);
	
	/**
	 * 사용자 정책 삭제
	 * @param user_id
	 * @return
	 */
	int deleteUserPolicy(String user_id);
}
