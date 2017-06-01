package com.gaia3d.persistence;

import org.springframework.stereotype.Repository;

import com.gaia3d.domain.UserInfo;
import com.gaia3d.domain.UserSession;


/**
 * 로그인
 * @author jeongdae
 *
 */
@Repository
public interface LoginMapper {

	/**
	 * 회원 세션 정보를 취득
	 * @param userInfo
	 * @return
	 */
	UserSession getUserSession(UserInfo userInfo);
	
	/**
	 * 로그인 성공 후 회원 정보를 갱신
	 * @param userSession
	 * @return
	 */
	int updateLoginUserSession(UserSession userSession);

}
