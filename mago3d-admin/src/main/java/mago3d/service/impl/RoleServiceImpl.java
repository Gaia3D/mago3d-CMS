package mago3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import mago3d.domain.Role;
import mago3d.persistence.RoleMapper;
import mago3d.service.RoleService;

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
	 * Role 목록
	 * @param role
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<Role> getListRole(Role role) {
		return roleMapper.getListRole(role);
	}
	
	/**
	 * Role 정보
	 * @param roleId
	 * @return
	 */
	@Transactional(readOnly=true)
	public Role getRole(Integer roleId) {
		return roleMapper.getRole(roleId);
	}
	
	/**
	 * Role 등록
	 * @param role
	 * @return
	 */
	@Transactional
	public int insertRole(Role role) {
		return roleMapper.insertRole(role);
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
	 * @param  roleId
	 * @return
	 */
	@Transactional
	public int deleteRole(Integer roleId) {
		return roleMapper.deleteRole( roleId);
	}
}
