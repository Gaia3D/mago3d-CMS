package gaia3d.persistence;

import java.util.List;

import gaia3d.domain.*;
import gaia3d.domain.common.FileInfo;
import gaia3d.domain.data.DataFileInfo;
import gaia3d.domain.data.DataFileParseLog;
import gaia3d.domain.data.DataGroup;
import gaia3d.domain.data.DataInfo;
import gaia3d.domain.data.DataInfoSimple;

import org.springframework.stereotype.Repository;

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
	 * Bulk 파일로 부터 데이터 등록(시퀀스를 사용하지 않고, 파일에 있는 dataId 사용)
	 * @param dataInfo
	 * @return
	 */
	int insertBulkData(DataInfo dataInfo);

	/**
	 * Bulk 파일로 부터 데이터 등록(dataId 시퀀스 사용)
	 * @param dataInfo
	 * @return
	 */
	int insertBulkDataWithDataId(DataInfo dataInfo);
	
	/**
	 * Data 파일 정보 등록
	 * @param dataFileInfo
	 * @return
	 */
	int insertDataFileInfo(DataFileInfo dataFileInfo);
	
	/**
	 * Data 파일 파싱 정보 등록
	 * @param dataFileParseLog
	 * @return
	 */
	int insertDataFileParseLog(DataFileParseLog dataFileParseLog);
	
	/**
	 * 데이터 속성 파일 정보 등록
	 * @param fileInfo
	 * @return
	 */
	int insertDataAttributeFileInfo(FileInfo fileInfo);
	
	/**
	 * Data 수정
	 * @param dataInfo
	 * @return
	 */
	int updateData(DataInfo dataInfo);
	
	/**
	 * Data 파일 정보 수정
	 * @param dataFileInfo
	 * @return
	 */
	int updateDataFileInfo(DataFileInfo dataFileInfo);
	
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
	
	/**
	 * user data 삭제
	 * @param userId
	 * @return
	 */
	int deleteDataByUserId(String userId);
}
