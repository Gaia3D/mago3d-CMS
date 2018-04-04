package com.gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.DataInfoAttribute;
import com.gaia3d.domain.DataInfoObjectAttribute;

/**
 * Data
 * @author jeongdae
 *
 */
@Repository
public interface DataMapper {

	/**
	 * Data 수
	 * @param dataInfo
	 * @return
	 */
	Long getDataTotalCount(DataInfo dataInfo);
	
	/**
	 * 데이터 상태별 통계 정보
	 * @param status
	 * @return
	 */
	Long getDataTotalCountByStatus(String status);
	
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
	 * data_group_id를 제외한 Data 목록
	 * @param dataInfo
	 * @return
	 */
	List<DataInfo> getListExceptDataGroupDataByGroupId(DataInfo dataInfo);
	
	/**
	 * Data Key 중복 건수
	 * @param dataInfo
	 * @return
	 */
	Integer getDuplicationKeyCount(DataInfo dataInfo);
	
	/**
	 * Data 정보 취득
	 * @param data_id
	 * @return
	 */
	DataInfo getData(Long data_id);
	
	/**
	 * Data 정보 취득
	 * @param dataInfo
	 * @return
	 */
	DataInfo getDataByDataKey(DataInfo dataInfo);
	
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
	 * 표시 순서
	 * @param dataInfo
	 * @return
	 */
	Integer getViewOrderByParent(DataInfo dataInfo);
	
	/**
	 * 한 프로젝트 내 Root Parent 개수를 체크
	 * @param dataInfo
	 * @return
	 */
	Integer getRootParentCount(DataInfo dataInfo);
	
	/**
	 * data_key 를 이용하여 data_attribute_id 를 얻음
	 * TODO 9.6 이후에 merge로 변경 예정 
	 * @param data_key
	 * @return
	 */
	DataInfoAttribute getDataIdAndDataAttributeIDByDataKey(String data_key);
	
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
	 * Data 수정
	 * @param dataInfo
	 * @return
	 */
	int updateData(DataInfo dataInfo);
	
	/**
	 * Data 속성 수정
	 * @param dataInfoAttribute
	 * @return
	 */
	int updateDataAttribute(DataInfoAttribute dataInfoAttribute);
	
	/**
	 * Data 테이블의 Data 그룹 정보 변경
	 * @param dataInfo
	 * @return
	 */
	int updateDataGroupData(DataInfo dataInfo);
	
	/**
	 * Data 상태 수정
	 * @param dataInfo
	 * @return
	 */
	int updateDataStatus(DataInfo dataInfo);
	
	/**
	 * Data 삭제
	 * @param data_id
	 * @return
	 */
	int deleteData(Long data_id);
	
	/**
	 * Data 에 속하는 모든 Object ID를 삭제
	 * @param dataId
	 * @return
	 */
	int deleteDataObjects(Long data_id);
	
	/**
	 * TODO 프로젝트에 속한 데이터들은 삭제해야 하나?
	 * project 이름으로 등록된 최상위 data를 삭제
	 * @return
	 */
	int deleteDataByProjectId(Long project_id);
}
