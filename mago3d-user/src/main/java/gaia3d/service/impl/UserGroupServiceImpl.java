package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.user.UserGroup;
import gaia3d.domain.user.UserGroupMenu;
import gaia3d.domain.user.UserGroupRole;
import gaia3d.persistence.UserGroupMapper;
import gaia3d.service.UserGroupService;

/**
 * 사용자 그룹
 * @author jeongdae
 *
 */
@Service
public class UserGroupServiceImpl implements UserGroupService {

	@Autowired
	private UserGroupMapper userGroupMapper;
	
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
	 * 자식 사용자 그룹 개수
	 * 
	 * @param userGroupId
	 * @return
	 */
	@Transactional(readOnly=true)
	public int getChildUserGroupCount(Integer userGroupId) {
		return userGroupMapper.getChildUserGroupCount(userGroupId);
	}
	
	/**
	 * 사용자 그룹 정보 취득
	 * @param userGroupId
	 * @return
	 */
	@Transactional(readOnly=true)
	public UserGroup getUserGroup(Integer userGroupId) {
		return userGroupMapper.getUserGroup(userGroupId);
	}
	
	/**
	 * 사용자 그룹 정보 취득
	 * @param userId
	 * @return
	 */
	@Transactional(readOnly=true)
	public UserGroup getUserGroupByUserId(String userId) {
		return userGroupMapper.getUserGroupByUserId(userId);
	}
	
	/**
	 * 자식 사용자 그룹 중 순서가 최대인 사용자 그룹 검색
	 * @param userGroupId
	 * @return
	 */
	@Transactional(readOnly=true)
	public UserGroup getMaxViewOrderChildUserGroup(Integer userGroupId) {
		return userGroupMapper.getMaxViewOrderChildUserGroup(userGroupId);
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
}
