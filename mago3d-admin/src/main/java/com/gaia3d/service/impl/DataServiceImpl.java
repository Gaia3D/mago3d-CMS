package com.gaia3d.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.DataInfoAttribute;
import com.gaia3d.domain.DataInfoObjectAttribute;
import com.gaia3d.domain.Project;
import com.gaia3d.persistence.DataMapper;
import com.gaia3d.service.DataService;
import com.gaia3d.service.ProjectService;

/**
 * Data
 * @author jeongdae
 *
 */
@Service
public class DataServiceImpl implements DataService {

	@Autowired
	private ProjectService projectService;
	@Autowired
	private DataMapper dataMapper;
	
	/**
	 * Data 수
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getDataTotalCount(DataInfo dataInfo) {
		return dataMapper.getDataTotalCount(dataInfo);
	}
	
	/**
	 * 데이터 상태별 통계 정보
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getDataTotalCountByStatus(DataInfo dataInfo) {
		return dataMapper.getDataTotalCountByStatus(dataInfo);
	}
	
	/**
	 * Data 목록
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataInfo> getListData(DataInfo dataInfo) {
		return dataMapper.getListData(dataInfo);
	}
	
	/**
	 * Data 목록
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataInfo> getListDataByProjectId(DataInfo dataInfo) {
		return dataMapper.getListDataByProjectId(dataInfo);
	}
	
	/**
	 * data_group_id를 제외한 Data 목록
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataInfo> getListExceptDataGroupDataByGroupId(DataInfo dataInfo) {
		return dataMapper.getListExceptDataGroupDataByGroupId(dataInfo);
	}
	
	/**
	 * Data Key 중복 건수
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public Integer getDuplicationKeyCount(DataInfo dataInfo) {
		return dataMapper.getDuplicationKeyCount(dataInfo);
	}
	
	/**
	 * Data 정보 취득
	 * @param data_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataInfo getData(Long data_id) {
		return dataMapper.getData(data_id);
	}
	
	/**
	 * Data 정보 취득
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataInfo getDataByDataKey(DataInfo dataInfo) {
		return dataMapper.getDataByDataKey(dataInfo);
	}
	
	/**
	 * 표시 순서
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public Integer getViewOrderByParent(DataInfo dataInfo) {
		return dataMapper.getViewOrderByParent(dataInfo);
	}
	
	/**
	 * 한 프로젝트 내 Root Parent 개수를 체크
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public Integer getRootParentCount(DataInfo dataInfo) {
		return dataMapper.getRootParentCount(dataInfo);
	}
	
	/**
	 * data_key 를 이용하여 data_attribute_id 를 얻음
	 * TODO 9.6 이후에 merge로 변경 예정 
	 * @param data_key
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataInfoAttribute getDataIdAndDataAttributeIDByDataKey(String data_key) {
		return dataMapper.getDataIdAndDataAttributeIDByDataKey(data_key);
	}
	
	/**
	 * Data Attribute 정보 취득
	 * @param data_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataInfoAttribute getDataAttribute(Long data_id) {
		return dataMapper.getDataAttribute(data_id);
	}
	
	/**
	 * Data 등록
	 * @param dataInfo
	 * @return
	 */
	@Transactional
	public int insertData(DataInfo dataInfo) {
		int result = dataMapper.insertData(dataInfo);
		
		Project project = new Project();
		project.setProject_id(dataInfo.getProject_id());
		project.setData_count(1);
		projectService.updateProject(project);
		return result;
	}
	
	/**
	 * Data 속성 등록
	 * @param dataInfoAttribute
	 * @return
	 */
	@Transactional
	public int insertDataAttribute(DataInfoAttribute dataInfoAttribute) {
		return dataMapper.insertDataAttribute(dataInfoAttribute);
	}
	
	/**
	 * Data Object 속성 등록
	 * @param dataInfoObjectAttribute
	 * @return
	 */
	@Transactional
	public int insertDataObjectAttribute(DataInfoObjectAttribute dataInfoObjectAttribute) {
		return dataMapper.insertDataObjectAttribute(dataInfoObjectAttribute);
	}
	
	/**
	 * 선택 Data 그룹내 Data 등록
	 * @param dataInfo
	 * @return
	 */
	@Transactional
	public int updateDataGroupData(DataInfo dataInfo) {
		// data_group 에 등록되지 않은 Data
		String[] leftDataId = dataInfo.getData_all_id();
		// data_group 에 등록된 Data
		String[] rightDataId = dataInfo.getData_select_id();
		
		if(leftDataId != null && leftDataId.length >0) {
			for(String data_id : leftDataId) {
				dataInfo.setData_id(Long.valueOf(data_id));
				dataMapper.updateDataGroupData(dataInfo);
			}
		} 
		
//		// 임시 그룹으로 보냄
//		if(rightDataId != null && rightDataId.length >0) {
//			for(String data_id : rightDataId) {
//				dataInfo.setData_group_id(DataGroup.TEMP_GROUP);
//				dataInfo.setData_id(data_id);
//				dataMapper.updateDataGroupData(dataInfo);
//			}
//		}
		return 0;
	}
	
	/**
	 * Data 수정
	 * @param dataInfo
	 * @return
	 */
	@Transactional
	public int updateData(DataInfo dataInfo) {
		return dataMapper.updateData(dataInfo);
	}
	
	/**
	 * Data 속성 수정
	 * @param dataInfoAttribute
	 * @return
	 */
	@Transactional
	public int updateDataAttribute(DataInfoAttribute dataInfoAttribute) {
		return dataMapper.updateDataAttribute(dataInfoAttribute);
	}
	
	/**
	 * Data 상태 수정
	 * @param dataInfo
	 * @return
	 */
	@Transactional
	public int updateDataStatus(DataInfo dataInfo) {
		return dataMapper.updateDataStatus(dataInfo);
	}
	
	/**
	 * Data 상태 수정
	 * @param business_type
	 * @param status_value
	 * @param check_ids
	 * @return
	 */
	@Transactional
	public List<String> updateDataStatus(String business_type, String status_value, String check_ids) {
		
		List<String> result = new ArrayList<>();
		String[] dataIds = check_ids.split(",");
		
		for(String data_id : dataIds) {
			DataInfo dataInfo = new DataInfo();
			dataInfo.setData_id(Long.valueOf(data_id));
			if("LOCK".equals(status_value)) {
				dataInfo.setStatus(DataInfo.STATUS_FORBID);
			} else if("UNLOCK".equals(status_value)) {
				dataInfo.setStatus(DataInfo.STATUS_USE);
			}
			dataMapper.updateDataStatus(dataInfo);
		}
		
		return result;
	}
	
	/**
	 * Data 삭제
	 * @param data_id
	 * @return
	 */
	@Transactional
	public int deleteData(Long data_id) {
		
		DataInfo dataInfo = dataMapper.getData(data_id);
		int result = dataMapper.deleteData(data_id);
		
		Project project = new Project();
		project.setProject_id(dataInfo.getProject_id());
		project.setData_count(-1);
		projectService.updateProject(project);
		return result;
	}
	
	/**
	 * 일괄 Data 삭제
	 * @param check_ids
	 * @return
	 */
	@Transactional
	public int deleteDataList(String check_ids) {
		String[] dataIds = check_ids.split(",");
		for(String data_id : dataIds) {
			deleteData(Long.valueOf(data_id));
		}
		
		return check_ids.length();
	}
	
	/**
	 * Data 에 속하는 모든 Object ID를 삭제
	 * @param dataId
	 * @return
	 */
	@Transactional
	public int deleteDataObjects(Long dataId) {
		return dataMapper.deleteDataObjects(dataId);
	}
}
