package com.gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.Project;
import com.gaia3d.persistence.ProjectMapper;
import com.gaia3d.service.ProjectService;

/**
 * 프로젝트 관리
 * 
 * @author jeongdae
 *
 */
@Service
public class ProjectServiceImpl implements ProjectService {

	@Autowired
	private ProjectMapper projectMapper;

	/**
	 * 프로젝트 목록
	 * 
	 * @param project
	 * @return
	 */
	@Transactional(readOnly = true)
	public List<Project> getListProject(Project project) {
		return projectMapper.getListProject(project);
	}
	
	/**
	 * geo 정보를 이용해서 가장 가까운 프로젝트 정보를 취득
	 * @param project
	 * @return
	 */
	@Transactional(readOnly = true)
	public Project getProjectByGeo(Project project) {
		return projectMapper.getProjectByGeo(project);
	}
	
	/**
	 * 프로젝트 조회
	 * 
	 * @param project_id
	 * @return
	 */
	@Transactional(readOnly = true)
	public Project getProject(Long project_id) {
		return projectMapper.getProject(project_id);
	}

}
