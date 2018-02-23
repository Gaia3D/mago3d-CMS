package com.gaia3d.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.DataInfoAttribute;
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
	 * data_group_id를 제외한 Data 수
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getExceptDataGroupDataByGroupIdTotalCount(DataInfo dataInfo) {
		return dataMapper.getExceptDataGroupDataByGroupIdTotalCount(dataInfo);
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
	 * @param data_key
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataInfo getDataByDataKey(String data_key) {
		return dataMapper.getDataByDataKey(data_key);
	}
	
	/**
	 * 표시 순서
	 * @param dvataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public Integer getViewOrderByParent(DataInfo dvataInfo) {
		return dataMapper.getViewOrderByParent(dvataInfo);
	}
	
	/**
	 * 한 프로젝트 내 Root Parent 개수를 체크
	 * @param dvataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public Integer getRootParentCount(DataInfo dvataInfo) {
		return dataMapper.getRootParentCount(dvataInfo);
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
		// TODO 환경 설정 값을 읽어 와서 update 할 건지, delete 할건지 분기를 타야 함
		return dataMapper.updateData(dataInfo);
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
		
		List<String> result = new ArrayList<String>();
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
//		Policy policy = CacheManager.getPolicy();
//		String dataDeleteType = policy.getData_delete_type();
		
		return dataMapper.deleteData(data_id);
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
}
