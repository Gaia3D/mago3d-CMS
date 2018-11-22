<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>mago3D 설정 | mago3D User</title>
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="/css/cloud.css?cache_version=${cache_version}">
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/externlib/color-picker/palette-color-picker.css" />
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
	<script type="text/javascript" src="/externlib/color-picker/palette-color-picker.js"></script>
	<script type="text/javascript" src="/js/cloud.js?cache_version=${cache_version}"></script>
</head>
<body>

<div class="site-body">
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<div id="site-content" class="on">
		<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
		<div id="content-wrap">
			<div id="gnb-content" class="clfix">
				<h1 style="padding-left: 20px;">
					<span style="font-size:26px;">mago3D 설정</span>
				</h1>
				<div class="location">
					<span style="padding-top:10px; font-size:12px; color: Mediumslateblue;">
						<i class="fas fa-cubes" title="프로젝트"></i>
					</span>
					<span style="font-size:12px;">Settings > mago3D 설정</span>
				</div>
			</div>
				
			<!-- Start content by page -->
			<div class="page-content">
				<div class="content-desc u-pull-right" style="padding-right: 10px;">
					<span class="icon-glyph glyph-emark-dot color-warning" style="display: inline-block; padding-bottom: 2px;"></span>
					<span style="display: inline-block; padding-bottom: 2px;"><spring:message code='check'/></span></div>
				<div style="margin-top: 20px; border: 1px solid #dddddd;">
					<ul style="list-style: none; font-size: 14px; border-bottom: 3px solid #573592">
						<li style="padding-left: 10px; padding-top: 5px; width: 235px; height: 30px; color: white; background: #573690;">
							mago3D 프로젝트 MAP 보기 설정
						</li>
					</ul>
					<div id="project_tab">
						<form:form id="userPolicy" modelAttribute="userPolicy" method="post" onsubmit="return false;">
						<table class="input-table scope-row">
							<col class="col-label" />
							<col class="col-input" />
							<tr>
					  			<th>
							  		<form:label path="geo_view_library" cssClass="nessItem"><spring:message code='config.geo.viewlibrary'/></form:label>
					 			</th>
					 			<td>
						  			<select id="geo_view_library" name="geo_view_library" class="select">
						  				<option value="cesium" selected>Cesium</option>
						  				<option value="worldwind">WorldWind</option>
						  			</select>
						  		</td>
					  		</tr>
					  		<tr>
								<th class="col-label l" scope="row">
									<form:label path="geo_data_path"><spring:message code='config.data.folder'/></form:label>
								</th>
								<td class="col-input">
									<form:input path="geo_data_path" cssClass="l" />
									<span class="table-desc"><spring:message code='config.directory'/></span>
									<form:errors path="geo_data_path" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="geo_data_default_projects"><spring:message code='config.geo.project.loading'/></form:label>
								</th>
								<td class="col-input">
									<form:input path="geo_data_default_projects_view" cssClass="l" />
									<form:hidden path="geo_data_default_projects" />
									<input type="button" id="projectFind" value="<spring:message code='search'/>" />
								</td>
							</tr>
							<tr>
					  			<th>
							  		<span><spring:message code='config.cullface.use.not'/></span>
					 			</th>
					 			<spring:message code='use' var='use'/>
					 			<spring:message code='no.use' var='noUse'/>
					 			<td class="col-input radio-set">
					 				<form:radiobutton path="geo_cull_face_enable" value="true" label="${use}" />
									<form:radiobutton path="geo_cull_face_enable" value="false" label="${noUse}" />
						  		</td>
					  		</tr>
					  		<tr>
					  			<th>
							  		<span><spring:message code='config.timeline.use.not'/></span>
					 			</th>
					 			<td class="col-input radio-set">
					 				<form:radiobutton path="geo_time_line_enable" value="true" label="${use}" />
									<form:radiobutton path="geo_time_line_enable" value="false" label="${noUse}" />
						  		</td>
					  		</tr>
					  		<tr>
					  			<th>
							  		<span><spring:message code='config.init.camera.move'/></span>
					 			</th>
					 			<td class="col-input radio-set">
					 				<form:radiobutton path="geo_init_camera_enable" value="true" label="${use}" />
									<form:radiobutton path="geo_init_camera_enable" value="false" label="${noUse}" />
						  		</td>
					  		</tr>
					  		<tr>
								<th class="col-label l" scope="row">
									<form:label path="geo_init_latitude"><spring:message code='config.init.camera.lattiude'/></form:label>
								</th>
								<td class="col-input">
									<form:input path="geo_init_latitude" cssClass="m" />
									<form:errors path="geo_init_latitude" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="geo_init_longitude"><spring:message code='config.init.camera.longitude'/></form:label>
								</th>
								<td class="col-input">
									<form:input path="geo_init_longitude" cssClass="m" />
									<form:errors path="geo_init_longitude" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="geo_init_height"><spring:message code='config.init.camera.height'/></form:label>
								</th>
								<td class="col-input">
									<form:input path="geo_init_height" cssClass="m" />
									<form:errors path="geo_init_height" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="geo_init_duration"><spring:message code='config.init.camera.time'/></form:label>
								</th>
								<td class="col-input">
									<form:input path="geo_init_duration" cssClass="m" />
									<span class="table-desc"><spring:message code='config.second.unit'/></span>
									<form:errors path="geo_init_duration" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="geo_init_default_terrain">Terrain</form:label>
								</th>
								<td class="col-input">
									<form:input path="geo_init_default_terrain" cssClass="l" />
									<form:errors path="geo_init_default_terrain" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="geo_init_default_fov">Field Of View</form:label>
								</th>
								<td class="col-input">
									<form:input path="geo_init_default_fov" cssClass="m" />
									<form:errors path="geo_init_default_fov" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="geo_lod0"><spring:message code='config.geo.lod0'/></form:label>
								</th>
								<td class="col-input">
									<form:input path="geo_lod0" cssClass="m" />&nbsp;M
									<form:errors path="geo_lod0" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="geo_lod1"><spring:message code='config.geo.lod1'/></form:label>
								</th>
								<td class="col-input">
									<form:input path="geo_lod1" cssClass="m" />&nbsp;M
									<form:errors path="geo_lod1" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="geo_lod2"><spring:message code='config.geo.lod2'/></form:label>
								</th>
								<td class="col-input">
									<form:input path="geo_lod2" cssClass="m" />&nbsp;M
									<form:errors path="geo_lod2" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="geo_lod3"><spring:message code='config.geo.lod3'/></form:label>
								</th>
								<td class="col-input">
									<form:input path="geo_lod3" cssClass="m" />&nbsp;M
									<form:errors path="geo_lod3" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="geo_lod4"><spring:message code='config.geo.lod4'/></form:label>
								</th>
								<td class="col-input">
									<form:input path="geo_lod4" cssClass="m" />&nbsp;M
									<form:errors path="geo_lod4" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="geo_lod5"><spring:message code='config.geo.lod5'/></form:label>
								</th>
								<td class="col-input">
									<form:input path="geo_lod5" cssClass="m" />&nbsp;M
									<form:errors path="geo_lod5" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="geo_ambient_reflection_coef"><spring:message code='config.geo.ambient_reflection_coeficient'/></form:label>
								</th>
								<td class="col-input" style="padding-left: 20px;">
									<div id="geo_ambient_reflection_coef" style="display: inline-block; width: 230px;">
										<div id="geo_ambient_reflection_coef_view" class="ui-slider-handle"></div>
									</div>
									<form:hidden path="geo_ambient_reflection_coef" />
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="geo_diffuse_reflection_coef"><spring:message code='config.geo.diffuse_reflection_coef'/></form:label>
								</th>
								<td class="col-input" style="padding-left: 20px;">
									<div id="geo_diffuse_reflection_coef" style="display: inline-block; width: 230px;">
										<div id="geo_diffuse_reflection_coef_view" class="ui-slider-handle"></div>
									</div>
									<form:hidden path="geo_diffuse_reflection_coef" />
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="geo_specular_reflection_coef"><spring:message code='config.geo.specular_reflection_coef'/></form:label>
								</th>
								<td class="col-input" style="padding-left: 20px;">
									<div id="geo_specular_reflection_coef" style="display: inline-block; width: 230px;">
										<div id="geo_specular_reflection_coef_view" class="ui-slider-handle"></div>
									</div>
									<form:hidden path="geo_specular_reflection_coef" />
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="geo_ambient_color"><spring:message code='config.geo.geo_ambient_color'/></form:label>
								</th>
								<td class="col-input">
									<form:input path="geo_ambient_color" cssClass="m"
										data-palette='["#D50000","#304FFE","#00B8D4","#00C853","#FFD600","#FF6D00","#FF1744","#3D5AFE","#00E5FF","#00E676","#FFEA00",
								       "#FF9100","#FF5252","#536DFE","#18FFFF","#69F0AE","#FFFF00","#FFAB40"]' />
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="geo_specular_color"><spring:message code='config.geo.geo_specular_color'/></form:label>
								</th>
								<td class="col-input">
									<form:input path="geo_specular_color" cssClass="m"
										data-palette='["#D50000","#304FFE","#00B8D4","#00C853","#FFD600","#FF6D00","#FF1744","#3D5AFE","#00E5FF","#00E676","#FFEA00",
								       "#FF9100","#FF5252","#536DFE","#18FFFF","#69F0AE","#FFFF00","#FFAB40"]' />
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="geo_ssao_radius"><spring:message code='config.geo.ssaoradius'/></form:label>
								</th>
								<td class="col-input">
									<form:input path="geo_ssao_radius" cssClass="m" />
									<form:errors path="geo_ssao_radius" cssClass="error" />
								</td>
							</tr>
						</table>
						
						<div class="button-group">
							<div id="updateLink" class="center-buttons">
								<input type="submit" value="<spring:message code='save'/>" onclick="updateUserPolicy();" />
							</div>
						</div>
						</form:form>
											</div>
				</div>
			</div>
			<!-- End content by page -->
			
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
</div>

<%@ include file="/WEB-INF/views/user/project-search-dialog.jsp" %>

<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$( ".tabs" ).tabs();
		initUserPolicy();
	});
	
	// 사용자 정책 업데이트
	var updateUserPolicyFlag = true;
	function updateUserPolicy() {
		if(updateUserPolicyFlag) {
			// validation 나중에
			updateUserPolicyFlag = false;
			var info = {};
			$.each( $("#userPolicy").serializeArray(), function(i, obj) { 
				if(obj.name === "geo_ambient_reflection_coef") {
					info[obj.name] = $("#geo_ambient_reflection_coef").val();
				} else if(obj.name === "geo_diffuse_reflection_coef") {
					info[obj.name] = $("#geo_diffuse_reflection_coef").val();
				} else if(obj.name === "geo_specular_reflection_coef") {
					info[obj.name] = $("#geo_specular_reflection_coef").val();
				} else {
					info[obj.name] = obj.value;
				}
			});
			$.ajax({
				url: "/user/ajax-update-user-policy.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateUserPolicyFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateUserPolicyFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 사용자 정책 geo 정보 설정
	function initUserPolicy() {
		var ambient = $( "#geo_ambient_reflection_coef_view" );
		$( "#geo_ambient_reflection_coef" ).slider({
			range: "max",
			min: 0, // min value
			max: 1, // max value
			step: 0.01,
			value: '${userPolicy.geo_ambient_reflection_coef}', // default value of slider
			create: function() {
				ambient.text( $( this ).slider( "value" ) );
			},
			slide: function( event, ui ) {
				ambient.text( ui.value);
				$("#geo_ambient_reflection_coef" ).val(ui.value);
			}
		});
		var diffuse = $( "#geo_diffuse_reflection_coef_view" );
		$( "#geo_diffuse_reflection_coef" ).slider({
			range: "max",
			min: 0, // min value
			max: 1, // max value
			step: 0.01,
			value: '${userPolicy.geo_diffuse_reflection_coef}', // default value of slider
			create: function() {
				diffuse.text( $( this ).slider( "value" ) );
			},
			slide: function( event, ui ) {
				diffuse.text( ui.value);
				$("#geo_diffuse_reflection_coef" ).val(ui.value);
			}
		});
		var specular = $( "#geo_specular_reflection_coef_view" );
		$( "#geo_specular_reflection_coef" ).slider({
			range: "max",
			min: 0, // min value
			max: 1, // max value
			step: 0.01,
			value: '${userPolicy.geo_specular_reflection_coef}', // default value of slider
			create: function() {
				specular.text( $( this ).slider( "value" ) );
			},
			slide: function( event, ui ) {
				specular.text( ui.value);
				$("#geo_specular_reflection_coef" ).val(ui.value);
			}
		});
		
		$('[name="geo_ambient_color"]').paletteColorPicker({
			clear_btn: 'last',
			//position: 'downside',
			close_all_but_this: true // Default is false
		});
		$('[name="geo_specular_color"]').paletteColorPicker({
			clear_btn: 'last',
			//position: 'downside',
			close_all_but_this: true // Default is false
		});
	}
	
	var projectDialog = $( ".projectDialog" ).dialog({
		autoOpen: false,
		height: 600,
		width: 1200,
		modal: true,
		overflow : "auto",
		resizable: false
	});
	
	// 시작 프로젝트 찾기
	$( "#projectFind" ).on( "click", function() {
		projectDialog.dialog( "open" );
		drawProjectList();
	});
	
	function drawProjectList() {
		$.ajax({
			url: "/project/ajax-list-project.do",
			type: "POST",
			//data: info,
			cache: false,
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					var content = "";
					var projectList = msg.projectList;
					if(projectList == null || projectList.length == 0) {
						content = content
							+ 	"<tr>"
							+ 	"	<td colspan=\"11\" class=\"col-none\">프로젝트가 존재하지 않습니다.</td>"
							+ 	"</tr>";
					} else {
						projectListCount = projectList.length;
						for(i=0; i<projectListCount; i++ ) {
							var project = projectList[i];
							content = content 
								+ 	"<tr>"
								+ 	"	<td class=\"col-checkbox\"><input type=\"checkbox\" id=\"project_id_" + project.project_id 
								+ 											"\" name=\"project_id\" value=\"" + project.project_id + "," + project.project_name + "\" /></td>"
								+ 	"	<td class=\"col-name\">" + project.sharing_type + " </td>"
								+ 	"	<td class=\"col-name\">" + project.project_name + " </td>"
								+ 	"	<td class=\"col-number\">" + project.view_order + "</td>"
								+ 	"	<td class=\"col-toggle\">" + project.default_yn + "</td>"
								+ 	"	<td class=\"col-toggle\">" + project.use_yn + "</td>"
								+ 	"	<td class=\"col-toggle\">" + project.latitude + "</td>"
								+ 	"	<td class=\"col-toggle\">" + project.longitude + "</td>"
								+ 	"	<td class=\"col-toggle\">" + project.height + "</td>"
								+ 	"	<td class=\"col-toggle\">" + project.duration + "</td>"
								+ 	"	<td class=\"col-toggle\">" + project.insert_date +"</td>"
								+ 	"	</tr>";
						}
					}
					
					$("#projectList").empty();
					$("#projectList").html(content);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error:function(request, status, error) {
				//alert(JS_MESSAGE["ajax.error.message"]);
				alert(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
    		}
		});
	}
	
	// 전체 선택 
	$("#chk_all").click(function() {
		$(":checkbox[name=project_id]").prop("checked", this.checked);
	});
	
	$( "#projectSelect" ).on( "click", function() {
		var checkedValue = "";
		var checkedName = "";
		$("input:checkbox[name=project_id]:checked").each(function(index){
			var tempValue = $(this).val().split(",");
			checkedValue += tempValue[0] + ",";
			checkedName += tempValue[1] + ",";
		});
		if(checkedValue.indexOf(",") > 0) {
			checkedValue =checkedValue.substring(0, checkedValue.lastIndexOf(","));
			checkedName =checkedName.substring(0, checkedName.lastIndexOf(","));
		}
		
		$("#geo_data_default_projects").val(checkedValue);
		$("#geo_data_default_projects_view").val(checkedName);
		projectDialog.dialog( "close" );
	});
</script>
</body>
</html>
