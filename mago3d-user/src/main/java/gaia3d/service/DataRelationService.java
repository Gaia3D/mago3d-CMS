package gaia3d.service;

import gaia3d.domain.data.DataRelationInfo;

/**
 * 데이터 연관관계 정보
 */
public interface DataRelationService {

    /**
     * 데이터 연관관계 정보 조회
     * @param dataRelationId dataRelationId
     * @return
     */
    DataRelationInfo getDataRelation(Long dataRelationId);

    /**
     * insert
     * @param dataRelationInfo dataRelationInfo
     * @return
     */
    int insertDataRelation(DataRelationInfo dataRelationInfo);

//    /**
//     * update
//     * @param dataRelationInfo dataRelationInfo
//     * @return
//     */
//    int updateDataRelation(DataRelationInfo dataRelationInfo);

    /**
     * delete
     * @param dataRelationId dataRelationId
     * @return
     */
    int deleteDataRelation(Long dataRelationId);
}
