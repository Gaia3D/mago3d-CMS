package com.gaia3d.service;

import java.util.List;

import com.gaia3d.domain.Project;

/**
 * Project 관리
 * 
 * @author jeongdae
 *
 */
public interface ProjectService {

	/**
	 * Project 목록
	 * 
	 * @param project
	 * @return
	 */
	List<Project> getListProject(Project project);
	
	/**
	 * Project 조회
	 * 
	 * @param project_id
	 * @return
	 */
	Project getProject(Long project_id);
	
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
	 * @param project_id
	 * @return
	 */
	int deleteProject(Long project_id);

}
