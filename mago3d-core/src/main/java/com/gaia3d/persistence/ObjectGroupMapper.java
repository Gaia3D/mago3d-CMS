package com.gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gaia3d.domain.ObjectGroup;

/**
 * Object 그룹
 * 
 * @author jeongdae
 *
 */
@Repository
public interface ObjectGroupMapper {

	/**
	 * object_group_id 최대값
	 * 
	 * @return
	 */
	Long getMaxObjectGroupId();

	/**
	 * Object 그룹 목록
	 * 
	 * @return
	 */
	List<ObjectGroup> getListObjectGroup(ObjectGroup objectGroup);

	/**
	 * Object 그룹 조회
	 * 
	 * @param object_group_id
	 * @return
	 */
	ObjectGroup getObjectGroup(Long object_group_id);

	/**
	 * Object 그룹에 속한 자식 그룹 개수
	 * 
	 * @param parent
	 * @return
	 */
	Integer getObjectGroupChildCount(Long parent);

	/**
	 * Object 그룹에 속한 자식 그룹 목록
	 * 
	 * @param parent
	 * @return
	 */
	List<Long> getListObjectGroupChild(Long parent);

	/**
	 * 가장 마지막 순서의 그룹 정보 취득
	 * 
	 * @param objectGroup
	 * @return
	 */
	ObjectGroup getMaxViewOrderChildObjectGroup(Long parent);

	/**
	 * Object 그룹 트리 부모와 순서로 그룹 정보 취득
	 * 
	 * @param objectGroup
	 * @return
	 */
	ObjectGroup getObjectGroupByParentAndViewOrder(ObjectGroup objectGroup);

	/**
	 * Object 그룹 등록
	 * 
	 * @param objectGroup
	 * @return
	 */
	int insertObjectGroup(ObjectGroup objectGroup);

	/**
	 * Object 그룹 수정
	 * 
	 * @param objectGroup
	 * @return
	 */
	int updateObjectGroup(ObjectGroup objectGroup);

	/**
	 * 그룹 순서 수정
	 * 
	 * @param objectGroup
	 * @return
	 */
	int updateViewOrderObjectGroup(ObjectGroup objectGroup);

	/**
	 * 자식 존재 유무 수정
	 * 
	 * @param objectGroup
	 * @return
	 */
	int updateObjectGroupChildYN(ObjectGroup objectGroup);

	/**
	 * Object 그룹 삭제
	 * 
	 * @param object_group_id
	 * @return
	 */
	int deleteObjectGroup(Long object_group_id);

}
