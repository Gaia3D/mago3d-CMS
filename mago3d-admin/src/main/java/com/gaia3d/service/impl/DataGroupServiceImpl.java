package com.gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.DataGroup;
import com.gaia3d.persistence.DataGroupMapper;
import com.gaia3d.service.DataGroupService;

/**
 * Data 그룹
 * 
 * @author jeongdae
 *
 */
@Service
public class DataGroupServiceImpl implements DataGroupService {

	@Autowired
	private DataGroupMapper dataGroupMapper;

	/**
	 * Data 그룹 목록
	 * 
	 * @param dataGroup
	 * @return
	 */
	@Transactional(readOnly = true)
	public List<DataGroup> getListDataGroup(DataGroup dataGroup) {
		return dataGroupMapper.getListDataGroup(dataGroup);
	}
	
	/**
	 * depth별 Data 그룹 목록
	 * @param depth
	 * @return
	 */
	@Transactional(readOnly = true)
	public List<DataGroup> getListDataGroupByDepth(Integer depth) {
		return dataGroupMapper.getListDataGroupByDepth(depth);
	}
	
	/**
	 * ancestor별 Data 그룹 목록
	 * @param ancestor
	 * @return
	 */
	@Transactional(readOnly = true)
	public List<DataGroup> getListDataGroupByAncestor(Long ancestor) {
		return dataGroupMapper.getListDataGroupByAncestor(ancestor);
	}

	/**
	 * Data 그룹 조회
	 * 
	 * @param data_group_id
	 * @return
	 */
	@Transactional(readOnly = true)
	public DataGroup getDataGroup(Long data_group_id) {
		return dataGroupMapper.getDataGroup(data_group_id);
	}

	/**
	 * 자식 그룹 중에 순서가 최대인 그룹을 검색
	 * 
	 * @param parent
	 * @return
	 */
	@Transactional(readOnly = true)
	public DataGroup getMaxViewOrderChildDataGroup(Long parent) {
		return dataGroupMapper.getMaxViewOrderChildDataGroup(parent);
	}

	/**
	 * Data 그룹 등록
	 * 
	 * @param dataGroup
	 * @return
	 */
	@Transactional
	public int insertDataGroup(DataGroup dataGroup) {

		// TODO 이건 bdr 때문에 한거 같은데.... sequence 로 바꿔야 할 듯
		dataGroup.setData_group_id(dataGroupMapper.getMaxDataGroupId());
		dataGroupMapper.insertDataGroup(dataGroup);

		// 부모 그룹 자식 존재 유무 컬럼 수정
		DataGroup parentDataGroup = new DataGroup();
		parentDataGroup.setData_group_id(dataGroup.getParent());
		parentDataGroup.setChild_yn("Y");
		dataGroupMapper.updateDataGroupChildYN(parentDataGroup);
		return 0;
	}

	/**
	 * Data 그룹 수정
	 * 
	 * @param dataGroup
	 * @return
	 */
	@Transactional
	public int updateDataGroup(DataGroup dataGroup) {
		return dataGroupMapper.updateDataGroup(dataGroup);
	}

	/**
	 * Data 그룹 트리에서 정렬 순서 변경
	 * 
	 * @param dataGroup
	 * @return
	 */
	@Transactional
	public int updateMoveDataGroup(DataGroup dataGroup) {
		Integer modifyViewOrder = dataGroup.getView_order();
		DataGroup searchDataGroup = new DataGroup();
		searchDataGroup.setUpdate_type(dataGroup.getUpdate_type());
		searchDataGroup.setParent(dataGroup.getParent());

		if ("up".equals(dataGroup.getUpdate_type())) {
			// 바로 위 메뉴의 view_order 를 +1
			searchDataGroup.setView_order(dataGroup.getView_order());
			searchDataGroup = getDataGroupByParentAndViewOrder(searchDataGroup);
			dataGroup.setView_order(searchDataGroup.getView_order());
			searchDataGroup.setView_order(modifyViewOrder);
		} else {
			// 바로 아래 메뉴의 view_order 를 -1 함
			searchDataGroup.setView_order(dataGroup.getView_order());
			searchDataGroup = getDataGroupByParentAndViewOrder(searchDataGroup);
			dataGroup.setView_order(searchDataGroup.getView_order());
			searchDataGroup.setView_order(modifyViewOrder);
		}
		updateViewOrderDataGroup(searchDataGroup);

		return updateViewOrderDataGroup(dataGroup);
	}

	/**
	 * 부모와 표시 순서로 메뉴 조회
	 * 
	 * @param dataGroup
	 * @return
	 */
	private DataGroup getDataGroupByParentAndViewOrder(DataGroup dataGroup) {
		return dataGroupMapper.getDataGroupByParentAndViewOrder(dataGroup);
	}

	/**
	 * 
	 * @param dataGroup
	 * @return
	 */
	private int updateViewOrderDataGroup(DataGroup dataGroup) {
		return dataGroupMapper.updateViewOrderDataGroup(dataGroup);
	}

	/**
	 * Data 그룹 삭제
	 * 
	 * @param data_group_id
	 * @return
	 */
	@Transactional
	public int deleteDataGroup(Long data_group_id) {
		return deleteDataGroupList(data_group_id);
	}

	/**
	 * Data 그룹 삭제 메소드
	 * 
	 * @param data_group_id
	 * @return
	 */
	public int deleteDataGroupList(Long data_group_id) {
		// 자식 목록 리스트
		List<Long> childDataGroupIdList = dataGroupMapper.getListDataGroupChild(data_group_id);

		if (childDataGroupIdList != null && !childDataGroupIdList.isEmpty()) {
			for (Long childDataGroupId : childDataGroupIdList) {
				deleteDataGroup(childDataGroupId);
			}
		}
		return dataGroupMapper.deleteDataGroup(data_group_id);
	}
}
