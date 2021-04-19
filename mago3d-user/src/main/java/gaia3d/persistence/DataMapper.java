package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.data.DataGroup;
import gaia3d.domain.data.DataInfo;
import gaia3d.domain.data.DataInfoSimple;

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
	 * DataGroupId를 제외한 Data 목록
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
	 * @param dataGroupId
	 * @return
	 */
	DataInfo getRootDataByDataGroupId(Integer dataGroupId);
	
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
	
//	/**
//	 * data_key 를 이용하여 data_attribute_id 를 얻음
//	 * TODO 9.6 이후에 merge로 변경 예정 
//	 * @param data_key
//	 * @return
//	 */
//	DataAttribute getDataIdAndDataAttributeIDByDataKey(String data_key);
//	
//	/**
//	 * Data Object 조회
//	 * @param dataInfoObjectAttribute
//	 * @return
//	 */
//	List<DataInfoObjectAttribute> getListDataObjectAttribute(DataInfoObjectAttribute dataInfoObjectAttribute);
//	
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
	
	/**
	 * Data 수정
	 * @param dataInfo
	 * @return
	 */
	int updateData(DataInfo dataInfo);
	
//	/**
//	 * Data 속성 수정
//	 * @param dataAttribute
//	 * @return
//	 */
//	int updateDataAttribute(DataAttribute dataAttribute);
//	
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
	 * @param dataInfo
	 * @return
	 */
	int deleteData(DataInfo dataInfo);
	
	/**
	 * Data 에 속하는 모든 Object ID를 삭제
	 * @param dataId
	 * @return
	 */
	int deleteDataObjects(Long dataId);
	
	/**
	 * TODO 프로젝트에 속한 데이터들은 삭제해야 하나?
	 * @param dataGroup
	 * @return
	 */
	int deleteDataByDataGroupId(DataGroup dataGroup);
	
	/**
	 * Data 삭제
	 * @param dataInfo
	 * @return
	 */
	int deleteDataByConverterJob(DataInfo dataInfo);
}
