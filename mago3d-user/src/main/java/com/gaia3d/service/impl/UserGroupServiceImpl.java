package com.gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.Menu;
import com.gaia3d.domain.UserGroup;
import com.gaia3d.domain.UserGroupMenu;
import com.gaia3d.persistence.UserGroupMapper;
import com.gaia3d.service.MenuService;
import com.gaia3d.service.UserGroupService;

/**
 * 사용자 그룹
 * @author jeongdae
 *
 */
@Service
public class UserGroupServiceImpl implements UserGroupService {

	@Autowired
	private UserGroupMapper userGroupMapper;
	@Autowired
	private MenuService menuService;

	/**
	 * 사용자 그룹 목록
	 * @param userGroup
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<UserGroup> getListUserGroup(UserGroup userGroup) {
		return userGroupMapper.getListUserGroup(userGroup);
	}
	
	/**
	 * 사용자 그룹 조회
	 * @param user_group_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public UserGroup getUserGroup(Long user_group_id) {
		return userGroupMapper.getUserGroup(user_group_id);
	}
	
	/**
	 * 사용자 그룹 메뉴 권한 목록
	 * @param userGroup
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<UserGroupMenu> getListUserGroupMenu(UserGroup userGroup) {
		
		List<UserGroupMenu> userGroupMenuList = userGroupMapper.getListUserGroupMenu(userGroup.getUser_group_id());
		if(userGroupMenuList.isEmpty()) {
			List<Menu> menuList = null;
			
			// TODO UserGroupRole 에서 확인해야 함
//			if(userGroup.getLevel() == UserGroup.SUPER_ADMIN) {
//				// 관리자는 모든 메뉴를
//				menuList = menuService.getListMenu(null);
//			} else {
//				// 기본 메뉴 외에 메뉴만
//				menuList = menuService.getListMenu("N");
//			}
			menuList = menuService.getListMenu(null);
			
			for(Menu menu : menuList) {
				UserGroupMenu userGroupMenu = new UserGroupMenu();
				userGroupMenu.setUser_group_id(userGroup.getUser_group_id());
				userGroupMenu.setMenu_id(menu.getMenu_id());
				userGroupMenu.setName(menu.getName());
				userGroupMenu.setParent(menu.getParent());
				userGroupMenu.setDepth(menu.getDepth());
				userGroupMenu.setView_order(menu.getView_order());
				userGroupMenu.setUse_yn(menu.getUse_yn());
				userGroupMenu.setUrl(menu.getUrl());
				userGroupMenu.setImage(menu.getImage());
				userGroupMenu.setImage_alt(menu.getImage_alt());
				userGroupMenu.setDescritpion(menu.getDescription());
				userGroupMenu.setDefault_yn(menu.getDefault_yn());
				userGroupMenu.setAll_yn("N");
				userGroupMenu.setRead_yn("N");
				userGroupMenu.setWrite_yn("N");
				userGroupMenu.setUpdate_yn("N");
				userGroupMenu.setDelete_yn("N");
				userGroupMenuList.add(userGroupMenu);
			}
		}
		
		return userGroupMenuList;
	}
	
	/**
	 * 자식 그룹 중에 순서가 최대인 그룹을 검색
	 * @param parent
	 * @return
	 */
	@Transactional(readOnly=true)
	public UserGroup getMaxViewOrderChildUserGroup(Long parent) {		
		return userGroupMapper.getMaxViewOrderChildUserGroup(parent);
	}
	
	/**
	 * 사용자 그룹 등록
	 * @param userGroup
	 * @return
	 */
	@Transactional
	public int insertUserGroup(UserGroup userGroup) {
		
		// TODO 이건 bdr 때문에 한거 같은데.... sequence 로 바꿔야 할 듯
		userGroup.setUser_group_id(userGroupMapper.getMaxUserGroupId());
		userGroupMapper.insertUserGroup(userGroup);
		
		// 부모 그룹 자식 존재 유무 컬럼 수정
		UserGroup parentUserGroup = new UserGroup();
		parentUserGroup.setUser_group_id(userGroup.getParent());
		parentUserGroup.setChild_yn("Y");
		userGroupMapper.updateUserGroupChildYN(parentUserGroup);
		return 0;
	}
	
	/**
	 * 신규 메뉴 등록시 사용자 그룹 메뉴 권한에 추가
	 * @param menu_id
	 * @return
	 */
	@Transactional
	public int insertUserGroupMenu(Long menu_id) {
		List<UserGroup> userGroupList = userGroupMapper.getListUserGroup(new UserGroup());
		for(UserGroup userGroup : userGroupList) {
			UserGroupMenu userGroupMenu = new UserGroupMenu();
			userGroupMenu.setUser_group_menu_id(userGroupMapper.getMaxUserGroupMenuId());
			userGroupMenu.setUser_group_id(userGroup.getUser_group_id());
			userGroupMenu.setMenu_id(menu_id);
			userGroupMapper.insertUserGroupMenu(userGroupMenu);
		}		
		return userGroupList.size();
	}
	
	/**
	 * 사용자 그룹 메뉴 등록
	 * @param user_group_id
	 * @param all_yn
	 * @param read_yn
	 * @param write_yn
	 * @param update_yn
	 * @param delete_yn
	 * @return
	 */
	@Transactional
	public int updateUserGroupMenu(Long user_group_id, String all_yn, String read_yn, String write_yn, String update_yn, String delete_yn) {
		List<UserGroupMenu> userGroupMenuList = userGroupMapper.getListUserGroupMenu(user_group_id);
		
		String[] allYnValues = all_yn.split(",");
		String[] readYnValues = read_yn.split(",");
		String[] writeYnValues = write_yn.split(",");
		String[] updateYnValues = update_yn.split(",");
		String[] deleteYnValues = delete_yn.split(",");
		
		boolean isInsert = false;
		if(userGroupMenuList.isEmpty()) {
			isInsert = true;
		}
		int totalCount = allYnValues.length;
		for(int i=0; i<totalCount; i++) {
			String[] allValues = allYnValues[i].split("_");
			
			UserGroupMenu userGroupMenu = new UserGroupMenu();
			userGroupMenu.setUser_group_id(user_group_id);
			userGroupMenu.setMenu_id(Long.valueOf(allValues[0]));
			userGroupMenu.setAll_yn(allValues[1]);
			userGroupMenu.setRead_yn(readYnValues[i]);
			userGroupMenu.setWrite_yn(writeYnValues[i]);
			userGroupMenu.setUpdate_yn(updateYnValues[i]);
			userGroupMenu.setDelete_yn(deleteYnValues[i]);
			
			if(isInsert) {
				userGroupMenu.setUser_group_menu_id(userGroupMapper.getMaxUserGroupMenuId());
				userGroupMapper.insertUserGroupMenu(userGroupMenu);
			} else {
				userGroupMapper.updateUserGroupMenu(userGroupMenu);
			}
		}
		
		// TODO 리턴은 별 의미 없음 확장성 때문
		return 0;
	}

	/**
	 * 사용자 그룹 수정
	 * @param userGroup
	 * @return
	 */
	@Transactional
	public int updateUserGroup(UserGroup userGroup) {
		return userGroupMapper.updateUserGroup(userGroup);
	}
	
	/**
	 * 사용자 그룹 트리에서 정렬 순서 변경
	 * @param userGroup
	 * @return
	 */
	@Transactional
	public int updateMoveUserGroup(UserGroup userGroup) {
		Integer modifyViewOrder = userGroup.getView_order();
		UserGroup searchUserGroup = new UserGroup();
		searchUserGroup.setUpdate_type(userGroup.getUpdate_type());
		searchUserGroup.setParent(userGroup.getParent());
		
		if ("up".equals(userGroup.getUpdate_type())) {
			// 바로 위 메뉴의 view_order 를 +1
			searchUserGroup.setView_order(userGroup.getView_order());
			searchUserGroup = getUserGroupByParentAndViewOrder(searchUserGroup);
			userGroup.setView_order(searchUserGroup.getView_order());
			searchUserGroup.setView_order(modifyViewOrder);
		} else {
			// 바로 아래 메뉴의 view_order 를 -1 함
			searchUserGroup.setView_order(userGroup.getView_order());
			searchUserGroup = getUserGroupByParentAndViewOrder(searchUserGroup);
			userGroup.setView_order(searchUserGroup.getView_order());
			searchUserGroup.setView_order(modifyViewOrder);
		}
		updateViewOrderUserGroup(searchUserGroup);
		
		return updateViewOrderUserGroup(userGroup);
	}
	
	/**
	 * 부모와 표시 순서로 메뉴 조회
	 * @param userGroup
	 * @return
	 */
	private UserGroup getUserGroupByParentAndViewOrder(UserGroup userGroup) {
		return userGroupMapper.getUserGroupByParentAndViewOrder(userGroup);
	}
	
	/**
	 * 
	 * @param userGroup
	 * @return
	 */
	private int updateViewOrderUserGroup(UserGroup userGroup) {
		return userGroupMapper.updateViewOrderUserGroup(userGroup);
	}
	
	/**
	 * 사용자 그룹 삭제
	 * @param user_group_id
	 * @return
	 */
	@Transactional
	public int deleteUserGroup(Long user_group_id) {
		return deleteUserGroupList(user_group_id);
	}
	
	/**
	 * 사용자 그룹 삭제 메소드
	 * @param user_group_id
	 * @return
	 */
	public int deleteUserGroupList(Long user_group_id) {
		// 자식 목록 리스트
		List<Long> childUserGroupIdList = userGroupMapper.getListUserGroupChild(user_group_id);
		
		if(childUserGroupIdList != null && !childUserGroupIdList.isEmpty()) {
			for(Long childUserGroupId : childUserGroupIdList) {
				deleteUserGroup(childUserGroupId);
			}
			
			// 사용자 그룹 메뉴 삭제
			userGroupMapper.deleteUserGroupMenu(user_group_id);
		}
		return userGroupMapper.deleteUserGroup(user_group_id);
	}
	
	/**
	 * 메뉴 삭제시 사용자 그룹 메뉴 권한도 삭제
	 * @param menuIdList
	 * @return
	 */
	@Transactional
	public int deleteUserGroupMenuList(List<Long> menuIdList) {
		return userGroupMapper.deleteUserGroupMenuList(menuIdList);
	}
}
