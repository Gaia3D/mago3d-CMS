package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.role.Role;

/**
 * Role
 * @author jeongdae
 *
 */
@Repository
public interface RoleMapper {

	/**
	 * role 수
	 * @param role
	 * @return
	 */
	Long getRoleTotalCount(Role role);
	
	/**
	 * role 사용자 수
	 * @return
	 */
	// List<UserStatistics> getRoleUserCount();

	/**
	 * Role 목록
	 * @param role
	 * @return
	 */
	List<Role> getListRole(Role role);

	/**
	 * Role 정보
	 * @param roleId
	 * @return
	 */
	Role getRole(Integer roleId);
	
	/**
	 * Role 등록
	 * @param role
	 * @return
	 */
	int insertRole(Role role);
	
	/**
	 * Role 정보 수정
	 * @param role
	 * @return
	 */
	int updateRole(Role role);
	
	/**
	 * Role 삭제
	 * @param roleId
	 * @return
	 */
	int deleteRole(Integer roleId);
	
}
