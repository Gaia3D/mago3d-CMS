package com.gaia3d.persistence;

import java.util.List;
import org.springframework.stereotype.Repository;
import com.gaia3d.domain.ObjectInfo;

/**
 * Object
 * @author jeongdae
 *
 */
@Repository
public interface ObjectMapper {

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
	 * Object 수정
	 * @param objectInfo
	 * @return
	 */
	int updateObject(ObjectInfo objectInfo);
	
	/**
	 * Object 테이블의 Object 그룹 정보 변경
	 * @param objectInfo
	 * @return
	 */
	int updateObjectGroupObject(ObjectInfo objectInfo);
	
	/**
	 * Object 상태 수정
	 * @param objectInfo
	 * @return
	 */
	int updateObjectStatus(ObjectInfo objectInfo);
	
	/**
	 * Object 삭제
	 * @param object_id
	 * @return
	 */
	int deleteObject(Long object_id);
}
