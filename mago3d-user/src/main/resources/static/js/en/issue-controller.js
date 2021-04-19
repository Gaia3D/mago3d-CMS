var IssueController = function(magoInstance) {
	var option = {
		imageFilePath         : "/images/ko/exclam_32.png",
		sizeX 				  : 32,
		sizeY 				  : 32
	};
	this.magoInstance = magoInstance;
	
	this.addIssue = function(issue){
		var magoManager = this.magoInstance.getMagoManager();
		if(Array.isArray(issue)) {
			for(var i in issue) {
				this.addIssue(issue[i]);
			}
		} else {
			var point = Mago3D.ManagerUtils.geographicCoordToWorldPoint(issue.longitude,issue.latitude,issue.altitude);
			option.positionWC = point;
			
			var objMarker = magoManager.objMarkerManager.newObjectMarker(option, magoManager);
			objMarker.issueId = issue.issueId;
		}
	}
	
	this.clearIssue = function(){
		var mm = this.magoInstance.getMagoManager();
		mm.objMarkerManager.setMarkerByCondition(function(om){
			return !om.issueId;
		});
	}
	
	this.getCenterRadiusIssue = function() {
		var that = this;
		var magoManager = that.magoInstance.getMagoManager();
		var campos = getCameraCurrentPositionAPI(magoInstance);
		var lon = campos.lon;
		var lat = campos.lat;
		
		var location = Mago3D.ManagerUtils.geographicToWkt({longitude:lon,latitude:lat}, 'POINT');
		if(location) {
			$.ajax({
				url: "/issues",
				type: "GET",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				data : {location : location, limit:100},
				success: function(msg){
					if(msg.statusCode <= 200) {
						var issueList = msg.issueList;
						if(issueList && issueList.length > 0) {
							that.addIssue(issueList);
						}
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
				}
			})
		}
	}
	
	this.magoInstance.getMagoManager().on(Mago3D.MagoManager.EVENT_TYPE.SELECTEDGENERALOBJECT, function(e){
		var generalObject = e.generalObject;
		if(generalObject instanceof Mago3D.ObjectMarker && generalObject.hasOwnProperty('issueId')) {
			detailIssueInfo(generalObject.issueId);
		}
	});
	this.magoInstance.getMagoManager().on(Mago3D.MagoManager.EVENT_TYPE.DESELECTEDGENERALOBJECT, function(e){
		//console.info('DESELECTEDGENERALOBJECT');
	});
}