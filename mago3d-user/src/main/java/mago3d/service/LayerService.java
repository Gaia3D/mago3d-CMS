package mago3d.service;

import java.util.List;

import mago3d.domain.Layer;

public interface LayerService {

    /**
    * layer 목록
    * @return
    */
    List<Layer> getListLayer(Layer layer);
    
}
