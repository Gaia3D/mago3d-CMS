package com.gaia3d.service.impl;

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
	 * @param status
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getDataTotalCountByStatus(String status) {
		return dataMapper.getDataTotalCountByStatus(status);
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
}
