<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>운영정책 | mago3D</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css?cacheVersion=${contentCacheVersion}">
    <link rel="stylesheet" href="/css/${lang}/admin-style.css?cacheVersion=${contentCacheVersion}" />
</head>
<body>
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	<div class="site-body">
		<div class="container">
			<div class="site-content">
				<%@ include file="/WEB-INF/views/layouts/sub_menu.jsp" %>
				<div class="page-area">
					<%@ include file="/WEB-INF/views/layouts/page_header.jsp" %>
					<div class="page-content">
						<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='check'/></div>
						<div class="tabs">
							<ul>
								<li><a href="#geopolicyTab">공간정보</a></li>
								<li><a href="#geoserverTab">GeoServer</a></li>
							</ul>
							<spring:message var="notuse" code='not.use'/>
							<spring:message var="use" code='use'/>
							<%@ include file="/WEB-INF/views/geopolicy/modify-geopolicy.jsp" %>
							<%@ include file="/WEB-INF/views/geopolicy/modify-geoserver.jsp" %>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/navigation.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$( ".tabs" ).tabs();
	});

	var updatePolicyGeoInfoFlag = true;
	function updatePolicyGeoInfo() {
	    if(updatePolicyGeoInfoFlag) {
	        if( geoInfoCheck() === false ) return false;

	        updatePolicyGeoInfoFlag = false;
	        var formData = $('#geoPolicyGeoInfo').serialize();
	        $.ajax({
				url: "/geopolicies/" + "${geoPolicy.geoPolicyId}",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData,
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert("공간정보 정책이 수정 되었습니다");
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
					updatePolicyGeoInfoFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updatePolicyGeoInfoFlag = true;
				}
			});
	    } else {
	        alert("진행 중입니다.");
	        return;
		}
	}

	var updatePolicyGeoServerFlag = true;
	function updatePolicyGeoServer() {
	    if(updatePolicyGeoServerFlag) {
	        if( geoserverCheck() === false ) return false;

	        updatePolicyGeoServerFlag = false;
	        var formData = $('#geoPolicyGeoServer').serialize();
	        $.ajax({
				url: "/geopolicies/geoserver/" + "${geoPolicy.geoPolicyId}",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData,
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert("GeoServer 정책이 수정 되었습니다");
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
					updatePolicyGeoServerFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updatePolicyGeoServerFlag = true;
				}
			});
	    } else {
	        alert("진행 중입니다.");
	        return;
		}
	}

	function numkeyCheck(event) {
		var keyValue = event.keyCode;
		if((keyValue >= 48) && (keyValue <= 57)) {
			return true;
		}
		return false;
	}

	function geoInfoCheck() {
		if(!$('#cesiumIonToken').val()) {
			alert('Cesium ion token을 입력해주세요.');
			$('#cesiumIonToken').focus();
			return false;
		}
		if(!$('#dataServicePath').val()) {
			alert('Data 폴더를 입력해주세요.');
			$('#dataServicePath').focus();
			return false;
		}
		if(!$('#terrainValue').val()) {
			alert('Terrain 값을 입력해주세요.');
			$('#terrainValue').focus();
			return false;
		}
		return true;
	}

	function geoserverCheck() {
		if(!$('#geoserverWmsVersion').val()) {
			alert('WMS 버전을 입력해주세요.');
			$('#geoserverWmsVersion').focus();
			return false;
		}
		if(!$('#geoserverDataUrl').val()) {
			alert('데이터 URL을 입력해주세요.');
			$('#geoserverDataUrl').focus();
			return false;
		}
		if(!$('#geoserverDataWorkspace').val()) {
			alert('작업공간명을 입력해주세요.');
			$('#geoserverDataWorkspace').focus();
			return false;
		}
		if(!$('#geoserverDataStore').val()) {
			alert('저장소명을 입력해주세요.');
			$('#geoserverDataStore').focus();
			return false;
		}
		if(!$('#geoserverUser').val()) {
			alert('사용자 계정을 입력해주세요.');
			$('#geoserverUser').focus();
			return false;
		}
		if(!$('#geoserverPassword').val()) {
			alert('비밀번호를 입력해주세요.');
			$('#geoserverPassword').focus();
			return false;
		}
		// ImageryProvider 사용 할 경우
		if($('[name=geoserverImageproviderEnable]:checked').val() == "true") {
			if(!$('#geoserverImageproviderUrl').val()) {
				alert('ImageryProvider 요청 URL을 입력해주세요.');
				$('#geoserverImageproviderUrl').focus();
				return false;
			}
			if(!$('#geoserverImageproviderLayerName').val()) {
				alert('ImageryProvider 레이어 명을 입력해주세요.');
				$('#geoserverImageproviderLayerName').focus();
				return false;
			}
			if(!$('#geoserverImageproviderStyleName').val()) {
				alert('ImageryProvider 스타일 명을 입력해주세요.');
				$('#geoserverImageproviderStyleName').focus();
				return false;
			}
			if(!$('#geoserverImageproviderParametersWidth').val()) {
				alert('ImageryProvider 레이어 이미지 가로 크기를 입력해주세요.');
				$('#geoserverImageproviderParametersWidth').focus();
				return false;
			}
			if(!$('#geoserverImageproviderParametersHeight').val()) {
				alert('ImageryProvider 레이어 이미지 세로 크기를 입력해주세요.');
				$('#geoserverImageproviderParametersHeight').focus();
				return false;
			}
			if(!$('#geoserverImageproviderParametersFormat').val()) {
				alert('ImageryProvider 레이어 포맷형식을 입력해주세요.');
				$('#geoserverImageproviderParametersFormat').focus();
				return false;
			}
		}
		// TerrainProvider 사용 할 경우
		if($('[name=terrainType]:checked').val() == "geoserver") {
			if(!$('#geoserverTerrainproviderStyleName').val()) {
				alert('TerrainProvider 스타일 명을 입력해주세요.');
				$('#geoserverTerrainproviderStyleName').focus();
				return false;
			}
			if(!$('#geoserverTerrainproviderParametersWidth').val()) {
				alert('TerrainProvider 레이어 이미지 가로 크기를 입력해주세요.');
				$('#geoserverTerrainproviderParametersWidth').focus();
				return false;
			}
			if(!$('#geoserverTerrainproviderParametersHeight').val()) {
				alert('TerrainProvider 레이어 이미지 세로 크기를 입력해주세요.');
				$('#geoserverTerrainproviderParametersHeight').focus();
				return false;
			}
			if(!$('#geoserverTerrainproviderParametersFormat').val()) {
				alert('TerrainProvider 레이어 포맷 형식을 입력해주세요.');
				$('#geoserverTerrainproviderParametersFormat').focus();
				return false;
			}
		}
		return true;
	}

</script>
</body>
</html>