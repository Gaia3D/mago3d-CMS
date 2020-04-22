package mago3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;
import mago3d.config.PropertiesConfig;
import mago3d.domain.DataGroup;
import mago3d.domain.Depth;
import mago3d.domain.Move;
import mago3d.persistence.DataGroupMapper;
import mago3d.persistence.DataMapper;
import mago3d.service.DataGroupService;
import mago3d.service.GeoPolicyService;
import mago3d.utils.FileUtils;

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
		return dataGroupMapper.getListDataGroup();
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
    	String userId = dataGroup.getUserId();
    	Integer parentDataGroupId = 0;
    	
    	DataGroup parentDataGroup = new DataGroup();
    	//parentDataGroup.setUserId(userId);
    	Integer depth = 0;
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
	 * 데이터 그룹 삭제
	 * @param dataGroup
	 * @return
	 */
    @Transactional
	public int deleteDataGroup(DataGroup dataGroup) {
    	
    	// TODO converter_job 이력도 삭제해야 하는가?
    	// 삭제하고, children update
    	
    	//String userId = dataGroup.getUserId();
    	dataGroup = dataGroupMapper.getDataGroup(dataGroup);
    	
    	int result = 0;
    	if(Depth.ONE == Depth.findBy(dataGroup.getDepth())) {
    		// 하위 데이터 그룹 조회
    		List<Integer> dataGroupIdList = dataGroupMapper.getDataGroupListByAncestor(dataGroup);
    		for(Integer dataGroupId : dataGroupIdList) {
    			DataGroup deleteDataGroup = new DataGroup();
    			//deleteDataGroup.setUserId(userId);
    			deleteDataGroup.setDataGroupId(dataGroupId);
    			// 하위 데이터 삭제
    			dataMapper.deleteDataByDataGroupId(deleteDataGroup);
    		}
    		
    		// 데이터 그룹 일괄 삭제
    		result = dataGroupMapper.deleteDataGroupByAncestor(dataGroup);
    	} else if(Depth.TWO == Depth.findBy(dataGroup.getDepth())) {
    		// 하위 데이터 그룹 조회
    		List<Integer> dataGroupIdList = dataGroupMapper.getDataGroupListByParent(dataGroup);
    		for(Integer dataGroupId : dataGroupIdList) {
    			DataGroup deleteDataGroup = new DataGroup();
    			//deleteDataGroup.setUserId(userId);
    			deleteDataGroup.setDataGroupId(dataGroupId);
    			// 하위 데이터 삭제
    			dataMapper.deleteDataByDataGroupId(deleteDataGroup);
    		}
    		
    		// 조상의 children -1
    		DataGroup ancestorDataGroup = new DataGroup();
    		//ancestorDataGroup.setUserId(userId);
    		ancestorDataGroup.setDataGroupId(dataGroup.getAncestor());
    		ancestorDataGroup = dataGroupMapper.getDataGroup(ancestorDataGroup);
    		DataGroup tempDataGroup = new DataGroup();
    		tempDataGroup.setDataGroupId(ancestorDataGroup.getDataGroupId());
    		tempDataGroup.setChildren(ancestorDataGroup.getChildren() - 1);
	    	dataGroupMapper.updateDataGroup(tempDataGroup);
    		
	    	// 데이터 그룹 일괄 삭제
    		result = dataGroupMapper.deleteDataGroupByParent(dataGroup);
    	} else if(Depth.THREE == Depth.findBy(dataGroup.getDepth())) {
    		DataGroup deleteDataGroup = new DataGroup();
			//deleteDataGroup.setUserId(userId);
			deleteDataGroup.setDataGroupId(dataGroup.getDataGroupId());
			// 하위 데이터 삭제
			dataMapper.deleteDataByDataGroupId(deleteDataGroup);
    		
			// 부모의 children -1
			DataGroup parentDataGroup = new DataGroup();
    		parentDataGroup.setDataGroupId(dataGroup.getParent());
    		parentDataGroup = dataGroupMapper.getDataGroup(parentDataGroup);
    		DataGroup tempDataGroup = new DataGroup();
    		tempDataGroup.setDataGroupId(parentDataGroup.getDataGroupId());
    		tempDataGroup.setChildren(parentDataGroup.getChildren() - 1);
	    	dataGroupMapper.updateDataGroup(tempDataGroup);
	    	
	    	result = dataGroupMapper.deleteDataGroup(dataGroup);
    	} else {
    		
    	}
    	
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
