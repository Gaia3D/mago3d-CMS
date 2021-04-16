package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.user.UserGroup;
import gaia3d.domain.user.UserGroupMenu;
import gaia3d.domain.user.UserGroupRole;

@Repository
public interface UserGroupMapper {

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
     * 부모와 표시 순서로 메뉴 조회
     * @param userGroup
     * @return
     */
    UserGroup getUserGroupByParentAndViewOrder(UserGroup userGroup);
    
    /**
     * 조상이 같은 사용자 그룹 아이디 목록
     * @param userGroupId
     * @return
     */
    List<Integer> getUserGroupIdByAncestor(Integer userGroupId);
    
    /**
     * 부모가 같은 사용자 그룹 아이디 목록
     * @param userGroupId
     * @return
     */
    List<Integer> getUserGroupIdByParent(Integer userGroupId);

    /**
     * 사용자 그룹 Key 중복 확인
     * @param userGroup
     * @return
     */
    Boolean isUserGroupKeyDuplication(UserGroup userGroup);

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
	 * 트리 구조의 하위 사용자 그룹 목록
	 * @param userGroup
	 * @return
	 */
	List<UserGroup> getListUserGroupTree(UserGroup userGroup);

    /**
     * 사용자 그룹 등록
     * @param userGroup
     * @return
     */
    int insertUserGroup(UserGroup userGroup);

	/**
	 * 사용자 그룹 메뉴 등록
	 * @param userGroupMenu
	 * @return
	 */
	int insertUserGroupMenu(UserGroupMenu userGroupMenu);

	/**
	 * 사용자 그룹 Role 등록
	 * @param userGroupRole
	 * @return
	 */
	int insertUserGroupRole(UserGroupRole userGroupRole);

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
	 * 사용자 그룹 삭제
	 * @param userGroup
	 * @return
	 */
	int deleteUserGroup(UserGroup userGroup);

	/**
	 * ancestor를 이용하여 데이터 그룹 삭제
	 * @param userGroup
	 * @return
	 */
	int deleteUserGroupByAncestor(UserGroup userGroup);

	/**
	 * parent를 이용하여 데이터 그룹 삭제
	 * @param userGroup
	 * @return
	 */
	int deleteUserGroupByParent(UserGroup userGroup);

	/**
	 * 사용자 그룹 메뉴 삭제
	 * @param userGroupId
	 * @return
	 */
	int deleteUserGroupMenu(Integer userGroupId);

	/**
	 * 사용자 그룹 Role 삭제
	 * @param userGroupId
	 * @return
	 */
	int deleteUserGroupRole(Integer userGroupId);
}
