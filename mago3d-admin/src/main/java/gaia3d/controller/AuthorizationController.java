package gaia3d.controller;

import java.util.List;

import org.apache.http.HttpStatus;

import gaia3d.domain.cache.CacheManager;
import gaia3d.support.RoleSupport;

/**
 * 권한 체크 인터페이스
 * TODO 관리자 페이지 기본 interface 로 확장 할지도 모름... 이름이 좀 애매 함
 * @author Jeongdae
 *
 */
public interface AuthorizationController {

	/**
	 * @param userGroupId
	 * @param roleKey
	 * @return
	 */
	default int getRoleStatusCode(Integer userGroupId, String roleKey) {
		int statusCode  = 0;
		List<String> userGroupRoleKeyList = CacheManager.getUserGroupRoleKeyList(userGroupId);
        if(!RoleSupport.isUserGroupRoleValid(userGroupRoleKeyList, roleKey)) {
			statusCode = HttpStatus.SC_FORBIDDEN;
		}
        
		return statusCode;
	}
}
