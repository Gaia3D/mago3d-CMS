package gaia3d.persistence;

import org.springframework.stereotype.Repository;

import gaia3d.domain.data.DataRelationInfo;

@Repository
public interface DataRelationMapper {

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
