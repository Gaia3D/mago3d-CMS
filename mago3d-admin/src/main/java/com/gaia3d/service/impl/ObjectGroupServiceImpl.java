package com.gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.ObjectGroup;
import com.gaia3d.persistence.ObjectGroupMapper;
import com.gaia3d.service.ObjectGroupService;

/**
 * Object 그룹
 * 
 * @author jeongdae
 *
 */
@Service
public class ObjectGroupServiceImpl implements ObjectGroupService {

	@Autowired
	private ObjectGroupMapper objectGroupMapper;

	/**
	 * Object 그룹 목록
	 * 
	 * @param objectGroup
	 * @return
	 */
	@Transactional(readOnly = true)
	public List<ObjectGroup> getListObjectGroup(ObjectGroup objectGroup) {
		return objectGroupMapper.getListObjectGroup(objectGroup);
	}

	/**
	 * Object 그룹 조회
	 * 
	 * @param object_group_id
	 * @return
	 */
	@Transactional(readOnly = true)
	public ObjectGroup getObjectGroup(Long object_group_id) {
		return objectGroupMapper.getObjectGroup(object_group_id);
	}

	/**
	 * 자식 그룹 중에 순서가 최대인 그룹을 검색
	 * 
	 * @param parent
	 * @return
	 */
	@Transactional(readOnly = true)
	public ObjectGroup getMaxViewOrderChildObjectGroup(Long parent) {
		return objectGroupMapper.getMaxViewOrderChildObjectGroup(parent);
	}

	/**
	 * Object 그룹 등록
	 * 
	 * @param objectGroup
	 * @return
	 */
	@Transactional
	public int insertObjectGroup(ObjectGroup objectGroup) {

		// TODO 이건 bdr 때문에 한거 같은데.... sequence 로 바꿔야 할 듯
		objectGroup.setObject_group_id(objectGroupMapper.getMaxObjectGroupId());
		objectGroupMapper.insertObjectGroup(objectGroup);

		// 부모 그룹 자식 존재 유무 컬럼 수정
		ObjectGroup parentObjectGroup = new ObjectGroup();
		parentObjectGroup.setObject_group_id(objectGroup.getParent());
		parentObjectGroup.setChild_yn("Y");
		objectGroupMapper.updateObjectGroupChildYN(parentObjectGroup);
		return 0;
	}

	/**
	 * Object 그룹 수정
	 * 
	 * @param objectGroup
	 * @return
	 */
	@Transactional
	public int updateObjectGroup(ObjectGroup objectGroup) {
		return objectGroupMapper.updateObjectGroup(objectGroup);
	}

	/**
	 * Object 그룹 트리에서 정렬 순서 변경
	 * 
	 * @param objectGroup
	 * @return
	 */
	@Transactional
	public int updateMoveObjectGroup(ObjectGroup objectGroup) {
		Integer modifyViewOrder = objectGroup.getView_order();
		ObjectGroup searchObjectGroup = new ObjectGroup();
		searchObjectGroup.setUpdate_type(objectGroup.getUpdate_type());
		searchObjectGroup.setParent(objectGroup.getParent());

		if ("up".equals(objectGroup.getUpdate_type())) {
			// 바로 위 메뉴의 view_order 를 +1
			searchObjectGroup.setView_order(objectGroup.getView_order());
			searchObjectGroup = getObjectGroupByParentAndViewOrder(searchObjectGroup);
			objectGroup.setView_order(searchObjectGroup.getView_order());
			searchObjectGroup.setView_order(modifyViewOrder);
		} else {
			// 바로 아래 메뉴의 view_order 를 -1 함
			searchObjectGroup.setView_order(objectGroup.getView_order());
			searchObjectGroup = getObjectGroupByParentAndViewOrder(searchObjectGroup);
			objectGroup.setView_order(searchObjectGroup.getView_order());
			searchObjectGroup.setView_order(modifyViewOrder);
		}
		updateViewOrderObjectGroup(searchObjectGroup);

		return updateViewOrderObjectGroup(objectGroup);
	}

	/**
	 * 부모와 표시 순서로 메뉴 조회
	 * 
	 * @param objectGroup
	 * @return
	 */
	private ObjectGroup getObjectGroupByParentAndViewOrder(ObjectGroup objectGroup) {
		return objectGroupMapper.getObjectGroupByParentAndViewOrder(objectGroup);
	}

	/**
	 * 
	 * @param objectGroup
	 * @return
	 */
	private int updateViewOrderObjectGroup(ObjectGroup objectGroup) {
		return objectGroupMapper.updateViewOrderObjectGroup(objectGroup);
	}

	/**
	 * Object 그룹 삭제
	 * 
	 * @param object_group_id
	 * @return
	 */
	@Transactional
	public int deleteObjectGroup(Long object_group_id) {
		return deleteObjectGroupList(object_group_id);
	}

	/**
	 * Object 그룹 삭제 메소드
	 * 
	 * @param object_group_id
	 * @return
	 */
	public int deleteObjectGroupList(Long object_group_id) {
		// 자식 목록 리스트
		List<Long> childObjectGroupIdList = objectGroupMapper.getListObjectGroupChild(object_group_id);

		if (childObjectGroupIdList != null && !childObjectGroupIdList.isEmpty()) {
			for (Long childObjectGroupId : childObjectGroupIdList) {
				deleteObjectGroup(childObjectGroupId);
			}
		}
		return objectGroupMapper.deleteObjectGroup(object_group_id);
	}
}
