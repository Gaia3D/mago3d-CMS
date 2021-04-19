package gaia3d.service;

import java.util.List;

import gaia3d.domain.layer.LayerGroup;

public interface LayerGroupService {

    /**
     * 레이어 그룹 목록 및 하위 레이어 조회
     * @return
     */
    List<LayerGroup> getListLayerGroupAndLayer(LayerGroup layerGroup);

    /**
     * 레이어 그룹 목록
     * @param
     * @return
     */
    List<LayerGroup> getListLayerGroup(LayerGroup layerGroup);

    /**
     * 레이어 그룹 정보 조회
     * @param layerGroupId
     * @return
     */
    LayerGroup getLayerGroup(Integer layerGroupId);

}
