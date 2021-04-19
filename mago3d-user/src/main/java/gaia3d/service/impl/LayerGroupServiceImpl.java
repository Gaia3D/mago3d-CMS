package gaia3d.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.layer.Layer;
import gaia3d.domain.layer.LayerGroup;
import gaia3d.persistence.LayerGroupMapper;
import gaia3d.service.LayerGroupService;
import gaia3d.service.LayerService;

@Service
public class LayerGroupServiceImpl implements LayerGroupService {

	private final LayerService layerService;

	private final LayerGroupMapper layerGroupMapper;
	
	public LayerGroupServiceImpl(LayerService layerService, LayerGroupMapper layerGroupMapper) {
		this.layerService = layerService;
		this.layerGroupMapper = layerGroupMapper;
	}
	
	/**
	 * 레이어 그룹 목록 및 하위 레이어를 조회
     *
     * @return
     */
	@Transactional(readOnly = true)
    public List<LayerGroup> getListLayerGroupAndLayer(LayerGroup layerGroup) {
        List<LayerGroup> layerGroupList = layerGroupMapper.getListLayerGroup(layerGroup);
        layerGroupList
						.forEach(group -> {
							Layer layer = Layer.builder()
											.layerGroupId(group.getLayerGroupId())
											.build();
							group.setLayerList(layerService.getListLayer(layer));
						});
		
		return layerGroupList;
	}

    /**
     * 레이어 그룹 목록
     */
    @Transactional(readOnly = true)
    public List<LayerGroup> getListLayerGroup(LayerGroup layerGroup) {
        return layerGroupMapper.getListLayerGroup(layerGroup);
    }

    /**
     * 레이어 그룹 정보 조회
     *
     * @param layerGroupId
     * @return
     */
    @Transactional(readOnly = true)
    public LayerGroup getLayerGroup(Integer layerGroupId) {
        return layerGroupMapper.getLayerGroup(layerGroupId);
    }
}
