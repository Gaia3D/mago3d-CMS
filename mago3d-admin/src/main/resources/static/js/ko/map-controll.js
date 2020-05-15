var lengthInMeters = 0;
var areaInMeters = 0;

function MapControll(viewer, option) {
    this._viewer = viewer;
    this._scene = viewer.scene;

    //viewer.scene.globe.depthTestAgainstTerrain = true;
    viewer.cesiumWidget.screenSpaceEventHandler.removeInputAction(Cesium.ScreenSpaceEventType.LEFT_DOUBLE_CLICK);

    this._polylines = [];
    this._labels = [];   

    var that = this;
    var handler = null;

    var drawingMode = 'line';
    var activeShapePoints = [];
    var activeShape;
    var activeLabel;

    /**
	 * 나침반 동작
	 */
    viewer.scene.postRender.addEventListener(function () {
        var camera = this._viewer.camera;
        var angle = Cesium.Math.toDegrees(camera.heading);
        if (angle > 359.9 || angle < .1) {
            $("#rotateReset").addClass('on');
            $("#rotateReset").css({
                '-webkit-transform': 'rotate(0)',
                '-moz-transform': 'rotate(0)',
                '-ms-transform': 'rotate(0)',
                'transform': 'rotate(0)'
            });
        }
        else {
            $("#rotateReset").removeClass('on');
            $("#rotateReset").css({
                '-webkit-transform': 'rotate(' + -angle + 'deg)',
                '-moz-transform': 'rotate(' + -angle + 'deg)',
                '-ms-transform': 'rotate(' + -angle + 'deg)',
                'transform': 'rotate(' + -angle + 'deg)'
            });
        }
    });
    

    function createPoint(worldPosition) {
        var entity = viewer.entities.add({
            position: worldPosition,
            point: {
                color: Cesium.Color.YELLOW,
                pixelSize: 5,
                outlineColor: Cesium.Color.BLACK,
                outlineWidth: 2,
                disableDepthTestDistance: Number.POSITIVE_INFINITY,
                heightReference: Cesium.HeightReference.CLAMP_TO_GROUND
            }
        });
        return entity;
    }

    var dynamicCenter = new Cesium.CallbackProperty(function () {
        var bs = Cesium.BoundingSphere.fromPoints(activeShapePoints);
        return Cesium.Ellipsoid.WGS84.scaleToGeodeticSurface(bs.center);
    }, false);

    var dynamicLabel = new Cesium.CallbackProperty(function () {
        return getArea(activeShapePoints);
    }, false);

    function drawShape(positionData) {
        var shape;
        if (drawingMode === 'line') {
            shape = viewer.entities.add({
                corridor: {
                    // polyline: {
                    positions: positionData,
                    material: new Cesium.ColorMaterialProperty(Cesium.Color.YELLOW),
                    //heightReference: Cesium.HeightReference.CLAMP_TO_GROUND,
                    // followSurface: true,
                    // clampToGround : true,
                    width: 3
                }
            });
        }
        else if (drawingMode === 'polygon') {
            shape = viewer.entities.add({
                name     : "Polygon for area measurement",
                polygon: {
                    hierarchy: positionData,
                    material: new Cesium.ColorMaterialProperty(Cesium.Color.YELLOW.withAlpha(0.3)),
                    /* height: 0.1, */
                    //heightReference: Cesium.HeightReference.CLAMP_TO_GROUND
                }
            });
        }
        return shape;
    }

    // use scratch object to avoid new allocations per frame.
    var startCartographic = new Cesium.Cartographic();
    var endCartographic = new Cesium.Cartographic();
    var scratch = new Cesium.Cartographic();
    var geodesic = new Cesium.EllipsoidGeodesic();

    function getLineLength(positions) {
        lengthInMeters = 0;
        for (var i = 1, len = positions.length; i < len; i++) {
            var startPoint = positions[i - 1];
            var endPoint = positions[i];

            lengthInMeters += Cesium.Cartesian3.distance(startPoint, endPoint);
        }
        return formatDistance(lengthInMeters);
    }

    function getArea(positions) {
        areaInMeters = 0;
        if (positions.length >= 3)
        {
            var points = [];
            for(var i = 0, len = positions.length; i < len; i++)
            {
                // points.push(Cesium.Cartesian2.fromCartesian3(positions[i]));
                var cartographic = Cesium.Cartographic.fromCartesian(positions[i]);
                points.push(new Cesium.Cartesian2(cartographic.longitude, cartographic.latitude));
            }
            if(Cesium.PolygonPipeline.computeWindingOrder2D(points) === Cesium.WindingOrder.CLOCKWISE)
            {
                points.reverse();
            }

            var triangles = Cesium.PolygonPipeline.triangulate(points);

            for(var i = 0, len = triangles.length; i < len; i+=3)
            {
                // areaInMeters +=
				// Cesium.PolygonPipeline.computeArea2D([points[triangles[i]],
				// points[triangles[i + 1]], points[triangles[i + 2]]]);
                areaInMeters += calArea(points[triangles[i]], points[triangles[i + 1]], points[triangles[i + 2]]);
            }
        }
        return formatArea(areaInMeters);
    }
    function calArea(t1, t2, t3, i) {
        var r = Math.abs(t1.x * (t2.y - t3.y) + t2.x * (t3.y - t1.y) + t3.x * (t1.y - t2.y)) / 2;
		var cartographic = new Cesium.Cartographic((t1.x + t2.x + t3.x) / 3, (t1.y + t2.y + t3.y) / 3);
		var cartesian = viewer.scene.globe.ellipsoid.cartographicToCartesian(cartographic);
        var magnitude = Cesium.Cartesian3.magnitude(cartesian);
        return r * magnitude * magnitude * Math.cos(cartographic.latitude)
    }

    function drawLabel(positionData) {
        var label;
        // if (drawingMode === 'line') {
            label = viewer.entities.add({
                position: positionData,
                label: {
                    text: getLineLength(activeShapePoints),
                    font: 'bold 20px sans-serif',
                    fillColor: Cesium.Color.YELLOW,
                    style: Cesium.LabelStyle.FILL,
                    verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
                    disableDepthTestDistance: Number.POSITIVE_INFINITY,
                    heightReference: Cesium.HeightReference.CLAMP_TO_GROUND/*
																			 * ,
																			 * pixelOffset :
																			 * new
																			 * Cesium.Cartesian2(5,
																			 * 20)
																			 */
                }
            });
        // }
        return label;
    }

    function drawAreaLabel() {
        var label;
        var bs = Cesium.BoundingSphere.fromPoints(activeShapePoints);
        var position = Cesium.Ellipsoid.WGS84.scaleToGeodeticSurface(bs.center);
        var text = getArea(activeShapePoints);

        label = viewer.entities.add({
            name     : "Label for area measurement",
            position: position,
            label: {
                text: text,
                font: 'bold 20px sans-serif',
                fillColor: Cesium.Color.BLUE,
                style: Cesium.LabelStyle.FILL,
                verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
                disableDepthTestDistance: Number.POSITIVE_INFINITY,
                heightReference: Cesium.HeightReference.CLAMP_TO_GROUND
            }
        });

        return label;
    }

    // Redraw the shape so it's not dynamic and remove the dynamic shape.
    function terminateShape() {
        // activeShapePoints.pop();
        lengthInMeters = 0;
        areaInMeters = 0
        this._polylines.push(drawShape(activeShapePoints));
        if (drawingMode === 'polygon')  this._labels.push(drawAreaLabel());

        viewer.entities.remove(activeShape);
        viewer.entities.remove(activeLabel);
        
        activeShape = undefined;
        activeLabel = undefined;
        activeShapePoints = [];
    }

    this.clearMap = function () {
        lengthInMeters = 0;
        areaInMeters = 0
        if (Cesium.defined(handler)) {
            handler.destroy();
            handler = null;
        }
        for (var i = 0, len = this._polylines.length; i < len; i++) {
            viewer.entities.remove(this._polylines[i]);
        }
        for (var i = 0, len = this._labels.length; i < len; i++) {
            viewer.entities.remove(this._labels[i]);
        }

        viewer.entities.remove(activeShape);
        viewer.entities.remove(activeLabel);

        activeShape = undefined;
        activeLabel = undefined;
        activeShapePoints = [];

        this._polylines = [];
        this._labels = [];
    }
    $("#rotateReset").click(function() {
        var camera = that._scene.camera;
        camera.flyTo({
            destination: camera.positionWC,
            duration : 0
        });

        $(this).css({
            '-webkit-transform': 'rotate(0)',
            '-moz-transform': 'rotate(0)',
            '-ms-transform': 'rotate(0)',
            'transform': 'rotate(0)'
        });
        $('#rotateInput').val(0);
        $('#pitchInput').val(-90);
    });
    
    $('#rotateLeft').click(function(){
    	that._scene.camera.twistLeft(Cesium.Math.toRadians(10));
    	var currentHeading = Math.round(Cesium.Math.toDegrees(viewer.camera.heading));
    	if(currentHeading > 180){
    		currentHeading = currentHeading - 360;
    	}
    	$('#rotateInput').val(currentHeading);
    });
    
    $('#rotateRight').click(function(){
    	that._scene.camera.twistRight(Cesium.Math.toRadians(10));
    	var currentHeading = Math.round(Cesium.Math.toDegrees(viewer.camera.heading));
    	if(currentHeading > 180){
    		currentHeading = currentHeading - 360;
    	}
    	$('#rotateInput').val(currentHeading);
    });
    
    /*
	 * viewer.screenSpaceEventHandler.setInputAction(function
	 * onMouseMove(movement){
	 * console.log(Cesium.Math.toDegrees(viewer.camera.heading)); var
	 * currentHeading = Cesium.Math.toDegrees(viewer.camera.heading);
	 * if(currentHeading > 180){ currentHeading = currentHeading - 360; }
	 * $('#rotateInput').val(currentHeading); },
	 * Cesium.ScreenSpaceEventType.LEFT_UP);
	 * 
	 */
    
    viewer.camera.changed.addEventListener(function() {
    	  var currentHeading = Math.round( Cesium.Math.toDegrees(viewer.camera.heading));
    	  //console.log('Heading:', currentHeading)
    	  
    	  if(currentHeading > 180){
      		currentHeading = currentHeading - 360;
      	}
    	  
      	$('#rotateInput').val(currentHeading);
    	  
    	  
    	  var deg = Math.round( Cesium.Math.toDegrees(viewer.camera.pitch))
    	  //console.log('Pitch:', deg)
    	  
    	 $('#pitchInput').val(deg);
    	  
    });

    $('#mapCtrlReset').click(function () {
        console.log("맵컨트롤 : 초기화");
        that._scene.camera.flyTo({
			destination: Cesium.Cartesian3.fromDegrees(parseFloat(Mago3D.MagoConfig.getPolicy().initLongitude),
				parseFloat(Mago3D.MagoConfig.getPolicy().initLatitude),
				parseFloat(Mago3D.MagoConfig.getPolicy().initAltitude)),
			duration: parseInt(Mago3D.MagoConfig.getPolicy().initDuration)
		});
    });
    
    $('#mapCtrlAll').click(function (){
    	that._scene.camera.flyTo({
			destination: new Cesium.Cartesian3(-3158185.8634899906, 4713784.056940694, 4516771.367915208), //대략적인 한반도 좌표..
			duration: parseInt(Mago3D.MagoConfig.getPolicy().initDuration)
		});
    });
    
    
    // 거리 측정 버튼
	$('#mapCtrlDistance').click(function() {
		$(this).toggleClass('on'); // 버튼 색 변경
		$('#mapCtrlArea').removeClass('on');
		$(this).trigger('afterClick');
	});

    $('#mapCtrlDistance').bind('afterClick', function () {
        console.log("맵컨트롤 : 거리");
        that.clearMap();
        drawingMode = 'line';
        
        if ($(this).hasClass('on')) {
            startDrawPolyLine();
        }
    });
    
    
    // 	면적 측정 버튼
	$('#mapCtrlArea').click(function() {
		$(this).toggleClass('on'); // 버튼 색 변경
		$('#mapCtrlDistance').removeClass('on');
		$(this).trigger('afterClick');
	});

    $('#mapCtrlArea').bind('afterClick', function () {
        console.log("맵컨트롤 : 면적");
        that.clearMap();
        drawingMode = 'polygon';

        if ($(this).hasClass('on')) {
            startDrawPolyLine();
        }
    });
    
    $('#mapCapture').click(function() {
    	// console.log("맵컨트롤 : 저장");
        var targetResolutionScale = 1.0;
        var timeout = 1000; // in ms

        var scene =that._scene;
        if (!scene) {
            console.error("No scene");
        }

        // define callback functions
        var prepareScreenshot = function(){
            var canvas = scene.canvas;
            viewer.resolutionScale = targetResolutionScale;
            scene.preRender.removeEventListener(prepareScreenshot);
            // take snapshot after defined timeout to allow scene update (ie. loading data)
            startLoading();
            setTimeout(function(){
                scene.postRender.addEventListener(takeScreenshot);
            }, timeout);
        }

        var takeScreenshot = function(){
            scene.postRender.removeEventListener(takeScreenshot);
            var canvas = scene.canvas;
            canvas.toBlob(function(blob){
                var url = URL.createObjectURL(blob);
                downloadURI(url, "snapshot-" + moment().format("YYYYMMDDHHmmss") + ".png");
                // reset resolutionScale
                viewer.resolutionScale = 1.0;
                stopLoading();
            });
        }

        scene.preRender.addEventListener(prepareScreenshot);
    });
    
    function downloadURI(uri, name) {
        var link = document.createElement("a");
        link.download = name;
        link.href = uri;
        // mimic click on "download button"
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
        delete link;
    }
    
    $('#mapCtrlZoomIn').click(function () {
        console.log("맵컨트롤 : 확대");
        var altitude = getCameraCurrentPositionAPI(MAGO3D_INSTANCE).alt;
        that._scene.camera.zoomIn(altitude * 0.1);
    });

    $('#mapCtrlZoomOut').click(function () {
        console.log("맵컨트롤 : 축소");
        var altitude = getCameraCurrentPositionAPI(MAGO3D_INSTANCE).alt;
        that._scene.camera.zoomOut(altitude * 0.1);
    });

    $('#distanceLayer button.focusA').click(function () {
        that.clearMap();
        $('#mapCtrlDistance').trigger('afterClick');
    });

    $('#areaLayer button.focusA').click(function () {
        that.clearMap();
        $('#mapCtrlArea').trigger('afterClick');
    });

    function startDrawPolyLine() {
        handler = new Cesium.ScreenSpaceEventHandler(viewer.canvas);
        var dynamicPositions = new Cesium.CallbackProperty(function () {
            return new Cesium.PolygonHierarchy(activeShapePoints);
        }, false);
        
        handler.setInputAction(function (event) {
            var earthPosition = viewer.scene.pickPosition(event.position);
            if (Cesium.defined(earthPosition)) {
                var cartographic = Cesium.Cartographic.fromCartesian(earthPosition);
                var tempPosition = Cesium.Cartesian3.fromDegrees(Cesium.Math.toDegrees(cartographic.longitude), Cesium.Math.toDegrees(cartographic.latitude));
                activeShapePoints.push(tempPosition);
                
                if (activeShapePoints.length === 1) {
                    activeShape = drawShape(dynamicPositions);
                    if (drawingMode === 'polygon') {
	                    activeLabel = viewer.entities.add({
	                        name     : "TempLabel for area measurement",
	                        position: dynamicCenter,
	                        label: {
	                            text: dynamicLabel,
	                            font: 'bold 20px sans-serif',
	                            fillColor: Cesium.Color.BLUE,
	                            style: Cesium.LabelStyle.FILL,
	                            verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
	                            disableDepthTestDistance: Number.POSITIVE_INFINITY,
	                            heightReference: Cesium.HeightReference.CLAMP_TO_GROUND
	                        }
	                    });
                    }
                }
                else {
                    this._labels.push(drawLabel(tempPosition));
                }
                this._polylines.push(createPoint(tempPosition));
            }
        }, Cesium.ScreenSpaceEventType.LEFT_CLICK);

        handler.setInputAction(function (event) {
            terminateShape();
        }, Cesium.ScreenSpaceEventType.RIGHT_CLICK);

    }
}

var formatDistance = function (_length) {
    var unitFactor = 1;//parseFloat($('#distanceFactor option:selected').val());
    var unitName = 'm (미터)';//$('#distanceFactor option:selected').text();
    var output= Math.round(_length / unitFactor * 100) / 100 + " " + unitName.substring(0, unitName.indexOf('('));
    return output;
};

var formatArea = function (_area) {
    var unitFactor = 1;//parseFloat($('#areaFactor option:selected').val());
    var unitName = 'm² (제곱미터)' //$('#areaFactor option:selected').text();
    var output= Math.round(_area / unitFactor * 100) / 100 + " " + unitName.substring(0, unitName.indexOf('('));
    return output;
};

$("#mapPolicy").click(function(){
	$("#mapPolicy").addClass("on");
	$(".labelLayer").show();
});
$(".layerClose").click(function(){
	$("#mapPolicy").removeClass("on");
	$(".labelLayer").hide();
});