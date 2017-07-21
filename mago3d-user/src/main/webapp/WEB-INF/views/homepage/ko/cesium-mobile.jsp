<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- <meta http-equiv="Cache-Control" content="no-cache"/>
	<meta http-equiv="Expires" content="-1"/>
	<meta http-equiv="Pragma" content="no-cache"/> -->
	<title>demo | mago3D User</title>
	<link rel="stylesheet" href="/externlib/${lang}/cesium/Widgets/widgets.css" />
	<link rel="stylesheet" href="/externlib/${lang}/jquery-mobile/jquery.mobile-1.4.5.min.css">
	<link rel="stylesheet" href="/externlib/${lang}/jquery-toast/jquery.toast.css" />
	<script src="/externlib/${lang}/jquery-mobile/jquery.min.js"></script>
	<script src="/externlib/${lang}/jquery-mobile/jquery.mobile-1.4.5.min.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/jquery-toast/jquery.toast.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/${lang}/message.js"></script>
	<script type="text/javascript" src="/js/analytics.js"></script>
	<style>
		.ui-panel-inner {
		    position: absolute;
		    top: 0;
		    left: 0;
		    right: 0;
		    bottom: 0px;
		    overflow: auto;
		    -webkit-overflow-scrolling: touch;
		}
		.ui-li-static.ui-collapsible > .ui-collapsible-heading {
			margin: 0;
		}

		.ui-li-static.ui-collapsible {
			padding: 0;
		}

		.ui-li-static.ui-collapsible > .ui-collapsible-heading > .ui-btn {
			border-top-width: 0;
		}

		.ui-li-static.ui-collapsible > .ui-collapsible-heading.ui-collapsible-heading-collapsed > .ui-btn,
		.ui-li-static.ui-collapsible > .ui-collapsible-content {
			border-bottom-width: 0;
		}
		.ui-collapsible-content .ui-body-inherit{
			font-size: 15px;
			margin-top: 3px;	
			border-style: hidden;
			margin-top: -2px;
		}
		.ui-block-a {
			margin-top: 15px;
		}
		.ui-li-static .ui-body-inherit {
			margin-top: -2px;
		}
	</style>
</head>

<body>
	<div data-role="page" class="jqm-demos" data-quicklinks="true">
		<div role="main" class="ui-content jqm-content"
			style="width:100%; height:100%; margin-top:0; padding:0; overflow:hidden;">
			<div id="magoContainer"
				style="position:absolute; width:100%; height:100%; margin-top:0; padding:0; overflow:hidden;"></div>
			<a href="#menuPanel" data-icon="bars" data-iconpos="notext"
				class="ui-btn ui-btn-icon-notext ui-icon-bars ui-nodisc-icon ui-alt-icon ui-btn-left">Menu</a> 
		</div>

		<!-- menuPanel  -->
		<div data-role="panel" id="menuPanel" data-position="left" data-display="overlay" data-theme="b">
			<ul data-role="listview" data-inset="false" data-shadow="false">
				<li data-filtertext="homepage" data-icon="home"><a href="/homepage/index.do">Home</a></li>
				<li data-role="collapsible" data-collapsed-icon="carat-d" data-expanded-icon="carat-u" data-iconpos="right" data-inset="false" data-collapsed="false">
					<h2>바로 가기</h2>
					<ul data-role="listview" data-theme="a">
						<c:forEach var="dataGroup" items="${projectDataGroupList}" varStatus="status">
						<li onclick="flyTo(null, null, '${dataGroup.longitude}', '${dataGroup.latitude}', '${dataGroup.height}', '${dataGroup.duration}')">${dataGroup.data_group_name }</li>
						</c:forEach>
					</ul>
				</li>

				<li data-role="collapsible" data-collapsed-icon="carat-d" data-expanded-icon="carat-u" data-iconpos="right" data-inset="false">
					<h2>이슈 사항</h2>
					<ul data-role="listview" data-theme="a">
						<li class="ui-field-contain">
						<a href="#" style="padding-top: 0px;padding-bottom: 0px;padding-right: 0px;padding-left: 0px;">
							<fieldset data-role="controlgroup" data-iconpos="right">
								<label for="issueEnable" style="background-color: white; border-top-width: 0px;margin-top: 0px;border-bottom-width: 0px;margin-bottom: 0px;border-left-width: 0px;border-right-width: 0px;">이슈 등록</label>
								<input type="checkbox" name="issueEnable" id="issueEnable"/>
								<label for="issuesEnable" style="background-color: white; border-top-width: 0px;margin-top: 0.1px;border-bottom-width: 0px;margin-bottom: 0px;border-left-width: 0px;border-right-width: 0px;">이슈 표시</label>
								<input type="checkbox" name="issuesEnable" id="issuesEnable"/>
							</fieldset>    
						</a>
						</li>
						<li><a href="#IssueListPage" style="background-color: white; margin-top:-2px;">이슈 목록</a></li>
					</ul>	
				</li>
				<li data-role="collapsible" data-collapsed-icon="carat-d" data-expanded-icon="carat-u" data-iconpos="right">
					<h2>API 목록</h2>
					<ul data-role="listview" data-theme="a">
						<li class="ui-field-contain">
						<a href="#" style="padding-top: 0px;padding-bottom: 0px;padding-right: 0px;padding-left: 0px;">
						<form>
							<fieldset data-role="controlgroup" data-iconpos="right">
								<label for="mouseObjectMove" style=" border-style: hidden;background-color: white; border-color: white;border-top-width: 0px;margin-top: 0.1px;border-bottom-width: 0px;margin-bottom: 0px;border-left-width: 0px;border-right-width: 0px;" data-corners="false">Object 이동</label>
								<input type="checkbox" name="mouseObjectMove" id="mouseObjectMove"/>
								<label for="objectInfoEnable" style=" border-style: hidden; background-color: white; border-color: white;border-top-width: 0px;margin-top: 0px;border-bottom-width: 0px;margin-bottom: 0px;border-left-width: 0px;border-right-width: 0px;" data-corners="false">Object 정보</label>
								<input type="checkbox" name="objectInfoEnable" id="objectInfoEnable"/>
								<label for="boundingBoxEnable" style=" border-style: hidden;background-color: white; border-color: white;border-top-width: 0px;margin-top: 0.1px;border-bottom-width: 0px;margin-bottom: 0px;border-left-width: 0px;border-right-width: 0px;" data-corners="false">BoundingBox 표시</label>
								<input type="checkbox" name="boundingBoxEnable" id="boundingBoxEnable"/>
							</fieldset>    						
						</form>
						</a>
						<li style="margin-top:-2px;"><a href="#LocationAndRotationPage" >Location And Rotation</a></li>
						</li>			
					</ul>
				</li>
			</ul>
		</div>
	</div>
	<div id="LocationAndRotationPage" data-role="page">
		<div data-role="header">
			<h1>Location And Rotation</h1>
			<a href="#" id="panelOpen" data-rel="back" data-icon="arrow-l" >Prev</a>
			<a id="changeLocationAndRotationAPI">변환</a>
		</div>
		<div data-role="content">
		<ul data-role="listview">
				<li class="ui-field-contain">
				<div class="ui-grid-a">
						<div class="ui-block-a">
							Data Key
						</div>
						<div class="ui-block-b">
							<input type="search" id="move_data_key" name="move_data_key" size="15" />
						</div>
				</div> 
				</li>
				<li class="ui-field-contain">
				<div class="ui-grid-a">
					<div class="ui-block-a">위도</div>
					<div class="ui-block-b">
						<input type="text" id="move_latitude" name="move_latitude" size="15" /> 
					</div>
				</div>
				</li>
				<li class="ui-field-contain">
				<div class="ui-grid-a">
				<div class="ui-block-a">경도</div>
					<div class="ui-block-b">
						<input type="text" id="move_longitude" name="move_longitude" size="15"/>
					</div>
				</div>
				</li>
				<li class="ui-field-contain">
					<div class="ui-grid-a">
						<div class="ui-block-a">높이</div>
						<div class="ui-block-b">
							<input type="text" id="move_height" name="move_height" size="15"/>
						</div>
					</div>
				</li>
				<li class="ui-field-contain">
					<div class="ui-grid-a">
						<div class="ui-block-a">Heading</div>
						<div class="ui-block-b">
							<input type="text" id="move_heading" name="move_heading" size="15"/>
						</div>
					</div>
				</li>
				<li class="ui-field-contain">
					<div class="ui-grid-a">
						<div class="ui-block-a">Pitch</div>
						<div class="ui-block-b">
							<input type="text" id="move_pitch" name="move_pitch" size="15" />
						</div>
					</div>
				</li>
				<li class="ui-field-contain">
					<div class="ui-grid-a">
						<div class="ui-block-a">Roll</div>
						<div class="ui-block-b">
							<input type="text" id="move_roll" name="move_roll" size="15" />
						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
	
	<div id="IssuePage" data-role="page">
		<div data-role="header">
			<h1>Issue 등록</h1>
			<a href="#" data-rel="back" data-icon="arrow-l" >back</a>
			<button id="issueInsertButton">Save</button>
			<div data-role="content">
			<form:form id="issue" modelAttribute="issue" method="post" onsubmit="return false;">
				<ul data-role="listview">
					<li class="ui-field-contain">
						<div class="ui-grid-a">
							<div class="ui-block-a">데이터 그룹</div>
							<div class="ui-block-b">
								<form:select path="data_group_id">
									<c:forEach var="dataGroup" items="${projectDataGroupList}">
									<option value="${dataGroup.data_group_id}">${dataGroup.data_group_name}</option>
									</c:forEach>
								</form:select>
							</div>
						</div>
					</li>
					<li class="ui-field-contain">
						<div class="ui-grid-a">
							<div class="ui-block-a">Issue Type</div>
							<div class="ui-block-b">
								<form:select path="issue_type" cssClass="select">
									<c:forEach var="commonCode" items="${issueTypeList}">
									<option value="${commonCode.code_value}">${commonCode.code_value}</option>
									</c:forEach>
								</form:select>
							</div>
						</div>
					</li>
					<li class="ui-field-contain">
						<div class="ui-grid-a">
							<div class="ui-block-a">Data Key</div>
							<div class="ui-block-b">
								<form:input path="data_key" cssClass="ml" />
								<form:errors path="data_key" cssClass="error" />
								<form:hidden path="latitude"/>
								<form:hidden path="longitude"/>
								<form:hidden path="height"/>
							</div>
						</div>

					</li>
					<li class="ui-field-contain">
						<div class="ui-grid-a">
							<div class="ui-block-a">제목</div>
							<div class="ui-block-b">
								<span class="icon-glyph glyph-emark-dot color-warning"></span>
								<form:input path="title" cssClass="ml" />
								<form:errors path="title" cssClass="error" />
							</div>
						</div>
					</li>
					<li class="ui-field-contain">
						<div class="ui-grid-a">
							<div class="ui-block-a">Issue Priority</div>
							<div class="ui-block-b">
								<form:select path="priority" cssClass="select">
								<c:forEach var="commonCode" items="${issuePriorityList}">
								<option value="${commonCode.code_value}">${commonCode.code_value}</option>
								</c:forEach>
								</form:select>
							</div>
						</div>
					</li>
					<li class="ui-field-contain">
						<div class="ui-grid-a">
							<div class="ui-block-a">마감일</div>
							<div class="ui-block-b">
								<form:hidden path="start_date" />
								<input type="text" id="start_day" name="start_day" placeholder="날짜" size="7" maxlength="4" />
							</div>
						</div>
					</li>
					<li class="ui-field-contain">
						<div class="ui-grid-a">
							<div class="ui-block-a">시간</div>
							<div class="ui-block-b">
								<input type="time" name="timePicker1" id="timePicker1" value="10:00">
							</div>
						</div>
					</li>
					<li class="ui-field-contain">
						<div class="ui-grid-a">
							<div class="ui-block-a">Assignee</div>
							<div class="ui-block-b">
								<form:input path="assignee" cssClass="m" placeholder="대리자" />
								<form:errors path="assignee" cssClass="error" />
							</div>
						</div>
					</li>	
					<li class="ui-field-contain">
						<div class="ui-grid-a">
							<div class="ui-block-a">reporter</div>
							<div class="ui-block-b">
								<form:input path="reporter" cssClass="m" placeholder="보고 해야 하는 사람" />
								<form:errors path="reporter" cssClass="error" />
							</div>
						</div>
					</li>			
					<li class="ui-field-contain">
						<form:label path="contents"><b>내용</b></form:label>
						<form:textarea path="contents" />
						<form:errors path="contents" cssClass="error" />
					</li>
				</ul>
			</form:form>
			</div>
		</div>
	</div>
	<div id="IssueListPage" data-role="page">
	<div data-role="header">
		<h1>Iusse List</h1>
		<a href="#" data-rel="back" data-icon="arrow-l">back</a>
	</div>
		<div data-role="content">
			<ul data-role="listview">
				<c:if test="${empty issueList }">
					<li>Issue가 존재하지 않습니다.</li>
				</c:if>
				<c:if test="${!empty issueList }">
					<c:set var="issueTypeCss" value="i1" />
					<c:set var="issuePriorityCss" value="t1" />

					<c:forEach var="issue" items="${issueList}" varStatus="status">
						<c:if test="${issue.issue_type eq 'BUGGER'}">
							<c:set var="issueTypeCss" value="i1" />
						</c:if>
						<c:if test="${issue.issue_type eq 'IMPROVE'}">
							<c:set var="issueTypeCss" value="i2" />
						</c:if>
						<c:if test="${issue.issue_type eq 'NEW'}">
							<c:set var="issueTypeCss" value="i3" />
						</c:if>
						<c:if test="${issue.issue_type eq 'ETC'}">
							<c:set var="issueTypeCss" value="i4" />
						</c:if>
						<c:if test="${issue.priority eq 'CRITICAL'}">
							<c:set var="issuePriorityCss" value="t1" />
						</c:if>
						<c:if test="${issue.priority eq 'MUST'}">
							<c:set var="issuePriorityCss" value="t2" />
						</c:if>
						<c:if test="${issue.priority eq 'MINOR'}">
							<c:set var="issuePriorityCss" value="t3" />
						</c:if>
						<c:if test="${issue.priority eq 'TRIVIAL'}">
							<c:set var="issuePriorityCss" value="t4" />
						</c:if>
						<li><a href="/homepage/demo.do"
							class="ui-btn ui-shadow ui-corner-all ui-btn-icon-right ui-icon-eye"
							onclick="flyTo('${issue.issue_id}', '${issue.issue_type}', '${issue.longitude}', '${issue.latitude}', '${issue.height}', '2')">
								<h3>${issue.title}</h3>
								<p class="info">
									<span class="tag ${issueTypeCss}">${issue.issue_type_name}</span>
									<span class="tag ${issuePriorityCss }">${issue.priority_name}</span>
									<span>[${issue.data_group_name}]</span> <span class="date">${issue.viewInsertDate}</span>
								</p>
						</a></li>
					</c:forEach>
				</c:if>
			</ul>
		</div>
	</div>
<script type="text/javascript" src="/externlib/${lang}/cesium/Cesium.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Code.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/API.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Config.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Callback.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Constant.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Message.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/ManagerFactory.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Atmosphere.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/GeometryUtil.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/GeometryModifier.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Line.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Plane.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Point3D.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Shader.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/ShaderSource.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/ReaderWriter.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Renderer.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Selection.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/VBOManager.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/CesiumManager.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/PostFxShader.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/FBO.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Geometry.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Accessor.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/NeoTexture.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/BoundingBox.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/BlockModels.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/FileRequestControler.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/ManagerUtils.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/NeoReferenceModels.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/OcclusionCullOctree.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Octree.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/VisibleObjectsControler.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Matrix4.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Lego.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Camera.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/GeoLocationData.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/MagoFacade.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Policy.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Box.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Vertex.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Triangle.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/TriSurface.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/TriPolyhedron.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/VertexList.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/VertexMatrix.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Color.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Quaternion.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/domain/ProjectLayer.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/MetaData.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/SceneState.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/SplitValue.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Frustum.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/GeographicCoord.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/TerranTile.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/GlobeTile.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Sphere.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/ObjectMarker.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Pin.js?currentTime=${currentTime}"></script>
<script>
	var agent = navigator.userAgent.toLowerCase();
	if(agent.indexOf('chrome') < 0) { 
		alert("이 데모 페이지는 대용량 웹 데이터 처리를 위해 Chrome 브라우저에 최적화 되어 있습니다. \n원활한 서비스 이용을 위해 Chrome 브라우저를 이용  하시기 바랍니다.");
	}

	var policyJson = ${policyJson};
	var dataGroupMap = ${dataGroupMap};
	var insertIssueFlag = false;
	var objectInfoViewFlag = false;
	var listIssueFlag = false;
	var imagePath = "/images/${lang}";
	var managerFactory = new ManagerFactory(null, "magoContainer", policyJson, dataGroupMap, imagePath);
	
	$(document).ready(function() {
		// BoundingBox
 		changeBoundingBoxAPI(false);
// 		// Selecting And Moving
		changeMouseMoveAPI(0);
	});
	
	function flyTo(issueId, issueType, longitude, latitude, height, duration) {
		managerFactory.flyTo(issueId, issueType, longitude, latitude, height, duration);
		// 현재 좌표를 저장
		$("#now_latitude").val(latitude);
		$("#now_longitude").val(longitude);
	}
	
	// 이슈 등록
	$("#issueEnable").click(function() {
		if(insertIssueFlag) {
			insertIssueFlag = false;
		} else {
			insertIssueFlag = true;
 			$.mobile.changePage("#dialogPage", {role: "dialog"});

		}
		$(this).attr("checked", insertIssueFlag).checkboxradio("refresh");
		changeInsertIssueModeAPI(insertIssueFlag);
		if(insertIssueFlag)	$("#menuPanel").panel("close");
		
	});
	//판넬 열기
	// object info 표시
	$("#objectInfoEnable").click(function() {
		if(objectInfoViewFlag) {
			objectInfoViewFlag = false;
		} else {
			objectInfoViewFlag = true;
		}
		$(this).attr("checked", objectInfoViewFlag).checkboxradio("refresh");
		changeObjectInfoViewModeAPI(objectInfoViewFlag);
		if(objectInfoViewFlag)	$("#menuPanel").panel("close");
	});
	//boundingBoxEnable
	$("#boundingBoxEnable").click(function () {
		if($("#boundingBoxEnable").prop("checked") == true) {
			changeBoundingBoxAPI(true);
		}
		else {
			changeBoundingBoxAPI(false);
		}
	});
	$("#mouseObjectMove").click(function () {
		if($("#mouseObjectMove").prop("checked") == true) {
			changeMouseMoveAPI(1);
		}
		else {
			changeMouseMoveAPI(0);
		}
	})
	// 마우스 클릭 객체 이동 모드 변경
// 	function changeMouseMove(mouseMoveMode) {
// 		$("input:radio[name='mouseMoveMode']:radio[value='" + mouseMoveMode + "']").prop("checked", true).checkboxradio('refresh');
// 		changeMouseMoveAPI(mouseMoveMode);
// 	}
// 	function changeBoundingBox(isShow) {
// 		$("input:radio[name='boundingBox']:radio[value='" + isShow + "']").prop("checked", true).checkboxradio('refresh');
// 		changeBoundingBoxAPI(isShow);
// 	}
	$("#issuesEnable").click(function() {
		if(listIssueFlag) {
			listIssueFlag = false;
			$("#issuesEnable").removeClass("on");
		} else {
			listIssueFlag = true;
			$("#issuesEnable").addClass("on");
			
			// 현재 위치의 latitude, logitude를 가지고 가장 가까이에 있는 데이터 그룹에 속하는 이슈 목록을 최대 100건 받아서 표시
			var now_latitude = $("#now_latitude").val();
			var now_longitude = $("#now_longitude").val();
			var info = "latitude=" + now_latitude + "&longitude=" + now_longitude;		
			$.ajax({
				url: "/issue/ajax-list-issue-by-geo.do",
				type: "GET",
				data: info,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						var issueList = msg.issueList;
						if(issueList != null && issueList.length > 0) {
							for(i=0; i<issueList.length; i++ ) {
								var issue = issueList[i];
								drawInsertIssueImageAPI(0, issue.issue_id, issue.issue_type, issue.data_key, issue.latitude, issue.longitude, issue.height);
							}
						}
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
				},
				error:function(request,status,error){
			        //alert(JS_MESSAGE["ajax.error.message"]);
					console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		}
		changeListIssueViewModeAPI(listIssueFlag);
		$("#menuPanel").panel("close");
	});
	
	// issue input layer call back function
	function showInsertIssueLayer(data_name, data_key, latitude, longitude, height) {
		if(insertIssueFlag) {
				$.mobile.changePage($("#IssuePage"));
				$("#data_key").val(data_name);
				$("#latitude").val(latitude);
				$("#longitude").val(longitude);
				$("#height").val(height);
				
				// 현재 좌표를 저장
				$("#now_latitude").val(latitude);
				$("#now_longitude").val(longitude);
		}
	}
	
	function check() {
		if ($("#data_key").val() == "") {
			alert(JS_MESSAGE["issue.datakey.empty"]);
			$("#data_key").focus();
			return false;
		}
		if ($("#title").val() == "") {
			alert(JS_MESSAGE["issue.title.empty"]);
			$("#title").focus();
			return false;
		}
		/* if ($("#assignee").val() == "") {
			alert(JS_MESSAGE["issue.assignee.empty"]);
			$("#assignee").focus();
			return false;
		}
		if ($("#reporter").val() == "") {
			alert(JS_MESSAGE["issue.reporter.empty"]);
			$("#reporter").focus();
			return false;
		} */
		if ($("#contents").val() == "") {
			alert(JS_MESSAGE["issue.contents.empty"]);
			$("#contents").focus();
			return false;
		}
		if ($("#start_hour").val() > 23) {
			alert(JS_MEESAGE["issue.start_hour.proper"]);
			$("#start_hour").focus();
			return false;
		}
		if ($("#start_minute").val() > 59) {
			alert(JS_MESSAGE["issue.start_minute.proper"]);
			$("#start_minute").focus();
			return false;
		}
	}
	
	var isInsertIssue = true;
	$("#issueInsertButton").click(function() {
		if (check() == false) {
			return false;
		}
		if(isInsertIssue) {
			isInsertIssue = false;
			var info = $("#issue").serialize();		
			$.ajax({
				url: "/issue/ajax-insert-issue.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["insert"]);
						// pin image를 그림
						drawInsertIssueImageAPI(msg.issue.issue_id, msg.issue.issue_type, $("#data_key").val(), $("#latitude").val(), $("#longitude").val(), $("#height").val());
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					
					$("#inputIssuePanel").panel("close");
					isInsertIssue = true;
					ajaxIssueList();
				},
				error:function(request,status,error){
			        //alert(JS_MESSAGE["ajax.error.message"]);
			        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			        isInsertIssue = true;
				}
			});
			
			changeInsertIssueStateAPI(0);
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	});
	
	$("#inputIssueClose").click(function() {
		$("#inputIssuePanel").panel("close");
		changeInsertIssueStateAPI(0);
	});
	
	// object 정보 표시 call back function
	function showSelectedObject(projectId, blockId, objectId, latitude, longitude, height, heading, pitch, roll){
		if(objectInfoViewFlag) {
			$("#listApiPanel").panel("open");
			
			$("#move_data_key").val(projectId + "_" + blockId);
			$("#move_latitude").val(latitude);
			$("#move_longitude").val(longitude);
			$("#move_height").val(height);
			$("#move_heading").val(heading);
			$("#move_pitch").val(pitch);
			$("#move_roll").val(roll);
			
			$("#listApiPanel").panel("close");
			$.toast({
			    heading: 'Click Object Info',
			    text: [
			        'projectId : ' + projectId, 
			        'blockId : ' + blockId, 
			        'objectId : ' + objectId,
			        'latitude : ' + latitude,
			        'longitude : ' + longitude,
			        'height : ' + height,
			        'heading : ' + heading,
			        'pitch : ' + pitch,
			        'roll : ' + roll
			    ],
				//bgColor : 'blue',
				hideAfter: 5000,
				icon: 'info'
			});
			
			// 현재 좌표를 저장
			$("#now_latitude").val(latitude);
			$("#now_longitude").val(longitude);
		}
	}
	
	// Data 검색
	$("#searchData").click(function() {
		if ($.trim($("#search_data_key").val()) === ""){
			alert("Data Key를 입력해 주세요.");
			$("#search_data_key").focus();
			return false;
		}
		searchDataAPI($("#search_data_key").val());
	});

	// 변환행렬
	$("#changeLocationAndRotationAPI").click(function() {
		if(!changeLocationAndRotationCheck()) return false;
		changeLocationAndRotationAPI(	$("#move_data_key").val(), $("#move_latitude").val(), $("#move_longitude").val(), 
										$("#move_height").val(), $("#move_heading").val(), $("#move_pitch").val(), $("#move_roll").val());
	});
	function changeLocationAndRotationCheck() {
		if ($.trim($("#move_data_key").val()) === ""){
			alert("Data Key를 입력해 주세요.");
			$("#move_data_key").focus();
			return false;
		}
		if ($.trim($("#move_latitude").val()) === ""){
			alert("위도를 입력해 주세요.");
			$("#move_latitude").focus();
			return false;
		}
		if ($.trim($("#move_longitude").val()) === ""){
			alert("경도를 입력해 주세요.");
			$("#move_longitude").focus();
			return false;
		}
		if ($.trim($("#move_height").val()) === ""){
			alert("높이를 입력해 주세요.");
			$("#move_height").focus();
			return false;
		}
		if ($.trim($("#move_heading").val()) === ""){
			alert("heading을 입력해 주세요.");
			$("#move_heading").focus();
			return false;
		}
		if ($.trim($("#move_pitch").val()) === ""){
			alert("pitch를 입력해 주세요.");
			$("#move_pitch").focus();
			return false;
		}
		if ($.trim($("#move_roll").val()) === ""){
			alert("roll를 입력해 주세요.");
			$("#move_roll").focus();
			return false;
		}
		return true;
	}
	
	// TODO issue url 밑에 있어야 할지도 모르겠다.
	function ajaxIssueList() {
		var info = "";		
		$.ajax({
			url: "/homepage/ajax-list-issue.do",
			type: "GET",
			data: info,
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					var issueList = msg.issueList;
					var content = "";
					
					if(issueList == null || issueList.length == 0) {
						content += 	"<div style=\"text-align: center; padding-top:20px; height: 50px;\">"
								+	"	Issue가 존재하지 않습니다."
								+	"</div>";
					} else {
						for(i=0; i<issueList.length; i++ ) {
							var issue = null;
							issue = issueList[i];
							content = content 
								+ 	"<div style=\"padding-left: 20px; padding-top: 20px; padding-bottom: 20px; background: gainsboro\">"
								+ 	"	<div>"
								+ 	"		<img src=\"/images/${lang }/homepage/bullet_h4.png\" alt=\"\" />"
								+ 	"		<span style=\"padding-left: 10px; width:200px; overflow: hidden;\">" + issue.title + "</span>"
								+ 	"		<span style=\"float:right; padding-right: 15px; padding-top: 5px;\">"
								+ 	"			<a href=\"#\" onclick=\"flyTo('" + issue.issue_id + "', '" + issue.issue_type 
													+ "', '" + issue.longitude + "', '" + issue.latitude + "', '" + issue.height + "', '2')\">"
								+ 	"				<img src=\"/images/${lang }/homepage/btn_going.png\" width=\"26\" height=\"26\" alt=\"\" />"
								+ 	"			</a>"
								+ 	"		</span>"
								+ 	"	</div>"
								+ 	"	<div id=\"issue_toggle_" + issue.issue_id + "\">"
								+ 	"		<span style=\"padding-left: 25px;\">[" +  issue.issue_type + "][" + issue.priority + "]</span>"
								+ 	"		<span style=\"padding-left: 5px;\">" + issue.data_group_name  + "</span>"
								+ 	"		<span style=\"float:right; padding-right: 20px;\">" + issue.insert_date.substring(0,19) + "</span>"
								+ 	"	</div>"
								+ 	"</div>";
						}
					}
					$("#recentIssueListContent").empty();
					$("#recentIssueListContent").html(content);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error:function(request,status,error){
		        //alert(JS_MESSAGE["ajax.error.message"]);
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
</script>

</body>
</html>