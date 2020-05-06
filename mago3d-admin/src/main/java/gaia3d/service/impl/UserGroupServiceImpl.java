package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;
import gaia3d.domain.Depth;
import gaia3d.domain.Move;
import gaia3d.domain.UserGroup;
import gaia3d.domain.UserGroupMenu;
import gaia3d.domain.UserGroupRole;
import gaia3d.domain.UserInfo;
import gaia3d.domain.YOrN;
import gaia3d.persistence.UserGroupMapper;
import gaia3d.service.UserGroupService;
import gaia3d.service.UserService;

@Slf4j
@Service
public class UserGroupServiceImpl implements UserGroupService {

	@Autowired
	private UserGroupMapper userGroupMapper;
	@Autowired
	private UserService userService;

	/**
     * 사용자 그룹 목록
     * @return
     */
	@Transactional(readOnly = true)
	public List<UserGroup> getListUserGroup() {
		return userGroupMapper.getListUserGroup();
	}

	/**
     * 사용자 그룹 정보 조회
     * @return
     */
	@Transactional(readOnly = true)
	public UserGroup getUserGroup(UserGroup userGroup) {
		return userGroupMapper.getUserGroup(userGroup);
	}

	/**
     * 기본 사용자 그룹 정보 조회
     * @return
     */
	@Transactional(readOnly = true)
	public UserGroup getBasicUserGroup() {
		return userGroupMapper.getBasicUserGroup();
	}

    /**
	 * 사용자 그룹 메뉴 권한 목록
	 * @param userGroupMenu
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<UserGroupMenu> getListUserGroupMenu(UserGroupMenu userGroupMenu) {
		return userGroupMapper.getListUserGroupMenu(userGroupMenu);
	}

	/**
	 * 사용자 그룹 Role 목록
	 * @param userGroupRole
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<UserGroupRole> getListUserGroupRole(UserGroupRole userGroupRole) {
		return userGroupMapper.getListUserGroupRole(userGroupRole);
	}

	/**
	 * 사용자 그룹 Role Key 목록
	 * @param userGroupRole
	 * @return
	 */
	@Transactional(readOnly = true)
	public List<String> getListUserGroupRoleKey(UserGroupRole userGroupRole) {
		return userGroupMapper.getListUserGroupRoleKey(userGroupRole);
	}

    /**
     * 사용자 그룹 등록
     * @param userGroup
     * @return
     */
    @Transactional
	public int insertUserGroup(UserGroup userGroup) {
    	//GeoPolicy geoPolicy = geoPolicyService.getGeoPolicy();

    	UserGroup parentUserGroup = new UserGroup();
    	Integer depth = 0;
    	if(userGroup.getParent() > 0) {
	    	parentUserGroup.setUserGroupId(userGroup.getParent());
	    	parentUserGroup = userGroupMapper.getUserGroup(parentUserGroup);
	    	depth = parentUserGroup.getDepth() + 1;
    	}

    	int result = userGroupMapper.insertUserGroup(userGroup);

    	if(depth > 1) {
	    	// parent의 children update
    		Integer children = parentUserGroup.getChildren();
    		if(children == null) children = 0;
    		children += 1;
    		parentUserGroup.setChildren(children);
	    	return userGroupMapper.updateUserGroup(parentUserGroup);
    	}

    	return result;
    }

    /**
     * 사용자 그룹 Key 중복 확인
     * @param userGroup
     * @return
     */
	@Transactional(readOnly = true)
	public Boolean isUserGroupKeyDuplication(UserGroup userGroup) {
		return userGroupMapper.isUserGroupKeyDuplication(userGroup);
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
	 * 사용자 그룹 표시 순서 수정 (up/down)
	 * @param userGroup
	 * @return
	 */
    @Transactional
	public int updateUserGroupViewOrder(UserGroup userGroup) {

    	UserGroup dbUserGroup = userGroupMapper.getUserGroup(userGroup);
    	dbUserGroup.setUpdateType(userGroup.getUpdateType());

    	Integer modifyViewOrder = dbUserGroup.getViewOrder();
    	UserGroup searchUserGroup = new UserGroup();
    	searchUserGroup.setUpdateType(dbUserGroup.getUpdateType());
    	searchUserGroup.setParent(dbUserGroup.getParent());

    	if(Move.UP == Move.valueOf(dbUserGroup.getUpdateType())) {
    		// 바로 위 메뉴의 view_order 를 +1
    		searchUserGroup.setViewOrder(dbUserGroup.getViewOrder());
    		searchUserGroup = getUserGroupByParentAndViewOrder(searchUserGroup);

    		if(searchUserGroup == null) return 0;

	    	dbUserGroup.setViewOrder(searchUserGroup.getViewOrder());
	    	searchUserGroup.setViewOrder(modifyViewOrder);
    	} else {
    		// 바로 아래 메뉴의 view_order 를 -1 함
    		searchUserGroup.setViewOrder(dbUserGroup.getViewOrder());
    		searchUserGroup = getUserGroupByParentAndViewOrder(searchUserGroup);

    		if(searchUserGroup == null) return 0;

    		dbUserGroup.setViewOrder(searchUserGroup.getViewOrder());
    		searchUserGroup.setViewOrder(modifyViewOrder);
    	}

    	updateViewOrderUserGroup(searchUserGroup);
		return updateViewOrderUserGroup(dbUserGroup);
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
	 * 사용자 그룹 표시 순서 수정 (up/down)
	 * @param userGroup
	 * @return
	 */
	private int updateViewOrderUserGroup(UserGroup userGroup) {
		return userGroupMapper.updateUserGroupViewOrder(userGroup);
	}

	/**
	 * 사용자 그룹 메뉴 수정
	 * @param userGroupMenu
	 * @return
	 */
	@Transactional
	public int updateUserGroupMenu(UserGroupMenu userGroupMenu) {
		Integer userGroupId = userGroupMenu.getUserGroupId();
		userGroupMapper.deleteUserGroupMenu(userGroupId);

		String[] allYnValues = userGroupMenu.getAllYn().split(",");
		String[] readYnValues = userGroupMenu.getReadYn().split(",");
		String[] writeYnValues = userGroupMenu.getWriteYn().split(",");
		String[] updateYnValues = userGroupMenu.getUpdateYn().split(",");
		String[] deleteYnValues = userGroupMenu.getDeleteYn().split(",");

		int totalCount = allYnValues.length;
		for(int i=0; i<totalCount; i++) {
			boolean insertFlag = false;
			String[] allValues = allYnValues[i].split("_");
			String[] readValues = readYnValues[i].split("_");
			String[] writeValues = writeYnValues[i].split("_");
			String[] updateValues = updateYnValues[i].split("_");
			String[] deleteValues = deleteYnValues[i].split("_");

			UserGroupMenu tempUserGroupMenu = new UserGroupMenu();
			tempUserGroupMenu.setUserGroupId(userGroupId);
			tempUserGroupMenu.setMenuId(Integer.parseInt(allValues[0]));

			if(allValues.length == 2 && YOrN.Y.name().equals(allValues[1])) {
				tempUserGroupMenu.setAllYn(allValues[1]);
				insertFlag = true;
			}
			if(readValues.length == 2 && YOrN.Y.name().equals(readValues[1])) {
				tempUserGroupMenu.setReadYn(readValues[1]);
				insertFlag = true;
			}
			if(writeValues.length == 2 && YOrN.Y.name().equals(writeValues[1])) {
				tempUserGroupMenu.setWriteYn(writeValues[1]);
				insertFlag = true;
			}
			if(updateValues.length == 2 && YOrN.Y.name().equals(updateValues[1])) {
				tempUserGroupMenu.setUpdateYn(updateValues[1]);
				insertFlag = true;
			}
			if(deleteValues.length == 2 && YOrN.Y.name().equals(deleteValues[1])) {
				tempUserGroupMenu.setDeleteYn(deleteValues[1]);
				insertFlag = true;
			}

			if(insertFlag) userGroupMapper.insertUserGroupMenu(tempUserGroupMenu);
		}

		return totalCount;
	}

	/**
	 * 사용자 그룹 Role 수정
	 * @param userGroupRole
	 * @return
	 */
	@Transactional
	public int updateUserGroupRole(UserGroupRole userGroupRole) {
		Integer userGroupId = userGroupRole.getUserGroupId();
		userGroupMapper.deleteUserGroupRole(userGroupId);

		String[] roleIds = userGroupRole.getCheckIds().split(",");
		for(String roleId : roleIds) {
			UserGroupRole tempUserGroupRole = new UserGroupRole();
			tempUserGroupRole.setUserGroupId(userGroupId);
			tempUserGroupRole.setRoleId(Integer.parseInt(roleId));
			userGroupMapper.insertUserGroupRole(tempUserGroupRole);
		}

		return roleIds.length;
	}

	/**
	 * 사용자 그룹 삭제
	 * @param userGroup
	 * @return
	 */
    @Transactional
	public int deleteUserGroup(UserGroup userGroup) {
    	// 삭제하고, children update

    	userGroup = userGroupMapper.getUserGroup(userGroup);
    	log.info("--- delete userGroup = {}", userGroup);
    	// TODO 삭제 후 캐시 갱신 필요 
    	int result = 0;
    	if(Depth.ONE == Depth.findBy(userGroup.getDepth())) {
    		log.info("--- one ================");
    		List<Integer> userGroupIdList = userGroupMapper.getUserGroupIdByAncestor(userGroup.getUserGroupId());
    		for(Integer userGroupId : userGroupIdList) {
    			userGroupMapper.deleteUserGroupMenu(userGroupId);
    			userGroupMapper.deleteUserGroupRole(userGroupId);
    			// 사용자 삭제
    			List<String> userList = userService.getListUserByGroupId(userGroupId);
    			for(String userId : userList) {
    				userService.deleteUser(userId);
    			}
    		}
    		result = userGroupMapper.deleteUserGroupByAncestor(userGroup);
    	} else if(Depth.TWO == Depth.findBy(userGroup.getDepth())) {
    		log.info("--- two ================");
    		List<Integer> userGroupIdList = userGroupMapper.getUserGroupIdByParent(userGroup.getUserGroupId());
    		userGroupIdList.add(userGroup.getUserGroupId());
    		for(Integer userGroupId : userGroupIdList) {
    			userGroupMapper.deleteUserGroupMenu(userGroupId);
    			userGroupMapper.deleteUserGroupRole(userGroupId);
    			List<String> userList = userService.getListUserByGroupId(userGroupId);
    			// 사용자 삭제
    			for(String userId : userList) {
    				userService.deleteUser(userId);
    			}
    		}
    		
    		result = userGroupMapper.deleteUserGroupByParent(userGroup);

    		UserGroup ancestorUserGroup = new UserGroup();
    		ancestorUserGroup.setUserGroupId(userGroup.getAncestor());
    		ancestorUserGroup = userGroupMapper.getUserGroup(ancestorUserGroup);
    		ancestorUserGroup.setChildren(ancestorUserGroup.getChildren() + 1);

    		log.info("--- delete ancestorUserGroup = {}", ancestorUserGroup);

	    	userGroupMapper.updateUserGroup(ancestorUserGroup);
    		// ancestor - 1
    	} else if(Depth.THREE == Depth.findBy(userGroup.getDepth())) {
    		log.info("--- three ================");
    		userGroupMapper.deleteUserGroupMenu(userGroup.getUserGroupId());
			userGroupMapper.deleteUserGroupRole(userGroup.getUserGroupId());
			List<String> userList = userService.getListUserByGroupId(userGroup.getUserGroupId());
			for(String userId : userList) {
				userService.deleteUser(userId);
			}
    		result = userGroupMapper.deleteUserGroup(userGroup);
    		log.info("--- userGroup ================ {}", userGroup);

    		UserGroup parentUserGroup = new UserGroup();
    		parentUserGroup.setUserGroupId(userGroup.getParent());
    		parentUserGroup = userGroupMapper.getUserGroup(parentUserGroup);
	    	log.info("--- parentUserGroup ================ {}", parentUserGroup);
	    	parentUserGroup.setChildren(parentUserGroup.getChildren() - 1);
	    	log.info("--- parentUserGroup children ================ {}", parentUserGroup);
	    	userGroupMapper.updateUserGroup(parentUserGroup);
    	} else {

    	}

    	return result;
    }

}
