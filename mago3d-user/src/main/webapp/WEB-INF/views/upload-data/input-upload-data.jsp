<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>프로젝트 등록 | mago3D User</title>
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="/css/cloud.css?cache_version=${cache_version}">
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/dropzone/dropzone.css">
	
	<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
	<script type="text/javascript" src="/js/cloud.js?cache_version=${cache_version}"></script>
	<script type="text/javascript" src="/externlib/dropzone/dropzone.js"></script>
	<style type="text/css">
	.dropzone .dz-preview.lp-preview {
		width: 150px;
    }
	.dropzone.hzScroll { 
		min-width: 1153px;
		max-width: 1920px;
		overflow: auto; 
		white-space: nowrap; 
	}
	</style>
</head>
<body>

<div class="site-body">
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<div id="site-content" class="on">
		<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
		<div id="content-wrap">
			<div id="gnb-content" class="clfix">
				<h1 style="padding-left: 20px;">
					<span style="font-size:26px;">파일 업로딩</span>
				</h1>
				<div class="location">
					<span style="padding-top:10px; font-size:12px; color: Mediumslateblue;">
						<i class="fas fa-cubes" title="프로젝트"></i>
					</span>
					<span style="font-size:12px;">프로젝트 > 프로젝트 등록</span>
				</div>
			</div>
			
			<div class="page-content">
				<div class="content-desc u-pull-right" style="padding-right: 10px;">
					<span class="icon-glyph glyph-emark-dot color-warning" style="display: inline-block; padding-bottom: 2px;"></span>
					<span style="display: inline-block; padding-bottom: 2px;"><spring:message code='check'/></span></div>
				<div style="margin-top: 20px; border: 1px solid #dddddd;">
					<ul style="list-style: none; font-size: 14px; border-bottom: 3px solid #573592">
						<li style="padding-left: 10px; padding-top: 5px; width: 80px; height: 30px; color: white; background: #573690;">
							공간 정보
						</li>
					</ul>
					<div id="project_tab">
						<form:form id="uploadData" modelAttribute="uploadData" method="post" onsubmit="return false;">
						<table class="input-table scope-row">
							<col class="col-label" />
							<col class="col-input" />
							<tr>
								<th class="col-label" scope="row">
									운영 정책 안내
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input" style="padding-bottom: 10px;">
									<ul style="list-style: none;">
										<li style="height: 25px;">
											업로딩 한 파일은 다른 사용자들에게 전부 <b style="color: blue;">공개</b> 됩니다. <b style="color: blue;">비공개, 그룹 공유</b> 기능은 현재 개발 중입니다. </li>
										<li style="height: 25px;"> 디렉토리를 포함하는 파일의 경우 <b style="color: blue;">zip</b> 파일로 압축해서 업로딩해 주십시오. </li>
										<li style="height: 25px;"> 복수 파일의 경우, <b style="color: blue;">대표 공간 정보</b>를 입력 후 데이터 목록 메뉴에서 수정하시기 바랍니다. </li>
									</ul>
								</td>
							</tr>
							<tr>
								<th class="col-label m" scope="row">
									<form:label path="sharing_type">공유 타입</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<select id="sharing_type" name="sharing_type" class="select" style="height: 30px;">
										<option value="1" selected="selected"> 공개 프로젝트 </option>
										<option value="2" disabled="disabled"> 개인 프로젝트 </option>
						          		<option value="3" disabled="disabled"> 공유 프로젝트 </option>
						          		<option value="0" disabled="disabled"> 공통 프로젝트 </option>
									</select>
								</td>
							</tr>
							<tr>
								<th class="col-label m" scope="row">
									<form:label path="data_type">데이터 타입</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<select id="data_type" name="sharing_type" class="select" style="height: 30px;">
										<option value="3ds" selected="selected"> 3DS </option>
										<option value="obj"> OBJ </option>
						          		<option value="dae"> DAE </option>
						          		<option value="ifc"> IFC </option>
						          		<option value="citygml"> CITYGML </option>
						          		<option value="indoorgml"> INDOORGML </option>
									</select>
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
									<form:label path="project_name"><spring:message code='project.name'/></form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:hidden path="project_id" />
									<form:input path="project_name" cssClass="l" readonly="true" />
									<input type="button" id="project_search_buttion" value="찾기" />
								</td>
							</tr>
							<tr>
								<th class="col-label m" scope="row">
									데이터명
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:input path="data_name" cssClass="l" />
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
									<form:label path="latitude"><spring:message code='latitude'/></form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:input path="latitude" class="m" />
			  						<form:errors path="latitude" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
									<form:label path="longitude"><spring:message code='longitude'/></form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:input path="longitude" class="m" />
			  						<form:errors path="longitude" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
									<form:label path="height"><spring:message code='height'/></form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:input path="height" class="m" />
			  						<form:errors path="height" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
									<form:label path="description">설명</form:label>
								</th>
								<td class="col-input">
									<form:input path="description" class="xl" />
			  						<form:errors path="description" cssClass="error" />
								</td>
							</tr>
						</table>
						</form:form>
					</div>
				</div>
				
				<div id="button-group" style="text-align: center;">
					<form id="my-dropzone" action="" class="dropzone hzScroll" style="border: 1px solid #d9d9d9; font-size: 16px;"></form>
					<div style="margin-top: 10px; margin-left: 5px;">
						<button id="allFileUpload">업로드</button>
						<button id="allFileClear">All Clear</button>
					</div>
				</div>		
				
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
</div>

<%@ include file="/WEB-INF/views/upload-data/project_dialog.jsp" %>

<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript">
	//그룹 선택
	$( "#project_search_buttion" ).on( "click", function() {
		projectDialog.dialog( "open" );
		searchProject();
	});
	var projectDialog = $( ".project_search-dialog" ).dialog({
		autoOpen: false,
		height: 600,
		width: 600,
		modal: true,
		resizable: false
	});
	
	var searchProjectFlag = true;
	function searchProject() {
		if(searchProjectFlag) {
			searchProjectFlag = false;
			var info = "sharing_type=" + $("#sharing_type").val();		
			$.ajax({
				url: "/project/ajax-list-project.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						drawProjectList(msg.projectList);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					searchProjectFlag = true;
				},
				error:function(request,status,error){
					alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
					searchProjectFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	function drawProjectList(projectList) {
		var content = "";
		if(projectList == null || projectList.length == 0) {
			content += 	"<li>"
					+	" 프로젝트가 존재하지 않습니다. 프로젝트 등록 후 이용 가능 합니다."
					+	"</li>";
		} else {
			for(i=0; i<projectList.length; i++ ) {
				var project = null;
				project = projectList[i];
				content = content 
					+ 	"<li>"
					+ 	"	<input type=\"radio\" id=\"radio_" + project.project_id + "\" name=\"radio_search_project\" value=\"" + project.project_id + "_" + project.project_name + "\" />"
					+	"	<label for=\"radio_" + project.project_id + "\">" + project.project_name + "</label>"
					+ 	"</li>";
			}
		}
		$("#project-list-area").empty();
		$("#project-list-area").html(content);
	}
	
	// 프로젝트 선택
	$( "#button_projectSelect" ).on( "click", function() {
		var radioObj = $(":radio[name=radio_search_project]:checked").val();
		if (!radioObj) {
			alert("프로젝트를 선택하여 주십시오.");
			return false;
	    } else {
	    	var splitValues = radioObj.split("_");
	    	var projectName = "";
	    	for(var i = 1; i < splitValues.length; i++) {
	    		projectName = projectName + splitValues[i];
	    		if(i != splitValues.length - 1) {
	    			projectName = projectName + "_";
	    		}
			}	    	
	    	$("#project_id").val(splitValues[0]);
			$("#project_name").val(projectName);
			projectDialog.dialog( "close" );
	    }
	});
	
	// https://ncube.net/13905
	// http://blog.naver.com/PostView.nhn?blogId=wolfre&logNo=220154561376&parentCategoryNo=&categoryNo=1&viewDate=&isShowPopularPosts=true&from=search

	var uploadFileCount = 0;
	Dropzone.options.myDropzone = {
		url: "/upload-data/insert-upload-data.do",	
		//paramName: "file",
		// Prevents Dropzone from uploading dropped files immediately
		timeout: 3600000,
		autoProcessQueue: false,
		// 여러개의 파일 허용
		uploadMultiple: true,
		method: "post",
		// 병렬 처리
		parallelUploads: 100,
		// 최대 파일 업로드 갯수
		maxFiles: 100,
		// 최대 업로드 용량 Mb단위
		maxFilesize: 2000,
		dictDefaultMessage: "Drop files here or click to upload",
		/* headers: {
			"x-csrf-token": document.querySelectorAll("meta[name=csrf-token]")[0].getAttributeNode("content").value,
		}, */
		// 허용 확장자
		acceptedFiles: ".3ds, .obj, .dae, .ifc, .citygml, .indoorgml, .jpg, .jpeg, .gif, .png, .bmp, .zip",
		// 업로드 취소 및 추가 삭제 미리 보기 그림 링크 를 기본 추가 하지 않음
		// 기본 true false 로 주면 아무 동작 못함
		//clickable: true,
		fallback: function() {
	    	// 지원하지 않는 브라우저인 경우
	    	alert("죄송합니다. 최신의 브라우저로 Update 후 사용해 주십시오.");
	    	return;
	    },
		init: function() {
			var magoDropzone = this; // closure
			var uploadTask = document.querySelector("#allFileUpload");
			var clearTask = document.querySelector("#allFileClear");
			
			uploadTask.addEventListener("click", function(e) {
				if (checkProject() === false) {
					return;
				}
				e.preventDefault();
	            e.stopPropagation();
	            magoDropzone.processQueue(); // Tell Dropzone to process all queued files.
			});

			clearTask.addEventListener("click", function () {
                // Using "_this" here, because "this" doesn't point to the dropzone anymore
                if (confirm("정말 전체 항목을 삭제하겠습니까?")) {
                	// true 주면 업로드 중인 파일도 다 같이 삭제
                	magoDropzone.removeAllFiles(true);
                }
            });
			
			this.on("sending", function(file, xhr, formData) {
				formData.append("sharing_type", $("#sharing_type").val());
				formData.append("data_type", $("#data_type").val());
				formData.append("project_id", $("#project_id").val());
				formData.append("data_name", $("#data_name").val());
				formData.append("latitude", $("#latitude").val());
				formData.append("longitude", $("#longitude").val());
				formData.append("height", $("#height").val());
				formData.append("description", $("#description").val());
			});
			
			// maxFiles 카운터를 초과하면 경고창
			this.on("maxfilesexceeded", function (data) {
				alert("최대 업로드 파일 수는 100개 입니다.");
				return;
			});
			
			/* this.on("complete", function (file) {
				if (file.xhr !== undefined) {
					var responseText = JSON.parse(file.xhr.responseText);
					console.log("file name = " + file.name + ", responseText = " + responseText.result);
					if(responseText.result === "success") {
						 return;
					} else {
						//alert("file name = " + file.name + ", error message = " + responseText.result);
					}
				} else {
					console.log("file.xhr is undefined. file name = " + file.name);
				}
			}); */
			
			this.on("success", function(file, response) {
				if(file !== undefined && file.name !== undefined) {
					console.log("file name = " + file.name + ", result = " + response.result);
					if(response.result === "success") {
						if(uploadFileCount === 0) {
							uploadFileCount++;
							alert("업로딩을 완료 하였습니다.");
						}
						return;
					} else if(response.result === "upload.file.type.invalid") {
						alert("복수의 파일을 업로딩 할 경우 zip 파일은 사용할 수 없습니다.")
					}
				} else {
					console.log("------- success response = " + response.result);	
				}
			})
		}
	};
	
	function checkProject() {
		if ($("#project_id").val() == "") {
			alert(JS_MESSAGE["project.name.empty"]);
			$("#project_id").focus();
			return false;
		}
		if ($("#data_name").val() == "") {
			alert(JS_MESSAGE["data.name.empty"]);
			$("#data_name").focus();
			return false;
		}
		if ($("#latitude").val() == "") {
			alert(JS_MESSAGE["latitude.empty"]);
			$("#latitude").focus();
			return false;
		}
		if ($("#longitude").val() == "") {
			alert(JS_MESSAGE["longitude.empty"]);
			$("#longitude").focus();
			return false;
		}
		if ($("#height").val() == "") {
			alert(JS_MESSAGE["height.empty"]);
			$("#height").focus();
			return false;
		}
	}
</script>
</body>
</html>
