package com.gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.Project;
import com.gaia3d.persistence.ProjectMapper;
import com.gaia3d.service.ProjectService;

/**
 * Project
 * 
 * @author jeongdae
 *
 */
@Service
public class ProjectServiceImpl implements ProjectService {

	@Autowired
	private ProjectMapper projectMapper;

	/**
	 * Project 목록
	 * 
	 * @param project
	 * @return
	 */
	@Transactional(readOnly = true)
	public List<Project> getListProject(Project project) {
		return projectMapper.getListProject(project);
	}
	
	/**
	 * Project 조회
	 * 
	 * @param project_id
	 * @return
	 */
	@Transactional(readOnly = true)
	public Project getProject(Long project_id) {
		return projectMapper.getProject(project_id);
	}

	/**
	 * Project Key 중복 건수
	 * @param project_key
	 * @return
	 */
	@Transactional(readOnly=true)
	public Integer getDuplicationKeyCount(String project_key) {
		return projectMapper.getDuplicationKeyCount(project_key);
	}
	
	/**
	 * Project 등록
	 * 
	 * @param project
	 * @return
	 */
	@Transactional
	public int insertProject(Project project) {
		return projectMapper.insertProject(project);
	}

	/**
	 * Project 수정
	 * 
	 * @param project
	 * @return
	 */
	@Transactional
	public int updateProject(Project project) {
		return projectMapper.updateProject(project);
	}

	/**
	 * Project 삭제
	 * 
	 * @param project_id
	 * @return
	 */
	@Transactional
	public int deleteProject(Long project_id) {
		return projectMapper.deleteProject(project_id);
	}
}
