package gaia3d.service;

import java.util.List;

import gaia3d.domain.user.UserGroup;
import gaia3d.domain.user.UserGroupMenu;
import gaia3d.domain.user.UserGroupRole;

/**
 * 사용자 그룹 관리
 * 
 * @author jeongdae
 *
 */
public interface UserGroupService {

	/**
	 * 사용자 그룹 목록
	 * 
	 * @param userGroup
	 * @return
	 */
	List<UserGroup> getListUserGroup(UserGroup userGroup);

	/**
	 * 자식 사용자 그룹 개수
	 * 
	 * @param userGroupId
	 * @return
	 */
	int getChildUserGroupCount(Integer userGroupId);
	
	/**
	 * 사용자 그룹 정보 취득
	 * @param userGroupId
	 * @return
	 */
	UserGroup getUserGroup(Integer userGroupId);
	
	/**
	 * 사용자 그룹 정보 취득
	 * @param userId
	 * @return
	 */
	UserGroup getUserGroupByUserId(String userId);
	
	/**
	 * 자식 사용자 그룹 중 순서가 최대인 사용자 그룹 검색
	 * @param userGroupId
	 * @return
	 */
	UserGroup getMaxViewOrderChildUserGroup(Integer userGroupId);
	
	/**
	 * 사용자 그룹 메뉴 권한 목록
	 * 
	 * @param userGroupMenu
	 * @return
	 */
	List<UserGroupMenu> getListUserGroupMenu(UserGroupMenu userGroupMenu);
	
	/**
	 * 사용자 그룹 Role 목록
	 * @param userGroupRole
	 * @return
	 */
	List<UserGroupRole> getListUserGroupRole(UserGroupRole userGroupRole);
	
	/**
	 * 사용자 그룹 Role Key 목록
	 * @param userGroupRole
	 * @return
	 */
	List<String> getListUserGroupRoleKey(UserGroupRole userGroupRole);
}
