/**
 * 레이어 관련 기능
 * @param magoInstance
 * @param baseLayers
 * @param policy
 * @returns
 */
function mapInit(magoInstance, baseLayers, policy) {
	if(!(this instanceof mapInit)) {
        throw new Error(JS_MESSAGE["layer.init"]);
    }
	
	var WMS_LAYER = 'wmsLayer';
	var DISTRICT_LAYER = 'district';
	var viewer = magoInstance.getViewer();
	var imageryLayers = viewer.imageryLayers;
	var dataSources = viewer.dataSources;
	var geoserverDataUrl = policy.geoserverDataUrl;
	var geoserverDataWorkspace = policy.geoserverDataWorkspace;
	// 레이어 리스트를 맵 형태로 저장 
	var layerMap = [];
	// 레이어 리스트
	var sortedLayer = [];
	for(var i=0; i < baseLayers.length; i++) {
		var layerList = baseLayers[i].layerList;
		var layerLength = layerList.length;
		for(var j=0; j < layerLength; j++) {
			sortedLayer.push(layerList[j]);
		}
	}
	
	// 레이어 리스트를 zindex 기준으로 오름 차순 정렬 
	sortedLayer.sort(function(a, b) { 
	    return a.zindex- b.zindex
	});
	
	// basemap 이 n개 이므로 basemap length 확인해서 레이어 추가/삭제 시 target index로 사용
	var baseMapLength = imageryLayers._layers.filter(function(f){
		return f.baseMapName;
	}).length;
	
	/**
	 * wms layer init
	 */
	var initWMSLayer = function(layerList) {
		var preLayer = getImageryLayerById(WMS_LAYER);
		if(preLayer) imageryLayers.remove(preLayer);
		if(layerList.length ===0) return; 
		
		var queryString = "enable_yn='Y'";
	    var queryStrings = layerList.map(function(){ return queryString; }).join(';');	// map: ie9부터 지원
		var provider = new Cesium.WebMapServiceImageryProvider({
	        url : geoserverDataUrl + "/wms",
	        layers : layerList.map(function(e){return geoserverDataWorkspace + ':'+e}).join(','),
	        minimumLevel:2,
	        maximumLevel : 20,
	        parameters : {
	            service : 'WMS'
	            ,version : '1.1.1'
	            ,request : 'GetMap'
	            ,transparent : 'true'
	            ,format : 'image/png'
	            ,time : 'P2Y/PRESENT'
//	            ,maxZoom : 25
//	            ,maxNativeZoom : 23
	            ,CQL_FILTER: queryStrings
	        },
	        enablePickFeatures : false
	    });
	    
		var layer = viewer.imageryLayers.addImageryProvider(provider);
		layer.id = WMS_LAYER;
	};
	
	/**
	 * wms 레이어 추가  
	 */
	var addWMSLayer = function(layerKey) {
		if(getWMSLayerExists(layerKey)) return;
		var layerList = null;
		if(getWMSLayers()) {
			layerList = getWMSLayers().split(",");
			var targetIndex = 0;
			// zindex에 따라 정렬 
			for(var i=0; i < layerList.length; i++) {
				var currnetLayerIndex = layerMap[layerList[i]].zindex;
				if(currnetLayerIndex <= layerMap[layerKey].zindex) {
					targetIndex = i+1;
				}
			}
			layerList.splice(targetIndex, 0, layerKey);
		} else {
			layerList = [layerKey];
		}
		
		initWMSLayer(layerList);
	};
	
	/**
	 * wfs 레이어 추가
	 */
	var addWFSLayer = function(layerKey) {
		if(getDataSourceById(layerKey)) return;
		
		var geoJson = geoserverDataUrl+ "/" + geoserverDataWorkspace + "/" + "/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=" +
//				geoserverDataWorkspace + ":" + layerKey + "&maxFeatures=200&outputFormat=application/json";
				geoserverDataWorkspace + ":" + layerKey + "&outputFormat=application/json";
		var promise = Cesium.GeoJsonDataSource.load(geoJson, {
			//TODO terrain 사용시 외곽선 disable 되는거 처리 해야함. wfs도 zindex를 적용해야 하는데 add 메서드에 index주는게 없음.
			stroke: Cesium.Color.fromCssColorString(layerMap[layerKey].layerLineColor),
	        fill: Cesium.Color.fromCssColorString(layerMap[layerKey].layerFillColor).withAlpha(layerMap[layerKey].layerAlphaStyle),
	        strokeWidth: layerMap[layerKey].layerLineStyle,
	        clampToGround: true
		});
		promise.then(function(wfsLayer) {
			wfsLayer.id = layerKey;
	        dataSources.add(wfsLayer);
	    }).otherwise(function(error){
	        //Display any errrors encountered while loading.
	        alert(error);
	    });
	};
	
	/**
	 * tile 레이어 추가
	 */
	var addTileLayer = function(layerKey) {
		if(getImageryLayerById(layerKey)) return;
		
		var provider = new Cesium.WebMapServiceImageryProvider({
	        url : geoserverDataUrl + "/gwc/service/wms",
	        layers : [geoserverDataWorkspace + ':'+layerKey],
	        minimumLevel:2,
	        maximumLevel : 20,
	        parameters : {
	            service : 'WMS'
	            ,version : '1.1.1'
	            ,request : 'GetMap'
	            ,transparent : 'true'
	            ,format : 'image/png'
	            ,time : 'P2Y/PRESENT',
//	            ,maxZoom : 25
//	            ,maxNativeZoom : 23,
	            tiled : true
	        }
	    });
		
		var targetIndex = baseMapLength;
		for(var i=0; i < imageryLayers.length; i++) {
			var layer = imageryLayers.get(i);
			var currnetLayerId = layer.id;
			// zindex에 따라 정렬 . wmsLayer, district(행정구역이동 provider)는 provider 하나씩 생성하므로 인덱스 정렬 대상에서 제외.   
			if(currnetLayerId && currnetLayerId !== WMS_LAYER && currnetLayerId !== DISTRICT_LAYER) {
				if(layerMap[currnetLayerId].zindex <= layerMap[layerKey].zindex) {
					targetIndex = i+1;
				}
			}
		}
		
		var addedLayer = new Cesium.ImageryLayer(provider, {minimumTerrainLevel:5});
		addedLayer.id = layerKey;
		viewer.imageryLayers.add(addedLayer, targetIndex);
		
		//var addedLayer = viewer.imageryLayers.addImageryProvider(provider, targetIndex);
	};
	
	/**
	 * wms 레이어 제거
	 */
	var removeWMSLayer = function(layerKey) {
		var layerList = getWMSLayers().split(",");
		for(var i=0; i < layerList.length;i++) {
			if(layerKey === layerList[i]) {
				layerList.splice(i,1);
			}
		}
		
		initWMSLayer(layerList);
	};
	
	/**
	 * wfs 레이어 제거 
	 */
	var removeWFSLayer = function(layerKey) {
		var layer = getDataSourceById(layerKey);
		dataSources.remove(layer);
	};
	
	/**
	 * tile 레이어 제거 
	 */
	var removeTileLayer = function(layerKey) {
		var layer = getImageryLayerById(layerKey);
		imageryLayers.remove(layer);
	};
	
	/*
	 * wms layer string 리턴 
	 */
	var getWMSLayers = function() {
		var layer = getImageryLayerById(WMS_LAYER);
		var layerList = "";
		if(layer) {
			layerList = layer._imageryProvider.layers;
			return layerList.split(geoserverDataWorkspace+":").join(""); 
		} else {
			return layerList;
		}
	};
	
	/**
	 * wms layer string이 있는지 확인 
	 */
	var getWMSLayerExists = function(layerKey) {
		var layerList  = getWMSLayers().split(",");
		var flag = false;
		for(var i=0; i < layerList.length; i++) {
			if(layerList[i] === layerKey) {
				flag = true;
			}
		}
		
		return flag;
	};
	
	/**
	 * layerKey에 해당하는 imageryLayer 객체를 리턴 
	 */
	var getImageryLayerById = function(layerKey) {
		var layer = null;
		var length = imageryLayers.length;
		for(var i=0; i < length; i++) {
			var id = imageryLayers.get(i).id;
			if(!id) continue;
			if(imageryLayers.get(i).id === layerKey){
	            layer = imageryLayers.get(i);
	            break;
	        }
		}
		
		return layer;
	};
	
	/**
	 * layerKey에 해당하는 dataSources 객체를 리턴
	 */
	var getDataSourceById = function(layerKey) {
		var layer = null;
		var length = dataSources.length;
		for(var i=0; i < length; i++) {
			var id = dataSources.get(i).id;
			if(!id) continue;
			if(dataSources.get(i).id === layerKey){
	            layer = dataSources.get(i);
	            break;
	        }
		}
		
		return layer;
	};
	
		
	return {
		/**
		 * 지도 객체에 baseLaye list를 추가
		 * @param displayFlag {boolean} true일경우에는 모든 레이어 추가, 아닐 경우에는 defaultDiaply true인 레이어만 추가 
		 * @returns
		 */
		initLayer : function(displayFlag) {
			var wmsLayerList = [];
			for(var i=0; i < sortedLayer.length; i++) {
				var ogcWebServices = sortedLayer[i].ogcWebServices;
				var cacheAvailable = sortedLayer[i].cacheAvailable;
				var layerKey = sortedLayer[i].layerKey;
				layerMap[layerKey] = sortedLayer[i];
				// 기본 표시 true일 경우에만 레이어 추가 
				if(!displayFlag && !sortedLayer[i].defaultDisplay) continue;
				if(ogcWebServices ==='wms' && cacheAvailable) {
					addTileLayer(layerKey);
				} else if (ogcWebServices ==='wms' && !cacheAvailable) {
					wmsLayerList.push(layerKey);
				} else if(ogcWebServices ==='wfs') {
					addWFSLayer(layerKey);
				} else {
					alert(ogcWebServices + JS_MESSAGE["layer.not.supported"]);
				}
			}
			
			if(wmsLayerList.length > 0) {
				initWMSLayer(wmsLayerList);
			}
		},
		
		/**
		 * 레이어 추가 
		 */
		addLayer : function(layerKey) {
			var ogcWebServices = layerMap[layerKey].ogcWebServices;
			var cacheAvailable = layerMap[layerKey].cacheAvailable;
			if(ogcWebServices === 'wms' && cacheAvailable) {
				addTileLayer(layerKey);
			} else {
				if(ogcWebServices === 'wms') {
					addWMSLayer(layerKey);
				} else if(ogcWebServices ==='wfs') {
					addWFSLayer(layerKey);
				} else {
					alert(ogcWebServices + JS_MESSAGE["layer.not.supported"]);
				}
			}
		},
		
		/**
		 * 그룹 레이어 추가 
		 */
		addGroupLayer : function(layerGroupId) {
			for(var i=0; i < baseLayers.length; i++) {
				var ancestor = baseLayers[i].ancestor; 
				var layerList = baseLayers[i].layerList;
				var layerLength = layerList.length;
				if(layerGroupId === ancestor && layerLength > 0) {
					for(var j=0; j < layerLength; j++) {
						this.addLayer(layerList[j].layerKey);
					}
					break;
				}
			}
		},
		
		/**
		 * 레이어 삭제
		 */
		removeLayer : function(layerKey) {
			var ogcWebServices = layerMap[layerKey].ogcWebServices;
			var cacheAvailable = layerMap[layerKey].cacheAvailable;
			if(ogcWebServices === 'wms' && cacheAvailable) {
				removeTileLayer(layerKey);
			} else {
				if(ogcWebServices === 'wms') {
					removeWMSLayer(layerKey);
				} else if(ogcWebServices ==='wfs') {
					removeWFSLayer(layerKey);
				} else {
					alert(ogcWebServices + JS_MESSAGE["layer.not.supported"]);
				}
			}
		},
		
		/**
		 * 그룹 레이어 삭제
		 */
		removeGroupLayer : function(layerGroupId) {
			for(var i=0; i < baseLayers.length; i++) {
				var ancestor = baseLayers[i].ancestor; 
				var layerList = baseLayers[i].layerList;
				var layerLength = layerList.length;
				if(layerGroupId === ancestor && layerLength > 0) {
					for(var j=0; j < layerLength; j++) {
						this.removeLayer(layerList[j].layerKey);
					}
					break;
				}
			}
		},
		
		/**
		 * 전체 레이어 삭제
		 */
		removeAllLayers : function() {
			if(imageryLayers.length > 0) {
				// 기본 provider를 제외하고 모두 삭제
				while(imageryLayers.length > baseMapLength) {
					imageryLayers.remove(imageryLayers.get(baseMapLength));
				}
			}
			// wfs 삭제 
			dataSources.removeAll();
		},
		
		getWMSLayers : function() {
			return getWMSLayers();
		},
		
		getImageryLayerById : function(layerKey) {
			return getImageryLayerById(layerKey);
		},
		
		getDataSourceById : function(layerKey) {
			return getDataSourceById(layerKey);
		}
	}
}
