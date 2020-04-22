<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>Layer 등록 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css?cacheVersion=${contentCacheVersion}" />
    <link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css?cacheVersion=${contentCacheVersion}">
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/dropzone/dropzone.min.css?cacheVersion=${contentCacheVersion}">
    <link rel="stylesheet" href="/css/${lang}/admin-style.css?cacheVersion=${contentCacheVersion}" />
    <script type="text/javascript" src="/externlib/dropzone/dropzone.min.js?cacheVersion=${contentCacheVersion}"></script>
    <style type="text/css">
        .dropzone .dz-preview.lp-preview {
            width: 150px;
        }
        .dropzone.hzScroll {
            min-width: 700px;
            overflow: auto;
            white-space: nowrap;
            border: 1px solid #e5e5e5;
        }

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
						<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='check'/></div>
						<div class="tabs" id="layerTabControl">
							<ul>
								<li><a href="#uploadLayerTab">업로드 레이어</a></li>
								<li><a href="#geoserverLayerTab">Geoserver 레이어</a></li>
							</ul>
 						<!-- 탭 제어를 위한 빈껍데기  -->
						<div id="uploadLayerTab"></div>
						<div id="geoserverLayerTab"></div>
						</div>
						<form:form id="layer" modelAttribute="layer" method="post" onsubmit="return false;">
						<form:hidden path="layerInsertType" value="upload"/>
						<table class="input-table scope-row" summary="2D 레이어 등록 테이블">
						<caption class="hiddenTag">2D 레이어 등록</caption>
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
									<form:input path="layerGroupName" cssClass="m" readonly="true" />
									<input type="button" id="layerGroupButtion" value="레이어 그룹 선택" />
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
			                        <form:input path="layerName" cssClass="m" maxlength="256" />
			                        <form:errors path="layerName" cssClass="error" />
			                    </td>
			                    <th class="col-label" scope="row">
			                        <form:label path="layerKey">Layer Key</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input">
			                        <form:input path="layerKey" cssClass="m" maxlength="100" />
			                        <label for="layerKeySelect" class="hiddenTag">geoserver layerKey</label>
			                        <select id="layerKeySelect" class="selectBoxClass" style="display:none;">
										<option value="">선택</option>
									</select>
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
			                        <label for="cacheAvailableTrue">Cache 사용 여부</label>
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
									<select id="geometryType" name="geometryType" class="forRaster selectBoxClass" >
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
									<input id="lineColorValue" placeholder="RGB" class="forRaster" />
									<input type="color" id="layerLineColor" name="layerLineColor" class="picker" alt="외곽선 색상" />
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
									<form:input type="text"  path="layerAlphaStyle" class="slider" alt="투명도"/>
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
			                        <label for="useY">사용 여부</label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input radio-set">
			                        <form:radiobutton id="availableTrue"  path="available" value="true" label="사용" />
									<form:radiobutton id="availableFalse" path="available" value="false" label="미사용" />
			                    </td>
			                </tr>
			                <tr>
			                	<th class="col-label" scope="row">
			                        <label for="labelDisplayTrue">Label 표시 여부</label>
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
			                <tr class="uploadLayerArea">
			                	<th class="col-label" scope="row">
			                        <form:label path="coordinate">좌표계</form:label>
			                    </th>
			                    <td class="col-input">
			                        <select id="coordinate"name="coordinate" class="selectBoxClass">
										<option value="EPSG:2096">EPSG:2096</option>
										<option value="EPSG:2097">EPSG:2097</option>
										<option value="EPSG:2098">EPSG:2098</option>
										<option value="EPSG:3857" selected>EPSG:3857</option>
										<option value="EPSG:32651">EPSG:32651</option>
										<option value="EPSG:32652">EPSG:32652</option>
										<option value="EPSG:4004">EPSG:4004</option>
										<option value="EPSG:4019">EPSG:4019</option>
										<option value="EPSG:4326">EPSG:4326</option>
										<option value="EPSG:5173">EPSG:5173</option>
										<option value="EPSG:5174">EPSG:5174</option>
										<option value="EPSG:5175">EPSG:5175</option>
										<option value="EPSG:5176">EPSG:5176</option>
										<option value="EPSG:5177">EPSG:5177</option>
										<option value="EPSG:5178">EPSG:5178</option>
										<option value="EPSG:5179">EPSG:5179</option>
										<option value="EPSG:5180">EPSG:5180</option>
										<option value="EPSG:5181">EPSG:5181</option>
										<option value="EPSG:5182">EPSG:5182</option>
										<option value="EPSG:5183">EPSG:5183</option>
										<option value="EPSG:5184">EPSG:5184</option>
										<option value="EPSG:5185">EPSG:5185</option>
										<option value="EPSG:5186">EPSG:5186</option>
										<option value="EPSG:5187">EPSG:5187</option>
										<option value="EPSG:5188">EPSG:5188</option>
									</select>
			                        <form:errors path="coordinate" cssClass="error" />
			                    </td>
			                	<th class="col-label" scope="row">
			                        <form:label path="shapeEncoding">SHP 파일 인코딩</form:label>
			                    </th>
			                    <td class="col-input">
			                    	<select id="shapeEncoding" class="selectBoxClass" name="shapeEncoding" style="width:100px; height: 30px;">
				                    	<option value="CP949">CP949</option>
				                        <option value="UTF-8">UTF-8</option>
				                    </select>
			                    </td>
			                </tr>
						</table>
						</form:form>

						<ul id="layerButtonArea">
							<li id="uploadLayerButton" class="onArea">
								<h4 style="margin-top: 30px; margin-bottom: 5px;">파일 업로딩</h4>
						        <div class="fileSection" style="font-size: 17px;">
						            <form id="my-dropzone" action="" class="dropzone hzScroll">
										<label for="dropzoneFile" class="hiddenTag">dropzoneFile영역</label>
						            </form>
						        </div>
						        <div class="button-group">
									<div class="center-buttons">
										<input type="submit" id="allFileUpload" value="<spring:message code='save'/>"/>
										<input type="submit" id="allFileClear" value="파일 초기화" />
										<a href="/layer/list" class="button">목록</a>
									</div>
								</div>
							</li>
							<li id="geoserverLayerButton" style="margin-top:30px;">
								<div class="button-group">
									<div class="center-buttons">
										<input type="submit" onClick="geoserverLayerSave(); return false;" value="<spring:message code='save'/>"/>
										<a href="/layer/list" class="button">목록</a>
									</div>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	<%@ include file="/WEB-INF/views/layer/spinner-dialog.jsp" %>
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
		$(".tabs").tabs();
		showRange(100);
		changeLayerType(null);
		changeGeometryType(null);

		$("input[name='sharing']").filter("[value='public']").prop("checked", true);
		$("input[name='defaultDisplay']").filter("[value='true']").prop("checked", true);
		$("input[name='available']").filter("[value='true']").prop("checked", true);
        $("input[name='labelDisplay']").filter("[value='true']").prop("checked", true);

        // geoserver layerlist 가져올 동안 스피너
		var layerLoadingDialog = $("#layerLoadingDialog").dialog({
			autoOpen: false,
			width: 250,
			height: 290,
			modal: true,
			resizable: false
		});
		layerLoadingDialog.dialog("open");
        getGeoserverLayerList(layerLoadingDialog);
        $("input[type='file']").attr("id", "dropzoneFile");
	});

	// 레이어 탭 이벤트
	$("#layerTabControl ul li").click(function(){
		var activeTab = $(this).find("a").attr("href");
		$("#layerButtonArea li").removeClass("onArea");
		if(activeTab === '#uploadLayerTab') {
			$("#uploadLayerButton").addClass("onArea");
			$(".uploadLayerArea").show();
			$("#layerInsertType").val("upload");
			$("#layerKey").show();
			$("#layerKeySelect").hide();
		} else {
			$("#geoserverLayerButton").addClass("onArea");
			$(".uploadLayerArea").hide();
			$("#layerInsertType").val("geoserver");
			$("#layerKey").hide();
			$("#layerKeySelect").show();
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

	// Layer Group 선택
	$( "#layerGroupButtion" ).on( "click", function() {
		layerGroupDialog.dialog( "open" );
		layerGroupDialog.dialog( "option", "title", "레이어 그룹 선택");
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
		if($("#layerInsertType").val() === 'upload' && !$("#layerKey").val()) {
			alert("Layer key를 입력하여 주십시오.");
			$("#layerKey").focus();
			return false;
		}
		if($("#layerInsertType").val() === 'geoserver' && !$("#layerKeySelect").val()) {
			alert("Layer key를 선택하여 주십시오.");
			$("#layerKeySelect").focus();
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
		if (!$("#coordinate").val()) {
			alert("좌표계를 선택해주세요.");
			$("#coordinate").focus();
			return false;
		}
	}

	var fileUploadDialog = $( ".spinner-dialog" ).dialog({
		autoOpen: false,
		width: 250,
		height: 290,
		modal: true,
		resizable: false
	});

	function alertMessage(response) {
		if(uploadFileResultCount === 0) {
			if(response.errorCode === "upload.file.type.invalid") {
				alert("복수의 파일을 업로딩 할 경우 zip 파일은 사용할 수 없습니다.");
			} else if(response.errorCode === "layer.name.empty") {
				alert("Layer 명이 유효하지 않습니다.");
			} else if(response.errorCode === "db.exception") {
				alert("죄송 합니다. 서버 실행중에 오류가 발생 하였습니다. \n 로그를 확인하여 주십시오.");
			} else if(response.errorCode === "io.exception") {
	            alert("입출력 처리 과정중 오류가 발생하였습니다. 잠시 후 다시 이용하여 주시기 바랍니다.");
	        } else if(response.errorCode === "runtime.exception") {
	            alert("프로그램 실행중 오류가 발생하였습니다. 잠시 후 다시 이용하여 주시기 바랍니다.");
	        } else if(response.errorCode === "unknown.exception") {
	            alert("서버 장애가 발생하였습니다. 잠시 후 다시 이용하여 주시기 바랍니다.");
	        } else {
	        	alert(JS_MESSAGE[response.errorCode]);
	        }
			uploadFileResultCount++;
		}
		return;
	}

    // 업로딩 파일 개수
    var uploadFileCount = 0;
    // dropzone 업로딩 결과(n개 파일을 올리면 n개 리턴이 옴)
    var uploadFileResultCount = 0;
    Dropzone.options.myDropzone = {
        url: "/layer/insert",
        //paramName: "file",
        // Prevents Dropzone from uploading dropped files immediately
        timeout: 3600000,
        autoProcessQueue: false,
        // 여러개의 파일 허용
        uploadMultiple: true,
        method: "post",
        // 병렬 처리
        parallelUploads: 10,
        // 최대 파일 업로드 갯수
        maxFiles: 10,
        // 최대 업로드 용량 Mb단위
        maxFilesize: 2000,
        dictDefaultMessage: "업로딩 하려면 Shape 파일을 올리거나 클릭 하십시오.",
        /* headers: {
            "x-csrf-token": document.querySelectorAll("meta[name=csrf-token]")[0].getAttributeNode("content").value,
        }, */
        // 허용 확장자
        acceptedFiles: initAcceptedFiles("${policy.shapeUploadType}"),
        // 업로드 취소 및 추가 삭제 미리 보기 그림 링크를 기본 추가 하지 않음
        // 기본 true false 로 주면 아무 동작 못함
        //clickable: true,
        fallback: function() {
            // 지원하지 않는 브라우저인 경우
            alert("죄송합니다. 최신의 브라우저로 Update 후 사용해 주십시오.");
            return;
        },
        init: function() {
            var myDropzone = this; // closure
            var uploadTask = document.querySelector("#allFileUpload");
            var clearTask = document.querySelector("#allFileClear");

            uploadTask.addEventListener("click", function(e) {
                if (check() === false) {
                    return;
                }

                uploadFileCount = 0;
                uploadFileResultCount = 0;
                e.preventDefault();
                e.stopPropagation();

                if (myDropzone.getQueuedFiles().length > 0) {
                    uploadFileCount = myDropzone.getQueuedFiles().length;
                    myDropzone.processQueue();
                    //startSpinner("fileUploadSpinner");
                    fileUploadDialog.dialog( "open" );
                } else {
                    //send empty
                    //myDropzone.uploadFiles([{ name: 'nofiles', upload: { filename: 'nofiles' } }]);
                    myDropzone._uploadData([{ upload: { filename: '' } }], [{ filename: '', name: '', data: new Blob() }]);
                }
            });

            clearTask.addEventListener("click", function () {
                // Using "_this" here, because "this" doesn't point to the dropzone anymore
	            if (confirm("[파일 업로딩]의 모든 파일을 삭제하겠습니까?")) {
                    // true 주면 업로드 중인 파일도 다 같이 삭제
                    myDropzone.removeAllFiles(true);
                }
            });

            this.on("sending", function(file, xhr, formData) {
                formData.append("layerGroupId", $("#layerGroupId").val());
                formData.append("sharing", $(':radio[name="sharing"]:checked').val());
                formData.append("layerName", $("#layerName").val());
                formData.append("layerKey", $("#layerKey").val());
                formData.append("serviceType", $("select[name=serviceType]").val());
                formData.append("layerType", $("select[name=layerType]").val());
                formData.append("geometryType", $("select[name=geometryType]").val());
                formData.append("layerLineColor", $("#layerLineColor").val());
                formData.append("layerFillColor", $("#layerFillColor").val());
                formData.append("layerAlphaStyle", $("#sliderRange").val() / 100);
                formData.append("defaultDisplay", $(':radio[name="defaultDisplay"]:checked').val());
                formData.append("available", $(':radio[name="available"]:checked').val());
                formData.append("labelDisplay", $(':radio[name="labelDisplay"]:checked').val());
                formData.append("coordinate", $("#coordinate").val());
                formData.append("description", $("#description").val());
                formData.append("shapeEncoding", $("#shapeEncoding").val());
                formData.append("layerInsertType", $("#layerInsertType").val());
                formData.append("cacheAvailable", $(':radio[name="cacheAvailable"]:checked').val());
                var zIndex = 0;
                var viewOrder = 1;
                if($("#zIndex").val()) zIndex = $("#zIndex").val();
                if($("#viewOrder").val()) viewOrder = $("#viewOrder").val();
                formData.append("zIndex", zIndex);
                formData.append("viewOrder", viewOrder);
                var layerLineStyle = 0;
                if($("#layerLineStyle").val()) layerLineStyle = $("#layerLineStyle").val();
                formData.append("layerLineStyle", layerLineStyle);
            });

            // maxFiles 카운터를 초과하면 경고창
            this.on("maxfilesexceeded", function (data) {
                alert("최대 업로드 파일 수는 10개 입니다.");
                return;
            });

            this.on("success", function(file, response) {
            	if(file !== undefined && file.name !== undefined) {
	                console.log("file name = " + file.name);
	                $("#fileUploadSpinner").empty();
	                fileUploadDialog.dialog( "close" );
					if(response.errorCode === undefined || response.errorCode === null) {
						uploadFileResultCount ++;
						if(uploadFileCount === uploadFileResultCount) {
							alert(JS_MESSAGE["insert"]);
						    uploadFileCount = 0;
						    uploadFileResultCount = 0;
		                    myDropzone.removeAllFiles(true);
						}
	                } else {
	                	alertMessage(response);
	                	myDropzone.removeAllFiles(true);
	                }
	            } else {
					console.log("------- success response = " + response);
					if(response.statusCode <= 200) {
		        		alert(JS_MESSAGE["insert"]);
					} else {
						alert(JS_MESSAGE[response.errorCode]);
						myDropzone.removeAllFiles(true);
						console.log("---- " + res.message);
					}
	            }
            });

            // 무한 루프 빠지네....
            /* this.on("error", function(response) {
                alert("파일 업로딩 중 오류가 발생하였습니다. 로그를 확인해 주십시오.");
            }); */
        }
    };

	var insertGeoserverLayerFlag = true;
	function geoserverLayerSave() {
	    if(insertGeoserverLayerFlag) {
	    	if (check() === false) {
                return;
            }
	    	insertGeoserverLayerFlag = false;
	    	$("#layerKey").val($("#layerKeySelect").val());
	    	$("#layerAlphaStyle").val($("#sliderRange").val() / 100);
	    	$("#coordinate").val("EPSG:4326");
            if(!$("#zIndex").val()) $("#zIndex").val(0);
            if(!$("#viewOrder").val()) $("#viewOrder").val(1);
	        var formData = $('#layer').serialize();
	        $.ajax({
				url: "/layer/insert-geoserver",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData,
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert(JS_MESSAGE["insert"]);
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
					insertGeoserverLayerFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        insertGeoserverLayerFlag = true;
				}
			});
	    } else {
	        alert("진행 중입니다.");
	        return;
		}
	}

	function getGeoserverLayerList(layerLoadingDialog) {
        $.ajax({
			url: "/layer/list-geoserver",
			type: "GET",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			success: function(msg){
				if(msg.statusCode <= 200) {
					var geoserverLayerList = JSON.parse(msg.geoserverLayerJson).layers;
					if(geoserverLayerList) {
						geoserverLayerList = geoserverLayerList.layer;
						for(var i=0; i< geoserverLayerList.length; i++) {
							var name = geoserverLayerList[i].name;
							$("#layerKeySelect").append("<option value="+name+">"+name+"</option>");
						}
					}
					layerLoadingDialog.dialog("close");
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
					console.log("---- " + msg.message);
				}
			},
			error:function(request, status, error){
		        alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

</script>
</body>
</html>