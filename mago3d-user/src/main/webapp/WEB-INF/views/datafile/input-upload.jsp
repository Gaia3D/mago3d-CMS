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
		width: 740px;
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
				<div class="input-header row">
					<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='check'/></div>
				</div>
				<form:form id="dataInfo" modelAttribute="dataInfo" method="post" onsubmit="return false;">
				<table class="input-table scope-row">
					<col class="col-label" />
					<col class="col-input" />
					<tr>
						<th class="col-label" scope="row">
							<form:label path="project_name"><spring:message code='project.name'/></form:label>
							<span class="icon-glyph glyph-emark-dot color-warning"></span>
						</th>
						<td class="col-input">
							<form:input path="project_name" cssClass="l" />
							<form:errors path="project_name" cssClass="error" />
						</td>
					</tr>
					<tr>
						<th class="col-label m" scope="row">
							데이터명
							<span class="icon-glyph glyph-emark-dot color-warning"></span>
						</th>
						<td class="col-input">
							<form:input path="data_name" cssClass="m" />
						</td>
					</tr>
				
				</table>
				</form:form>
				
				<div id="button-group" style="margin-top: 20px;">
					<form id="my-dropzone" action="" class="dropzone hzScroll" style="border: 1px solid #d9d9d9;"></form>
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

<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript">
	// https://ncube.net/13905
	// http://blog.naver.com/PostView.nhn?blogId=wolfre&logNo=220154561376&parentCategoryNo=&categoryNo=1&viewDate=&isShowPopularPosts=true&from=search

	Dropzone.options.myDropzone = {
		url: "/converter/insert-upload.do",	
		//paramName: "file",
		// Prevents Dropzone from uploading dropped files immediately
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
		acceptedFiles: ".3ds, .obj, .dae, .ifc, citygml, indoorgml, jpg, jpeg gif, png, bmp",
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
	            /* formData.append("userId", $("#userId").val());
	            formData.append("userName", $("#userName").val()); */
	        });
			
			// maxFiles 카운터를 초과하면 경고창
			this.on("maxfilesexceeded", function (data) {
				alert("최대 업로드 파일 수는 100개 입니다.");
				return;
			});
			
			this.on("complete", function (data) {
				console.log("-------------" + data);
				/* if (this.getUploadingFiles().length === 0 && this.getQueuedFiles().length === 0) {
					if (data.xhr != undefined) {
						var res = eval('(' + data.xhr.responseText + ')');
						var msg;
						if (res.Result) {
							msg = "이미지 업로드 완료( " + res.Count + " )";
						} else {
							msg = "업로드 실패: " + res.Message;
						}
						alert(msg);
					}
				} */
			});
		}
	};
</script>
</body>
</html>
