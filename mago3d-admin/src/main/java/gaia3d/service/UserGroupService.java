package gaia3d.service;

import java.util.List;

import gaia3d.domain.user.UserGroup;
import gaia3d.domain.user.UserGroupMenu;
import gaia3d.domain.user.UserGroupRole;

public interface UserGroupService {

	/**
     * 사용자 그룹 목록
     * @return
     */
    List<UserGroup> getListUserGroup();

    /**
     * 사용자 그룹 정보 조회 조회
     * @param userGroup
     * @return
     */
    UserGroup getUserGroup(UserGroup userGroup);

    /**
     * 기본 사용자 그룹 정보 조회
     * @return
     */
    UserGroup getBasicUserGroup();

	/**
	 * 사용자 그룹 메뉴 권한 목록
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

    /**
     * 사용자 그룹 Key 중복 확인
     * @param userGroup
     * @return
     */
    Boolean isUserGroupKeyDuplication(UserGroup userGroup);
    
    /**
     * 사용자 그룹 등록
     * @param userGroup
     * @return
     */
    int insertUserGroup(UserGroup userGroup);

	/**
	 * 사용자 그룹 수정
	 * @param userGroup
	 * @return
	 */
	int updateUserGroup(UserGroup userGroup);

	/**
	 * 사용자 그룹 표시 순서 수정 (up/down)
	 * @param userGroup
	 * @return
	 */
	int updateUserGroupViewOrder(UserGroup userGroup);

	/**
	 * 사용자 그룹 메뉴 수정
	 * @param userGroupMenu
	 * @return
	 */
	int updateUserGroupMenu(UserGroupMenu userGroupMenu);

	/**
	 * 사용자 그룹 Role 수정
	 * @param userGroupRole
	 * @return
	 */
	int updateUserGroupRole(UserGroupRole userGroupRole);

	/**
	 * 사용자 그룹 삭제
	 * @param userGroup
	 * @return
	 */
	int deleteUserGroup(UserGroup userGroup);

}
