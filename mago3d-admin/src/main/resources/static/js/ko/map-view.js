/**
 * 지도 객체 생성
 */
var mapViewer = function(policy, layer, versionId) {

    if (!(this instanceof mapViewer)) {
        throw new Error("New 를 통해 생성 하십시오.");
    }
    
    // geoPolicy 정보
    var geoserverDataUrl = policy.geoserverDataUrl;
	var geoserverDataWorkspace = policy.geoserverDataWorkspace;
	var geoserverDataStore = policy.geoserverDataStore;
	var coordinate = policy.layerTargetCoordinate;
	
	// cql_flter값 : versionId가 있을 경우 해당 버전 보여주고 없을경우 현재 활성화된 레이어 보여줌 
	var layerKey = layer.layerKey;
	var layerInsertType = layer.layerInsertType;
	var queryString = (versionId > 0) ? "version_id='" + versionId + "'" :"enable_yn='Y'";
	var layerName = geoserverDataWorkspace + ":" + layerKey;
	var layerParam = {
			'VERSION' : '1.1.1',
			tiled: true,
            srs: coordinate,
            layers: [layerName]
	};
	
	// 사용자가 업로드한 레이어일 경우에만 필터 적용 
	if(layerInsertType ==='upload') layerParam.CQL_FILTER = queryString;
	
 	// 요청 레이어의 bbox 구하기 
	var url = geoserverDataUrl + "/wms?request=GetCapabilities&service=WMS&version=1.1.1";
	var parser = new ol.format.WMSCapabilities();
	$.ajax(url).then(function(response) {
	    var result = parser.read(response);
	    var Layers = result.Capability.Layer.Layer; 
	    for (var i=0, len = Layers.length; i<len; i++) {
	        var layerobj = Layers[i];
	        if (layerobj.Name === layerName) {
	        	var extent = layerobj.BoundingBox[0].extent;
	        	break;
        	}
        }
	    
	    // 배경 지도는 임시로 OSM으로. 
	    var layers = [
//			new ol.layer.Tile({ 
//				source: new ol.source.OSM()
//			}),
			
     		new ol.layer.Image({
     			id: layerKey,
     			visible: true,
     			source: new ol.source.ImageWMS({
     				url: geoserverDataUrl + '/' + geoserverDataWorkspace + '/wms',
     				params: layerParam
     			})
     		})
		];
	    
	    var proj = new ol.proj.Projection({
	        code: coordinate,
	        units: 'm',
	        global: false,
	        extent: extent
	    });
	    
	    var view = new ol.View({
	        zoom: 1,
	        maxZoom: 20,
	        center : ol.extent.getCenter(extent),
	        projection : proj
	    });
	    
	    var map = new ol.Map({
             layers: layers,
             target: 'map',
             view : view
        });
	    
	    // 레이어 영역으로 위치 이동 
//	    var x1y1 = ol.proj.fromLonLat([extent[0],extent[1]]);
//	    var x2y2 = ol.proj.fromLonLat([extent[2],extent[3]]);
//	    var tranxformExtent = [x1y1[0], x1y1[1], x2y2[0], x2y2[1]];
//	    map.getView().fit(tranxformExtent, map.getSize());
     });
};
