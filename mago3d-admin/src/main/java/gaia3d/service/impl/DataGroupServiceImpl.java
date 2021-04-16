package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.config.PropertiesConfig;
import gaia3d.domain.Move;
import gaia3d.domain.data.DataGroup;
import gaia3d.persistence.DataGroupMapper;
import gaia3d.persistence.DataMapper;
import gaia3d.service.DataGroupService;
import gaia3d.utils.FileUtils;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class DataGroupServiceImpl implements DataGroupService {

	@Autowired
	private DataMapper dataMapper;
	@Autowired
	private DataGroupMapper dataGroupMapper;
	@Autowired
	private PropertiesConfig propertiesConfig;

	/**
	 * Data Group 총건수
	 * @param dataGroup
	 * @return
	 */
	@Transactional(readOnly = true)
	public Long getDataGroupTotalCount(DataGroup dataGroup) {
		return dataGroupMapper.getDataGroupTotalCount(dataGroup);
	}
	
	/**
     * 전체 데이터 그룹 목록
     * @param dataGroup
     */
	@Transactional(readOnly = true)
	public List<DataGroup> getAllListDataGroup(DataGroup dataGroup) {
		return dataGroupMapper.getAllListDataGroup(dataGroup);
	}
	
	/**
     * 데이터 그룹 목록
     * @return
     */
	@Transactional(readOnly = true)
	public List<DataGroup> getListDataGroup(DataGroup dataGroup) {
		return dataGroupMapper.getListDataGroup(dataGroup);
	}

	/**
     * 데이터 그룹 정보 조회
     * @param dataGroup
	 * @return
	 */
	@Transactional(readOnly = true)
	public DataGroup getDataGroup(DataGroup dataGroup) {
		return dataGroupMapper.getDataGroup(dataGroup);
	}

	/**
     * 기본 데이터 그룹 정보 조회
     * @return
     */
	@Transactional(readOnly = true)
	public DataGroup getBasicDataGroup() {
		return dataGroupMapper.getBasicDataGroup();
	}
	
	/**
     * 데이터 그룹 Key 중복 확인
     * @param dataGroup
     * @return
     */
	@Transactional(readOnly = true)
	public Boolean isDataGroupKeyDuplication(DataGroup dataGroup) {
		return dataGroupMapper.isDataGroupKeyDuplication(dataGroup);
	}
	
	/**
     * 부모와 표시 순서로 메뉴 조회
     * @param dataGroup
     * @return
     */
	@Transactional(readOnly = true)
    public DataGroup getDataGroupByParentAndViewOrder(DataGroup dataGroup) {
    	return dataGroupMapper.getDataGroupByParentAndViewOrder(dataGroup);
    }

    /**
     * 데이터 그룹 등록
     * @param dataGroup
     * @return
     */
    @Transactional
	public int insertDataGroup(DataGroup dataGroup) {
//    	String userId = dataGroup.getUserId();
    	Integer parentDataGroupId = 0;
    	
    	DataGroup parentDataGroup = new DataGroup();
    	//parentDataGroup.setUserId(userId);
    	int depth = 0;
    	if(dataGroup.getParent() > 0) {
    		parentDataGroupId = dataGroup.getParent();
    		parentDataGroup.setDataGroupId(parentDataGroupId);
    		parentDataGroup = dataGroupMapper.getDataGroup(parentDataGroup);
	    	depth = parentDataGroup.getDepth() + 1;
    	}
	    
    	// 디렉토리 생성
    	String dataGroupPath = dataGroup.getDataGroupKey() + "/";
    	FileUtils.makeDirectoryByPath(propertiesConfig.getAdminDataServiceDir(), dataGroupPath);
    	dataGroup.setDataGroupPath(propertiesConfig.getAdminDataServicePath() + dataGroupPath);
    	int result = dataGroupMapper.insertDataGroup(dataGroup);

    	if(depth > 1) {
	    	// parent 의 children update
    		Integer children = parentDataGroup.getChildren();
    		if(children == null) children = 0;
    		children += 1;
    		
    		parentDataGroup = new DataGroup();
    		//parentDataGroup.setUserId(userId);
    		parentDataGroup.setDataGroupId(parentDataGroupId);
    		parentDataGroup.setChildren(children);
	    	return dataGroupMapper.updateDataGroup(parentDataGroup);
    	}

    	return result;
    }
    
    /**
     * 기본 데이터 그룹 등록
     * @param dataGroup
     * @return
     */
    @Transactional
	public int insertBasicDataGroup(DataGroup dataGroup) {
    	return dataGroupMapper.insertBasicDataGroup(dataGroup);
    }

    /**
	 * 데이터 그룹 수정
	 * @param dataGroup
	 * @return
	 */
    @Transactional
	public int updateDataGroup(DataGroup dataGroup) {
    	return dataGroupMapper.updateDataGroup(dataGroup);
    }

    /**
	 * 데이터 그룹 표시 순서 수정. UP, DOWN
	 * @param dataGroup
	 * @return
	 */
    @Transactional
	public int updateDataGroupViewOrder(DataGroup dataGroup) {

    	DataGroup dbDataGroup = dataGroupMapper.getDataGroup(dataGroup);
    	dbDataGroup.setUpdateType(dataGroup.getUpdateType());

    	Integer modifyViewOrder = dbDataGroup.getViewOrder();
    	DataGroup searchDataGroup = new DataGroup();
    	//searchDataGroup.setUserId(dataGroup.getUserId());
    	searchDataGroup.setUpdateType(dbDataGroup.getUpdateType());
    	searchDataGroup.setParent(dbDataGroup.getParent());

    	if(Move.UP == Move.valueOf(dbDataGroup.getUpdateType())) {
    		// 바로 위 메뉴의 view_order 를 +1
    		searchDataGroup.setViewOrder(dbDataGroup.getViewOrder());
    		searchDataGroup = getDataGroupByParentAndViewOrder(searchDataGroup);

    		if(searchDataGroup == null) return 0;

	    	dbDataGroup.setViewOrder(searchDataGroup.getViewOrder());
	    	searchDataGroup.setViewOrder(modifyViewOrder);
    	} else {
    		// 바로 아래 메뉴의 view_order 를 -1 함
    		searchDataGroup.setViewOrder(dbDataGroup.getViewOrder());
    		searchDataGroup = getDataGroupByParentAndViewOrder(searchDataGroup);

    		if(searchDataGroup == null) return 0;

    		dbDataGroup.setViewOrder(searchDataGroup.getViewOrder());
    		searchDataGroup.setViewOrder(modifyViewOrder);
    	}

    	dataGroupMapper.updateDataGroupViewOrder(searchDataGroup);
		return dataGroupMapper.updateDataGroupViewOrder(dbDataGroup);
    }

	/**
	 * 자식의 수를 + 또는 - 연산
	 */
	@Transactional
	public int updateDataGroupChildren(DataGroup dataGroup) {
		return dataGroupMapper.updateDataGroupChildren(dataGroup);
	}

    /**
	 * 데이터 그룹 삭제
	 * @param dataGroup
	 * @return
	 */
    @Transactional
	public int deleteDataGroup(DataGroup dataGroup) {
    	
    	int result = 0;
		// TODO converter_job 이력도 삭제해야 하는가?
		// 삭제 대상의 하위목록을 트리로 가져와서 모두 삭제
		List<DataGroup> dataGroupList = dataGroupMapper.getListDataGroup(dataGroup);
		dataGroupList.forEach(f -> {
					// 데이터 삭제
					dataMapper.deleteDataByDataGroupId(f);
					// 데이터 그룹 삭제
					dataGroupMapper.deleteDataGroup(f);
				});
    		
		DataGroup parentGroup = dataGroupMapper.getDataGroup(DataGroup.builder()
				.dataGroupId(dataGroupList.get(0).getParent())
				.build());

		if (parentGroup != null) {
			// parent 데이터 그룹의 카운트 1 감소
			dataGroupMapper.updateDataGroup(DataGroup.builder()
					.dataGroupId(parentGroup.getDataGroupId())
					.children(parentGroup.getChildren() - 1)
					.build());
    	}
    	
		// 마지막으로 실제 삭제 대상 그룹 삭제
		dataGroupMapper.deleteDataGroup(dataGroup);
		dataMapper.deleteDataByDataGroupId(dataGroup);

    	return result;
    }
    
    @Transactional
	public int deleteDataGroupByAncestor(DataGroup dataGroup) {
		return dataGroupMapper.deleteDataGroupByAncestor(dataGroup);
	}
    
    @Transactional
	public int deleteDataGroupByParent(DataGroup dataGroup) {
		return dataGroupMapper.deleteDataGroupByParent(dataGroup);
	}
	
    @Transactional
	public int deleteDataGroupByUserId(String userId) {
		return dataGroupMapper.deleteDataGroupByUserId(userId);
	}
}
