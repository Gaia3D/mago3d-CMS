package com.gaia3d.service;

import java.util.List;

import com.gaia3d.domain.Project;

/**
 * project 관리
 * 
 * @author jeongdae
 *
 */
public interface ProjectService {

	/**
	 * 프로젝트 목록
	 * 
	 * @param project
	 * @return
	 */
	List<Project> getListProject(Project project);
	
	/**
	 * geo 정보를 이용해서 가장 가까운 프로젝트 정보를 취득
	 * @param project
	 * @return
	 */
	Project getProjectByGeo(Project project);
	
	/**
	 * 프로젝트 정보 조회
	 * 
	 * @param project_id
	 * @return
	 */
	Project getProject(Long project_id);

}
