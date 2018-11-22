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
	 * 프로젝트 총건수
	 * @param project
	 * @return
	 */
	Long getProjectTotalCount(Project project);

	/**
	 * project 목록
	 * @param project_id
	 * @return
	 */
	List<Project> getListProject(Project project);
	
	/**
	 * 기본 프로젝트 목록
	 * @param projectIds
	 * @return
	 */
	List<Project> getListDefaultProject(String[] projectIds);
	
	/**
	 * geo 정보를 이용해서 가장 가까운 project 정보를 획득
	 * @param project
	 * @return
	 */
	Project getProjectByGeo(Project project);
	
	/**
	 * project 조회
	 * 
	 * @param project
	 * @return
	 */
	Project getProject(Project project);
	
	/**
	 * project Key 중복 건수
	 * @param project_key
	 * @return
	 */
	Integer getDuplicationKeyCount(String project_key);
	
	/**
	 * 프로젝트 목록(데이터 총 건수로 정렬)
	 * @param project
	 * @return
	 */
	List<Project> getListProjectByDataCountRank(Project project);
	
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
	 * @param project
	 * @return
	 */
	int deleteProject(Project project);
}
