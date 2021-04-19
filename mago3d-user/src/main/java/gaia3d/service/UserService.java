package gaia3d.service;

import gaia3d.domain.user.UserInfo;

/**
 * 사용자
 * @author jeongdae
 *
 */
public interface UserService {
	
	/**
	 * 사용자 ID 중복 체크
	 * @param userInfo
	 * @return
	 */
	Boolean isUserIdDuplication(UserInfo userInfo);

	/**
	 * 사용자 정보 취득
	 * @param userId
	 * @return
	 */
	UserInfo getUser(String userId);

	/**
	 * 사용자 등록
	 * @param userInfo
	 * @return
	 */
	int insertUser(UserInfo userInfo);
	
	/**
	 * 사용자 비밀번호 수정
	 * @param userInfo
	 * @return
	 */
	int updatePassword(UserInfo userInfo);
}
