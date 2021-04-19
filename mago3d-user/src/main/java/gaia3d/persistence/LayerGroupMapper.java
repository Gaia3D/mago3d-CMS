package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.layer.LayerGroup;

@Repository
public interface LayerGroupMapper {

	/**
     * 레이어 그룹 목록
     * @return
     */
    List<LayerGroup> getListLayerGroup(LayerGroup layerGroup);

    /**
     * 레이어 정보 조회
     * @param layerGroupId
     * @return
     */
    LayerGroup getLayerGroup(Integer layerGroupId);
}
