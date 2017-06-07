package com.gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gaia3d.domain.UserGroup;
import com.gaia3d.domain.UserGroupMenu;

/**
 * 사용자 그룹
 * 
 * @author jeongdae
 *
 */
@Repository
public interface UserGroupMapper {

	/**
	 * user_group_id 최대값
	 * 
	 * @return
	 */
	Long getMaxUserGroupId();

	/**
	 * user_group_menu_id 최대값
	 * 
	 * @return
	 */
	Long getMaxUserGroupMenuId();

	/**
	 * 사용자 그룹 목록
	 * 
	 * @return
	 */
	List<UserGroup> getListUserGroup(UserGroup userGroup);

	/**
	 * 사용자 그룹 조회
	 * 
	 * @param user_group_id
	 * @return
	 */
	UserGroup getUserGroup(Long user_group_id);

	/**
	 * 사용자 그룹에 속한 자식 그룹 개수
	 * 
	 * @param parent
	 * @return
	 */
	Integer getUserGroupChildCount(Long parent);

	/**
	 * 사용자 그룹에 속한 자식 그룹 목록
	 * 
	 * @param parent
	 * @return
	 */
	List<Long> getListUserGroupChild(Long parent);

	/**
	 * 사용자 그룹 메뉴 권한 목록
	 * 
	 * @param user_group_id
	 * @return
	 */
	List<UserGroupMenu> getListUserGroupMenu(Long user_group_id);

	/**
	 * 가장 마지막 순서의 그룹 정보 취득
	 * 
	 * @param userGroup
	 * @return
	 */
	UserGroup getMaxViewOrderChildUserGroup(Long parent);

	/**
	 * 사용자 그룹 트리 부모와 순서로 그룹 정보 취득
	 * 
	 * @param userGroup
	 * @return
	 */
	UserGroup getUserGroupByParentAndViewOrder(UserGroup userGroup);

	/**
	 * 사용자 그룹 등록
	 * 
	 * @param userGroup
	 * @return
	 */
	int insertUserGroup(UserGroup userGroup);

	/**
	 * 사용자 그룹별 메뉴 권한 등록
	 * 
	 * @param userGroupMenu
	 * @return
	 */
	int insertUserGroupMenu(UserGroupMenu userGroupMenu);

	/**
	 * 사용자 그룹 수정
	 * 
	 * @param userGroup
	 * @return
	 */
	int updateUserGroup(UserGroup userGroup);

	/**
	 * 사용자 그룹별 메뉴 권한 수정
	 * 
	 * @param userGroupMenu
	 * @return
	 */
	int updateUserGroupMenu(UserGroupMenu userGroupMenu);

	/**
	 * 그룹 순서 수정
	 * 
	 * @param userGroup
	 * @return
	 */
	int updateViewOrderUserGroup(UserGroup userGroup);

	/**
	 * 자식 존재 유무 수정
	 * 
	 * @param userGroup
	 * @return
	 */
	int updateUserGroupChildYN(UserGroup userGroup);

	/**
	 * 사용자 그룹 삭제
	 * 
	 * @param user_group_id
	 * @return
	 */
	int deleteUserGroup(Long user_group_id);

	/**
	 * 사용자 그룹 메뉴 삭제
	 * 
	 * @param user_group_id
	 * @return
	 */
	int deleteUserGroupMenu(Long user_group_id);

	/**
	 * 메뉴 삭제시 사용자 그룹 메뉴 권한도 삭제
	 * 
	 * @param menuIdList
	 * @return
	 */
	int deleteUserGroupMenuList(List<Long> menuIdList);
}
