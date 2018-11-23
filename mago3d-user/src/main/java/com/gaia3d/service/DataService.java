package com.gaia3d.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.DataInfoAttribute;
import com.gaia3d.domain.DataInfoLog;
import com.gaia3d.domain.DataInfoObjectAttribute;

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
	 * 데이터 상태별 통계 정보
	 * @param dataInfo
	 * @return
	 */
	Long getDataTotalCountByStatus(DataInfo dataInfo);
	
	/**
	 * Data Object 총건수
	 * @param dataInfoObjectAttribute
	 * @return
	 */
	Long getDataObjectAttributeTotalCount(DataInfoObjectAttribute dataInfoObjectAttribute);
	
	/**
	 * Data 목록
	 * @param dataInfo
	 * @return
	 */
	List<DataInfo> getListData(DataInfo dataInfo);
	
	/**
	 * 프로젝트별 Data 목록
	 * @param dataInfo
	 * @return
	 */
	List<DataInfo> getListDataByProjectId(DataInfo dataInfo);
	
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
	 * 최상위 root dataInfo 정보 취득
	 * @param projectId
	 * @return
	 */
	public DataInfo getRootDataByProjectId(Integer projectId);
	
	/**
	 * Data Attribute 정보 취득
	 * @param data_id
	 * @return
	 */
	DataInfoAttribute getDataAttribute(Long data_id);
	
	/**
	 * Data Object Attribute 정보 취득
	 * @param data_object_attribute_id
	 * @return
	 */
	DataInfoObjectAttribute getDataObjectAttribute(Long data_object_attribute_id);
	
	/**
	 * Data Object 조회
	 * @param dataInfoObjectAttribute
	 * @return
	 */
	List<DataInfoObjectAttribute> getListDataObjectAttribute(DataInfoObjectAttribute dataInfoObjectAttribute);
	
	/**
	 * Data 등록
	 * @param dataInfo
	 * @return
	 */
	int insertData(DataInfo dataInfo);
	
	/**
	 * Data 속성 등록
	 * @param dataInfoAttribute
	 * @return
	 */
	int insertDataAttribute(DataInfoAttribute dataInfoAttribute);
	
	/**
	 * Data Object 속성 등록
	 * @param dataInfoObjectAttribute
	 * @return
	 */
	int insertDataObjectAttribute(DataInfoObjectAttribute dataInfoObjectAttribute);
	
	/**
	 * 데이터 공간 정보 변경 요청
	 * @return
	 */
	int updateDataLocationAndRotation(DataInfoLog dataInfoLog);
	
	/**
	 * Data 수정
	 * @param dataInfo
	 * @return
	 */
	int updateData(DataInfo dataInfo);
	
	/**
	 * Data Attribute 수정
	 * @param dataInfoAttribute
	 * @return
	 */
	int updateDataAttribute(DataInfoAttribute dataInfoAttribute);
	
	/**
	 * Data 상태 수정
	 * @param dataInfo
	 * @return
	 */
	int updateDataStatus(DataInfo dataInfo);
	
	/**
	 * Data 상태 수정
	 * @param business_type
	 * @param status_value
	 * @param check_ids
	 * @param business_type
	 * @param status_value
	 * @param check_ids
	 * @return
	 */
	List<String> updateDataStatus(String business_type, String status_value, String check_ids);
	
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
}
