package com.gaia3d.helper;

import java.util.List;

/**
 * Role Check
 * @author Cheon JeongDae
 *
 */
public class GroupRoleHelper {

	/**
	 * 사용자 그룹 Role 체크
	 * @param listUserGroupRole
	 * @param type
	 * @return
	 */
	public static boolean isUserGroupRoleValid(List<String> listUserGroupRole, String roleKey) {
		if(listUserGroupRole.contains(roleKey)) {
			return true;
		}
		return false;
	}
}
