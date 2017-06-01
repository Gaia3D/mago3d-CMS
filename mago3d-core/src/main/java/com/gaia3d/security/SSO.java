package com.gaia3d.security;

import java.util.UUID;

/**
 * TODO JWT 는 잠시 보류함
 * SSO 
 * @author jeongdae
 *
 */
public class SSO {

	private SSO() {
	};
	
	/**
	 * 토큰 발행
	 * @param session
	 * @return
	 */
	public static String getUUIDToken() {
		return UUID.randomUUID().toString();
	}
}
