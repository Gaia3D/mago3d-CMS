var MapDataControll = function(magoInstance) {

	var magoManager = magoInstance.getMagoManager();
	var $dataControlWrap = $('#dataControllWrap');
	var $header = $dataControlWrap.find('.layerDivTit');
	var projectId;
	var dataKey;
	var dataId;
	//지도상에서 데이터 all 선택 시
    magoManager.on(Mago3D.MagoManager.EVENT_TYPE.SELECTEDF4D, function(result) {
    	var f4d = result.f4d;
		if(f4d) {
			clearDataControl();

			var data = f4d.data;
			dataId = data.dataId;
			dataKey = data.nodeId;
			projectId = data.projectId;

			var dataGroupName = NDTP.dataGroup.get(projectId);

			var tempDataName = data.data_name || data.nodeId;
			if(tempDataName.indexOf("F4D_") >= 0) {
				tempDataName = tempDataName.replace("F4D_", "");
			}
			//var title = dataGroupName + ' / ' + (data.data_name || data.nodeId);
			//$header.text(title);
			$header.text(dataGroupName + ' / ' + tempDataName);

			var currentGeoLocData = f4d.getCurrentGeoLocationData();

			var currentGeoCoord = currentGeoLocData.geographicCoord;
			$('#dcLongitude').val(currentGeoCoord.longitude);
			$('#dcLatitude').val(currentGeoCoord.latitude);
			$('#dcAltitude').val(currentGeoCoord.altitude);

			$('#dcPitch,#dcPitchRange').val(currentGeoLocData.pitch);
			$('#dcHeading,#dcHeadingRange').val(currentGeoLocData.heading);
			$('#dcRoll,#dcRollRange').val(currentGeoLocData.roll);

			var hex;
			if(data.aditionalColor && data.isColorChanged) {
				hex = data.aditionalColor.getHexCode();
			} else {
				hex = '#000000';
			}
			$('#dcColorPicker').val(hex).change();

			if(!$('#mapPolicy').hasClass('on')) {
				$('#mapPolicy').trigger('click');
			}
			$dataControlWrap.show();

			setIssueFormValue(f4d, null, currentGeoCoord);
		}
	});

  //지도상에서 데이터 object 선택 시
    magoManager.on(Mago3D.MagoManager.EVENT_TYPE.SELECTEDF4DOBJECT, function(result) {
    	var resultObj = result.object;
    	var resultBuilding = result.octree;
    	if(resultObj && resultBuilding) {
    		clearDataControl();
    		var node = resultBuilding.nodeOwner;
			var data = node.data;
			dataId = data.dataId;
			dataKey = data.nodeId;
			projectId = data.projectId;
			var objectId = resultObj.objectId;
			
			var tempDataName = data.data_name || data.nodeId;
			if(tempDataName.indexOf("F4D_") >= 0) {
				tempDataName = tempDataName.replace("F4D_", "");
			}
			//var title = projectId + ' / ' + (data.data_name || data.nodeId) + ' / ' + objectId;
			//$header.text(title);
			$header.text(projectId + ' / ' + tempDataName + ' / ' + objectId);
			
			var block = resultBuilding.motherBlocksArray[resultObj._block_idx];
			var bbCenter = block.bbox.getCenterPoint();
			var orgMat = resultObj._originalMatrix4;
			var auxLocalPoint = orgMat.transformPoint3D(bbCenter);
			var geoLocData = node.getCurrentGeoLocationData();
			var pinPoint = geoLocData.tMatrix.transformPoint3D(auxLocalPoint);

			$dataControlWrap.show();

			var pinGeoCoord = Mago3D.ManagerUtils.pointToGeographicCoord(pinPoint);
			//issue 인풋에 값 세팅
			setIssueFormValue(node, objectId, pinGeoCoord);

    	}
	});
  	//선택된 데이터 이동 시 결과 리턴
    magoManager.on(Mago3D.MagoManager.EVENT_TYPE.SELECTEDF4DMOVED, function(result) {
		var item = result.result;

		$('#dcLongitude').val(item.longitude);
		$('#dcLatitude').val(item.latitude);
		$('#dcAltitude').val(item.altitude);

		$('#dcPitch,#dcPitchRange').val(item.pitch);
		$('#dcHeading,#dcHeadingRange').val(item.heading);
		$('#dcRoll,#dcRollRange').val(item.roll);
	});

  	//지도상에서 데이터 all 선택해제시
	magoManager.on(Mago3D.MagoManager.EVENT_TYPE.DESELECTEDF4D, deselectCallback);
	//magoManager.on(Mago3D.MagoManager.EVENT_TYPE.DESELECTEDF4D, function(){alert(1);});

	//지도상에서 데이터 object 선택해제시
	magoManager.on(Mago3D.MagoManager.EVENT_TYPE.DESELECTEDF4DOBJECT, deselectCallback);

	//색상변경 적용
	$('#dcColorApply').click(function() {
		if(!projectId || !dataKey) {
			alert(JS_MESSAGE["data.select"]);
			return;
		}

		var rgbArray = hex2rgbArray($('#dcColorInput').val());
		changeColorAPI(magoInstance, projectId, dataKey, null, 'isPhysical=true', rgbArray.join(','));
	});
	//색상변경 취소
	$('#dcColorCancle').click(function() {
		deleteAllChangeColorAPI(magoInstance);
	});
	$('#dcColorPicker').change(function(){
		var color = $('#dcColorPicker').val();
		$('#dcColorInput').val(color).css('color',color);
	});

	//회전 변경 range 조절
	$('#dcPitchRange,#dcHeadingRange,#dcRollRange').on('input change',function(){
		var val = $(this).val();
		var type = $(this).data('type');
		$('#dc' + type).val(val);

		changeF4d();
	});

	//회전 변경 버튼 조절
	var rotBtnHoldInterval;
	$('.dcRangeBtn').on('click', function(e) {
		if (rotBtnHoldInterval) clearInterval(rotBtnHoldInterval);
		var $this = $(this);
		var type = $this.data('type');
		var range = $this.siblings('input[type="range"]');
		var offset = (type ==='prev') ? -1 : 1;
		var curVal = parseFloat(range.val());
		range.val(curVal + offset).change();
	});
	$('.dcRangeBtn').on('mousedown', function(e) {
		if (rotBtnHoldInterval) clearInterval(rotBtnHoldInterval);
		var $this = $(this);
		rotBtnHoldInterval = setInterval(function(){
			var type = $this.data('type');
			var range = $this.siblings('input[type="range"]');
			var offset = (type ==='prev') ? -1 : 1;
			var curVal = parseFloat(range.val());
			range.val(curVal + offset).change();
		}, 150);
	});
	$('.dcRangeBtn').on('mouseup mouseleave',function() {
		clearInterval(rotBtnHoldInterval);
	});

	//데이터 높이 이벤트
	var locAltholdInterval;
	$('#dcAltUp,#dcAltDown').on('click', function(e) {
		if (locAltholdInterval) clearInterval(locAltholdInterval);
		var $this = $(this);
		var type = $this.data('type');
		var offset = parseFloat($('#dcAltitudeOffset').val());
		offset = (type==='up') ? offset : -offset;

		var alt = parseFloat($('#dcAltitude').val());
		$('#dcAltitude').val(alt + offset);

		changeF4d();
	});
	$('#dcAltUp,#dcAltDown').on('mousedown', function(e) {
		if (locAltholdInterval) clearInterval(locAltholdInterval);
		var $this = $(this);
		locAltholdInterval = setInterval(function(){
			var type = $this.data('type');
			var offset = parseFloat($('#dcAltitudeOffset').val());
			offset = (type==='up') ? offset : -offset;

			var alt = parseFloat($('#dcAltitude').val());
			$('#dcAltitude').val(alt + offset);

			changeF4d();
		}, 150);
	});
	$('#dcAltUp,#dcAltDown').on('mouseup mouseleave',function() {
		clearInterval(locAltholdInterval);
	});

	//속성조회
	$('#dcShowAttr').click(function(){
		detailDataInfo("/datas/" + dataId);
	});
	//위치회전정보 저장
	$('#dcSavePosRot').click(function() {
		if(confirm(JS_MESSAGE["data.update.check"])) {
			if(!dataId) {
				alert(JS_MESSAGE["data.not.select"]);
				return false;
			}
			startLoading();
			var formData = $('#dcRotLocForm').serialize();
			$.ajax({
				url: "/datas/" + dataId,
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				data: formData,
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert(JS_MESSAGE["update"]);
					} else if(msg.statusCode === 403) {
						//data.smart.tiling
						alert(JS_MESSAGE["data.smart.tiling.grant.required"]);
					} else if (msg.statusCode === 428) {
						if(confirm(JS_MESSAGE[msg.errorCode])) {
							$('input[name="dataId"]').val(dataId);
							var formData = $('#dcRotLocForm').serialize();
							$.ajax({
								url: "/data-adjust-logs",
								type: "POST",
								headers: {"X-Requested-With": "XMLHttpRequest"},
								data: formData,
								success: function(msg){
									if(msg.statusCode <= 200) {
										alert(JS_MESSAGE["requested"]);
									} else {
										alert(JS_MESSAGE[msg.errorCode]);
										console.log("---- " + msg.message);
									}
									insertDataAdjustLogFlag = true;
								},
								error: function(request, status, error){
							        alert(JS_MESSAGE["ajax.error.message"]);
							        insertDataAdjustLogFlag = true;
								},
								always: function(msg) {
									$('input[name="dataId"]').val("");
								}
							});
						}
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
					updateDataInfoFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateDataInfoFlag = true;
				}
			}).always(stopLoading);
		} else {
			//alert('no');
		}
	});

	var changeF4d = function() {
		var lat = parseFloat($('#dcLatitude').val());
		var lon = parseFloat($('#dcLongitude').val());
		var alt = parseFloat($('#dcAltitude').val());
		var heading = parseInt($('#dcHeading').val());
		var pitch = parseInt($('#dcPitch').val());
		var roll = parseInt($('#dcRoll').val());

		changeLocationAndRotationAPI(magoInstance, projectId, dataKey,
				lat, lon, alt, heading, pitch, roll);
	}

	var clearDataControl = function() {
		dataId = undefined;
		dataKey = undefined;
		projectId = undefined;
		$header.empty();
	}
	function deselectCallback(result) {
		clearDataControl();
		$dataControlWrap.hide();

		//clear issue form;
		setIssueFormValue();
	}

	function setIssueFormValue(f4d, objectId, coord) {
		if(f4d) {
			var data = f4d.data;
			projectId = data.projectId;
			var dataGroupName = NDTP.dataGroup.get(projectId);
			
			var tempDataName = data.data_name;
			if(tempDataName.indexOf("F4D_") >= 0) {
				tempDataName = tempDataName.replace("F4D_", "");
			}

			$("#issueDataId").val(data.dataId);
			$("#issueDataKey").val(data.nodeId);
			$("#issueDataName").html(tempDataName);
			$("#issueObjectKey").val(objectId);
			$("#issueDataGroupId").val(data.projectId);
			$("#issueDataGroupName").html(dataGroupName);//no exist..
			$("#issueLongitude").val(coord.longitude);
			$("#issueLatitude").val(coord.latitude);
			$("#issueAltitude").val(coord.altitude);
		} else {
			$("#issueDataId").val('');
			$("#issueDataKey").val('');
			$("#issueDataName").html('');
			$("#issueObjectKey").val('');
			$("#issueDataGroupId").val('');
			$("#issueDataGroupName").html('');
			$("#issueLongitude").val('');
			$("#issueLatitude").val('');
			$("#issueAltitude").val('');
		}
	}
}