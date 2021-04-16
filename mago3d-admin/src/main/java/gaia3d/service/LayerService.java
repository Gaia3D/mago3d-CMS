package gaia3d.service;

import java.util.List;
import java.util.Map;

import gaia3d.domain.layer.Layer;
import gaia3d.domain.layer.LayerFileInfo;
import gaia3d.domain.policy.GeoPolicy;

public interface LayerService {

	/**
	 * Layer 총 건수
	 * @param layer
	 * @return
	 */
	Long getLayerTotalCount(Layer layer);
	
    /**
    * layer 목록
    * @return
    */
    List<Layer> getListLayer(Layer layer);
    
    /**
     * geoserver에 등록된 레이어 목록 조회 
     * @return
     */
    String getListGeoserverLayer(GeoPolicy geoPolicy);

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
    * 레이어 테이블의 컬럼 타입이 어떤 geometry 타입인지를 구함
    * @param layerKey
    * @return
    */
    String getGeometryType(String layerKey);

    /**
     * 레이어의 칼럼 목록을 조회 
     * @param layerKey
     * @return
     */
    String getLayerColumn(String layerKey);

    /**
    * 레이어 등록
    * @param layer
    * @return
    */
    Map<String, Object> insertLayer(Layer layer, List<LayerFileInfo> layerFileInfoList);

    /**
    * shape 파일을 이용한 layer 정보 수정
    * @param layer
    * @param isLayerFileInfoExist
    * @param layerFileInfoList
    * @return
    * @throws Exception
    */
    Map<String, Object> updateLayer(Layer layer, boolean isLayerFileInfoExist, List<LayerFileInfo> layerFileInfoList);

    /**
    * Ogr2Ogr 실행
    * @param layer
    * @param isLayerFileInfoExist
    * @param shapeFileName
    * @param shapeEncoding
    * @throws Exception
    */
    void insertOgr2Ogr(Layer layer, boolean isLayerFileInfoExist, String shapeFileName, String shapeEncoding) throws Exception;

    /**
     * shp파일 정보를 db정보를 기준으로 갱신
     * @param layerFileInfo
     * @param layer
     * @throws Exception
     */
    void exportOgr2Ogr(LayerFileInfo layerFileInfo, Layer layer) throws Exception;
    
    /**
    * layer 가 등록 되어 있지 않은 경우 rest api 를 이용해서 layer를 등록
     * @param geoPolicy
     * @param layerKey
     * @throws Exception
     */
    void registerLayer(GeoPolicy geoPolicy, String layerKey) throws Exception;
    
    /**
	 * 레이어의 스타일 정보를 수정
	 * @param layer
	 * @return
	 */
	int updateLayerStyle(Layer layer) throws Exception;

    /**
    * 레이어 롤백 처리
    * @param layer
    * @param isLayerFileInfoExist
    * @param layerFileInfo
    * @param deleteLayerFileInfoTeamId
    */
    void rollbackLayer(Layer layer, boolean isLayerFileInfoExist, LayerFileInfo layerFileInfo, Integer deleteLayerFileInfoTeamId);

    /**
    * layer 를 이 shape 파일로 활성화
    * @param layerId
    * @param deleteLayerFileInfoTeamId
    * @param layerFileInfoId
    * @return
    */
    int updateLayerByLayerFileInfoId(Integer layerId, Integer deleteLayerFileInfoTeamId, Integer layerFileInfoId);

     /**
    * 레이어 삭제
    * @param layerId
    * @return
    */
    int deleteLayer(Integer layerId);
}
