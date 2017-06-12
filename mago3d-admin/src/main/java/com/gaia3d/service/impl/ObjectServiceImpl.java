package com.gaia3d.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.ObjectInfo;
import com.gaia3d.persistence.ObjectMapper;
import com.gaia3d.service.ObjectService;
import com.gaia3d.util.StringUtil;

/**
 * Object
 * @author jeongdae
 *
 */
@Service
public class ObjectServiceImpl implements ObjectService {

	@Autowired
	private ObjectMapper objectMapper;
	
	/**
	 * Object 수
	 * @param objectInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getObjectTotalCount(ObjectInfo objectInfo) {
		return objectMapper.getObjectTotalCount(objectInfo);
	}
	
	/**
	 * object_group_id를 제외한 Object 수
	 * @param objectInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getExceptObjectGroupObjectByGroupIdTotalCount(ObjectInfo objectInfo) {
		return objectMapper.getExceptObjectGroupObjectByGroupIdTotalCount(objectInfo);
	}
	
	/**
	 * Object 목록
	 * @param objectInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<ObjectInfo> getListObject(ObjectInfo objectInfo) {
		return objectMapper.getListObject(objectInfo);
	}
	
	/**
	 * object_group_id를 제외한 Object 목록
	 * @param objectInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<ObjectInfo> getListExceptObjectGroupObjectByGroupId(ObjectInfo objectInfo) {
		return objectMapper.getListExceptObjectGroupObjectByGroupId(objectInfo);
	}
	
	/**
	 * Object 아이디 중복 건수
	 * @param object_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public Integer getDuplicationIdCount(Long object_id) {
		return objectMapper.getDuplicationIdCount(object_id);
	}
	
	/**
	 * Object 정보 취득
	 * @param object_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public ObjectInfo getObject(Long object_id) {
		return objectMapper.getObject(object_id);
	}
	
	/**
	 * Object 등록
	 * @param objectInfo
	 * @return
	 */
	@Transactional
	public int insertObject(ObjectInfo objectInfo) {
		return objectMapper.insertObject(objectInfo);
	}
	
	/**
	 * 선택 Object 그룹내 Object 등록
	 * @param objectInfo
	 * @return
	 */
	@Transactional
	public int updateObjectGroupObject(ObjectInfo objectInfo) {
		// object_group 에 등록되지 않은 Object
		String[] leftObjectId = objectInfo.getObject_all_id();
		// object_group 에 등록된 Object
		String[] rightObjectId = objectInfo.getObject_select_id();
		
		if(leftObjectId != null && leftObjectId.length >0) {
			for(String object_id : leftObjectId) {
				objectInfo.setObject_id(Long.valueOf(object_id));
				objectMapper.updateObjectGroupObject(objectInfo);
			}
		} 
		
//		// 임시 그룹으로 보냄
//		if(rightObjectId != null && rightObjectId.length >0) {
//			for(String object_id : rightObjectId) {
//				objectInfo.setObject_group_id(ObjectGroup.TEMP_GROUP);
//				objectInfo.setObject_id(object_id);
//				objectMapper.updateObjectGroupObject(objectInfo);
//			}
//		}
		return 0;
	}
	
	/**
	 * Object 수정
	 * @param objectInfo
	 * @return
	 */
	@Transactional
	public int updateObject(ObjectInfo objectInfo) {
		// TODO 환경 설정 값을 읽어 와서 update 할 건지, delete 할건지 분기를 타야 함
		return objectMapper.updateObject(objectInfo);
	}
	
	/**
	 * Object 상태 수정
	 * @param objectInfo
	 * @return
	 */
	@Transactional
	public int updateObjectStatus(ObjectInfo objectInfo) {
		return objectMapper.updateObjectStatus(objectInfo);
	}
	
	/**
	 * Object 상태 수정
	 * @param business_type
	 * @param status_value
	 * @param check_ids
	 * @return
	 */
	@Transactional
	public List<String> updateObjectStatus(String business_type, String status_value, String check_ids) {
		
		List<String> result = new ArrayList<String>();
		String[] objectIds = check_ids.split(",");
		
		for(String object_id : objectIds) {
			ObjectInfo objectInfo = new ObjectInfo();
			objectInfo.setObject_id(Long.valueOf(object_id));
			if("LOCK".equals(status_value)) {
				objectInfo.setStatus(ObjectInfo.STATUS_FORBID);
			} else if("UNLOCK".equals(status_value)) {
				objectInfo.setStatus(ObjectInfo.STATUS_USE);
			}
			objectMapper.updateObjectStatus(objectInfo);
		}
		
		return result;
	}
	
	/**
	 * Object 등록 방법에 의한 Object 상태 수정
	 * @param objectInfo
	 * @return
	 */
	@Transactional
	public int updateObjectStatusByInsertType(ObjectInfo objectInfo) {
		return objectMapper.updateObjectStatusByInsertType(objectInfo);
	}
	
	/**
	 * Object 삭제
	 * @param object_id
	 * @return
	 */
	@Transactional
	public int deleteObject(Long object_id) {
//		Policy policy = CacheManager.getPolicy();
//		String objectDeleteType = policy.getObject_delete_type();
		
		return objectMapper.deleteObject(object_id);
	}
	
	/**
	 * 일괄 Object 삭제
	 * @param check_ids
	 * @return
	 */
	@Transactional
	public int deleteObjectList(String check_ids) {
		String[] objectIds = check_ids.split(",");
		for(String object_id : objectIds) {
			deleteObject(Long.valueOf(object_id));
		}
		
		return check_ids.length();
	}
}
