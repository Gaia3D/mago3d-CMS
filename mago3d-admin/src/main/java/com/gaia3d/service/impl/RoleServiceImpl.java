package com.gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.Role;
import com.gaia3d.domain.UserGroupRole;
import com.gaia3d.persistence.RoleMapper;
import com.gaia3d.service.RoleService;

/**
 * Role
 * @author jeongdae
 *
 */
@Service
public class RoleServiceImpl implements RoleService {
	
	@Autowired
	private RoleMapper roleMapper;
	
	/**
	 * role 수
	 * @param role
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getRoleTotalCount(Role role) {
		return roleMapper.getRoleTotalCount(role);
	}
	
	/**
	 * Role 정보
	 * @param role_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public Role getRole(Long role_id) {
		return roleMapper.getRole(role_id);
	}
	
	/**
	 * Role 목록
	 * @param role
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<Role> getListRole(Role role) {
		return roleMapper.getListRole(role);
	}
	
	/**
	 * 사용자 그룹 전체 Role 에서 해당 그룹의 Role 을 제외한 목록 총 건수
	 * @param userGroupRole
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getListExceptUserGroupRoleByGroupIdCount(UserGroupRole userGroupRole) {
		return roleMapper.getListExceptUserGroupRoleByGroupIdCount(userGroupRole);
	}
	
	/**
	 * 사용자 그룹 전체 Role 에서 해당 그룹의 Role을 제외한 목록
	 * @param userGroupRole
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<UserGroupRole> getListExceptUserGroupRoleByGroupId(UserGroupRole userGroupRole) {
		return roleMapper.getListExceptUserGroupRoleByGroupId(userGroupRole);
	}
	
	/**
	 * 사용자 그룹별 Role 목록 총 건수
	 * @param userGroupRole
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getListUserGroupRoleCount(UserGroupRole userGroupRole) {
		return roleMapper.getListUserGroupRoleCount(userGroupRole);
	}
	
	/**
	 * 사용자 그룹별 Role 목록
	 * @param userGroupRole
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<UserGroupRole> getListUserGroupRole(UserGroupRole userGroupRole) {
		return roleMapper.getListUserGroupRole(userGroupRole);
	}
	
	/**
	 * 사용자 그룹 전체 Role 에서 접속한 사용자가 속한 사용자 그룹의 Role 목록
	 * @param userGroupRole
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<String> getListUserGroupRoleByUserId(UserGroupRole userGroupRole) {
		return roleMapper.getListUserGroupRoleByUserId(userGroupRole);
	}
	
	/**
	 * Role 등록
	 * @param role
	 * @return
	 */
	@Transactional
	public int insertRole(Role role) {
		role.setRole_id(roleMapper.getMaxRoleId());
		return roleMapper.insertRole(role);
	}
	
	/**
	 * 선택 사용자 그룹내 Role 등록
	 * @param userGroupRole
	 * @return
	 */
	@Transactional
	public int insertUserGroupRole(UserGroupRole userGroupRole) {
		Long[] leftRoleId = userGroupRole.getRole_all_id();
		for(Long role_id : leftRoleId) {
			userGroupRole.setRole_id(role_id);
			userGroupRole.setUser_group_role_id(roleMapper.getMaxUserGroupRoleId());
			roleMapper.insertUserGroupRole(userGroupRole);
		}
		return 0;
	}
	
	/**
	 * Role 수정
	 * @param role
	 * @return
	 */
	@Transactional
	public int updateRole(Role role) {
		return roleMapper.updateRole(role);
	}
	
	/**
	 * Role 삭제
	 * @param role_id
	 * @return
	 */
	@Transactional
	public int deleteRole(Long role_id) {
		return roleMapper.deleteRole(role_id);
	}
	
	/**
	 * 선택 사용자 그룹내 Role 삭제
	 * @param userGroupRole
	 * @return
	 */
	@Transactional
	public int deleteUserGroupRole(UserGroupRole userGroupRole) {
		return roleMapper.deleteUserGroupRole(userGroupRole);
	}
}
