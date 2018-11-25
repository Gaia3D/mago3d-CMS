package com.gaia3d.service.impl;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.Project;
import com.gaia3d.domain.UploadDirectoryType;
import com.gaia3d.persistence.DataMapper;
import com.gaia3d.persistence.PolicyMapper;
import com.gaia3d.persistence.ProjectMapper;
import com.gaia3d.service.ProjectService;
import com.gaia3d.util.FileUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * Project
 * 
 * @author jeongdae
 *
 */
@Slf4j
@Service
public class ProjectServiceImpl implements ProjectService {

	@Autowired
	private PolicyMapper policyMapper;
	@Autowired
	private ProjectMapper projectMapper;
	@Autowired
	private DataMapper dataMapper;

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
	 * @param project
	 * @return
	 */
	@Transactional(readOnly = true)
	public Project getProject(Project project) {
		return projectMapper.getProject(project);
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
	 * 프로젝트 목록(데이터 총 건수로 정렬)
	 * @param project
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<Project> getListProjectByDataCountRank(Project project) {
		return projectMapper.getListProjectByDataCountRank(project);
	}
	
	/**
	 * Project 등록
	 * 
	 * @param project
	 * @return
	 */
	@Transactional
	public int insertProject(Project project) {
		
		Policy policy = CacheManager.getPolicy();
		// TODO 시연 때문에 일단 임시 경로로 함
//		String makedDirectory = FileUtil.makeDirectory(project.getUser_id(), UploadDirectoryType.YEAR_MONTH, policy.getGeo_data_path() + File.separator);
//		FileUtil.makeDirectory(makedDirectory + project.getProject_key());
//		project.setProject_path(makedDirectory + project.getProject_key() + File.separator);
		FileUtil.makeDirectory(policy.getGeo_data_path() + File.separator + project.getProject_key());
		project.setProject_path(project.getProject_key() + File.separator);
		int result = projectMapper.insertProject(project);
		
		DataInfo dataInfo = new DataInfo();
		dataInfo.setSharing_type(project.getSharing_type());
		dataInfo.setProject_id(project.getProject_id());
		dataInfo.setData_key(project.getProject_key());
		dataInfo.setData_name(project.getProject_name());
		dataInfo.setUser_id(project.getUser_id());
		dataInfo.setParent(0l);
		dataInfo.setDepth(1);
		dataInfo.setView_order(1);
		dataInfo.setAttributes(project.getAttributes());
		dataMapper.insertData(dataInfo);
		
		return result;
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
	public int deleteProject(Project project) {
		Integer project_id = project.getProject_id();
		
		// 환경 설정에서 init project 에도 삭제해 줘야 함
		Policy policy = CacheManager.getPolicy();
		String geo_data_default_projects = policy.getGeo_data_default_projects();
		log.info("@@ geo_data_default_projects = {} ", geo_data_default_projects);
		if(geo_data_default_projects != null && !"".equals(geo_data_default_projects)) {
			String[] projectIds = geo_data_default_projects.split(",");
			int count = projectIds.length;
			String tempIds = "";
			for(int i=0; i<count; i++) {
				if(project_id.longValue() != Long.valueOf(projectIds[i]).longValue()) {
					if("".equals(tempIds)) {
						tempIds += projectIds[i];
					} else {
						tempIds += "," + projectIds[i];
					}
				}
			}
			policy.setGeo_data_default_projects(tempIds);
			policyMapper.updatePolicyGeo(policy);
		}
		
		// TODO 프로젝트에 속한 데이터들은 삭제해야 하나?
		// project 이름으로 등록된 최상위 data를 삭제
		dataMapper.deleteDataByProjectId(project);
		
		return projectMapper.deleteProject(project);
	}
}
