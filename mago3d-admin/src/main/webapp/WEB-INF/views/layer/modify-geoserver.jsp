<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>Layer 수정 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css?cacheVersion=${contentCacheVersion}">
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
    <link rel="stylesheet" href="/css/${lang}/admin-style.css?cacheVersion=${contentCacheVersion}" />
    <style type="text/css">
    	.loader-txt p {
            font-size: 13px;
            color: #666;
        }
    
        .loader-txt p small {
            font-size: 11.5px;
            color: #999;
        }
        
        .loader {
            position: relative;
            text-align: center;
            margin: 15px auto 35px auto;
            z-index: 9999;
            display: block;
            width: 80px;
            height: 80px;
            border: 10px solid rgba(0, 0, 0, 0.3);
            border-radius: 50%;
            border-top-color: #000;
            animation: spin 1s ease-in-out infinite;
            -webkit-animation: spin 1s ease-in-out infinite;
        }
        @keyframes spin {
            to {
                -webkit-transform: rotate(360deg);
            }
        }
    
        @-webkit-keyframes spin {
            to {
                -webkit-transform: rotate(360deg);
            }
        }
    </style>
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
						<div class="input-header row">
							<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='check'/></div>
						</div>
						<form:form id="layer" modelAttribute="layer" method="post" onsubmit="return false;">
						<form:hidden path="layerId"/>
						<table class="input-table scope-row" summary="geoserver 레이어 수정 테이블">
						<caption class="hiddenTag">geoserver 레이어 수정</caption>
							<colgroup>
			                    <col class="col-label l" style="width: 15%" >
			                    <col class="col-input" style="width: 35%" >
			                    <col class="col-label l" style="width: 15%" >
			                    <col class="col-input" style="width: 35%" >
			                </colgroup>
			                <tr>
								<th class="col-label" scope="row">
									<form:label path="layerGroupName">Layer 그룹명</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:hidden path="layerGroupId" />
									<form:input path="layerGroupName" cssClass="ml" readonly="true" />
									<input type="button" id="layerGroupButtion" value="Layer 그룹 찾기" />
								</td>
								<th class="col-label" scope="row">
			                        <label for="sharing">공유 유형</label>
			                    </th>
			                    <td class="col-input radio-set">
			                        <form:radiobutton id="sharingPublic"  path="sharing" value="public" label="공개" />
									<form:radiobutton id="sharingPrivate" path="sharing" value="private" label="비공개" />
									<form:radiobutton id="sharingGroup" path="sharing" value="group" label="그룹" />
			                    </td>
							</tr>
							<tr>
			                    <th class="col-label" scope="row">
			                        <form:label path="layerName">Layer 명</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input">
			                        <form:input path="layerName" cssClass="ml" />
			                        <form:errors path="layerName" cssClass="error" />
			                    </td>
			                    <th class="col-label" scope="row">
			                        <form:label path="layerKey">Layer Key</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input">
			                        <form:input path="layerKey" cssClass="ml" readonly="true" />
			                        <form:errors path="layerKey" cssClass="error" />
			                    </td>
			                </tr>
			                <tr>
			                    <th class="col-label" scope="row">
			                        <form:label path="serviceType">서비스 타입</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input">
			                        <select id="serviceType" name="serviceType" class="selectBoxClass">
										<option value="">선택</option>
										<option value="wms">WMS</option>
										<option value="wfs">WFS</option>
										<option value="wcs">WCS</option>
										<option value="wps">WPS</option>
									</select>
			                    </td>
			                    <th class="col-label" scope="row">
			                        <label for="cacheAvailableTrue">Cache 사용 유무</label>
			                    </th>
			                    <td class="col-input radio-set">
			                        <form:radiobutton id="cacheAvailableTrue"  path="cacheAvailable" value="true" label="사용" />
									<form:radiobutton id="cacheAvailableFalse" path="cacheAvailable" value="false" label="미사용" checked="checked"/>
			                    </td>
			                </tr>
			                <tr>
			                	<th class="col-label" scope="row">
			                        <form:label path="layerType">Layer 타입</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input">
			                        <select id="layerType" name="layerType" class="selectBoxClass">
										<option value="">선택</option>
										<option value="vector">Vector</option>
										<option value="raster">Raster</option>
									</select>
			                    </td>
			                    <th class="col-label" scope="row">
			                        <form:label path="geometryType">도형 타입</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
								<td class="col-input">
									<select id="geometryType" name="geometryType" class="forRaster selectBoxClass">
										<option value="">선택</option>
										<option value="Point">Point</option>
										<option value="Line">Line</option>
										<option value="Polygon">Polygon</option>
									</select>
								</td>
							</tr>
							<tr>	
								<th class="col-label" scope="row">
			                        <form:label path="layerLineColor">외곽선 색상</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
								<td class="col-input">
									<label for="lineColorValue" class="hiddenTag">외곽선 색상값</label>
									<input id="lineColorValue" placeholder="RGB" class="forRaster forLineColor" />
									<input type="color" id="layerLineColor" name="layerLineColor" class="picker forLineColor" alt="외곽선 색상" />
								</td>
								<th class="col-label" scope="row">
			                        <form:label path="layerLineStyle">외곽선 두께</form:label>
			                    </th>
								<td class="col-input">
									<input type="number" id="layerLineStyle"  name="layerLineStyle" class="forRaster" alt="외곽선 두께" min="0.1" max="5.0" size="3" step="0.1">
								</td>
							</tr>
			                <tr>
			                	<th class="col-label" scope="row">
			                        <form:label path="layerFillColor">채우기 색상</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
								<td class="col-input">
									<label for="fillColorValue" class="hiddenTag">채우기 색상값</label>
									<input id="fillColorValue" placeholder="RGB" class="forRaster forPolygon">
									<input type="color" id="layerFillColor" name="layerFillColor" class="picker forPolygon" alt="채우기 색상">
								</td>
			                	<th class="col-label" scope="row">
			                        <form:label path="layerAlphaStyle">투명도</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
								<td class="col-input">
									<form:input type="text" path="layerAlphaStyle" class="slider" alt="투명도"/>
									<label for="sliderRange" class="hiddenTag">투명도 값</label>
									<input type="range" id="sliderRange" min="0" max="100" value="100" alt="투명도">
								</td>
			                </tr>
			                <tr>
			                	<th class="col-label" scope="row">
			                        <label for="viewOrder">레이어 표시 순서</label>
			                    </th>
			                    <td class="col-input">
			                        <form:input path="viewOrder" cssClass="s"/>
			                        <form:errors path="viewOrder" cssClass="error" />
			                    </td>
			                	<th class="col-label" scope="row">
			                        <label for="zIndex">표시 순서(Z-Index)</label>
			                    </th>
			                    <td class="col-input">
			                        <form:input path="zIndex" cssClass="s" />
			                        <form:errors path="zIndex" cssClass="error" />
			                    </td>
			                </tr>
			                <tr>
			                	<th class="col-label" scope="row">
			                        <label for="defaultDisplayTrue">기본 표시</label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input radio-set">
			                        <form:radiobutton id="defaultDisplayTrue"  path="defaultDisplay" value="true" label="사용" />
									<form:radiobutton id="defaultDisplayFlase" path="defaultDisplay" value="false" label="미사용" />
			                    </td>
			                	<th class="col-label" scope="row">
			                        <label for="useY">사용유무</label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input radio-set">
			                        <form:radiobutton id="availableTrue"  path="available" value="true" label="사용" />
									<form:radiobutton id="availableFalse" path="available" value="false" label="미사용" />
			                    </td>
			                </tr>
			                <tr>
			                	<th class="col-label" scope="row">
			                        <label for="labelDisplayTrue">Label 표시 유무</label>
			                    </th>
			                    <td class="col-input radio-set">
			                        <form:radiobutton id="labelDisplayTrue"  path="labelDisplay" value="true" label="표시" />
									<form:radiobutton id="labelDisplayFalse" path="labelDisplay" value="false" label="비표시" />
			                    </td>
			                    <th class="col-label" scope="row">
			                        <form:label path="description">설명</form:label>
			                    </th>
			                    <td class="col-input">
			                        <form:input path="description" cssClass="l"/>
			                        <form:errors path="description" cssClass="error" />
			                    </td>
			                </tr>
						</table>
						</form:form>
						
						<div class="button-group" style="margin-top:30px;">
							<div class="center-buttons">
								<input type="submit" onClick="geoserverLayerUpdate(); return false;" value="<spring:message code='save'/>"/>
								<a href="/layer/list" class="button">목록</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	<%@ include file="/WEB-INF/views/layer/loading-dialog.jsp" %>
	<!-- Dialog -->
	<%@ include file="/WEB-INF/views/layer/layer-group-dialog.jsp" %>
	
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/navigation.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript">
	$(document).ready(function() {
		showRange(parseInt('${layer.layerAlphaStyle * 100}'));
		changeLayerType('${layer.layerType}');
		changeGeometryType('${layer.geometryType}');
		$("#sliderRange").val(parseInt('${layer.layerAlphaStyle * 100}'));
		$("#layerLineStyle").val('${layer.layerLineStyle}');
		$("input[name='sharing']").filter("[value='${layer.sharing}']").prop("checked", true);
		$("input[name='defaultDisplay']").filter("[value='${layer.defaultDisplay}']").prop("checked", true);
		$("input[name='available']").filter("[value='${layer.available}']").prop("checked", true);
        $("input[name='labelDisplay']").filter("[value='${layer.labelDisplay}']").prop("checked", true);
        $("input[name='layerFillColor']").filter("[value='${layer.layerFillColor}']").prop("checked", true);
        $("input[name='labelDisplay']").filter("[value='${layer.labelDisplay}']").prop("checked", true);
        $("select[name=serviceType] option[value='${layer.serviceType}'").prop('selected',true);
        $("select[name=geometryType] option[value='${layer.geometryType}'").prop('selected',true);
        $("select[name=layerType] option[value='${layer.layerType}'").prop('selected',true);
        $(".forLineColor").val("${layer.layerLineColor}");
        $(".forPolygon").val("${layer.layerFillColor}");
        $("input[name='cacheAvailable']").filter("[value='${layer.cacheAvailable}']").prop("checked", true);
        
        if('${layer.serviceType}' !== 'wms') {
        	$("input[name='cacheAvailable']").attr("disabled", true);
        }
        
	});
	
	$('[name=layerType]').on('change', function() {
		changeLayerType($("[name=layerType]").val());
	});
	
	$('[name=geometryType]').on('change', function() {
		changeGeometryType($("[name=geometryType]").val());
	});
	
	// wms일 경우에만 cache 설정 할 수 있도록 활성화
	$("select[name=serviceType]").change(function(e){
		var value = $(this).val();
	    if(value === "wms") {
	    	$("input[name='cacheAvailable']").attr("disabled", false);
	    } else {
	    	$("input[name='cacheAvailable']").attr("disabled", true);
	    	$("input[name='cacheAvailable']").filter("[value='false']").prop("checked", true);
	    }
	});
	
	
	// 레이어 타입 Raster 선택 시 입력폼 변경
	function changeLayerType(layerType) {
		if(layerType == 'vector') {
			$('.forRaster').attr('disabled', false);
			$('.forRaster').removeClass('disabled');
			$('.picker').attr('disabled', false);
			changeGeometryType(null);
			$('#layerLineStyle').val(Number(1.0));
		} else {
			$('.forRaster').attr('disabled', true);
			$('.forRaster').addClass('disabled');
			$('.picker').attr('disabled', true);
			$('.forRaster').val('');
			$('.picker').val(null);
		}
	}

	// 도형 타입 Polygon 선택시 선택폼 변경
	function changeGeometryType(geometryType) {
		if(geometryType == 'Polygon') {
			$('.forPolygon').attr('disabled', false);
			$('.forPolygon').removeClass("disabled");
			$('.picker.forPolygon').attr('disabled', false);
		} else {
			$('.forPolygon').attr('disabled', true);
			$('.forPolygon').addClass("disabled");
			$('.picker.forPolygon').attr('disabled', true);
			$('.forPolygon').val(null);
		}
	}
	
	// 슬라이더
	function showRange(valus) {
		$('#layerAlphaStyle').val(valus + "%");
	}

	var rangeSlider = function(){
		var range = $('#sliderRange');
		
		range.on('change', function(){		
			showRange(this.value);
		});
	};
	rangeSlider();

	// color picker
	function pickerColor() {
		var layerFillColor = $('#layerFillColor');
		var layerLineColor = $('#layerLineColor');
		var fillColorValue = $('#fillColorValue');
		var lineColorValue = $('#lineColorValue');
		
		layerFillColor.on('change', function(){		
			$('#fillColorValue').val($(this).val().toUpperCase());
		});

		layerLineColor.on('change', function(){		
			$('#lineColorValue').val($(this).val().toUpperCase());
		});

		fillColorValue.on('change', function(){		
			$('#layerFillColor').val($(this).val().toUpperCase());
		});

		lineColorValue.on('change', function(){		
			$('#layerLineColor').val($(this).val().toUpperCase());
		});
	}
	pickerColor();
	
	var layerGroupDialog = $( ".dialog" ).dialog({
		autoOpen: false,
		height: 600,
		width: 1200,
		modal: true,
		overflow : "auto",
		resizable: false
	});
	
	var layerLoadingDialog = $("#layerLoadingDialog").dialog({
		autoOpen: false,
		width: 250,
		height: 290,
		modal: true,
		resizable: false
	});
	
	// Layer Group 찾기
	$( "#layerGroupButtion" ).on( "click", function() {
		layerGroupDialog.dialog( "open" );
		layerGroupDialog.dialog( "option", "title", "Layer 그룹 선택");
	});
	
	// 상위 Node
	function confirmParent(parent, parentName) {
		$("#layerGroupId").val(parent);
		$("#layerGroupName").val(parentName);
		layerGroupDialog.dialog( "close" );
	}
	
	function check() {
		var number = /^[0-9]+$/;
		
		if(!$("#layerGroupId").val() || !number.test($("#layerGroupId").val())) {
			alert("레이어 그룹을 선택해 주세요.");
			$("#layerGroupName").focus();
			return false;
		}
		if (!$("#layerName").val()) {
			alert("Layer 명을 입력하여 주십시오.");
			$("#layerName").focus();
			return false;
		}
		if (!$("#layerKey").val()) {
			alert("Layer key를 입력하여 주십시오.");
			$("#layerKey").focus();
			return false;
		}
		if (!$("select[name=serviceType]").val()) {
			alert("서비스 타입을 선택해 주십시오.");
			$("#serviceType").focus();
			return false;
		}
		if (!$("select[name=layerType]").val()) {
			alert("layer 타입을 선택해 주십시오.");
			$("#layerType").focus();
			return false;
		}
		if ($("select[name=layerType]").val() ==='vector' && !$("select[name=geometryType]").val()) {
			alert("도형 타입을 선택해 주십시오.");
			$("#geometryType").focus();
			return false;
		}
	}
	
	var updateGeoserverLayerFlag = true;
	function geoserverLayerUpdate() {
	    if(updateGeoserverLayerFlag) {
	    	if (check() === false) {
                return;
            }
	    	updateGeoserverLayerFlag = false;
	    	$("#layerAlphaStyle").val($("#sliderRange").val() / 100);
	    	if(!$("#zIndex").val()) $("#zIndex").val(0);
	        var formData = $('#layer').serialize();
	        var layerLoadingDialog = $("#layerLoadingDialog").dialog({
	    		autoOpen: false,
	    		width: 250,
	    		height: 290,
	    		modal: true,
	    		resizable: false
	    	});
	        layerLoadingDialog.dialog("open");
	        $.ajax({
				url: "/layer/update-geoserver",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData,
				success: function(msg){
					if(msg.statusCode <= 200) {
						layerLoadingDialog.dialog("close");
						setTimeout(function(){
							alert(JS_MESSAGE["update"]);
						},100);
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
					updateGeoserverLayerFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateGeoserverLayerFlag = true;
				}
			});
	    } else {
	        alert("진행 중입니다.");
	        return;
		}
	}
	
</script>
</body>
</html>