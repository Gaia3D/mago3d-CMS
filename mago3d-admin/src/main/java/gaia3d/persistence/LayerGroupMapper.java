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
    List<LayerGroup> getListLayerGroup();

    /**
     * 레이어 정보 조회
     * @param layerGroup
     * @return
     */
    LayerGroup getLayerGroup(LayerGroup layerGroup);

    /**
     * 부모와 표시 순서로 메뉴 조회
     * @param layerGroup
     * @return
     */
    LayerGroup getLayerGroupByParentAndViewOrder(LayerGroup layerGroup);

    /**
     * 레이어 그룹 등록
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

	/**
	 * ancestor를 이용하여 레이어 그룹 삭제
	 * @param layerGroup
	 * @return
	 */
	int deleteLayerGroupByAncestor(LayerGroup layerGroup);

	/**
	 * parent를 이용하여 레이어 그룹 삭제
	 * @param layerGroup
	 * @return
	 */
	int deleteLayerGroupByParent(LayerGroup layerGroup);
}
