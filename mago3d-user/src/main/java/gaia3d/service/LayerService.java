package gaia3d.service;

import java.util.List;

import gaia3d.domain.layer.Layer;

public interface LayerService {

    /**
    * layer 목록
    * @return
    */
    List<Layer> getListLayer(Layer layer);
    
    /**
     * layer 정보 취득
     * @param layerId 레이어 아이디
     * @return
     */
    Layer getLayer(Long layerId);
}
