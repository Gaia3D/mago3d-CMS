<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>main | mago3D User</title>
	<link rel="stylesheet" href="/externlib/sufee-template/css/bootstrap.min.css">
	<link rel="stylesheet" href="/externlib/sufee-template/css/font-awesome.min.css">
	<link rel="stylesheet" href="/externlib/sufee-template/css/themify-icons.css">
	<link rel="stylesheet" href="/externlib/sufee-template/scss/style.css">
	<link rel="stylesheet" href="/externlib/dropzone/dropzone.css">
	<link rel="stylesheet" href="/css/ko/style.css">
	
	<script src="/externlib/dropzone/dropzone.min.js"></script>
</head>
<body>
	
<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>

<div id="right-panel" class="right-panel">

	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<%@ include file="/WEB-INF/views/layouts/page_header.jsp" %>
			
	<div class="content mt-3" style="min-height: 750px;">
		
		<div class="page-content">
			<div class="input-header row">
				<div><span style="margin-left:20px; margin-bottom: 10px;" class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='notice.field.required'/></div>
			</div>
			<div class="tabs">
			
				<!-- <div id="trueForm">
				<form id="my-dropzone" class="dropzone" style="min-height: 300px;" enctype="multipart/form-data" method="post">
				</form>
				
					<div style="margin-top: 10px; margin-left: 5px;">
						<button type="submit" id="allFileUpload" disabled="disabled">업로드</button>
						<button id="allFileClear" disabled="disabled">All Clear</button>
				    </div>
				</div>	 -->
				
				<form action="" class="dropzone" id="my-dropzone"></form>

				<div style="margin-top: 10px; margin-left: 5px;">
					<button id="allFileUpload">업로드</button>
					<button id="allFileClear">All Clear</button>
				</div>
			</div>
		</div>
					
	</div>
	
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
</div>

<script src="/externlib/jquery/jquery.js"></script>
<script src="/externlib/sufee-template/js/plugins.js"></script>
<script src="/externlib/sufee-template/js/main.js"></script>

<script type="text/javascript">
	// https://ncube.net/13905
	// http://blog.naver.com/PostView.nhn?blogId=wolfre&logNo=220154561376&parentCategoryNo=&categoryNo=1&viewDate=&isShowPopularPosts=true&from=search

	Dropzone.options.myDropzone = {
		url: "/fileupload/insert-fileupload.do",	
		//paramName: "file",
		// Prevents Dropzone from uploading dropped files immediately
		autoProcessQueue: false,
		// 여러개의 파일 허용
		uploadMultiple: true,
		method: "post",
		// 병렬 처리
		parallelUploads: 20,
		// 최대 파일 업로드 갯수
		maxFiles: 20,
		// 최대 업로드 용량 Mb단위
		maxFilesize: 500,
		dictDefaultMessage: "Drop files here or click to upload",
		/* headers: {
			"x-csrf-token": document.querySelectorAll("meta[name=csrf-token]")[0].getAttributeNode("content").value,
		}, */
		// 허용 확장자
		acceptedFiles: ".js, .css, .jpg .3ds, .obj, .dae, .ifc, .3DS, .OBJ, .DAE, .IFC",
		// 업로드 취소 및 추가 삭제 미리 보기 그림 링크 를 기본 추가 하지 않음
		// 기본 true false 로 주면 아무 동작 못함
		//clickable: true,
		removedfile: function(file) {
			console.log("remove file call");
			var _ref;
			(_ref = file.previewElement) != null ? _ref.parentNode.removeChild(file.previewElement) : void 0;
			setFilesName();
			return;
	    },
	    fallback: function() {
	    	// 지원하지 않는 브라우저인 경우
	    },

		init: function() {
			var dataDropzone = this; // closure
			var uploadTask = document.querySelector("#allFileUpload")
			
			uploadTask.addEventListener("click", function() {
				dataDropzone.processQueue(); // Tell Dropzone to process all queued files.
			});

			// You might want to show the submit button only when 
			// files are dropped here:
			this.on("addedfile", function() {
				// Show submit button here and/or inform user to click it.
			});
		}
	};
</script>
</body>
</html>
