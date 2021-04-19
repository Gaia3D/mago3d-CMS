package gaia3d.service;

import java.util.List;

import gaia3d.domain.data.DataGroup;

public interface DataGroupService {
	
	/**
	 * 사용자 Data Group 총건수
	 * @param dataGroup
	 * @return
	 */
	Long getDataGroupTotalCountForBasic(DataGroup dataGroup);

	/**
	 * 사용자 데이터 그룹 전체 목록
	 * @param dataGroup
	 * @return
	 */
	List<DataGroup> getAllListDataGroupForBasic(DataGroup dataGroup);

	/**
	 * 사용자 Data Group 총건수
	 * @param dataGroup
	 * @return
	 */
	Long getDataGroupTotalCount(DataGroup dataGroup);

	/**
     * 사용자 데이터 그룹 전체 목록
     * @return
     */
    List<DataGroup> getAllListDataGroup(DataGroup dataGroup);
    
    /**
     * 사용자 데이터 그룹 목록
     * @return
     */
    List<DataGroup> getListDataGroup(DataGroup dataGroup);
    
    /**
	 * 사용자 데이터 그룹 목록(부모)
	 * @return
	 */
	List<DataGroup> getListDataGroupByPatent(DataGroup dataGroup);
    
    /**
     * 사용자 데이터 정보 조회
     * @param dataGroup
     * @return
     */
    DataGroup getDataGroup(DataGroup dataGroup);
    
    /**
     * 기본 사용자  데이터 그룹 정보 조회
     * @param dataGroup
     * @return
     */
    DataGroup getBasicDataGroup(DataGroup dataGroup);
    
    /**
     * 부모와 표시 순서로 메뉴 조회
     * @param dataGroup
     * @return
     */
    DataGroup getDataGroupByParentAndViewOrder(DataGroup dataGroup);
    
    /**
     * 사용자 데이터 그룹 Key 중복 확인
     * @param dataGroup
     * @return
     */
    Boolean isDataGroupKeyDuplication(DataGroup dataGroup);

    /**
     * 사용자 데이터 그룹 등록
     * @param dataGroup
     * @return
     */
    int insertDataGroup(DataGroup dataGroup);
    
    /**
     * 기본 데이터 그룹 등록
     * @param dataGroup
     * @return
     */
    int insertBasicDataGroup(DataGroup dataGroup);
    
	/**
	 * 사용자 데이터 그룹 수정
	 * @param dataGroup
	 * @return
	 */
	int updateDataGroup(DataGroup dataGroup);
	
	/**
	 * 사용자 데이터 그룹 표시 순서 수정. UP, DOWN
	 * @param dataGroup
	 * @return
	 */
	int updateDataGroupViewOrder(DataGroup dataGroup);
    
	/**
	 * 사용자 데이터 그룹 삭제
	 * @param dataGroup
	 * @return
	 */
	int deleteDataGroup(DataGroup dataGroup);
	
	/**
	 * ancestor를 이용하여 사용자 데이터 그룹 삭제
	 * @param dataGroup
	 * @return
	 */
	int deleteDataGroupByAncestor(DataGroup dataGroup);
	
	/**
	 * parent를 이용하여 사용자 데이터 그룹 삭제
	 * @param dataGroup
	 * @return
	 */
	int deleteDataGroupByParent(DataGroup dataGroup);
}
