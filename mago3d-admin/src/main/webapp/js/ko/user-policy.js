var UserPolicy = function(magoInstance) {
	
	//객체정보 변경
	$("input[name='datainfoDisplay']").change(function(e){
		var flag = JSON.parse($(this).val().toLowerCase());
		changeObjectInfoViewModeAPI(magoInstance, flag);
	});
	
	//오리진 표시 유무 변경
	$("input[name='originDisplay']").change(function(e){
		var flag = JSON.parse($(this).val().toLowerCase());
		changeOriginAPI(magoInstance, flag);
	});
	
	//바운딩박스 표시 유무 변경
	$("input[name='bboxDisplay']").change(function(e){
		var flag = JSON.parse($(this).val().toLowerCase());
		changeBoundingBoxAPI(magoInstance, flag);
	});
	
	$("input[name='objectMoveMode']").change(function(e){
		changeObjectMoveAPI(magoInstance, $(this).val());
	});
	
	//lod 변경
	$('#changeLodButton').click(function(e){
		var lod0 = $("#geoLod0").val();
		var lod1 = $("#geoLod1").val();
		var lod2 = $("#geoLod2").val();
		var lod3 = $("#geoLod3").val();
		var lod4 = $("#geoLod4").val();
		var lod5 = $("#geoLod5").val();
		if(isNaN(lod0) || isNaN(lod1) || isNaN(lod2)|| isNaN(lod3) || isNaN(lod4) || isNaN(lod5)) {
			alert('숫자만 입력 가능합니다.');
			return;
		}
		
		changeLodAPI(magoInstance, lod0, lod1, lod2, lod3, lod4, lod5);
	});
	
	//ssao 변경
	$('#changeSsaoButton').click(function(e){
		var ssao = $('#ssaoRadius').val();
		if(isNaN(ssao)) {
			alert('숫자만 입력 가능합니다.');
			return;
		} 
		
		changeSsaoRadiusAPI(magoInstance, ssao);
	});
	
	// 지도에서 선택
	$("#findStartPoint").click(function(e){
		var magoManager = MAGO3D_INSTANCE.getMagoManager();
		// TODO event 삭제 필요 
		magoManager.once(Mago3D.MagoManager.EVENT_TYPE.CLICK, function(result) {
			var longitude = result.clickCoordinate.geographicCoordinate.longitude;
			var latitude = result.clickCoordinate.geographicCoordinate.latitude;
			var altitude = getCameraCurrentPositionAPI(MAGO3D_INSTANCE).alt;
			
			$("#initLatitude").val(latitude);
			$("#initLongitude").val(longitude);
			$("#initAltitude").val(altitude);
		});
	});
}