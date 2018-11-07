<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>main | mago3D User</title>
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="/css/cloud.css?cache_version=${cache_version}">
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
<c:if test="${geoViewLibrary == null || geoViewLibrary eq '' || geoViewLibrary eq 'cesium' }">
	<link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css?cache_version=${cache_version}" />
</c:if>
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
	<script type="text/javascript" src="/js/cloud.js?cache_version=${cache_version}"></script>
	<link rel="stylesheet" href="/externlib/jquery-toast/jquery.toast.css" />
	<script type="text/javascript" src="/externlib/jquery-toast/jquery.toast.js"></script>
	<style type="text/css">
		#objectLabel {
			position:absolute;left:0px;top:0px; z-index: 999; pointer-events: none;
		}
	</style>
</head>
<body>

<div class="site-body">
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<div id="site-content" class="on">
		<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
		<div id="content-wrap">
			<div id="magoContainer" style="height: 700px;"></div>
			<canvas id="objectLabel"></canvas>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
</div>
<c:if test="${geoViewLibrary == null || geoViewLibrary eq '' || geoViewLibrary eq 'cesium' }">
<script type="text/javascript" src="/externlib/cesium/Cesium.js?cache_version=${cache_version}"></script>
</c:if>
<c:if test="${geoViewLibrary eq 'worldwind' }">
<script type="text/javascript" src="/externlib/webworldwind/worldwind.js?cache_version=${cache_version}"></script>
</c:if>
<script type="text/javascript" src="/js/mago3d.js?cache_version=${cache_version}"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script>
console.log("---------------- window.innerHeight = " + window.innerHeight);
	var mapSize = window.innerHeight - 106;
	console.log("---------------- map size = " + mapSize);
	$("#magoContainer").css("height", mapSize);

	var agent = navigator.userAgent.toLowerCase();
	if(agent.indexOf('chrome') < 0) { 
		alert(JS_MESSAGE["demo.browser.recommend"]);
	}

	var managerFactory = null;
	var policyJson = ${policyJson};
	var initProjectJsonMap = ${initProjectJsonMap};
	var menuObject = { 	homeMenu : false, myIssueMenu : false, searchMenu : false, apiMenu : false, insertIssueMenu : false, 
						treeMenu : false, chartMenu : false, logMenu : false, attributeMenu : false, configMenu : false };
	var insertIssueEnable = false;
	var FPVModeFlag = false;
	
	var imagePath = "/images/${lang}";
	var dataInformationUrl = "/data/ajax-project-data-by-project-id.do";
	magoStart();
	var intervalCount = 0;
	var timerId = setInterval("startMogoUI()", 1000);
	
	$(document).ready(function() {
	});
	
	function startMogoUI() {
		intervalCount++;
		if(managerFactory != null && managerFactory.getMagoManagerState() === CODE.magoManagerState.READY) {
			//initJqueryCalendar();
			// Label 표시
			changeLabel(false);
			// object 정보 표시
			changeObjectInfoViewMode(true);
			// Origin 표시
            changeOrigin(false);
			// BoundingBox
			changeBoundingBox(false);
			// Selecting And Moving
			changeObjectMove("2");
			// slider, color-picker
			initRendering();
			// 3PView Mode
			changeViewMode(false);
			
			clearInterval(timerId);
			console.log(" managerFactory != null, managerFactory.getMagoManagerState() = " + managerFactory.getMagoManagerState() + ", intervalCount = " + intervalCount);
			return;
		}
		console.log("--------- intervalCount = " + intervalCount);
	}
	
	// mago3d 시작, 정책 데이터 파일을 로딩
	function magoStart() {
		var initProjectsLength = ${initProjectsLength};
		if(initProjectsLength === null || initProjectsLength === 0) {
			managerFactory = new ManagerFactory(null, "magoContainer", policyJson, null, null, null, imagePath);
		} else {
			var projectIdArray = new Array(initProjectsLength);
			var projectDataArray = new Array(initProjectsLength);
			var projectDataFolderArray = new Array(initProjectsLength);
			var index = 0;
			for(var projectId in initProjectJsonMap) {
				projectIdArray[index] = projectId;
				var projectJson = JSON.parse(initProjectJsonMap[projectId]);
				projectDataArray[index] = projectJson;
				projectDataFolderArray[index] = projectJson.data_key;
				index++;
			}
			
			managerFactory = new ManagerFactory(null, "magoContainer", policyJson, projectIdArray, projectDataArray, projectDataFolderArray, imagePath);			
		}
	}
	
	// 프로젝트를 로딩한 후 이동
	function gotoProject(projectId, longitude, latitude, height, duration) {
		var projectData = getDataAPI(CODE.PROJECT_ID_PREFIX + projectId);
		if (projectData === null || projectData === undefined) {
			$.ajax({
				url: dataInformationUrl,
				type: "POST",
				data: "project_id=" + projectId,
				dataType: "json",
				headers: { "X-mago3D-Header" : "mago3D"},
				success : function(msg) {
					if(msg.result === "success") {
						var projectDataJson = JSON.parse(msg.projectDataJson);
						if(projectDataJson === null || projectDataJson === undefined) {
							alert(JS_MESSAGE["project.data.no.found"]);
							return;
						}
						gotoProjectAPI(managerFactory, projectId, projectDataJson, projectDataJson.data_key, longitude, latitude, height, duration);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
				},
				error : function(request, status, error) {
					alert(JS_MESSAGE["ajax.error.message"]);
					console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
				}
			});
		} else {
			gotoProjectAPI(managerFactory, projectId, projectData, projectData.data_key, longitude, latitude, height, duration);	
		}
		
		// 현재 좌표를 저장
		saveCurrentLocation(latitude, longitude);
	}
	
	// 설정 메뉴 시작
	// Label 표시
	function changeLabel(isShow) {
		$("input:radio[name='labelInfo']:radio[value='" + isShow + "']").prop("checked", true);
		changeLabelAPI(managerFactory, isShow);
	}
	// object info 표시
	function changeObjectInfoViewMode(isShow) {
	}
	// Origin 표시/비표시
    function changeOrigin(isShow) {
    }
	// boundingBox 표시/비표시
	function changeBoundingBox(isShow) {
	}
	function changeObjectMove() {
	}
	function initRendering() {
	}
	function changeViewMode() {
	}
	// click poisition call back function
	function showClickPosition(position) {
		
	}
	
	// 모든 데이터 비표시
	function clearAllData() {
		
	}
	
	// general callback alert function
	function showApiResult(apiName, result) {
		
	}
	
	function saveCurrentLocation(latitude, longitude) {
		
	}
	
	// moved data callback
	function showMovedData(projectId, dataKey, objectId, latitude, longitude, height, heading, pitch, roll) {
		
    }
</script>
</body>
</html>
