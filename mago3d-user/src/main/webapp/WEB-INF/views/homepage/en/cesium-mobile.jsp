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
		<div data-role="panel" id="menuPanel" data-position="left" data-display="overlay" data-theme="a">
			<ul data-role="listview" data-inset="false" data-shadow="false">
				<li data-filtertext="homepage" data-icon="home"><a href="/homepage/index.do">Home</a></li>
				<li data-role="collapsible" data-collapsed-icon="carat-d" data-expanded-icon="carat-u" data-iconpos="right" data-inset="false">
					<h2>Shortcuts</h2>
					<ul data-role="listview" data-theme="b">
						<c:forEach var="dataGroup" items="${projectDataGroupList}" varStatus="status">
						<li onclick="flyTo(null, null, '${dataGroup.longitude}', '${dataGroup.latitude}', '${dataGroup.height}', '${dataGroup.duration}')">${dataGroup.data_group_name }</li>
						</c:forEach>
					</ul>
				</li>
				<li data-role="collapsible" data-collapsed-icon="carat-d" data-expanded-icon="carat-u" data-iconpos="right" data-inset="false">
					<h2>Issues</h2>
					<ul data-role="listview" data-theme="b">
						<li class="ui-field-contain">
						<a href="#" style="padding-top: 0px;padding-bottom: 0px;padding-right: 0px;padding-left: 0px;">
							<fieldset data-role="controlgroup">
								<label for="issueEnable" style="border-top-width: 0px;margin-top: 0px;border-bottom-width: 0px;margin-bottom: 0px;border-left-width: 0px;border-right-width: 0px;" data-corners="false">Issue Register</label>
								<input type="checkbox" name="issueEnable" id="issueEnable"/>
							</fieldset>    
						</a>
						</li>
						<li><a href="#issueListPanel">Issue List</a></li>
					</ul>
				</li>
				<li data-role="collapsible" data-collapsed-icon="carat-d" data-expanded-icon="carat-u" data-iconpos="right" data-inset="false">
					<h2>API List</h2>
					<ul data-role="listview" data-theme="b">
						<li class="ui-field-contain">
						<a href="#" style="padding-top: 0px;padding-bottom: 0px;padding-right: 0px;padding-left: 0px;">
							<fieldset data-role="controlgroup">
								<label for="objectInfoEnable" style="border-top-width: 0px;margin-top: 0px;border-bottom-width: 0px;margin-bottom: 0px;border-left-width: 0px;border-right-width: 0px;" data-corners="false">Object Information</label>
								<input type="checkbox" name="objectInfoEnable" id="objectInfoEnable"/>
							</fieldset>    
						</a>
						</li>
						<li class="ui-field-contain">
							<label>Data Key</label>
							<input type="text" id="search_data_key" name="search_data_key" size="15" />
							<button type="button" id="searchData" style=""background: #727272;">Search</button>
						</li>
						<li class="ui-field-contain">
						<fieldset data-role="controlgroup" data-type="horizontal">
							<legend>Bounding Box</legend>
							<input type="radio" id="showBoundingBox" name="boundingBox" value="true" onclick="changeBoundingBox(true);" />
							<label for="showBoundingBox">Show</label>
							<input type="radio" id="hideBoundingBox" name="boundingBox" value="false" onclick="changeBoundingBox(false);"/>
							<label for="hideBoundingBox">Hide</label>					
						</fieldset>
						</li>
						<li class="ui-field-contain">
						<fieldset data-role="controlgroup" data-type="horizontal">
							<legend>Selecting And Moving</legend>
							<input type="radio" id="mouseAllMove" name="mouseMoveMode" value="0" onclick="changeMouseMove('0');"/>
							<label for="mouseAllMove">ALL</label>
							<input type="radio" id="mouseObjectMove" name="mouseMoveMode" value="1" onclick="changeMouseMove('1');"/>
							<label for="mouseObjectMove">Object</label>					
						</fieldset>
						</li>
						<li><a href="#listApiPanel">Location And Rotation</a></li>
					</ul>
				</li>
			</ul>
		</div>
		<!-- /menuPanel -->

		<div data-role="panel" id="inputIssuePanel" data-position="left" data-display="overlay" data-theme="a">
			<div data-role="header">
				<h3>Issue Register</h3>
				<a href="#menuPanel" data-rel="back" class="ui-btn ui-btn-left ui-alt-icon ui-nodisc-icon ui-corner-all ui-btn-icon-notext ui-icon-carat-l">Back</a>
				<a href="#" data-rel="close">Close</a>
			</div>
			<form:form id="issue" modelAttribute="issue" method="post" onsubmit="return false;">
				<ul data-role="listview" data-inset="true">
					<li class="ui-field-contain">
						<form:label path="data_group_id">Data Group</form:label>
						<form:select path="data_group_id">
							<c:forEach var="dataGroup" items="${projectDataGroupList}">
							<option value="${dataGroup.data_group_id}">${dataGroup.data_group_name}</option>
							</c:forEach>
						</form:select>
					</li>
					<li class="ui-field-contain">
						<form:label path="issue_type">Issue Type</form:label>
						<form:select path="issue_type" cssClass="select">
							<c:forEach var="commonCode" items="${issueTypeList}">
							<option value="${commonCode.code_value}">${commonCode.code_value}</option>
							</c:forEach>
						</form:select>
					</li>
					<li class="ui-field-contain">
						<form:label path="data_key">Data Key</form:label>
						<form:input path="data_key" cssClass="ml" />
						<form:errors path="data_key" cssClass="error" />
						<form:hidden path="latitude"/>
						<form:hidden path="longitude"/>
						<form:hidden path="height"/>
					</li>
					<li class="ui-field-contain">
						<form:label path="title">Title</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
						<form:input path="title" cssClass="ml" />
						<form:errors path="title" cssClass="error" />
					</li>
					<li class="ui-field-contain">
						<form:label path="priority">Issue Type</form:label>
						<form:select path="priority" cssClass="select">
							<c:forEach var="commonCode" items="${issuePriorityList}">
							<option value="${commonCode.code_value}">${commonCode.code_value}</option>
							</c:forEach>
						</form:select>		
					</li>
					<li class="ui-field-contain">
						<form:label path="due_date">Due Date</form:label>
						<form:hidden path="start_date" />
						<input type="text" id="start_day" name="start_day" placeholder="Day" size="7" maxlength="4" />
						<input type="text" id="start_hour" name="start_hour" placeholder="Hour" size="3" maxlength="2" />
						<span class="delimeter">:</span>
						<input type="text" id="start_minute" name="start_minute" placeholder="Minute" size="3" maxlength="2" />
					</li>	        
					<li class="ui-field-contain">
						<form:label path="assignee">Assignee</form:label>
						<form:input path="assignee" cssClass="m" placeholder="assignee" />
						<form:errors path="assignee" cssClass="error" />
					</li>
					<li class="ui-field-contain">
						<form:label path="reporter">reporter</form:label>
						<form:input path="reporter" cssClass="m" placeholder="reporter" />
						<form:errors path="reporter" cssClass="error" />
					</li>
					<li class="ui-field-contain">
						<form:label path="contents">Contents</form:label>
						<form:textarea path="contents" />
						<form:errors path="contents" cssClass="error" />
					</li>
					<li class="ui-field-contain">
						<button id="issueInsertButton">Save</button>
					</li>
				</ul>
			</form:form>
		</div>
		
		<div data-role="panel" id="issueListPanel" data-position="left" data-display="overlay" data-theme="a">
			<div data-role="header">
				<h3>Issue List</h3>
				<a href="#menuPanel" data-rel="back" class="ui-btn ui-btn-left ui-alt-icon ui-nodisc-icon ui-corner-all ui-btn-icon-notext ui-icon-carat-l">Back</a>
				<a href="#" data-rel="close">Close</a>
			</div>

			<ul data-role="listview" data-inset="true">
				<c:if test="${empty issueList }">
				<li>The issue does not exist.</li>
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
				<li><a href="#" class="ui-btn ui-shadow ui-corner-all ui-btn-icon-right ui-icon-eye" onclick="flyTo('${issue.issue_id}', '${issue.issue_type}', '${issue.longitude}', '${issue.latitude}', '${issue.height}', '2')">
					<h3>${issue.title}</h3>
					<p class="info">
						<span class="tag ${issueTypeCss}">${issue.issue_type_name}</span>
						<span class="tag ${issuePriorityCss }">${issue.priority_name}</span>
						<span>[${issue.data_group_name}]</span>
						<span class="date">${issue.viewInsertDate}</span>
					</p>
				</a></li>
			</c:forEach>
			</c:if>
			</ul>
		</div>
		
		<div data-role="panel" id="listApiPanel" data-position="left" data-display="overlay" data-theme="a">
			<div data-role="header">
				<h3>Location And Rotation</h3>
				<a href="#menuPanel" data-rel="back" class="ui-btn ui-btn-left ui-alt-icon ui-nodisc-icon ui-corner-all ui-btn-icon-notext ui-icon-carat-l">Back</a>
				<a href="#" data-rel="close">Close</a>
			</div>
			
			<ul data-role="listview" data-inset="true">
				<li class="ui-field-contain">
					<label for="move_data_key">Data Key</label>
					<input type="text" id="move_data_key" name="move_data_key" size="15" />
				</li>
				<li class="ui-field-contain">
					<label for="move_latitude">Latitude</label>
					<input type="text" id="move_latitude" name="move_latitude" size="15"/> 
				</li>
				<li class="ui-field-contain">
					<label for="move_longitude">Longitude</label>
					<input type="text" id="move_longitude" name="move_longitude" size="15"/>
				</li>
				<li class="ui-field-contain">
					<label for="move_height">Altitude</label>
					<input type="text" id="move_height" name="move_height" size="15" />
				</li>
				<li class="ui-field-contain">
					<label for="move_heading">Heading</label>
					<input type="text" id="move_heading" name="move_heading" size="15" />
				</li>
				<li class="ui-field-contain">
					<label for="move_pitch">Pitch</label>
					<input type="text" id="move_pitch" name="move_pitch" size="15" />
				</li>
				<li class="ui-field-contain">
					<label for="move_roll">Roll</label>
					<input type="text" id="move_roll" name="move_roll" size="15" />
				</li>
				<li class="ui-field-contain">
					<button type="button" id="changeLocationAndRotationAPI">Transform</button>
				</li>
			</ul>
		</div>
	</div>
<script type="text/javascript" src="/externlib/${lang}/cesium/Cesium.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d.js?currentTime=${currentTime}"></script>
<script>
	var agent = navigator.userAgent.toLowerCase();
	if(agent.indexOf('chrome') < 0) { 
		alert("This page is optimized for the Chrome browser for massive data processing.\nPlease use the Chrome browser for seamless service.");
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
		changeBoundingBox(false);
		// Selecting And Moving
		changeMouseMove("0");
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
		}
		$(this).attr("checked", insertIssueFlag).checkboxradio("refresh");
		changeInsertIssueModeAPI(insertIssueFlag);
		if(insertIssueFlag)	$("#menuPanel").panel("close");
	});
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
	
	// issue input layer call back function
	function showInsertIssueLayer(data_name, data_key, latitude, longitude, height) {
		if(insertIssueFlag) {
				$("#inputIssuePanel").panel("open");
				
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
			alert("Please enter data key.");
			$("#search_data_key").focus();
			return false;
		}
		searchDataAPI($("#search_data_key").val());
	});
	// boundingBox 표시/비표시
	function changeBoundingBox(isShow) {
		$("input:radio[name='boundingBox']:radio[value='" + isShow + "']").prop("checked", true).checkboxradio('refresh');
		changeBoundingBoxAPI(isShow);
	}
	// 마우스 클릭 객체 이동 모드 변경
	function changeMouseMove(mouseMoveMode) {
		$("input:radio[name='mouseMoveMode']:radio[value='" + mouseMoveMode + "']").prop("checked", true).checkboxradio('refresh');
		changeMouseMoveAPI(mouseMoveMode);
	}
	// 변환행렬
	$("#changeLocationAndRotationAPI").click(function() {
		if(!changeLocationAndRotationCheck()) return false;
		changeLocationAndRotationAPI(	$("#move_data_key").val(), $("#move_latitude").val(), $("#move_longitude").val(), 
										$("#move_height").val(), $("#move_heading").val(), $("#move_pitch").val(), $("#move_roll").val());
	});
	function changeLocationAndRotationCheck() {
		if ($.trim($("#move_data_key").val()) === ""){
			alert("Please enter data key.");
			$("#move_data_key").focus();
			return false;
		}
		if ($.trim($("#move_latitude").val()) === ""){
			alert("Please enter latitude.");
			$("#move_latitude").focus();
			return false;
		}
		if ($.trim($("#move_longitude").val()) === ""){
			alert("Please enter longitude.");
			$("#move_longitude").focus();
			return false;
		}
		if ($.trim($("#move_height").val()) === ""){
			alert("Please enter altitude.");
			$("#move_height").focus();
			return false;
		}
		if ($.trim($("#move_heading").val()) === ""){
			alert("Please enter heading.");
			$("#move_heading").focus();
			return false;
		}
		if ($.trim($("#move_pitch").val()) === ""){
			alert("Please enter pitch.");
			$("#move_pitch").focus();
			return false;
		}
		if ($.trim($("#move_roll").val()) === ""){
			alert("Please enter roll.");
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
								+	"	The issue does not exist."
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