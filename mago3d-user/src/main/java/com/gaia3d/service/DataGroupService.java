package com.gaia3d.service;

import java.util.List;

import com.gaia3d.domain.DataGroup;

/**
 * Data 그룹 관리
 * 
 * @author jeongdae
 *
 */
public interface DataGroupService {

	/**
	 * Data 그룹 목록
	 * 
	 * @param dataGroup
	 * @return
	 */
	List<DataGroup> getListDataGroup(DataGroup dataGroup);
	
	/**
	 * depth별 Data 그룹 목록
	 * @param depth
	 * @return
	 */
	List<DataGroup> getListDataGroupByDepth(Integer depth);
	
	/**
	 * geo 정보를 이용해서 가장 가까운 데이터 그룹 정보를 획득
	 * @param dataGroup
	 * @return
	 */
	DataGroup getDataGroupByGeo(DataGroup dataGroup);
	
	/**
	 * ancestor별 Data 그룹 목록
	 * @param ancestor
	 * @return
	 */
	List<DataGroup> getListDataGroupByAncestor(Long ancestor);

	/**
	 * Data 그룹 조회
	 * 
	 * @param data_group_id
	 * @return
	 */
	DataGroup getDataGroup(Long data_group_id);

	/**
	 * 자식 그룹 중 순서가 최대인 그룹을 검색
	 * 
	 * @param parent
	 * @return
	 */
	DataGroup getMaxViewOrderChildDataGroup(Long parent);

	/**
	 * Data 그룹 등록
	 * 
	 * @param dataGroup
	 * @return
	 */
	int insertDataGroup(DataGroup dataGroup);

	/**
	 * Data 그룹 수정
	 * 
	 * @param dataGroup
	 * @return
	 */
	int updateDataGroup(DataGroup dataGroup);

	/**
	 * Data 그룹 위로/아래로 수정
	 * 
	 * @param dataGroup
	 * @return
	 */
	int updateMoveDataGroup(DataGroup dataGroup);

	/**
	 * Data 그룹 삭제
	 * 
	 * @param data_group_id
	 * @return
	 */
	int deleteDataGroup(Long data_group_id);

}
