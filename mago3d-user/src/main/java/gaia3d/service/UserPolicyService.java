package gaia3d.service;

import gaia3d.domain.user.UserPolicy;

public interface UserPolicyService {

	/**
	 * 사용자 설정 정보 취득
	 * @param userId
	 * @return
	 */
	UserPolicy getUserPolicy(String userId);

	/**
	 * 사용자 설정 수정
	 * @param userPolicy
	 * @return
	 */
	int updateUserPolicy(UserPolicy userPolicy);
	
	/**
	 * 사용자 기본 레이어 수정 
	 * @param userPolicy
	 * @return
	 */
	int updateBaseLayers(UserPolicy userPolicy);

}
