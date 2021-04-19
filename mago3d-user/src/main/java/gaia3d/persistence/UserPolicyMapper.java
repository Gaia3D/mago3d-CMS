package gaia3d.persistence;

import org.springframework.stereotype.Repository;

import gaia3d.domain.user.UserPolicy;

@Repository
public interface UserPolicyMapper {

	/**
	 * 사용자 설정 정보 취득
	 * @param userId
	 * @return
	 */
	UserPolicy getUserPolicy(String userId);

	/**
	 * 사용자 설정 등록
	 * @param userPolicy
	 * @return
	 */
	int insertUserPolicy(UserPolicy userPolicy);

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
