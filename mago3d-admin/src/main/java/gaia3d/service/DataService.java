package gaia3d.service;

import java.util.List;

import gaia3d.domain.data.DataFileInfo;
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
	 * @param status
	 * @return
	 */
	Long getDataTotalCountByStatus(String status);
	
	/**
	 * Data 목록
	 * @param dataInfo
	 * @return
	 */
	List<DataInfo> getListData(DataInfo dataInfo);

	/**
	 * 데이터 그룹에 포함되는 모든 데이터를 취득
	 * @param dataGroupId
	 * @return
	 */
	List<DataInfoSimple> getListAllDataByDataGroupId(Integer dataGroupId);
	
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

	/**
	 * 데이터 현황
	 * @return
	 */
	List<DataInfo> getDataTypeCount();

	/**
	 * Data 등록
	 * @param dataInfo
	 * @return
	 */
	int insertData(DataInfo dataInfo);
	
	/**
	 * Data 수정
	 * @param dataInfo
	 * @return
	 */
	int updateData(DataInfo dataInfo);
	
	/**
	 * Data Bulk 등록
	 * @param dataFileInfo
	 * @return
	 */
	DataFileInfo upsertBulkData(DataFileInfo dataFileInfo);
	
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
	
	/**
	 * user data 삭제
	 * @param userId
	 * @return
	 */
	int deleteDataByUserId(String userId);
}
