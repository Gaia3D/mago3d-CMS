package com.gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gaia3d.domain.Role;
import com.gaia3d.domain.UserGroupRole;

/**
 * Role
 * @author jeongdae
 *
 */
@Repository
public interface RoleMapper {

	/**
	 * role_id 최대값
	 * @return
	 */
	Long getMaxRoleId();
	
	/**
	 * user_group_role_id 최대값
	 * @return
	 */
	Long getMaxUserGroupRoleId();
	
	/**
	 * role 수
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
	 * 사용자 그룹 전체 Role 에서 해당 그룹의 Role 을 제외한 목록
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

	/**
	 사용자 그룹 전체 Role 에서 접속한 사용자가 속한 사용자 그룹의 Role 목록
	 * @param userGroupRole
	 * @return
	 */
	List<String> getListUserGroupRoleByUserId(UserGroupRole userGroupRole);
	
	/**
	 * Role 등록
	 * @param role
	 * @return
	 */
	int insertRole(Role role);
	
	/**
	 * Role Command 등록
	 * @param role
	 * @return
	 */
	int insertRoleCommand(Role role);
	
	/**
	 * 선택 사용자 그룹내 Role 등록
	 * @param userGroupRole
	 * @return
	 */
	int insertUserGroupRole(UserGroupRole userGroupRole);
	
	/**
	 * Role 정보 수정
	 * @param role
	 * @return
	 */
	int updateRole(Role role);
	
	/**
	 * Role 삭제
	 * @param role_id
	 * @return
	 */
	int deleteRole(Long role_id);
	
	/**
	 * 선택 사용자 그룹내 Role 삭제
	 * @param userGroupRole
	 * @return
	 */
	int deleteUserGroupRole(UserGroupRole userGroupRole);
}
