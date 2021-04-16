package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.Depth;
import gaia3d.domain.Move;
import gaia3d.domain.layer.Layer;
import gaia3d.domain.layer.LayerGroup;
import gaia3d.persistence.LayerGroupMapper;
import gaia3d.service.LayerGroupService;
import gaia3d.service.LayerService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LayerGroupServiceImpl implements LayerGroupService {

	@Autowired
	private LayerService layerService;

	@Autowired
	private LayerGroupMapper layerGroupMapper;

	/**
	 * 레이어 그룹 목록
	 */
	@Transactional(readOnly = true)
	public List<LayerGroup> getListLayerGroup() {
		return layerGroupMapper.getListLayerGroup();
	}

	/**
     * 레이어 그룹 정보 조회
     * @param layerGroup
     * @return
     */
	@Transactional(readOnly = true)
    public LayerGroup getLayerGroup(LayerGroup layerGroup) {
		return layerGroupMapper.getLayerGroup(layerGroup);
	}

	/**
	 * 레이어 그룹 목록 및 하위 레이어를 조회
     * @return
     */
	@Transactional(readOnly = true)
	public List<LayerGroup> getListLayerGroupAndLayer() {
		List<LayerGroup> layerGroupList = layerGroupMapper.getListLayerGroup();
		for(LayerGroup layerGroup : layerGroupList) {
			Layer layer = new Layer();
			layer.setLayerGroupId(layerGroup.getLayerGroupId());
			layerGroup.setLayerList(layerService.getListLayer(layer));
		}

		return layerGroupList;
	}

	/**
	 * 레이어 그룹 표시 순서 수정 (up/down)
	 * @param layerGroup
	 * @return
	 */
    @Transactional
	public int updateLayerGroupViewOrder(LayerGroup layerGroup) {

    	LayerGroup dbLayerGroup = layerGroupMapper.getLayerGroup(layerGroup);
    	dbLayerGroup.setUpdateType(layerGroup.getUpdateType());

    	Integer modifyViewOrder = dbLayerGroup.getViewOrder();
    	LayerGroup searchLayerGroup = new LayerGroup();
    	searchLayerGroup.setUpdateType(dbLayerGroup.getUpdateType());
    	searchLayerGroup.setParent(dbLayerGroup.getParent());

    	if(Move.UP == Move.valueOf(dbLayerGroup.getUpdateType())) {
    		// 바로 위 메뉴의 view_order 를 +1
    		searchLayerGroup.setViewOrder(dbLayerGroup.getViewOrder());
    		searchLayerGroup = getDataLayerByParentAndViewOrder(searchLayerGroup);

    		if(searchLayerGroup == null) return 0;

	    	dbLayerGroup.setViewOrder(searchLayerGroup.getViewOrder());
	    	searchLayerGroup.setViewOrder(modifyViewOrder);
    	} else {
    		// 바로 아래 메뉴의 view_order 를 -1 함
    		searchLayerGroup.setViewOrder(dbLayerGroup.getViewOrder());
    		searchLayerGroup = getDataLayerByParentAndViewOrder(searchLayerGroup);

    		if(searchLayerGroup == null) return 0;

    		dbLayerGroup.setViewOrder(searchLayerGroup.getViewOrder());
    		searchLayerGroup.setViewOrder(modifyViewOrder);
    	}

    	updateViewOrderLayerGroup(searchLayerGroup);
		return updateViewOrderLayerGroup(dbLayerGroup);
    }

    /**
	 * 레이어 그룹 등록
	 */
	@Transactional
	public int insertLayerGroup(LayerGroup layerGroup) {
		
		Integer parentLayerGroupId = 0;
    	
    	LayerGroup parentLayerGroup = new LayerGroup();
    	int depth = 0;
    	if(layerGroup.getParent() > 0) {
    		parentLayerGroupId = layerGroup.getParent();
    		parentLayerGroup.setLayerGroupId(parentLayerGroupId);
    		parentLayerGroup = layerGroupMapper.getLayerGroup(parentLayerGroup);
	    	depth = parentLayerGroup.getDepth() + 1;
    	}
    	
    	int result = layerGroupMapper.insertLayerGroup(layerGroup); 
		
    	if(depth > 1) {
	    	// parent 의 children update
    		Integer children = parentLayerGroup.getChildren();
    		if(children == null) children = 0;
    		children += 1;
    		
    		parentLayerGroup = new LayerGroup();
    		parentLayerGroup.setLayerGroupId(parentLayerGroupId);
    		parentLayerGroup.setChildren(children);
	    	return layerGroupMapper.updateLayerGroup(parentLayerGroup);
    	}
    	
		return result; 
	}

	/**
	 * 레이어 그룹 수정
	 * @param layerGroup
	 * @return
	 */
    @Transactional
	public int updateLayerGroup(LayerGroup layerGroup) {
    	return layerGroupMapper.updateLayerGroup(layerGroup);
    }

    /**
     * 부모와 표시 순서로 메뉴 조회
     * @param layerGroup
     * @return
     */
    private LayerGroup getDataLayerByParentAndViewOrder(LayerGroup layerGroup) {
    	return layerGroupMapper.getLayerGroupByParentAndViewOrder(layerGroup);
    }

    /**
	 * 사용자 그룹 표시 순서 수정 (up/down)
	 * @param layerGroup
	 * @return
	 */
	private int updateViewOrderLayerGroup(LayerGroup layerGroup) {
		return layerGroupMapper.updateLayerGroupViewOrder(layerGroup);
	}

    /**
	 * 레이어 그룹 삭제
	 * @param layerGroup
	 * @return
	 */
    @Transactional
	public int deleteLayerGroup(LayerGroup layerGroup) {
    	// 삭제하고, children update

    	layerGroup = layerGroupMapper.getLayerGroup(layerGroup);
    	log.info("--- 111111111 delete dataGroup = {}", layerGroup);

    	int result = 0;
    	if(Depth.ONE == Depth.findBy(layerGroup.getDepth())) {
    		log.info("--- one ================");
    		result = layerGroupMapper.deleteLayerGroupByAncestor(layerGroup);
    	} else if(Depth.TWO == Depth.findBy(layerGroup.getDepth())) {
    		log.info("--- two ================");

    		LayerGroup ancestorLayerGroup = new LayerGroup();
    		ancestorLayerGroup.setLayerGroupId(layerGroup.getAncestor());
    		ancestorLayerGroup = layerGroupMapper.getLayerGroup(ancestorLayerGroup);
    		ancestorLayerGroup.setChildren(ancestorLayerGroup.getChildren() - 1);
	    	layerGroupMapper.updateLayerGroup(ancestorLayerGroup);
	    	
	    	result = layerGroupMapper.deleteLayerGroupByParent(layerGroup);
    		// ancestor - 1
    	} else if(Depth.THREE == Depth.findBy(layerGroup.getDepth())) {
    		log.info("--- three ================");
    		log.info("--- dataGroup ================ {}", layerGroup);

    		LayerGroup parentDataGroup = new LayerGroup();
	    	parentDataGroup.setLayerGroupId(layerGroup.getParent());
	    	parentDataGroup = layerGroupMapper.getLayerGroup(parentDataGroup);
	    	parentDataGroup.setChildren(parentDataGroup.getChildren() - 1);
	    	layerGroupMapper.updateLayerGroup(parentDataGroup);
	    	
	    	result = layerGroupMapper.deleteLayerGroup(layerGroup);
    	} else {

    	}

    	return result;
    }
}
