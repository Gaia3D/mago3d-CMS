package gaia3d.persistence;

import org.springframework.stereotype.Repository;

import gaia3d.domain.UserInfo;

/**
 * 사용자
 * @author jeongdae
 *
 */
@Repository
public interface UserMapper {

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
