package com.gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.DataGroup;

/**
 * Data 그룹
 * 
 * @author jeongdae
 *
 */
@Repository
public interface DataGroupMapper {

	/**
	 * data_group_id 최대값
	 * 
	 * @return
	 */
	Long getMaxDataGroupId();

	/**
	 * Data 그룹 목록
	 * 
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
	 * Data 그룹에 속한 자식 그룹 개수
	 * 
	 * @param parent
	 * @return
	 */
	Integer getDataGroupChildCount(Long parent);

	/**
	 * Data 그룹에 속한 자식 그룹 목록
	 * 
	 * @param parent
	 * @return
	 */
	List<Long> getListDataGroupChild(Long parent);

	/**
	 * 가장 마지막 순서의 그룹 정보 취득
	 * 
	 * @param dataGroup
	 * @return
	 */
	DataGroup getMaxViewOrderChildDataGroup(Long parent);

	/**
	 * Data 그룹 트리 부모와 순서로 그룹 정보 취득
	 * 
	 * @param dataGroup
	 * @return
	 */
	DataGroup getDataGroupByParentAndViewOrder(DataGroup dataGroup);

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
	 * 그룹 순서 수정
	 * 
	 * @param dataGroup
	 * @return
	 */
	int updateViewOrderDataGroup(DataGroup dataGroup);

	/**
	 * 자식 존재 유무 수정
	 * 
	 * @param dataGroup
	 * @return
	 */
	int updateDataGroupChildYN(DataGroup dataGroup);

	/**
	 * Data 그룹 삭제
	 * 
	 * @param data_group_id
	 * @return
	 */
	int deleteDataGroup(Long data_group_id);

}
