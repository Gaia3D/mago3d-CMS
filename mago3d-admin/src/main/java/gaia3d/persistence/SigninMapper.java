package gaia3d.persistence;

import org.springframework.stereotype.Repository;

import gaia3d.domain.user.UserInfo;
import gaia3d.domain.user.UserSession;


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
