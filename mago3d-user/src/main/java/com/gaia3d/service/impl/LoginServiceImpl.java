package com.gaia3d.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.UserInfo;
import com.gaia3d.domain.UserSession;
import com.gaia3d.persistence.LoginMapper;
import com.gaia3d.service.LoginService;

/**
 * 로그인 관련 처리
 * @author jeongdae
 *
 */
@Service
public class LoginServiceImpl implements LoginService {

	@Autowired
	private LoginMapper loginMapper;
	
	/**
	 * 회원 세션 정보를 취득
	 * @param userInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public UserSession getUserSession(UserInfo userInfo) {
		return loginMapper.getUserSession(userInfo);
	}

	/**
	 * 로그인 성공 후 회원 정보를 갱신
	 * @param userSession
	 * @return
	 */
	@Transactional
	public int updateLoginUserSession(UserSession userSession) {
		return loginMapper.updateLoginUserSession(userSession);
	}
}
