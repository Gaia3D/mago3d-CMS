package com.gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.DataInfoAttribute;

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
	 * data_group_id 그룹을 제외한 Data 수
	 * @param dataInfo
	 * @return
	 */
	Long getExceptDataGroupDataByGroupIdTotalCount(DataInfo dataInfo);
	
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
	 * Project Data 정보 취득
	 * @param project_id
	 * @return
	 */
	DataInfo getDataByProjectId(Long project_id);
	
	/**
	 * 표시 순서
	 * @param dvataInfo
	 * @return
	 */
	Integer getViewOrderByParent(DataInfo dvataInfo);
	
	/**
	 * 한 프로젝트 내 Root Parent 개수를 체크
	 * @param dvataInfo
	 * @return
	 */
	Integer getRootParentCount(DataInfo dvataInfo);
	
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
	 * Data 수정
	 * @param dataInfo
	 * @return
	 */
	int updateData(DataInfo dataInfo);
	
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
}
