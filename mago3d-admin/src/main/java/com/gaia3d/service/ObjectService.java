package com.gaia3d.service;

import java.util.List;

import com.gaia3d.domain.ObjectInfo;

/**
 * Object 관리
 * @author jeongdae
 *
 */
public interface ObjectService {
	
	/**
	 * Object 수
	 * @param objectInfo
	 * @return
	 */
	Long getObjectTotalCount(ObjectInfo objectInfo);
	
	/**
	 * object_group_id 그룹을 제외한 Object 수
	 * @param objectInfo
	 * @return
	 */
	Long getExceptObjectGroupObjectByGroupIdTotalCount(ObjectInfo objectInfo);
	
	/**
	 * Object 목록
	 * @param objectInfo
	 * @return
	 */
	List<ObjectInfo> getListObject(ObjectInfo objectInfo);
	
	/**
	 * object_group_id를 제외한 Object 목록
	 * @param objectInfo
	 * @return
	 */
	List<ObjectInfo> getListExceptObjectGroupObjectByGroupId(ObjectInfo objectInfo);
	
	/**
	 * Object 아이디 중복 건수
	 * @param object_id
	 * @return
	 */
	Integer getDuplicationIdCount(Long object_id);
	
	/**
	 * Object 정보 취득
	 * @param object_id
	 * @return
	 */
	ObjectInfo getObject(Long object_id);
	
	/**
	 * Object 등록
	 * @param objectInfo
	 * @return
	 */
	int insertObject(ObjectInfo objectInfo);
	
	/**
	 * Object 그룹에 Object 등록
	 * @param objectInfo
	 * @return
	 */
	int updateObjectGroupObject(ObjectInfo objectInfo);
	
	/**
	 * Object 수정
	 * @param objectInfo
	 * @return
	 */
	int updateObject(ObjectInfo objectInfo);
	
	/**
	 * Object 상태 수정
	 * @param objectInfo
	 * @return
	 */
	int updateObjectStatus(ObjectInfo objectInfo);
	
	/**
	 * Object 상태 수정
	 * @param business_type
	 * @param status_value
	 * @param check_ids
	 * @param business_type
	 * @param status_value
	 * @param check_ids
	 * @return
	 */
	List<String> updateObjectStatus(String business_type, String status_value, String check_ids);
	
	/**
	 * Object 삭제
	 * @param object_id
	 * @return
	 */
	int deleteObject(Long object_id);
	
	/**
	 * 일괄 Object 삭제
	 * @param objectIds
	 * @return
	 */
	int deleteObjectList(String objectIds);
}
