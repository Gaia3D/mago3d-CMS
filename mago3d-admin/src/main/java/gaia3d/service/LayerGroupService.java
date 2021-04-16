package gaia3d.service;

import java.util.List;

import gaia3d.domain.layer.LayerGroup;

public interface LayerGroupService {

	/**
     * 레이어 그룹 목록
     * @return
     */
    List<LayerGroup> getListLayerGroup();

    /**
     * 레이어 그룹 정보 조회
	 * @param layerGroup
     * @return
     */
    LayerGroup getLayerGroup(LayerGroup layerGroup);

    /**
     * 레이어 그룹 목록 및 하위 레이어 조회
     * @return
     */
    List<LayerGroup> getListLayerGroupAndLayer();

	/**
	 * 레이어 그룹 등록
	 *
	 * @param layerGroup
	 * @return
	 */
	int insertLayerGroup(LayerGroup layerGroup);

	/**
	 * 레이어 그룹 수정
	 * @param layerGroup
	 * @return
	 */
	int updateLayerGroup(LayerGroup layerGroup);

    /**
	 * 레이어 그룹 표시 순서 수정 (up/down)
	 * @param layerGroup
	 * @return
	 */
	int updateLayerGroupViewOrder(LayerGroup layerGroup);

	/**
	 * 레이어 그룹 삭제
	 * @param layerGroup
	 * @return
	 */
	int deleteLayerGroup(LayerGroup layerGroup);
}
