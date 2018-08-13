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
	 * 프로젝트 총건수
	 * @param project
	 * @return
	 */
	Long getProjectTotalCount(Project project);
	
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
	 * @param project
	 * @return
	 */
	Project getProject(Project project);
	
	/**
	 * Project Key 중복 건수
	 * @param project_key
	 * @return
	 */
	Integer getDuplicationKeyCount(String project_key);
	
	/**
	 * Project 등록
	 * 
	 * @param project
	 * @return
	 */
	int insertProject(Project project);

	/**
	 * Project 수정
	 * 
	 * @param project
	 * @return
	 */
	int updateProject(Project project);

	/**
	 * Project 삭제
	 * 
	 * @param project
	 * @return
	 */
	int deleteProject(Project project);
}
