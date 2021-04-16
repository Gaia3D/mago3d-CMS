package gaia3d.support;

import java.util.List;

import gaia3d.domain.role.RoleKey;
import gaia3d.domain.user.UserGroupRole;

/**
 * Role Check
 * @author Cheon JeongDae
 *
 */
public class RoleSupport {

	/**
	 * 사용자 그룹 Role 체크
	 * @param listUserGroupRole
	 * @param roleKey
	 * @return
	 */
	public static boolean isUserGroupRoleValid(List<UserGroupRole> listUserGroupRole, RoleKey roleKey) {
		boolean isExist = false;
		if(listUserGroupRole == null || listUserGroupRole.isEmpty()) return isExist;
		
		for(UserGroupRole userGroupRole : listUserGroupRole) {
			if(roleKey == RoleKey.valueOf(userGroupRole.getRoleKey())) {
				isExist = true;
			}
		}
		return isExist;
	}
	
	/**
	 * 사용자 그룹 Role 체크
	 * @param listUserGroupRoleKey
	 * @param roleKey
	 * @return
	 */
	public static boolean isUserGroupRoleValid(List<String> listUserGroupRoleKey, String roleKey) {
		if(listUserGroupRoleKey == null || listUserGroupRoleKey.isEmpty()) return false;
		return listUserGroupRoleKey.contains(roleKey);
	}
}
