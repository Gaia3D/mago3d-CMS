package com.gaia3d.service;

import java.util.List;

import com.gaia3d.domain.ObjectGroup;

/**
 * Object 그룹 관리
 * 
 * @author jeongdae
 *
 */
public interface ObjectGroupService {

	/**
	 * Object 그룹 목록
	 * 
	 * @param objectGroup
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
	 * 자식 그룹 중 순서가 최대인 그룹을 검색
	 * 
	 * @param parent
	 * @return
	 */
	ObjectGroup getMaxViewOrderChildObjectGroup(Long parent);

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
	 * Object 그룹 위로/아래로 수정
	 * 
	 * @param objectGroup
	 * @return
	 */
	int updateMoveObjectGroup(ObjectGroup objectGroup);

	/**
	 * Object 그룹 삭제
	 * 
	 * @param object_group_id
	 * @return
	 */
	int deleteObjectGroup(Long object_group_id);

}
