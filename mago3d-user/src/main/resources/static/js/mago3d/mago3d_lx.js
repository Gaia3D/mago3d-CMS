Mago3D.ManagerUtils.geographicToWkt = function(geographic, type) {
	var wkt = '';
	
	switch(type) {
		case 'POINT' : {
			wkt = 'POINT (';
			wkt += geographic.longitude;
			wkt += ' ';
			wkt += geographic.latitude;
			wkt += ')';
			break;
		}
		case 'LINE' : {
			wkt = 'LINESTRING (';
			for(var i=0,len=geographic.length;i<len;i++) {
				if(i>0) {
					wkt += ',';
				}
				wkt += geographic[i].longitude;
				wkt += ' ';
				wkt += geographic[i].latitude;
			}
			wkt += ')';
			break;
		}
		case 'POLYGON' : {
			wkt = 'POLYGON ((';
			for(var i=0,len=geographic.length;i<len;i++) {
				if(i>0) {
					wkt += ',';
				}
				wkt += geographic[i].longitude;
				wkt += ' ';
				wkt += geographic[i].latitude;
			}
			wkt += ',';
			wkt += geographic[0].longitude;
			wkt += ' ';
			wkt += geographic[0].latitude;
			wkt += '))';
			break;
		}
	}
	
	function coordToString(coord,str) {
		var text = str ? str : '';
		if(Array.isArray(coord)) {
			for(var i=0,len=coord.length;i<len;i++) {
				coordToString(coord[i],text);
			}
		} else {
			if(text) {
				text += ',';
			}
			text += coord.longitude;
			text += ' ';
			text += coord.latitude;
		}
		
		return text;
	}
	
	return wkt;
}

Mago3D.ManagerUtils.getCoordinateFromWKT = function(wkt, type) {
	switch(type) {
		case 'POINT' : {
			var removePrefix = wkt.replace(/\bpoint\b\s*\(/i, "");
			var removeSuffix = removePrefix.replace(/\s*\)\s*$/, "");
			var coordinates = removeSuffix.match(/[+-]?\d*(\.?\d+)/g);
			return coordinates;
		}
	}
}

Mago3D.TranslateInteraction.prototype.handleDownEvent = function(browserEvent)
{
	var manager = this.manager;
	if (browserEvent.type !== "leftdown") { return; }

	var selectManager = manager.selectionManager;

	if (manager.selectionFbo === undefined) 
	{ manager.selectionFbo = new Mago3D.FBO(gl, manager.sceneState.drawingBufferWidth[0], manager.sceneState.drawingBufferHeight[0], {matchCanvasSize: true}); }

	var gl = manager.getGl();
	selectManager.selectProvisionalObjectByPixel(gl, browserEvent.point.screenCoordinate.x, browserEvent.point.screenCoordinate.y);

	if (!this.filter_)
	{
		this.setFilterFunction();
	}

	var filterProvisional = selectManager.filterProvisional(this.targetType, this.filter_);
	
	if (!Mago3D.isEmpty(filterProvisional) && (filterProvisional.hasOwnProperty(this.targetType) || this.targetType === Mago3D.DataType.ALL))
	{
		if(this.targetType !== Mago3D.DataType.ALL) {
			this.target = filterProvisional[this.targetType][0];
			if (this.targetType === Mago3D.DataType.OBJECT)
			{
				this.parentNode = filterProvisional[Mago3D.DataType.F4D][0];
			}
		} else {
			this.target = filterProvisional[Object.keys(filterProvisional)[0]][0];
		}
		
		if(this.target instanceof Mago3D.Node && this.target.data.attributes.assemble) {
			this.targetArray = [];
			var refTeamId = this.target.data.attributes.teamId;
			var hierarchyManager = manager.hierarchyManager;
			var staticModelKeys = Object.keys(hierarchyManager?.staticModelsManager?.staticModelsMap);

			for(var i in staticModelKeys) {
				var nodes = hierarchyManager.getRootNodes(staticModelKeys[i]);
				for(var j in nodes) {
					var node = nodes[j];
					if(!node.data.attributes.assemble) break;
					if(node.data.attributes.teamId !== refTeamId) continue;

					this.targetArray.push(node);
				}
			}
		}
	}
	else 
	{
		this.init();
	}
};

Mago3D.TranslateInteraction.prototype.handleF4dDrag = function(browserEvent)
{
	var manager = this.manager;
	var target = this.target;

	var diffPosition = this._calculateIntersectionPoint(browserEvent, target)
	if(this.targetArray) {
		this.moveMultiF4d(diffPosition);
	} else {
		this.moveSingleF4d(diffPosition, target);
	}
};

Mago3D.TranslateInteraction.prototype._calculateIntersectionPoint = function(browserEvent, node) {
	var manager = this.manager;
	var geoLocDataManager = node.getNodeGeoLocDataManager();
	var geoLocationData = geoLocDataManager.getCurrentGeoLocationData();
	var attributes = node.data.attributes;
	if (!this.selObjMovePlaneCC)
	{
		this.selObjMovePlaneCC = new Mago3D.Plane();

		var geoLocMatrix = geoLocationData.geoLocMatrix;
		var mvMat = manager.sceneState.modelViewMatrix;
		var mvMatRelToEye = manager.sceneState.modelViewRelToEyeMatrix;

		var sc = this.startPoint.screenCoordinate;
		var magoWC = Mago3D.ManagerUtils.calculatePixelPositionWorldCoord(manager.getGl(), sc.x, sc.y, magoWC, undefined, undefined, undefined, manager);
		var pixelPosCC = mvMat.transformPoint3D(this.startPoint.worldCoordinate, pixelPosCC);
        
		if (attributes.movementInAxisZ)
		{
			// movement in plane XZ.
			var globeYaxisWC = new Mago3D.Point3D(geoLocMatrix._floatArrays[4], geoLocMatrix._floatArrays[5], geoLocMatrix._floatArrays[6]);
			var globeYaxisCC = mvMatRelToEye.transformPoint3D(globeYaxisWC, undefined);
			this.selObjMovePlaneCC.setPointAndNormal(pixelPosCC.x, pixelPosCC.y, pixelPosCC.z,    globeYaxisCC.x, globeYaxisCC.y, globeYaxisCC.z); 
		}
		else 
		{
			// movement in plane XY.
			var globeZaxisWC = new Mago3D.Point3D(geoLocMatrix._floatArrays[8], geoLocMatrix._floatArrays[9], geoLocMatrix._floatArrays[10]);
			var globeZaxisCC = mvMatRelToEye.transformPoint3D(globeZaxisWC, undefined);
			this.selObjMovePlaneCC.setPointAndNormal(pixelPosCC.x, pixelPosCC.y, pixelPosCC.z,    globeZaxisCC.x, globeZaxisCC.y, globeZaxisCC.z); 
		}
	}

	var screenCoordinate = browserEvent.endEvent.screenCoordinate;
	var camRay = Mago3D.ManagerUtils.getRayCamSpace(screenCoordinate.x, screenCoordinate.y, camRay, manager);
	this.lineCC.setPointAndDir(0, 0, 0,  camRay[0], camRay[1], camRay[2]);
    
	var intersectionPointCC = new Mago3D.Point3D();
	intersectionPointCC = this.selObjMovePlaneCC.intersectionLine(this.lineCC, intersectionPointCC);
    
	var mvMat = manager.sceneState.getModelViewMatrixInv();
	var intersectionPointWC = mvMat.transformPoint3D(intersectionPointCC, intersectionPointWC);
    var cartographic = Mago3D.ManagerUtils.pointToGeographicCoord(intersectionPointWC, cartographic, this);
	return cartographic;
}

Mago3D.TranslateInteraction.prototype.moveMultiF4d = function(position) {
	var manager = this.manager;

	for(var i=0,len=this.targetArray.length;i<len;i++) {
		var node = this.targetArray[i];

		var geoLocDataManager = node.getNodeGeoLocDataManager();
		var geoLocationData = geoLocDataManager.getCurrentGeoLocationData();

		if(!node.data.startGeoCoordDif) {
			var buildingGeoCoord = geoLocationData.geographicCoord;
			node.data.startGeoCoordDif = new Mago3D.GeographicCoord(position.longitude-buildingGeoCoord.longitude, position.latitude-buildingGeoCoord.latitude, position.altitude-buildingGeoCoord.altitude);
		}
		
		var difX = position.longitude - node.data.startGeoCoordDif.longitude;
		var difY = position.latitude - node.data.startGeoCoordDif.latitude;
		var difZ = position.altitude - node.data.startGeoCoordDif.altitude;

		var attributes = node.data.attributes;
		if (attributes.movementInAxisZ)
		{
			//geoLocationData = ManagerUtils.calculateGeoLocationData(undefined, undefined, newAltitude, undefined, undefined, undefined, geoLocationData, this);
			manager.changeLocationAndRotationNode(node, undefined, undefined, difZ, undefined, undefined, undefined);
		}
		else 
		{
			//geoLocationData = ManagerUtils.calculateGeoLocationData(newLongitude, newlatitude, undefined, undefined, undefined, undefined, geoLocationData, this);
			manager.changeLocationAndRotationNode(node, difY, difX, undefined, undefined, undefined, undefined);
		}

		this.emit(Mago3D.TranslateInteraction.EVENT_TYPE.MOVING_F4D, {
			type   : Mago3D.TranslateInteraction.EVENT_TYPE.MOVING_F4D,
			result : node,
			timestamp: new Date()
		});
	}
}

Mago3D.TranslateInteraction.prototype.moveSingleF4d = function(position, node) {
	var manager = this.manager;

	var geoLocDataManager = node.getNodeGeoLocDataManager();
	var geoLocationData = geoLocDataManager.getCurrentGeoLocationData();

	if (!this.startGeoCoordDif)
	{
		var buildingGeoCoord = geoLocationData.geographicCoord;
		this.startGeoCoordDif = new Mago3D.GeographicCoord(position.longitude-buildingGeoCoord.longitude, position.latitude-buildingGeoCoord.latitude, position.altitude-buildingGeoCoord.altitude);
	}

	var difX = position.longitude - this.startGeoCoordDif.longitude;
	var difY = position.latitude - this.startGeoCoordDif.latitude;
	var difZ = position.altitude - this.startGeoCoordDif.altitude;

	var attributes = node.data.attributes;
	if (attributes.movementInAxisZ)
	{
		//geoLocationData = ManagerUtils.calculateGeoLocationData(undefined, undefined, newAltitude, undefined, undefined, undefined, geoLocationData, this);
		manager.changeLocationAndRotationNode(node, undefined, undefined, difZ, undefined, undefined, undefined);
	}
	else 
	{
		//geoLocationData = ManagerUtils.calculateGeoLocationData(newLongitude, newlatitude, undefined, undefined, undefined, undefined, geoLocationData, this);
		manager.changeLocationAndRotationNode(node, difY, difX, undefined, undefined, undefined, undefined);
	}

	this.emit(Mago3D.TranslateInteraction.EVENT_TYPE.MOVING_F4D, {
		type   : Mago3D.TranslateInteraction.EVENT_TYPE.MOVING_F4D,
		result : node,
		timestamp: new Date()
	});
}

Mago3D.TranslateInteraction.prototype.init = function() 
{
	this.begin = false;
	this.dragging = false;
	this.mouseBtn = undefined;
	this.startPoint = undefined;
	this.endPoint = undefined;
	this.selObjMovePlaneCC = undefined;
	this.selObjMovePlane = undefined;
	this.startGeoCoordDif = undefined;
	this.startMovPoint = undefined;
	this.target = undefined;
	this.parentNode = undefined;

	if(this.targetArray) {
		for(var i=0,len=this.targetArray.length;i<len;i++) {	
			delete this.targetArray[i].data.startGeoCoordDif
		}
		delete this.targetArray;
	}
};

Mago3D.RotateInteraction.prototype.handleDownEvent = function(browserEvent)
{
	var manager = this.manager;
	if (browserEvent.type !== "leftdown") { return; }

	var selectManager = manager.selectionManager;

	if (manager.selectionFbo === undefined) 
	{ manager.selectionFbo = new Mago3D.FBO(gl, manager.sceneState.drawingBufferWidth[0], manager.sceneState.drawingBufferHeight[0], {matchCanvasSize: true}); }

	var gl = manager.getGl();
	var clickScreenCoord = browserEvent.point.screenCoordinate;
	selectManager.selectProvisionalObjectByPixel(gl, clickScreenCoord.x, clickScreenCoord.y);

	if (!this.filter_)
	{
		this.setFilterFunction();
	}

	var filterProvisional = selectManager.filterProvisional(this.targetType, this.filter_);

	if (!Mago3D.isEmpty(filterProvisional))
	{
		this.target = filterProvisional[this.targetType][0];
		if (this.targetType === Mago3D.DataType.OBJECT)
		{
			this.parentNode = filterProvisional[DataType.F4D][0];
		}
		if(this.isTeam(this.target)) {
			const team = dataLibrary2Obj.dataLibraryItems.findByNode(this.target);
			let position = team.position;
			if(team.commonAttributes.drawType === 'point') {
				var currentGeoLocData = this.target.getCurrentGeoLocationData();
				var currentGeoCoord = currentGeoLocData.geographicCoord;
				var wc = Mago3D.ManagerUtils.geographicCoordToWorldPoint(currentGeoCoord.longitude, currentGeoCoord.latitude, currentGeoCoord.altitude);
		        
				this.centerScreenCoord = Mago3D.ManagerUtils.calculateWorldPositionToScreenCoord(undefined, wc.x, wc.y, wc.z, this.centerScreenCoord, manager);
				let rad = Math.atan2(clickScreenCoord.x - this.centerScreenCoord.x, clickScreenCoord.y - this.centerScreenCoord.y);
				this.clickDeg = Math.round((rad * (180/Math.PI)));
			} else {
				let firstPosition = position[0];
				let lastPosition = position[1];
				
				let firstWC = Mago3D.ManagerUtils.geographicCoordToWorldPoint(firstPosition.lon, firstPosition.lat, 0);
				
				//this.highFirtWC = new Float32Array(3);
				//this.lowFirstWC = new Float32Array(3);
				//Mago3D.ManagerUtils.calculateSplited3fv([firstWC.x, firstWC.y, firstWC.z], this.highFirtWC, this.lowFirstWC);
				
				let secondWC = Mago3D.ManagerUtils.geographicCoordToWorldPoint(lastPosition.lon, lastPosition.lat, 0);
				this.dist = secondWC.distToPoint(firstWC);
				this.firstGC = new Mago3D.GeographicCoord(firstPosition.lon, firstPosition.lat, 0);
				this.firstGC.makeDefaultGeoLocationData();
			}
		} else {
			var currentGeoLocData = this.target.getCurrentGeoLocationData();
			var currentGeoCoord = currentGeoLocData.geographicCoord;
			var wc = Mago3D.ManagerUtils.geographicCoordToWorldPoint(currentGeoCoord.longitude, currentGeoCoord.latitude, currentGeoCoord.altitude);
	        
			this.centerScreenCoord = Mago3D.ManagerUtils.calculateWorldPositionToScreenCoord(undefined, wc.x, wc.y, wc.z, this.centerScreenCoord, manager);
			let rad = Math.atan2(clickScreenCoord.x - this.centerScreenCoord.x, clickScreenCoord.y - this.centerScreenCoord.y);
			this.clickDeg = Math.round((rad * (180/Math.PI)));
		}
		
		this.manager.setCameraMotion(false);
	}
	else 
	{
		this.init();
	}
};

Mago3D.RotateInteraction.prototype.handleDragEvent = function(browserEvent)
{
	if (this.target && this.dragging)
	{
		var manager = this.manager;
		if(this.isTeam(this.target)) {
			const team = dataLibrary2Obj.dataLibraryItems.findByNode(this.target);
			let position = team.position;
			
			if(team.commonAttributes.drawType === 'point') {
				team.heading = rdeg;
				var screenCoordinate = browserEvent.endEvent.screenCoordinate;
				var rad = Math.atan2(screenCoordinate.x - this.centerScreenCoord.x, screenCoordinate.y - this.centerScreenCoord.y);
				var deg = Math.round((rad * (180/Math.PI)));
				var rdeg = deg - this.clickDeg;
				
				var currentGeoLocData = this.target.getCurrentGeoLocationData();
				var currentGeoCoord = currentGeoLocData.geographicCoord;
				var currentLon = currentGeoCoord.longitude;
				var currentLat = currentGeoCoord.latitude;
				var currentAlt = currentGeoCoord.altitude;
				var currentRoll = currentGeoLocData.roll;
				var currentPitch = currentGeoLocData.pitch;
				
				var nodes = team.nodes;
				for(var i=0,len=nodes.length;i<len;i++) {
					var node = nodes[i];
					var nodeGeoLocData = node.getCurrentGeoLocationData();
					var nodeGeoCoord = nodeGeoLocData.geographicCoord;
				
					node.changeLocationAndRotation(currentLat, currentLon, nodeGeoCoord.altitude, rdeg, currentRoll, currentPitch);
				}
			} else {
				let mouseWC =browserEvent.endEvent.worldCoordinate;
				let mouseGC =browserEvent.endEvent.geographicCoordinate;
				mouseGC.altitude = 0;
				
				let mouseWCHeightZero = Mago3D.ManagerUtils.geographicCoordToWorldPoint(mouseGC.longitude, mouseGC.latitude, 0);
				let firstGLDM = this.firstGC.getGeoLocationDataManager();
				let firstGeoLocData = firstGLDM.getCurrentGeoLocationData();
				
				let mouseLC = firstGeoLocData.worldCoordToLocalCoord(mouseWCHeightZero);
				let mouseCloneLC = new Mago3D.Point3D(mouseLC.x, mouseLC.y, mouseLC.z);
				mouseCloneLC.unitary();
				mouseCloneLC.scale(this.dist);
				
				let secondWC = firstGeoLocData.localCoordToWorldCoord(mouseCloneLC);
				
				//let secondWC = new Mago3D.Point3D((this.lowFirstWC[0] + vectorWC.x) + this.highFirtWC[0], (this.lowFirstWC[1] + vectorWC.y) + this.highFirtWC[1], (this.lowFirstWC[2] + vectorWC.z) + this.highFirtWC[2]);
				//let secondWC = new Mago3D.Point3D(this.firstWC.x + vectorWC.x, this.firstWC.y + vectorWC.y, this.firstWC.z + vectorWC.z);
				let secondGeographicCoord = Mago3D.ManagerUtils.pointToGeographicCoord(secondWC);
				
				team.position[1].lat = secondGeographicCoord.latitude;
				team.position[1].lon = secondGeographicCoord.longitude;
				
				team.clearNode(true);
				team.render();
				
				manager.selectionManager.selectF4d(team.nodes[0]);
				this.target = team.nodes[0];
			}
		} else {
			var screenCoordinate = browserEvent.endEvent.screenCoordinate;
			var rad = Math.atan2(screenCoordinate.x - this.centerScreenCoord.x, screenCoordinate.y - this.centerScreenCoord.y);
			var deg = Math.round((rad * (180/Math.PI)));
			var rdeg = deg - this.clickDeg;
			
			var currentGeoLocData = this.target.getCurrentGeoLocationData();
			var currentGeoCoord = currentGeoLocData.geographicCoord;
			var currentLon = currentGeoCoord.longitude;
			var currentLat = currentGeoCoord.latitude;
			var currentAlt = currentGeoCoord.altitude;
			var currentRoll = currentGeoLocData.roll;
			var currentPitch = currentGeoLocData.pitch;

			this.target.changeLocationAndRotation(currentLat, currentLon, currentAlt, rdeg, currentRoll, currentPitch);
		}
	}
};

Mago3D.RotateInteraction.prototype.handleUpEvent = function()
{
	this.init();
	this.manager.setCameraMotion(true);
	this.manager.isCameraMoved = true;
	return;
};

Mago3D.RotateInteraction.prototype.init = function() 
{
	this.dragging = false;
	this.mouseBtn = undefined;
	this.startPoint = undefined;
	this.endPoint = undefined;
	this.target = undefined;
	this.parentNode = undefined;
	this.centerScreenCoord = undefined;
	this.clickDeg = undefined;
	this.highFirtWC = undefined;
	this.lowFirstWC = undefined;
	this.dist = undefined;
	this.firstGC = undefined;
};

Mago3D.RotateInteraction.prototype.isTeam = function(node) {
	return node.data.attributes.teamId && node.data.attributes.assemble
}