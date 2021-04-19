package gaia3d.service;

import java.util.List;

import gaia3d.domain.data.DataInfo;
import gaia3d.domain.data.DataInfoSimple;

/**
 * Data 관리
 * @author jeongdae
 *
 */
public interface DataService {
	
	/**
	 * Data 수
	 * @param dataInfo
	 * @return
	 */
	Long getDataTotalCount(DataInfo dataInfo);

	/**
	 * 그룹핑 데이터 수
	 * @param dataRelationId dataRelationId
	 * @return
	 */
	Long getDataRelationCount(Long dataRelationId);
	
	/**
	 * 데이터 상태별 통계 정보
	 * @param dataInfo
	 * @return
	 */
	Long getDataTotalCountByStatus(DataInfo dataInfo);
	
//	/**
//	 * Data Object 총건수
//	 * @param dataInfoObjectAttribute
//	 * @return
//	 */
//	Long getDataObjectAttributeTotalCount(DataInfoObjectAttribute dataInfoObjectAttribute);
	
	/**
	 * 데이터 그룹에 속하는 전체 데이터 목록
	 * @param dataInfo
	 * @return
	 */
	List<DataInfo> getAllListData(DataInfo dataInfo);
	
	/**
	 * Data 목록
	 * @param dataInfo
	 * @return
	 */
	List<DataInfo> getListData(DataInfo dataInfo);
	
	/**
	 * Smart Tiling용 데이터 그룹에 포함되는 모든 데이터를 취득
	 * @param dataGroupId
	 * @return
	 */
	List<DataInfoSimple> getListAllDataByDataGroupId(Integer dataGroupId);
	
	/**
	 * 공유 유형별 데이터 통계
	 * @param dataInfo
	 * @return
	 */
	List<DataInfo> getDataTotalCountBySharing(DataInfo dataInfo);
	
	/**
	 * Data 정보 취득
	 * @param dataInfo
	 * @return
	 */
	DataInfo getData(DataInfo dataInfo);
	
	/**
	 * Data 정보 취득
	 * @param dataInfo
	 * @return
	 */
	DataInfo getDataByDataKey(DataInfo dataInfo);
	
	/**
	 * Data 정보 취득
	 * @param dataInfo
	 * @return
	 */
	List<DataInfo> getDataByConverterJob(DataInfo dataInfo);
	
//	/**
//	 * Data Attribute 정보 취득
//	 * @param dataId
//	 * @return
//	 */
//	DataAttribute getDataAttribute(Long dataId);
//	
//	/**
//	 * Data Object Attribute 정보 취득
//	 * @param data_object_attribute_id
//	 * @return
//	 */
//	DataInfoObjectAttribute getDataObjectAttribute(Long data_object_attribute_id);
//	
//	/**
//	 * Data Object 조회
//	 * @param dataInfoObjectAttribute
//	 * @return
//	 */
//	List<DataInfoObjectAttribute> getListDataObjectAttribute(DataInfoObjectAttribute dataInfoObjectAttribute);
	
	/**
	 * Data 등록
	 * @param dataInfo
	 * @return
	 */
	int insertData(DataInfo dataInfo);
	
//	/**
//	 * Data 속성 등록
//	 * @param dataAttribute
//	 * @return
//	 */
//	int insertDataAttribute(DataAttribute dataAttribute);
//	
//	/**
//	 * Data Object 속성 등록
//	 * @param dataInfoObjectAttribute
//	 * @return
//	 */
//	int insertDataObjectAttribute(DataInfoObjectAttribute dataInfoObjectAttribute);
//	
//	/**
//	 * 데이터 공간 정보 변경 요청
//	 * @return
//	 */
//	int updateDataLocationAndRotation(DataInfoLog dataInfoLog);
	
	/**
	 * Data 수정
	 * @param dataInfo
	 * @return
	 */
	int updateData(DataInfo dataInfo);
	
//	/**
//	 * Data Attribute 수정
//	 * @param dataAttribute
//	 * @return
//	 */
//	int updateDataAttribute(DataAttribute dataAttribute);
	
	/**
	 * Data 상태 수정
	 * @param dataInfo
	 * @return
	 */
	int updateDataStatus(DataInfo dataInfo);
	
//	/**
//	 * Data 상태 수정
//	 * @param business_type
//	 * @param status_value
//	 * @param check_ids
//	 * @param business_type
//	 * @param status_value
//	 * @param check_ids
//	 * @return
//	 */
//	List<String> updateDataStatus(String business_type, String status_value, String check_ids);
	
	/**
	 * Data 삭제
	 * @param dataInfo
	 * @return
	 */
	int deleteData(DataInfo dataInfo);
	
	/**
	 * 일괄 Data 삭제
	 * @param userId
	 * @param dataIds
	 * @return
	 */
	int deleteDataList(String userId, String dataIds);
	
	/**
	 * Data 에 속하는 모든 Object ID를 삭제
	 * @param dataId
	 * @return
	 */
	int deleteDataObjects(Long dataId);
	
	/**
	 * Data 삭제
	 * @param dataInfo
	 * @return
	 */
	int deleteDataByConverterJob(DataInfo dataInfo);
}
