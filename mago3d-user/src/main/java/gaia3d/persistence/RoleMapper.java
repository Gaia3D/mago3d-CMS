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
	
}
