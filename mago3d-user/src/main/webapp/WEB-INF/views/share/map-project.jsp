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
	<link rel="stylesheet" href="/css/cloud.css">
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<script type="text/javascript" src="/js/cloud.js"></script>
</head>
<body>

<div class="default-layout">
	<!-- 왼쪽 메뉴 -->
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	<!-- 왼쪽 메뉴 -->
	
	<!--  컨텐츠 -->
	<div class="content-layout">
		<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
		<div>
			<%@ include file="/WEB-INF/views/layouts/page_header.jsp" %>
			<div class="content-detail">
				
				<!-- Start content by page -->
				<div class="page-content">
					<div style="padding-left: 200px; padding-top: 100px; font-size: 100px;">개발중 입니다.</div>
				</div>
				<!-- End content by page -->
				
			</div>
			<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
		</div>
	</div>
	<!--  컨텐츠 -->
</div>

<!-- Dialog -->
<div id="dataDialog" class="dataDialog" title="<spring:message code='search'/>">
	<table class="list-table scope-col">
		<col class="col-number" />
		<col class="col-name" />
		<col class="col-name" />
		<col class="col-number" />
		<col class="col-toggle" />
		<col class="col-toggle" />
		<col class="col-toggle" />
		<col class="col-toggle" />
		<col class="col-toggle" />
		<col class="col-number" />
		<col class="col-date" />
		<thead>
			<tr>
				<th scope="col" class="col-checkbox"><input type="checkbox" id="chk_all" name="chk_all" /></th>
				<th scope="col" class="col-name">Key</th>
				<th scope="col" class="col-name"><spring:message code='project.name'/></th>
				<th scope="col" class="col-number"><spring:message code='order'/></th>
				<th scope="col" class="col-toggle"><spring:message code='default.value'/></th>
				<th scope="col" class="col-toggle"><spring:message code='status'/></th>
				<th scope="col" class="col-toggle"><spring:message code='latitude'/></th>
				<th scope="col" class="col-toggle"><spring:message code='longitude'/></th>
				<th scope="col" class="col-toggle"><spring:message code='height'/></th>
				<th scope="col" class="col-number"><spring:message code='movement.time'/></th>
				<th scope="col" class="col-date"><spring:message code='data.insert.date'/></th>
			</tr>
		</thead>
		<tbody id="projectList">
		</tbody>
	</table>
	<div class="button-group">
		<input type="button" id="projectSelect" class="button" value="<spring:message code='select'/>"/>
	</div>
</div>


<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
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
				url: "/settings/ajax-update-user-policy.do",
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
	
	var dataDialog = $( ".dataDialog" ).dialog({
		autoOpen: false,
		height: 600,
		width: 1200,
		modal: true,
		overflow : "auto",
		resizable: false
	});
	
	// 시작 프로젝트 찾기
	$( "#projectFind" ).on( "click", function() {
		dataDialog.dialog( "open" );
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
								+ 	"	<td class=\"col-name\">" + project.project_key + " </td>"
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
		dataDialog.dialog( "close" );
	});
</script>
</body>
</html>
