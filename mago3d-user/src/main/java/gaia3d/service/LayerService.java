package gaia3d.service;

import java.util.List;

import gaia3d.domain.Layer;

public interface LayerService {

    /**
    * layer 목록
    * @return
    */
    List<Layer> getListLayer(Layer layer);
    
}
