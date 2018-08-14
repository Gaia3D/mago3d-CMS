package com.gaia3d.persistence;

import org.springframework.stereotype.Repository;

import com.gaia3d.domain.UserPolicy;

/**
 * 사용자 정책
 * @author jeongdae
 *
 */
@Repository
public interface UserPolicyMapper {

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
