package com.gaia3d.service;

import java.util.List;

import com.gaia3d.domain.UserGroup;
import com.gaia3d.domain.UserGroupMenu;

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
	 * 사용자 그룹 조회
	 * 
	 * @param user_group_id
	 * @return
	 */
	UserGroup getUserGroup(Long user_group_id);

	/**
	 * 자식 그룹 중 순서가 최대인 그룹을 검색
	 * 
	 * @param parent
	 * @return
	 */
	UserGroup getMaxViewOrderChildUserGroup(Long parent);

	/**
	 * 사용자 그룹 메뉴 권한 목록
	 * 
	 * @param userGroup
	 * @return
	 */
	List<UserGroupMenu> getListUserGroupMenu(UserGroup userGroup);

	/**
	 * 사용자 그룹 등록
	 * 
	 * @param userGroup
	 * @return
	 */
	int insertUserGroup(UserGroup userGroup);

	/**
	 * 신규 메뉴 등록시 사용자 그룹 메뉴 권한에 추가
	 * 
	 * @param menu_id
	 * @return
	 */
	int insertUserGroupMenu(Long menu_id);

	/**
	 * 사용자 그룹 수정
	 * 
	 * @param userGroup
	 * @return
	 */
	int updateUserGroup(UserGroup userGroup);

	/**
	 * 사용자 그룹 메뉴 등록
	 * 
	 * @param user_group_id
	 * @param all_yn
	 * @param read_yn
	 * @param write_yn
	 * @param update_yn
	 * @param delete_yn
	 * @return
	 */
	int updateUserGroupMenu(Long user_group_id, String all_yn, String read_yn, String write_yn, String update_yn, String delete_yn);

	/**
	 * 사용자 그룹 위로/아래로 수정
	 * 
	 * @param userGroup
	 * @return
	 */
	int updateMoveUserGroup(UserGroup userGroup);

	/**
	 * 사용자 그룹 삭제
	 * 
	 * @param user_group_id
	 * @return
	 */
	int deleteUserGroup(Long user_group_id);

	/**
	 * 메뉴 삭제시 사용자 그룹 메뉴 권한도 삭제
	 * 
	 * @param menuIdList
	 * @return
	 */
	int deleteUserGroupMenuList(List<Long> menuIdList);
}
