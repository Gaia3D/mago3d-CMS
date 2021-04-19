package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.MethodType;
import gaia3d.domain.data.DataGroup;
import gaia3d.domain.data.DataInfo;
import gaia3d.domain.data.DataInfoLog;
import gaia3d.domain.data.DataInfoSimple;
import gaia3d.persistence.DataMapper;
import gaia3d.service.DataGroupService;
import gaia3d.service.DataLogService;
import gaia3d.service.DataRelationService;
import gaia3d.service.DataService;

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
	private DataRelationService dataRelationService;
	
	@Autowired
	private DataGroupService dataGroupService;
	
	@Autowired
	private DataLogService dataLogService;
	
	/**
	 * Data 수
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getDataTotalCount(DataInfo dataInfo) {
		return dataMapper.getDataTotalCount(dataInfo);
	}
	
	@Transactional(readOnly = true)
	public Long getDataRelationCount(Long dataRelationId) {
		return dataMapper.getDataRelationCount(dataRelationId);
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
	
//	/**
//	 * Data Object 총건수
//	 * @param dataInfoObjectAttribute
//	 * @return
//	 */
//	@Transactional(readOnly=true)
//	public Long getDataObjectAttributeTotalCount(DataInfoObjectAttribute dataInfoObjectAttribute) {
//		return dataMapper.getDataObjectAttributeTotalCount(dataInfoObjectAttribute);
//	}
	
	/**
	 * 데이터 그룹에 속하는 전체 데이터 목록
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataInfo> getAllListData(DataInfo dataInfo) {
		return dataMapper.getAllListData(dataInfo);
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
	 * Smart Tiling용 데이터 그룹에 포함되는 모든 데이터를 취득
	 * @param dataGroupId
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataInfoSimple> getListAllDataByDataGroupId(Integer dataGroupId) {
		return dataMapper.getListAllDataByDataGroupId(dataGroupId);
	}
	
	/**
	 * 공유 유형별 데이터 통계
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataInfo> getDataTotalCountBySharing(DataInfo dataInfo) {
		return dataMapper.getDataTotalCountBySharing(dataInfo);
	}
	
	/**
	 * Data 정보 취득
	 * @param data_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataInfo getData(DataInfo dataInfo) {
		return dataMapper.getData(dataInfo);
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
	public DataInfo getRootDataByDataGroupId(Integer dataGroupId) {
		return dataMapper.getRootDataByDataGroupId(dataGroupId);
	}
	
	/**
	 * Data 정보 취득
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataInfo> getDataByConverterJob(DataInfo dataInfo) {
		return dataMapper.getDataByConverterJob(dataInfo);
	}
	
//	/**
//	 * Data Attribute 정보 취득
//	 * @param dataId
//	 * @return
//	 */
//	@Transactional(readOnly=true)
//	public DataAttribute getDataAttribute(Long dataId) {
//		return dataMapper.getDataAttribute(dataId);
//	}
	
//	/**
//	 * Data Object Attribute 정보 취득
//	 * @param data_object_attribute_id
//	 * @return
//	 */
//	@Transactional(readOnly=true)
//	public DataInfoObjectAttribute getDataObjectAttribute(Long data_object_attribute_id) {
//		return dataMapper.getDataObjectAttribute(data_object_attribute_id);
//	}
//	
//	/**
//	 * Data Object 조회
//	 * @param dataInfoObjectAttribute
//	 * @return
//	 */
//	@Transactional(readOnly=true)
//	public List<DataInfoObjectAttribute> getListDataObjectAttribute(DataInfoObjectAttribute dataInfoObjectAttribute) {
//		return dataMapper.getListDataObjectAttribute(dataInfoObjectAttribute);
//	}
	
//	/**
//	 * 데이터 공간 정보 변경 요청
//	 * @return
//	 */
//	@Transactional
//	public int updateDataLocationAndRotation(DataInfoLog dataInfoLog) {
//		Policy policy = CacheManager.getPolicy();
//		if(Policy.DATA_CHANGE_REQUEST_DECISION_AUTO.equals(policy.getGeo_data_change_request_decision())) {
//			// 자동이면 update 후 log
//			dataInfoLog.setStatus(DataInfoLog.STATUS_COMPLETE);
//			
//			DataInfo dataInfo = new DataInfo();
//			dataInfo.setData_id(dataInfoLog.getData_id());
//			dataInfo.setLatitude(dataInfoLog.getLatitude());
//			dataInfo.setLongitude(dataInfoLog.getLongitude());
//			dataInfo.setHeight(dataInfoLog.getHeight());
//			dataInfo.setHeading(dataInfoLog.getHeading());
//			dataInfo.setPitch(dataInfoLog.getPitch());
//			dataInfo.setRoll(dataInfoLog.getRoll());
//			dataMapper.updateData(dataInfo);
//		} else {
//			// 대기 상태
//			dataInfoLog.setStatus(DataInfoLog.STATUS_REQUEST);
//		}
//		
//		return dataLogMapper.insertDataInfoLog(dataInfoLog);
//	}
	
	/**
	 * Data 등록
	 * @param dataInfo
	 * @return
	 */
	@Transactional
	public int insertData(DataInfo dataInfo) {
		dataMapper.insertData(dataInfo);
		DataInfoLog dataInfoLog = new DataInfoLog(dataInfo);
		dataInfoLog.setChangeType(MethodType.INSERT.name().toLowerCase());
		return dataLogService.insertDataInfoLog(dataInfoLog);
	}
	
//	/**
//	 * Data 속성 등록
//	 * @param dataAttribute
//	 * @return
//	 */
//	@Transactional
//	public int insertDataAttribute(DataAttribute dataAttribute) {
//		return dataMapper.insertDataAttribute(dataAttribute);
//	}
//	
//	/**
//	 * Data Object 속성 등록
//	 * @param dataInfoObjectAttribute
//	 * @return
//	 */
//	@Transactional
//	public int insertDataObjectAttribute(DataInfoObjectAttribute dataInfoObjectAttribute) {
//		return dataMapper.insertDataObjectAttribute(dataInfoObjectAttribute);
//	}
	
	/**
	 * Data 수정
	 * @param dataInfo
	 * @return
	 */
	@Transactional
	public int updateData(DataInfo dataInfo) {
		// TODO 환경 설정 값을 읽어 와서 update 할 건지, delete 할건지 분기를 타야 함
		dataMapper.updateData(dataInfo);
		dataInfo = dataMapper.getData(dataInfo);
		DataInfoLog dataInfoLog = new DataInfoLog(dataInfo);
		dataInfoLog.setChangeType(MethodType.UPDATE.name().toLowerCase());
		dataInfoLog.setUpdateUserId(dataInfo.getUserId());
		return dataLogService.insertDataInfoLog(dataInfoLog);
	}
	
//	/**
//	 * Data 속성 수정
//	 * @param dataAttribute
//	 * @return
//	 */
//	@Transactional
//	public int updateDataAttribute(DataAttribute dataAttribute) {
//		return dataMapper.updateDataAttribute(dataAttribute);
//	}
	
	/**
	 * Data 상태 수정
	 * @param dataInfo
	 * @return
	 */
	@Transactional
	public int updateDataStatus(DataInfo dataInfo) {
		return dataMapper.updateDataStatus(dataInfo);
	}
	
//	/**
//	 * TODO 위에 것과 하나로 합쳐라.
//	 * 일괄 데이터 상태 수정
//	 * @param business_type
//	 * @param status_value
//	 * @param check_ids
//	 * @return
//	 */
//	@Transactional
//	public List<String> updateDataStatus(String business_type, String status_value, String check_ids) {
//		
//		List<String> result = new ArrayList<>();
//		String[] dataIds = check_ids.split(",");
//		
//		for(String data_id : dataIds) {
//			DataInfo dataInfo = new DataInfo();
//			dataInfo.setData_id(Long.valueOf(data_id));
//			if("LOCK".equals(status_value)) {
//				dataInfo.setStatus(DataInfo.STATUS_FORBID);
//			} else if("UNLOCK".equals(status_value)) {
//				dataInfo.setStatus(DataInfo.STATUS_USE);
//			}
//			dataMapper.updateDataStatus(dataInfo);
//		}
//		
//		return result;
//	}
	
	/**
	 * Data 삭제
	 * @param dataInfo
	 * @return
	 */
	@Transactional
	public int deleteData(DataInfo dataInfo) {
		// 데이터 그룹 count -1
		dataInfo = dataMapper.getData(dataInfo);
		
		DataGroup dataGroup = new DataGroup();
		dataGroup.setDataGroupId(dataInfo.getDataGroupId());
		dataGroup = dataGroupService.getDataGroup(dataGroup);
		
		DataGroup tempDataGroup = DataGroup.builder()
				.dataGroupId(dataGroup.getDataGroupId())
				.dataCount(dataGroup.getDataCount() - 1).build();
		dataGroupService.updateDataGroup(tempDataGroup);

		// data_relation 삭제
		Long dataRelationId = dataInfo.getDataRelationId();
		if (dataMapper.getDataRelationCount(dataRelationId) == 1) {
			dataRelationService.deleteDataRelation(dataInfo.getDataRelationId());
		}
		
		return dataMapper.deleteData(dataInfo);
		// TODO 디렉토리도 삭제 해야 함
	}
	
	/**
	 * 일괄 Data 삭제
	 * @param checkIds
	 * @return
	 */
	@Transactional
	public int deleteDataList(String userId, String checkIds) {
		// TODO sql in 으로 한번 query 가능 함. 수정해야 함
		
		String[] dataIds = checkIds.split(",");
		for(String dataId : dataIds) {
			DataInfo dataInfo = new DataInfo();
			dataInfo.setUserId(userId);
			dataInfo.setDataId(Long.valueOf(dataId));
			return dataMapper.deleteData(dataInfo);
		}
		
		return checkIds.length();
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
	
	/**
	 * Data 삭제
	 * @param dataInfo
	 * @return
	 */
	@Transactional
	public int deleteDataByConverterJob(DataInfo dataInfo) {
		return dataMapper.deleteDataByConverterJob(dataInfo);
	}
}
