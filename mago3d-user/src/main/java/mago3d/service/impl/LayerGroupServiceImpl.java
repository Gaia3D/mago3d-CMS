package mago3d.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import mago3d.domain.Layer;
import mago3d.domain.LayerGroup;
import mago3d.persistence.LayerGroupMapper;
import mago3d.service.LayerGroupService;
import mago3d.service.LayerService;

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
     * @return
     */
	@Transactional(readOnly = true)
	public List<LayerGroup> getListLayerGroupAndLayer() {
		List<LayerGroup> layerGroupList = layerGroupMapper.getListLayerGroup();
		layerGroupList.stream()
						.forEach(group -> {
							Layer layer = Layer.builder()
											.layerGroupId(group.getLayerGroupId())
											.build();
							group.setLayerList(layerService.getListLayer(layer));
						});
		
//		List<Layer> layerList = new ArrayList<>();
//		layerGroupList.stream()
//						.forEach(group -> {
//							Layer layer = Layer.builder()
//											.layerGroupId(group.getLayerGroupId())
//											.parent(group.getParent())
//											.parentName(group.getLayerGroupName())
//											.depth(group.getDepth())
//											.build();
//							layerList.add(layer);
//							List<Layer> childLayerList = layerService.getListLayer(layer);
//							if(childLayerList.size() > 0) {
//								layerList.addAll(childLayerList);
//							}
//						});

		return layerGroupList;
	}
}
