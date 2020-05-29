var Simulation = function(magoInstance) {
	var that = this;
	var CAMERA_MOVE_NEED_DISTANCE = 5000;
	
	var $reportBtn = $('#solarAnalysis .report');
	var magoManager = magoInstance.getMagoManager();
	if(!magoManager.speechBubble) {
		magoManager.speechBubble = new Mago3D.SpeechBubble();
	}
	
	magoManager.on(Mago3D.MagoManager.EVENT_TYPE.SMARTTILELOADEND, smartTileLoaEndCallbak);
	magoManager.on(Mago3D.MagoManager.EVENT_TYPE.F4DLOADEND, echoLoadEndCallback);
	var observer;
	var observerTarget = document.getElementById('simulationContent');
	var observerConfig = { attributes: true};
	
	
	var datepicker = new tui.DatePicker('#solayDatePicker', {
        date: new Date(),
        input: {
            element: '#datepicker-input',
            format: 'yyyy-MM-dd'
        }
    });
	
	// 일조분석 리포트 다이얼 로그
	var simulSolarDialog = $( "#simulSolarDialog" ).dialog({
		autoOpen: false,
		width: 500,
		height: 240,
		modal: true,
		overflow : "auto",
		resizable: false
	});
	
	var solarDefaultTime = [12,15,12,9];

	var timeSlider;
	var solarMode = false;
	//일조분석 조회
	$('#solarAnalysis .execute').click(function(){
		if(!timeSlider) {
			timeSlider = new KotSlider('timeInput');
			timeSlider.setMin(1);
			timeSlider.setMax(24);
			timeSlider.setDuration(200);
			var html = '';
			for(var i=1;i<25;i++){
				if(i === 1 || 1 === 10) {
					html += '<span style="margin-left:22px;">' + i + '</span>';
				} else if(i < 10) {
					html += '<span style="margin-left:27px;">' + i + '</span>';
				} else {
					html += '<span style="margin-left:19px;">' + i + '</span>';
				}
			}
			
			$('#saRange .rangeWrapChild.legend').html(html);
			$('#saRange .rangeWrapChild.legend').on('click','span',function(){
				timeSlider.setValue(parseInt($(this).index())+1);
			});
		}
		
		var currentHour = new Date().getHours();
		currentHour  = currentHour === 0 ? 24 : currentHour;
		timeSlider.setValue(currentHour);
		
		//레인지 보이기
		$('#saRange').show();
		$('#csRange').hide();
		
		magoInstance.getViewer().scene.globe.enableLighting = true;
		magoManager.sceneState.setApplySunShadows(true);
		
		$('#shadowDisplayY').prop('checked',true);
		$reportBtn.show();
		solarMode = true;
		
		changeDateTime();
	});
	
	//경관 분석 위치지정
	$('#solarAnalysis .drawObserverPoint').click(function(){
		var $this = $(this);
		if(!solarMode) {
			alert(JS_MESSAGE["simulation.analysis.start"]);
			return;
		}
		magoManager.once(Mago3D.MagoManager.EVENT_TYPE.CLICK, function(e){
			deleteSolarMark();
			if(solarMode) {
				var geoCoord = e.clickCoordinate.geographicCoordinate;
				$this.siblings('input').val(geoCoord.longitude.toFixed(4) + ' , ' + geoCoord.latitude.toFixed(4));
				var sb = magoManager.speechBubble;
				
				var options = {
					positionWC    : e.clickCoordinate.worldCoordinate,
					imageFilePath : sb.getPng([64,40],'#D9E364', {
						text : '일조 분석',
						pixel : 12,
						color : 'black',
						borderColor : 'white'
					})
				};
				var om = magoManager.objMarkerManager.newObjectMarker(options, magoManager);
				om.solarAnalysis = true;
				
				magoManager.flyTo(geoCoord.longitude, geoCoord.latitude, 300, 2);
			}
		});
	});
	
	$reportBtn.click(function() {
		var filtered = magoManager.objMarkerManager.objectMarkerArray.filter(function(om){
			return om.solarAnalysis;
		});
		
		if(filtered.length !== 1) {
			alert(JS_MESSAGE["simulation.select.location"]);
			return;
		}
		var om = filtered[0];
		simulSolarDialog.dialog('open');
		var geoCoord = om.geoLocationData.geographicCoord;
		var ratio = geoCoord.altitude / 100;
		
		$('#simulSolarDialog tbody td').each(function(idx,elem){
			var dTime = solarDefaultTime[idx] * ratio / 2;
			dTime = dTime.toFixed(2);
			$(elem).text(dTime);
		});
	})
	
	//경관 분석 취소
	$('#solarAnalysis .reset').click(function(){
		setDate(new Date());
		$('#saRange').hide();
		$reportBtn.hide();
		deleteSolarMark();
		$('#solarAnalysis .drawObserverPoint').siblings('input').val('');
		magoInstance.getViewer().scene.globe.enableLighting = false;
	});

	datepicker.on('change', function() {
		changeDateTime();
	});
	
	//회전 변경 range 조절
	$('#timeInput').on('input change',function(){
		changeDateTime();
	});
	
	var changeDateTime = function() {
		var date = datepicker.getDate();
		var hours = $('#timeInput').val();
		date.setHours(hours);
		setDate(date);
	}
	
	var setDate = function(date){
		var jd = Cesium.JulianDate.fromDate(date, jd);
		magoInstance.getViewer().clock.currentTime = jd;
		magoManager.sceneState.sunSystem.setDate(date);
	}
	var deleteSolarMark = function(){
		var filtered = magoManager.objMarkerManager.objectMarkerArray.filter(function(om){
			return !om.solarAnalysis;
		});
		magoManager.objMarkerManager.objectMarkerArray = filtered;
	}
	
	var cache = {};
	var SEJONG_TILE_NAME = 'SEJONG_TILE';
	var SEJONG_POSITION = new Cesium.Cartesian3(-3108649.1049808883, 4086368.566202183, 3773910.6726226895);
	var SEJONG_ROTATION = {heading : 0, pitch : -90, roll:0};
	var ECHO_DATA_NAME = 'busan';
	var ECHO_POSITION = new Cesium.Cartesian3(-3281184.6256381427, 4064587.5919688237, 3647565.7181758513);
	var ECHO_ROTATION = {heading : 0, pitch : -45, roll:0};
	var slider;
	var simulatingSejong = false;
	var simulatingEcho = false;
	//zBounceSpring zBounceLinear
	//건설공정 조회
	$('#constructionProcess .execute').click(function(){
		var targetArea = $('input[name="cpProtoArea"]:checked').val();
		
		if(!slider) {
			slider = new KotSlider('rangeInput');
		}
		
		var dataName;
		var initPosition;
		var initRotation;
		if(targetArea === 's') {
			dataName = SEJONG_TILE_NAME;
			initPosition = SEJONG_POSITION;
			initRotation = SEJONG_ROTATION;
			
			simulatingSejong = true;
			simulatingEcho = false;
			
			slider.setDuration(1000);
			$('#constructionProcess .profileInfo').show();
		} else {
			dataName = ECHO_DATA_NAME;
			initPosition = ECHO_POSITION;
			initRotation = ECHO_ROTATION;
			
			simulatingSejong = false;
			simulatingEcho = true;
			
			slider.setDuration(2500);
			$('#constructionProcess .profileInfo').hide();
		}
		
		//레인지,  보이기
		$('#csRange').show();
		$('#saRange').hide();
		slider.setValue(0);
		if(!cache['doSimul']) {
			//if(dataName.indexOf('_TILE') > 0) {
			var html = '';
			html += '<span>1단계</span>';
			html += '<span>2단계</span>';
			html += '<span>3단계</span>';
			html += '<span>4단계</span>';
			html += '<span>5단계</span>';
			html += '<span>6단계</span>';
			
			$('#csRange .rangeWrapChild.legend').html(html);
			$('#csRange .rangeWrapChild.legend').on('click','span',function(){
				slider.setValue($(this).index());
			});
			//}
		}
		
		var dis = Math.abs(Cesium.Cartesian3.distance(initPosition, MAGO3D_INSTANCE.getViewer().camera.position));
		if(dis > CAMERA_MOVE_NEED_DISTANCE) {
			magoInstance.getViewer().camera.flyTo({
				destination:initPosition,
				orientation:{
					heading : Cesium.Math.toRadians(initRotation.heading),
					pitch   : Cesium.Math.toRadians(initRotation.pitch),
					roll    : Cesium.Math.toRadians(initRotation.roll)
				},
				duration : 1
			});
		}
		setObserver();
	});
	
	//건설공정 취소
	$('#constructionProcess .reset').click(function(){
		constructionProcessReset();
	});
	function echoLoadEndCallback(evt){
		var f4ds = evt.f4d;
		for(var i in f4ds) {
			var f4d = f4ds[i];
			if(!f4d.data.attributes.simulation) {
				continue;
			}
			
			var node = magoManager.hierarchyManager.getNodeByDataKey(f4d.data.projectId, f4d.data.nodeId);
			var data = node.data;
			magoManager.effectsManager.addEffect(data.nodeId, new Mago3D.Effect({
				//effectType      : pitch > 0 ? "zBounceLinear":"zBounceSpring",
				effectType      : "zBounceSpring",
				durationSeconds : 1.8
			}));
			magoManager.effectsManager.addEffect(data.nodeId, new Mago3D.Effect({
				effectType      : "borningLight",
				durationSeconds : 2.4
			}));
			
			node.setRenderCondition(function(data){
				var attributes = data.attributes; 
				if(!simulatingEcho) {
					if(data.simulating) {
						data.simulating = false;
						attributes.isVisible = true;
						data.isColorChanged = false;
					}
				} else {
					data.simulating = true;
					var sliderValue = slider.getValue();
					
					var dataId = data.nodeId;
					var splitDataId = dataId.split('_');
					var refNum = splitDataId[splitDataId.length-1]; 
					var specify = refNum % 6;
					
					if(sliderValue >= specify) {
						attributes.isVisible = true;
					} else {
						attributes.isVisible = false;
						if(!magoManager.effectsManager.hasEffects(dataId)) {
							magoManager.effectsManager.addEffect(dataId, new Mago3D.Effect({
								//effectType      : pitch > 0 ? "zBounceLinear":"zBounceSpring",
								effectType      : "zBounceSpring",
								durationSeconds : 1.8
							}));
							magoManager.effectsManager.addEffect(dataId, new Mago3D.Effect({
								effectType      : 'borningLight',
								durationSeconds : 2.4
							}));
						}
					}
				}
			});
		}
	}
	
	function smartTileLoaEndCallbak(evt){
		var nodes = evt.tile.nodesArray;
		for(var i in nodes){
			var node = nodes[i];
			var data = node.data;
			var projectFolderName = data.projectFolderName.toLowerCase();
			
			if(projectFolderName.indexOf('sejong') < 0) {
				return;
			}
			
			if(!cache[node.data.nodeId]) {
				cache[node.data.nodeId] = true;
			}else {
				return;
			}
			/**
			 * TODO: 스마트타일링 이슈
			 * 세종시 스마트타일링 데이터 높이값 보정 코드.
			 * 문제 : 노드가 로드 완료된 시점에서 처리하려하는데 해당 시점에는 bbox와 geoLocationDataManager가 존재하지 않음
			 * 해결 : 일단 억지로 끼워 넣음.
			 * 추후 목표 : 강제로 데이터 로드시 해당 부분을 미리 생성하는 옵션을 추가, 원래는 데이터가 표출될 때 처리되는 부분.
			 */
			/*var metaData = data.neoBuilding.metaData;
			if (metaData.fileLoadState === Mago3D.CODE.fileLoadState.LOADING_FINISHED) 
			{
				var auxBytesReaded = 0;
				data.neoBuilding.parseHeader(data.neoBuilding.headerDataArrayBuffer, auxBytesReaded);

			}
			if(!data.geoLocDataManager) {
				data.geoLocDataManager = new Mago3D.GeoLocationDataManager();
				data.geoLocDataManager.newGeoLocationData("deploymentLoc");
			}

			var bbox = data.neoBuilding.bbox;
			data.bbox = bbox;
			// 여기까지.
			
			var rotDeg = data.rotationsDegree;
			var pitch = rotDeg.x;
			var heading = rotDeg.z;
			var roll = rotDeg.y;
			var geo = data.geographicCoord;
			
			var offset;
			if(pitch > 0 ){
				 offset = bbox.getYLength() / 2;
			} else {
				offset = bbox.getZLength() / 2;
			}
			var newHeight = offset + geo.altitude;
			
			node.changeLocationAndRotation(geo.latitude, geo.longitude, newHeight, heading, pitch, roll,magoManager);*/
			
			magoManager.effectsManager.addEffect(data.nodeId, new Mago3D.Effect({
				//effectType      : pitch > 0 ? "zBounceLinear":"zBounceSpring",
				effectType      : "zBounceSpring",
				durationSeconds : 0.4
			}));
			magoManager.effectsManager.addEffect(data.nodeId, new Mago3D.Effect({
				effectType      : "borningLight",
				durationSeconds : 0.6
			}));
			
			node.setRenderCondition(function(data){
				var attributes = data.attributes; 
				if(!simulatingSejong) {
					if(data.simulating) {
						data.simulating = false;
						attributes.isVisible = true;
						data.isColorChanged = false;
					}
				} else {
					data.simulating = true;
					var sliderValue = slider.getValue();
					
					var dataId =data.nodeId;
					var refNum = parseInt(dataId.split('_')[2]);
					var specify = refNum % 6;
					
					if(sliderValue >= specify) {
						attributes.isVisible = true;
						
						if(data.currentLod < 4) {
							data.isColorChanged = false;
						} else {
							data.isColorChanged = true;
							if(!data.aditionalColor) {
								data.aditionalColor = new Mago3D.Color();
								
								switch(specify) {
									case 0 : data.aditionalColor.setRGB(230/255,8/255,0);break; 
									case 1 : data.aditionalColor.setRGB(255/255,100/255,28/255);break;
									case 2 : data.aditionalColor.setRGB(141/255,30/255,77/255);break;
									case 3 : data.aditionalColor.setRGB(125/255,44/255,121/255);break;
									case 4 : data.aditionalColor.setRGB(255/255,208/255,9/255);break;
									case 5 : data.aditionalColor.setRGB(0,169/255,182/255);break;
								}
							}
						}
					} else {
						attributes.isVisible = false;
						if(!magoManager.effectsManager.hasEffects(dataId)) {
							magoManager.effectsManager.addEffect(dataId, new Mago3D.Effect({
								//effectType      : pitch > 0 ? "zBounceLinear":"zBounceSpring",
								effectType      : "zBounceSpring",
								durationSeconds : 0.4
							}));
							magoManager.effectsManager.addEffect(dataId, new Mago3D.Effect({
								effectType      : 'borningLight',
								durationSeconds : 0.6
							}));
						}
					}
				}
			})
		}
	}
	var setObserver = function(){
		if(!observer) {
			observer = new MutationObserver(function(mutations) {
				var mutation = mutations[0];
				var display = mutation.target.style.display;
				if(display === 'none') {
					constructionProcessReset();
					this.disconnect();
				}
			});
		}
		observer.observe(observerTarget, observerConfig);
	}
	var constructionProcessReset = function() {
		simulatingSejong = false;
		simulatingEcho = false;
		//레인지, 레전드 끄기
		$('#csRange, #constructionProcess .profileInfo').hide();
	}
}