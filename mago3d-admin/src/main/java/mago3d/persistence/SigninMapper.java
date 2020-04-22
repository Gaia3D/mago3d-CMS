package mago3d.persistence;

import org.springframework.stereotype.Repository;

import mago3d.domain.UserInfo;
import mago3d.domain.UserSession;


/**
 * Sign in
 * @author jeongdae
 *
 */
@Repository
public interface SigninMapper {

	/**
	 * 회원 세션 정보를 취득
	 * @param userInfo
	 * @return
	 */
	UserSession getUserSession(UserInfo userInfo);
	
	/**
	 * Sign in 성공 후 회원 정보를 갱신
	 * @param userSession
	 * @return
	 */
	int updateSigninUserSession(UserSession userSession);

}
