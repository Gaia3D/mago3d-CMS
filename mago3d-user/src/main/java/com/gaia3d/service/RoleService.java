package com.gaia3d.service;

import java.util.List;

import com.gaia3d.domain.Role;
import com.gaia3d.domain.UserGroupRole;

public interface RoleService {
	
	/**
	 * Role 수
	 * @param role
	 * @return
	 */
	Long getRoleTotalCount(Role role);
	
	/**
	 * Role 정보
	 * @param role_id
	 * @return
	 */
	Role getRole(Long role_id);

	/**
	 * Role 목록
	 * @param role
	 * @return
	 */
	List<Role> getListRole(Role role);
	
	/**
	 * 사용자 그룹 전체 Role 에서 해당 그룹의 Role 을 제외한 목록 총 건수
	 * @param userGroupRole
	 * @return
	 */
	Long getListExceptUserGroupRoleByGroupIdCount(UserGroupRole userGroupRole);
	
	/**
	 * 사용자 그룹 전체 Role 에서 해당 그룹의 Role을 제외한 목록
	 * @param userGroupRole
	 * @return
	 */
	List<UserGroupRole> getListExceptUserGroupRoleByGroupId(UserGroupRole userGroupRole);
	
	/**
	 * 사용자 그룹별 Role 목록 총 건수
	 * @param userGroupRole
	 * @return
	 */
	Long getListUserGroupRoleCount(UserGroupRole userGroupRole);
	
	/**
	 * 사용자 그룹별 Role 목록
	 * @param userGroupRole
	 * @return
	 */
	List<UserGroupRole> getListUserGroupRole(UserGroupRole userGroupRole);
	
//	/**
//	 * 서버 그룹 전체 Role 에서 해당 그룹의 Role을 제외한 목록 총 건수
//	 * @param serverGroupRole
//	 * @return
//	 */
//	Long getListExceptServerGroupRoleByGroupIdCount(ServerGroupRole serverGroupRole);
//	
//	/**
//	 * 서버 그룹 전체 Role 에서 해당 그룹의 Role을 제외한 목록
//	 * @param serverGroupRole
//	 * @return
//	 */
//	List<ServerGroupRole> getListExceptServerGroupRoleByGroupId(ServerGroupRole serverGroupRole);
//	
//	/**
//	 * 서버 그룹별 Role 목록 총 건수
//	 * @param serverGroupRole
//	 * @return
//	 */
//	Long getListServerGroupRoleCount(ServerGroupRole serverGroupRole);
//	
//	/**
//	 * 서버 그룹별 Role 목록
//	 * @param serverGroupRole
//	 * @return
//	 */
//	List<ServerGroupRole> getListServerGroupRole(ServerGroupRole serverGroupRole);
//	
//	/**
//	 * 서버 그룹 전체 Role 에서 접속한 Client IP 가 속한 서버의 해당 서버 그룹의 Role 목록
//	 * @param serverGroupRole
//	 * @return
//	 */
//	List<String> getListServerGroupRoleByClientIp(ServerGroupRole serverGroupRole);
	
	/**
	 * 사용자 그룹 전체 Role 에서 접속한 사용자가 속한 사용자 그룹의 Role 목록
	 * @param userGroupRole
	 * @return
	 */
	List<String> getListUserGroupRoleByUserId(UserGroupRole userGroupRole);
}
