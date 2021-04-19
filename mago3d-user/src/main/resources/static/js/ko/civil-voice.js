var civilVoice = civilVoice || {};

function CivilVoice(magoInstance) {
	var viewer = magoInstance.getViewer();
	civilVoice = $.extend(civilVoice, new CivilVoiceControll(magoInstance, viewer));
}

function CivilVoiceControll(magoInstance, viewer) {
	var that = this;
	var magoManager = magoInstance.getMagoManager();

	if(!magoManager.speechBubble) {
		magoManager.speechBubble = new Mago3D.SpeechBubble();
	}
	var sb = magoManager.speechBubble;
	var bubbleColor = new Mago3D.Color(1,1,1);
	var groupOption = {
		imageFilePath : "defaultRed",
	};

	var commentTextOption = {
		pixel:12,
		color:'black',
		borderColor:'white',
	}

	var store = {
		contents: {
			list: $("#civilVoiceListContent"),
			input: $("#civilVoiceInputContent"),
			modify: $("#civilVoiceModifyContent"),
			detail: $("#civilVoiceDetailContent")
		},
		marker: {
			// 마커 색상 - https://cesium.com/docs/cesiumjs-ref-doc/Color.html
			color: Cesium.Color.DARKORANGE,
			size: 32
		},
		beforeEntity: null
	}

	function toggleContent(target) {
		var viewList = store.contents;
		// hide all
		for(var property in viewList) {
			var content = viewList[property];
			content.hide();
		}
		// show target
		var targetContent = viewList[target];
		targetContent.show();
	}

	function removeStoredEntity() {
		if(store.beforeEntity) {
			//viewer.entities.removeById(store.beforeEntity);

			magoManager.objMarkerManager.setMarkerByCondition(function(om){return !om.civilDrawMarker});
			store.beforeEntity = null;
		}
	}

	function _clusterRenderFunc(trees, magoManager){
		magoManager.objMarkerManager.setMarkerByCondition(function(om){
			return !om.tree;
		});
		var treeLength = trees.length;

		for (var i=0;i<treeLength;i++)
		{
			var tree = trees[i];

			if (tree.hasChildren())
			{
				var points = tree.displayPointsArray;

				var pointLength = points.length;

				for (var j=0;j<pointLength;j++)
				{
					var point = points[j];
					var mass = point.mass;
					groupOption.positionWC = point;

					var imgSize;
					var pixel;
					if(mass > 10) {
						imgSize = [96,96];
						pixel = 50;
					} else if(mass > 6 && mass <= 10) {
						imgSize = [80,80];
						pixel = 48;
					} else if(mass > 4 && mass <= 6) {
						imgSize = [64,64];
						pixel = 46;
					} else if(mass > 2 && mass <= 4) {
						imgSize = [48,48];
						pixel = 44;
					} else {
						imgSize = [32,32];
						pixel = 30;
					}
					groupOption.imageFilePath = sb.getPng(imgSize,'#287be4',{text:'...', pixel:pixel});
					var om = magoManager.objMarkerManager.newObjectMarker(groupOption, magoManager);
					om.tree = tree;
				}
			}
			else
			{
				var points = tree.data;
				if (points)
				{
					var pointLength = points.length;
					var bubbleColor;
					for (var j=0;j<pointLength;j++)
					{
						var point = points[j];
						var commentCnt = point.commentCount;
						if(point.commentCount === undefined || point.commentCount === null) point.commentCount = 0;
						if(commentCnt <= 10) {
							bubbleColor = '#bdd4df';
						} else if(commentCnt > 10 && commentCnt <= 20) {
							bubbleColor = '#a3c8d8';
						} else if(commentCnt > 20 && commentCnt <= 30) {
							bubbleColor = '#87b9ce';
						} else if(commentCnt > 30 && commentCnt <= 40) {
							bubbleColor = '#ffe200';
						} else if(commentCnt > 40 && commentCnt <= 50) {
							bubbleColor = '#fabf00';
						} else if(commentCnt > 50 && commentCnt <= 60) {
							bubbleColor = '#f7ac00';
						} else if(commentCnt > 60 && commentCnt <= 70) {
							bubbleColor = '#f49800';
						} else if(commentCnt > 70 && commentCnt <= 80) {
							bubbleColor = '#ed6d46';
						} else if(commentCnt > 80 && commentCnt <= 90) {
							bubbleColor = '#eb5532';
						} else if(commentCnt > 90 && commentCnt <= 100) {
							bubbleColor = '#e83820';
						} else {
							bubbleColor = '#e83820';
							commentCnt = '100+';
						}

						commentTextOption.text = commentCnt;

						var img = sb.getPng([32,32],bubbleColor, commentTextOption);

						var options = {
							positionWC    : Mago3D.ManagerUtils.geographicCoordToWorldPoint(point.x, point.y, 0),
							imageFilePath : img
						};
						var om = magoManager.objMarkerManager.newObjectMarker(options, magoManager);
						om.tree = tree;
						om.civilVoice = point;
					}
				}
			}
		}
	}

	function _clusterSelected(e) {
		var generalObject = e.generalObject;
		if(generalObject instanceof Mago3D.ObjectMarker && generalObject.hasOwnProperty('civilVoice') ) {
			//console.info(generalObject);
		}
	}

	function _startRender(){
		var voices = this.list;
		if(voices && Array.isArray(voices) && voices.length > 0) {
			var cluster = new Mago3D.Cluster(_voicesToPointList(voices), 6, magoManager,_clusterRenderFunc);

			magoManager.addCluster(cluster);
			this.magoCluster = cluster;
			magoManager.on(Mago3D.MagoManager.EVENT_TYPE.SELECTEDGENERALOBJECT, _clusterSelected);
		}
	}

	function _stopRender() {
		this.magoCluster = undefined;
		magoManager.clearCluster();
		magoManager.off(Mago3D.MagoManager.EVENT_TYPE.SELECTEDGENERALOBJECT, _clusterSelected);
	}

	function _addVoice(voice) {
		if(!this.magoCluster || this.list.length === 0) {
			this.list.push(voice);
			_startRender.call(this);
		} else {
			this.list.push(voice);
			var p2 = _voiceToPoint(voice);
			this.magoCluster.addPoint(p2);
		}
	}

	function _deleteVoice(civilVoiceId) {
		var deletedList = this.list.filter(function(item){
			return item.civilVoiceId !== civilVoiceId;
		})
		this.list = deletedList;
		this.magoCluster.deletePointByCondition(function(point){return point.civilVoiceId !== civilVoiceId});
		if(this.list.length === 0) {
			_stopRender.call(this);
		}
	}

	function _updateVoice(voice) {
		var p2 = _voiceToPoint(voice);
		this.magoCluster.updatePoint(p2, function(point){return point.civilVoiceId === voice.civilVoiceId});
	}

	function _updateVoiceCommentCnt(civilVoiceId) {
		var updatedVoice = this.list.filter(function(voice){
			return voice.civilVoiceId == civilVoiceId;
		})[0];
		updatedVoice.commentCount += 1;
		var p2 = _voiceToPoint(updatedVoice);
		this.magoCluster.updatePoint(p2, function(point){return point.civilVoiceId === updatedVoice.civilVoiceId});
	}

	function _voicesToPointList(voices) {
		var p2dList = new Mago3D.Point2DList();
		for(var i in voices) {
			var voice = voices[i];
			p2dList.addPoint(_voiceToPoint(voice));
		}

		return p2dList;
	}
	function _voiceToPoint(voice){
		var lon = parseFloat(voice.longitude);
		var lat = parseFloat(voice.latitude);

		var p2 = new Mago3D.Point2D(lon, lat);
		p2.civilVoiceId = voice.civilVoiceId;
		p2.commentCount = voice.commentCount;
		return p2;
	}
	// public
	return {
		/************************** Map ***************************/
		cluster: {
			list: null,
			magoCluster : null,
			refresh: function() {
				getCivilVoiceListAll();
			},
			startRender : _startRender,
			stopRender : _stopRender,
			addVoice : _addVoice,
			deleteVoice : _deleteVoice,
			updateVoice : _updateVoice,
			updateVoiceCommentCnt : _updateVoiceCommentCnt
		},
		clear: function() {
			removeStoredEntity();

		},
		flyToLocation: function(longitude, latitude) {
			this.flyTo(longitude, latitude);
		},
		flyTo: function(longitude, latitude) {
			var altitude = 100;
			var duration = 1;
			magoManager.flyTo(longitude, latitude, altitude, duration);
		},
		drawMarker: function(longitude, latitude) {
			removeStoredEntity();

			var markerSize = store.marker.size;
			var img = sb.getPng([markerSize,markerSize],store.marker.color.toCssColorString());

			var terrainProvider = viewer.terrainProvider;
	        var positions = [
	            Cesium.Cartographic.fromDegrees(longitude, latitude)
	        ];
	        var promise = Cesium.sampleTerrain(terrainProvider, 11, positions);
	        Cesium.when(promise, function(updatedPositions) {
	            console.info(updatedPositions);
	            var options = {
    				positionWC    : Mago3D.ManagerUtils.geographicCoordToWorldPoint(longitude, latitude,updatedPositions[0].height),
    				imageFilePath : img
    			};
    			var om = magoManager.objMarkerManager.newObjectMarker(options, magoManager);
    			om.civilDrawMarker = true;
    			store.beforeEntity = om;
	        });

			/*var x = Number(longitude);
	   		var y = Number(latitude);

	   		var pinBuilder = new Cesium.PinBuilder();
	   		var addedEntity = viewer.entities.add({
	   		    name : 'Location',
	   		    position : Cesium.Cartesian3.fromDegrees(x, y),
	   		    billboard : {
	   	        	disableDepthTestDistance : Number.POSITIVE_INFINITY,
	   				heightReference: Cesium.HeightReference.CLAMP_TO_GROUND,
	   		        image : pinBuilder.fromColor(store.marker.color, store.marker.size).toDataURL(),
	   	            horizontalOrigin : Cesium.HorizontalOrigin.CENTER,
	   	            verticalOrigin : Cesium.VerticalOrigin.BOTTOM
	   		    }
	   		});*/
		},
		updateMarker: function(count) {
			if(store.beforeEntity) {
				var entity = viewer.entities.getById(store.beforeEntity);
				if(entity) {
					var pinBuilder = new Cesium.PinBuilder();
					var markerImage = pinBuilder.fromText(count, store.marker.color, store.marker.size).toDataURL();
					entity.billboard.image.setValue(markerImage);
				}
			}
		},
		getGeographicCoord: function() {
			magoManager.once(Mago3D.MagoManager.EVENT_TYPE.CLICK, function(result) {
				var geographicCoord = result.clickCoordinate.geographicCoordinate;
				civilVoice.drawMarker(geographicCoord.longitude, geographicCoord.latitude);
				$('#civilVoiceContent [name=longitude]:visible').val(geographicCoord.longitude);
				$('#civilVoiceContent [name=latitude]:visible').val(geographicCoord.latitude);
			});
		},
		/********************************************************/
		currentPage: null,
		currentCivilVoiceId: null,
		showContent: function(target) {
			this.initFormContent('civilVoiceForm');
			this.initFormContent('civilVoiceCommentForm');
			toggleContent(target);
		},
		initFormContent: function(formId) {
			var tokenSelector = '[name=CSRFToken]';
			$('#' + formId + ' input').not(tokenSelector).val("");
			$('#' + formId + ' textarea').not(tokenSelector).val("");
		},
		drawHandlebarsHtml: function(data, templateId, targetId) {
			var source = $('#' + templateId).html();
			var template = Handlebars.compile(source);
			var html = template(data);
			$('#' + targetId).empty().append(html);
		}
	}
}


$(document).ready(function() {
	if(location.hash && location.hash === '#civilVoice') {
		getCivilVoiceList();
		getCivilVoiceListAll(true);
	}
});

// 시민참여 탭 클릭시 조회
$('#civilVoiceMenu').on('click', function() {
	if(!$(this).hasClass('on')){
		getCivilVoiceList();
		getCivilVoiceListAll(true);
	}
});

// 시민참여 위치보기
$('#civilVoiceList').on('click', '.goto', function(e) {
	e.stopPropagation();
	var longitude = $(this).data('longitude');
	var latitude = $(this).data('latitude');
	civilVoice.flyToLocation(longitude, latitude);
});

// 시민참여 상세보기
$('#civilVoiceContent').on('click', 'li.comment', function() {
	civilVoice.showContent('detail');
	// set current id
	var id = $(this).data('id');
	civilVoice.currentCivilVoiceId = id;
	// get data
	getCivilVoiceDetail();
	getCivilVoiceCommentList();
});

// 시민참여 등록 화면 이동
$("#civilVoiceInputButton").on('click', function(){
	civilVoice.showContent('input');
	civilVoice.clear();
});

// 시민참여 수정 화면 이동
$('#civilVoiceContent').on('click', '#civilVoiceModifyButton', function(){
	civilVoice.showContent('modify');
	getCivilVoiceModify();
});

// 시민참여 취소 / 목록 보기
$('#civilVoiceContent').on('click', '[data-goto=list]', function(){
	civilVoice.showContent('list');
	getCivilVoiceList(civilVoice.currentPage);
});

// 시민참여 취소 / 상세 보기
$('#civilVoiceContent').on('click', '[data-goto=detail]', function(){
	civilVoice.showContent('detail');
});

// 시민참여 목록 조회
function getCivilVoiceList(page) {
	if(!page) page = 1;

	if(!$.isEmptyObject(civilVoice)) {
		civilVoice.currentPage = page;
		civilVoice.currentCivilVoiceId = null;
		civilVoice.clear();
	}

	var formId = 'civilVoiceSearchForm';
	var formData = $('#' + formId).serialize();

	$.ajax({
		url: '/civil-voices',
		type: 'GET',
		headers: {'X-Requested-With': 'XMLHttpRequest'},
		data: formData + '&pageNo='+page,
		dataType: 'json',
		success: function(res){
			if(res.statusCode <= 200) {
				$('#civilVoiceTotalCount').text(formatNumber(res.totalCount));
				$('#civilVoiceCurrentPage').text(res.pagination.pageNo);
				$('#civilVoiceLastPage').text(res.pagination.lastPage);
				civilVoice.drawHandlebarsHtml(res, 'templateCivilVoiceList', 'civilVoiceList');
				civilVoice.drawHandlebarsHtml(res, 'templateCivilVoicePagination', 'civilVoicePagination');
			} else {
				alert(JS_MESSAGE[res.errorCode]);
				console.log("---- " + res.message);
				}
		},
		error: function(request, status, error) {
			alert(JS_MESSAGE["ajax.error.message"]);
		}
	});
}

// 시민참여 전체 목록 조회
function getCivilVoiceListAll(render) {
	$.ajax({
		url: '/civil-voices/all',
		type: 'GET',
		headers: {'X-Requested-With': 'XMLHttpRequest'},
		dataType: 'json',
		success: function(res){
			if(res.statusCode <= 200) {
				civilVoice.cluster.list = res.civilVoiceList;

				if(render) {
					civilVoice.cluster.startRender();
				}
			} else {
				alert(JS_MESSAGE[res.errorCode]);
				console.log("---- " + res.message);
			}
		},
		error: function(request, status, error) {
			alert(JS_MESSAGE["ajax.error.message"]);
		}
	});
}

// 시민참여 상세 조회
function getCivilVoiceDetail() {
	var id = civilVoice.currentCivilVoiceId;

	$.ajax({
		url: '/civil-voices/' + id,
		type: 'GET',
		headers: {'X-Requested-With': 'XMLHttpRequest'},
		contentType: "application/json; charset=utf-8",
		dataType: 'json',
		success: function(res){
			if(res.statusCode <= 200) {
				civilVoice.drawHandlebarsHtml(res, 'templateCivilVoiceView', 'civilVoiceView');
				civilVoice.flyToLocation(res.civilVoice.longitude, res.civilVoice.latitude);

				var contents = $('#civilVoiceContents').text();
				contents = contents.replace(/(?:\r\n|\r|\n)/g, '<br />');
				$("#civilVoiceContents").html(contents);
			} else {
				alert(JS_MESSAGE[res.errorCode]);
				console.log("---- " + res.message);
				}
		},
		error: function(request, status, error) {
			alert(JS_MESSAGE["ajax.error.message"]);
		}
	});
}

// 시민참여  수정 화면 요청
function getCivilVoiceModify() {
	var id = civilVoice.currentCivilVoiceId;

	$.ajax({
		url: '/civil-voices/' + id,
		type: 'GET',
		headers: {'X-Requested-With': 'XMLHttpRequest'},
		contentType: "application/json; charset=utf-8",
		dataType: 'json',
		data: {readOnly: false},
		success: function(res){
			if(res.statusCode <= 200) {
				civilVoice.drawHandlebarsHtml(res, 'templateCivilVoiceModify', 'civilVoiceModify');
			} else {
				alert(JS_MESSAGE[res.errorCode]);
				console.log("---- " + res.message);
				}
		},
		error: function(request, status, error) {
			alert(JS_MESSAGE["ajax.error.message"]);
		}
	});
}

// 시민참여 댓글 조회
function getCivilVoiceCommentList(page) {
	if(!page) page = 1;
	var id = civilVoice.currentCivilVoiceId;

	$.ajax({
		url: '/civil-voice-comments/' + id,
		type: 'GET',
		headers: {'X-Requested-With': 'XMLHttpRequest'},
		contentType: "application/json; charset=utf-8",
		dataType: 'json',
		data: {pageNo: page},
		success: function(res){
			if(res.statusCode <= 200) {
				$('#civilVoiceCommentTotalCount').text(formatNumber(res.totalCount));
				civilVoice.drawHandlebarsHtml(res, 'templateCivilVoiceComment', 'civilVoiceComment');
				civilVoice.drawHandlebarsHtml(res, 'templateCivilVoiceCommentPagination', 'civilVoiceCommentPagination');

				civilVoice.updateMarker(res.totalCount);
			} else {
				alert(JS_MESSAGE[res.errorCode]);
				console.log("---- " + res.message);
			}
		},
		error: function(request, status, error) {
			alert(JS_MESSAGE["ajax.error.message"]);
		}
	});
}

// 시민참여 등록
var insertCivilVoiceFlag = true;
function saveCivilVoice() {
	if(!civilVoiceValidation($('#civilVoiceForm'))) return false;

	if(insertCivilVoiceFlag) {
		insertCivilVoiceFlag = false;
		var url = "/civil-voices";
		var formId = 'civilVoiceForm';
		var $form = $('#' + formId);
		var formData = $form.serialize();

		$.ajax({
			url: url,
			type: "POST",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			data: formData,
			dataType: "json",
			success: function(msg) {
				if(msg.statusCode <= 200) {
					alert("저장 되었습니다.");

					//클러스터 데이터 추가 시 갱신
					civilVoice.cluster.addVoice.call(civilVoice.cluster, {
						longitude : $form.find('input[name="longitude"]').val(),
						latitude : $form.find('input[name="latitude"]').val(),
						civilVoiceId : msg.civilVoiceId,
						commentCount : 0
					});

					civilVoice.initFormContent(formId);
					civilVoice.showContent('list');
					civilVoice.clear();
					getCivilVoiceList();
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
					console.log("---- " + msg.message);
				}
				insertCivilVoiceFlag = true;
			},
	        error: function(request, status, error) {
	        	alert(JS_MESSAGE["ajax.error.message"]);
	        	insertCivilVoiceFlag = true;
	        }
		});
	} else {
		alert("진행 중입니다.");
		return;
	}
}

// 시민참여 수정
var updateCivilVoiceFlag = true;
function updateCivilVoice() {
	if(!civilVoiceValidation($('#civilVoiceModifyForm'))) return false;
	var id = civilVoice.currentCivilVoiceId;

	if(updateCivilVoiceFlag) {
		updateCivilVoiceFlag = false;
		var url = "/civil-voices/" + id;
		var formId = 'civilVoiceModifyForm';
		var $form = $('#' + formId);
		var formData = $form.serialize();

		$.ajax({
			url: url,
			type: "POST",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			data: formData,
			dataType: "json",
			success: function(msg) {
				if(msg.statusCode <= 200) {
					alert("저장 되었습니다.");

					//클러스터 데이터 수정 시 갱신
					var updatedVoice = civilVoice.cluster.list.filter(function(item){
						return item.civilVoiceId === id;
					})[0];


					civilVoice.cluster.updateVoice.call(civilVoice.cluster, {
						longitude : $form.find('input[name="longitude"]').val(),
						latitude : $form.find('input[name="latitude"]').val(),
						civilVoiceId : msg.civilVoiceId,
						commentCount : updatedVoice.commentCount
					});

					civilVoice.initFormContent(formId);
					civilVoice.showContent('detail');
					civilVoice.clear();
					getCivilVoiceDetail(id);
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
					console.log("---- " + msg.message);
				}
				updateCivilVoiceFlag = true;
			},
	        error: function(request, status, error) {
	        	alert(JS_MESSAGE["ajax.error.message"]);
	        	updateCivilVoiceFlag = true;
	        }
		});
	} else {
		alert("진행 중입니다.");
		return;
	}
}

// 시민참여 삭제
var deleteCivilVoiceFlag = true;
function deleteCivilVoice(id) {
	if(!deleteWarning()) return false;

	if(deleteCivilVoiceFlag) {
		deleteCivilVoiceFlag = false;
		var url = "/civil-voices/" + id;

		$.ajax({
			url: url,
			type: "DELETE",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg) {
				if(msg.statusCode <= 200) {
					alert("삭제 되었습니다.");

					//클러스터 데이터 삭제 시 갱신
					civilVoice.cluster.deleteVoice.call(civilVoice.cluster, id);

					civilVoice.showContent('list');
					getCivilVoiceList();
				} else {
					alert(msg.message);
					console.log("---- " + msg.message);
				}
				deleteCivilVoiceFlag = true;
			},
	        error: function(request, status, error) {
	        	alert(JS_MESSAGE["ajax.error.message"]);
	        	deleteCivilVoiceFlag = true;
	        }
		});
	} else {
		alert("진행 중입니다.");
		return;
	}
}

// 시민참여 댓글 등록
var insertCivilVoiceCommentFlag = true;
function saveCivilVoiceComment() {
	if(insertCivilVoiceCommentFlag) {
		insertCivilVoiceCommentFlag = false;
		var id = civilVoice.currentCivilVoiceId;
		var url = "/civil-voice-comments";
		var formId = 'civilVoiceCommentForm';
		var formData = $('#' + formId).serialize();

		$.ajax({
			url: url,
			type: "POST",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			data: formData + '&civilVoiceId=' + id,
			dataType: "json",
			success: function(msg) {
				if(msg.statusCode <= 200) {
					alert("등록 되었습니다.");

					//클러스터 데이터 삭제 시 갱신
					civilVoice.cluster.updateVoiceCommentCnt.call(civilVoice.cluster, id);
					civilVoice.initFormContent(formId);

					getCivilVoiceCommentList();
				} else {
		        	alert(JS_MESSAGE[msg.errorCode]);
					console.log("---- " + msg.message);
				}
				insertCivilVoiceCommentFlag = true;
			},
	        error: function(request, status, error) {
	        	alert(JS_MESSAGE["ajax.error.message"]);
	        	insertCivilVoiceCommentFlag = true;
	        }
		});
	} else {
		alert("진행 중입니다.");
		return;
	}
}

// validation
function civilVoiceValidation(form) {
	if(!form.find('[name=title]').val()) {
		alert("제목을 입력하여 주십시오.");
		form.find('[name=title]').focus();
		return false;
	}
	if(!form.find('[name=longitude]').val() || !form.find('[name=latitude]').val()) {
		alert("위치를 지정하여 주십시오.");
		form.find('[name=longitude]').focus();
		return false;
	}
	if(!form.find('[name=contents]').val()) {
		alert("내용을 입력하여 주십시오.");
		form.find('[name=contents]').focus();
		return false;
	}
	return true;
}
