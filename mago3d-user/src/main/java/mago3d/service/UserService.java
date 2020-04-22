package mago3d.service;

import mago3d.domain.UserInfo;

/**
 * 사용자
 * @author jeongdae
 *
 */
public interface UserService {
	
	/**
	 * 사용자 정보 취득
	 * @param userId
	 * @return
	 */
	UserInfo getUser(String userId);
	
	/**
	 * 사용자 비밀번호 수정
	 * @param userInfo
	 * @return
	 */
	int updatePassword(UserInfo userInfo);
}
