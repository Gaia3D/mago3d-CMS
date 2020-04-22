package mago3d.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import mago3d.domain.Layer;
import mago3d.persistence.LayerMapper;
import mago3d.service.LayerService;

/**
 * 여기서는 Geoserver Rest API 결과를 가지고 파싱 하기 때문에 RestTemplate을 커스트마이징하면 안됨
 * @author Cheon JeongDae
 *
 */
@Service
public class LayerServiceImpl implements LayerService {

    private final LayerMapper layerMapper;
    
    public LayerServiceImpl(LayerMapper layerMapper) {
    	this.layerMapper = layerMapper;
    }
    /**
    * layer 목록
    * @return
    */
    @Transactional(readOnly=true)
    public List<Layer> getListLayer(Layer layer) {
        return layerMapper.getListLayer(layer);
    }
}
