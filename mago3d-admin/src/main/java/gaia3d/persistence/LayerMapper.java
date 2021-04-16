package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.layer.Layer;

@Repository
public interface LayerMapper {
	
	/**
	 * Layer 총 건수
	 * @param layer
	 * @return
	 */
	Long getLayerTotalCount(Layer layer);

    /**
    * layer 목록
    * @param layer
    * @return
    */
    List<Layer> getListLayer(Layer layer);

    /**
    * layer 정보 취득
    * @param layerId
    * @return
    */
    Layer getLayer(Integer layerId);
    
    /**
     * layerKey 중복 체크 
     * @param layerKey
     * @return
     */
    Boolean isLayerKeyDuplication(String layerKey);

    /**
    * 자식 레이어 중 순서가 최대인 레이어를 검색
    * @param layerId
    * @return
    */
    Layer getMaxViewOrderChildLayer(Integer layerId);

    /**
    * 자식 레이어 개수
    * @param layerId
    * @return
    */
    int getChildLayerCount(Integer layerId);

    /**
    * 레이어 트리 부모와 순서로 그룹 정보 취득
    * @param layer
    * @return
    */
    Layer getLayerByParentAndViewOrder(Layer layer);

    /**
    * 레이어 테이블의 컬럼 타입이 어떤 geometry 타입인지를 구함
    * @param layerKey
    * @return
    */
    String getGeometryType(String layerKey);

    /**
    * 레이어 등록
    * @param layer
    * @return
    */
    int insertLayer(Layer layer);

    /**
    * 레이어 트리 정보 수정
    * @param layer
    * @return
    */
    int updateTreeLayer(Layer layer);

    /**
    * 레이어 트리 순서 수정
    * @param layer
    * @return
    */
    int updateViewOrderLayer(Layer layer);

    /**
    * layer 정보 수정
    * @param layer
    * @return
    */
    int updateLayer(Layer layer);

    /**
    * 레이어 삭제
    * @param layerId
    * @return
    */
    int deleteLayer(Integer layerId);
    
    /**
     * 공간정보 테이블 삭제
     * @param layerKey
     * @return
     */
    int deleteLayerTable(String layerKey);
    
    /**
     * 레이어의 칼럼 목록을 조회 
     * @param layerKey
     * @return
     */
    String getLayerColumn(String layerKey);
    
    /**
     * 테이블이 존재 하는지 확인 
     * @param layerKey
     * @return
     */
    String isLayerExists(String layerKey);
}
