package com.gaia3d.service;

import com.gaia3d.domain.UserInfo;
import com.gaia3d.domain.UserSession;

/**
 * 로그인 관련 처리
 * @author jeongdae
 *
 */
public interface LoginService {

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
