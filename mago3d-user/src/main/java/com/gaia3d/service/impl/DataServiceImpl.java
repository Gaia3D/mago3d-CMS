package com.gaia3d.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.DataInfoAttribute;
import com.gaia3d.domain.DataInfoLog;
import com.gaia3d.domain.DataInfoObjectAttribute;
import com.gaia3d.domain.Policy;
import com.gaia3d.persistence.DataLogMapper;
import com.gaia3d.persistence.DataMapper;
import com.gaia3d.service.DataService;

/**
 * Data
 * @author jeongdae
 *
 */
@Service
public class DataServiceImpl implements DataService {

	@Autowired
	private DataMapper dataMapper;
	@Autowired
	private DataLogMapper dataLogMapper;
	
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
	 * Data Object 총건수
	 * @param dataInfoObjectAttribute
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getDataObjectAttributeTotalCount(DataInfoObjectAttribute dataInfoObjectAttribute) {
		return dataMapper.getDataObjectAttributeTotalCount(dataInfoObjectAttribute);
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
	 * 프로젝트별 Data 목록
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataInfo> getListDataByProjectId(DataInfo dataInfo) {
		return dataMapper.getListDataByProjectId(dataInfo);
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
	 * 최상위 root dataInfo 정보 취득
	 * @param projectId
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataInfo getRootDataByProjectId(Integer projectId) {
		return dataMapper.getRootDataByProjectId(projectId);
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
	 * Data Object Attribute 정보 취득
	 * @param data_object_attribute_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataInfoObjectAttribute getDataObjectAttribute(Long data_object_attribute_id) {
		return dataMapper.getDataObjectAttribute(data_object_attribute_id);
	}
	
	/**
	 * Data Object 조회
	 * @param dataInfoObjectAttribute
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataInfoObjectAttribute> getListDataObjectAttribute(DataInfoObjectAttribute dataInfoObjectAttribute) {
		return dataMapper.getListDataObjectAttribute(dataInfoObjectAttribute);
	}
	
	/**
	 * 데이터 공간 정보 변경 요청
	 * @return
	 */
	@Transactional
	public int updateDataLocationAndRotation(DataInfoLog dataInfoLog) {
		Policy policy = CacheManager.getPolicy();
		if(Policy.DATA_CHANGE_REQUEST_DECISION_AUTO.equals(policy.getGeo_data_change_request_decision())) {
			// 자동이면 update 후 log
			dataInfoLog.setStatus(DataInfoLog.STATUS_COMPLETE);
			
			DataInfo dataInfo = new DataInfo();
			dataInfo.setData_id(dataInfoLog.getData_id());
			dataInfo.setLatitude(dataInfoLog.getLatitude());
			dataInfo.setLongitude(dataInfoLog.getLongitude());
			dataInfo.setHeight(dataInfoLog.getHeight());
			dataInfo.setHeading(dataInfoLog.getHeading());
			dataInfo.setPitch(dataInfoLog.getPitch());
			dataInfo.setRoll(dataInfoLog.getRoll());
			dataMapper.updateData(dataInfo);
		} else {
			// 대기 상태
			dataInfoLog.setStatus(DataInfoLog.STATUS_REQUEST);
		}
		
		return dataLogMapper.insertDataInfoLog(dataInfoLog);
	}
	
	/**
	 * Data 등록
	 * @param dataInfo
	 * @return
	 */
	@Transactional
	public int insertData(DataInfo dataInfo) {
		return dataMapper.insertData(dataInfo);
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
	 * Data 수정
	 * @param dataInfo
	 * @return
	 */
	@Transactional
	public int updateData(DataInfo dataInfo) {
		// TODO 환경 설정 값을 읽어 와서 update 할 건지, delete 할건지 분기를 타야 함
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
	 * TODO 위에 것과 하나로 합쳐라.
	 * 일괄 데이터 상태 수정
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
	public int deleteData(DataInfo dataInfo) {
//		Policy policy = CacheManager.getPolicy();
//		String dataDeleteType = policy.getData_delete_type();
		return dataMapper.deleteData(dataInfo);
	}
	
	/**
	 * 일괄 Data 삭제
	 * @param check_ids
	 * @return
	 */
	@Transactional
	public int deleteDataList(String userId, String check_ids) {
		// TODO sql in 으로 한번 query 가능 함. 수정해야 함
		
		String[] dataIds = check_ids.split(",");
		for(String data_id : dataIds) {
			DataInfo dataInfo = new DataInfo();
			dataInfo.setUser_id(userId);
			dataInfo.setData_id(Long.valueOf(data_id));
			return dataMapper.deleteData(dataInfo);
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
