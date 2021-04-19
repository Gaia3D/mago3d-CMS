package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.layer.Layer;

@Repository
public interface LayerMapper {
	
    /**
    * layer 목록
    * @param layer
    * @return
    */
    List<Layer> getListLayer(Layer layer);
    
    /**
     * 기본 사용 레이어 목록 
     * @return
     */
    List<String> getListDefaultDisplayLayer(Layer layer);

    /**
     * Layer 정보 취득
     * @param layerId
     * @return
     */
    Layer getLayer(Long layerId);
}
