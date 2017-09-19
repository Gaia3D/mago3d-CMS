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
	
//	/**
//	 * 서버 그룹 전체 Role 에서 해당 그룹의 Role을 제외한 목록 총 건수
//	 * @param serverGroupRole
//	 * @return
//	 */
//	@Transactional(readOnly=true)
//	public Long getListExceptServerGroupRoleByGroupIdCount(ServerGroupRole serverGroupRole) {
//		return roleMapper.getListExceptServerGroupRoleByGroupIdCount(serverGroupRole);
//	}
//	
//	/**
//	 * 서버 그룹 전체 Role 에서 해당 그룹의 Role을 제외한 목록
//	 * @param serverGroupRole
//	 * @return
//	 */
//	@Transactional(readOnly=true)
//	public List<ServerGroupRole> getListExceptServerGroupRoleByGroupId(ServerGroupRole serverGroupRole) {
//		return roleMapper.getListExceptServerGroupRoleByGroupId(serverGroupRole);
//	}
//	
//	/**
//	 * 서버 그룹별 Role 목록 총 건수
//	 * @param serverGroupRole
//	 * @return
//	 */
//	@Transactional(readOnly=true)
//	public Long getListServerGroupRoleCount(ServerGroupRole serverGroupRole) {
//		return roleMapper.getListServerGroupRoleCount(serverGroupRole);
//	}
//	
//	/**
//	 * 서버 그룹별 Role 목록
//	 * @param serverGroupRole
//	 * @return
//	 */
//	@Transactional(readOnly=true)
//	public List<ServerGroupRole> getListServerGroupRole(ServerGroupRole serverGroupRole) {
//		return roleMapper.getListServerGroupRole(serverGroupRole);
//	}
//	
//	/**
//	 * 서버 그룹 전체 Role 에서 접속한 Client IP 가 속한 서버의 해당 서버 그룹의 Role 목록
//	 * @param serverGroupRole
//	 * @return
//	 */
//	@Transactional(readOnly=true)
//	public List<String> getListServerGroupRoleByClientIp(ServerGroupRole serverGroupRole) {
//		return roleMapper.getListServerGroupRoleByClientIp(serverGroupRole);
//	}
	
	/**
	 * 사용자 그룹 전체 Role 에서 접속한 사용자가 속한 사용자 그룹의 Role 목록
	 * @param userGroupRole
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<String> getListUserGroupRoleByUserId(UserGroupRole userGroupRole) {
		return roleMapper.getListUserGroupRoleByUserId(userGroupRole);
	}
}
