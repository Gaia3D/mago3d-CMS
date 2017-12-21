package com.gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gaia3d.domain.Project;

/**
 * project
 * 
 * @author jeongdae
 *
 */
@Repository
public interface ProjectMapper {

	/**
	 * project 목록
	 * @param project_id
	 * @return
	 */
	List<Project> getListProject(Project project);
	
	/**
	 * geo 정보를 이용해서 가장 가까운 project 정보를 획득
	 * @param project
	 * @return
	 */
	Project getProjectByGeo(Project project);
	
	/**
	 * project 조회
	 * 
	 * @param project_id
	 * @return
	 */
	Project getProject(Long project_id);
	
	/**
	 * project Key 중복 건수
	 * @param project_key
	 * @return
	 */
	Integer getDuplicationKeyCount(String project_key);
	
	/**
	 * project 등록
	 * 
	 * @param project
	 * @return
	 */
	int insertProject(Project project);

	/**
	 * project 수정
	 * 
	 * @param project
	 * @return
	 */
	int updateProject(Project project);

	/**
	 * project 삭제
	 * 
	 * @param project_id
	 * @return
	 */
	int deleteProject(Long project_id);
}
