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
	<link rel="stylesheet" href="/externlib/dropzone/dropzone.min.css">
	<link rel="stylesheet" href="/css/ko/style.css">
	
	<script src="/externlib/dropzone/dropzone.min.js"></script>
</head>
<body>
	
<!-- Left Panel -->
<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
<!-- Left Panel -->

<!-- Right Panel -->
<div id="right-panel" class="right-panel">

	<!-- Header-->
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
    <!-- Header-->

	<!-- Page Header-->
	<%@ include file="/WEB-INF/views/layouts/page_header.jsp" %>
    <!-- Page Header-->
			
	<div class="content mt-3" style="min-height: 750px;">
		
		<div class="page-content">
			<div class="input-header row">
				<div><span style="margin-left:20px; margin-bottom: 10px;" class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='notice.field.required'/></div>
			</div>
			<div class="tabs">
				<button id="submit-all">Submit all files</button>
				<form action="/target" class="dropzone" id="my-dropzone"></form>





				<%-- <table class="input-table scope-row">
					<col class="col-label m" />
					<col class="col-input" />
					<tr>
						<th class="col-label" scope="row">
							<form:label path="data_key">Data Key</form:label>
							<span class="icon-glyph glyph-emark-dot color-warning"></span>
						</th>
						<td class="col-input">
							<form:input path="data_key" cssClass="l" />
							<form:errors path="data_key" cssClass="error" />
							<form:hidden path="latitude"/>
							<form:hidden path="longitude"/>
						</td>
					</tr>
					<tr>
						<th class="col-label" scope="row">
							첨부 파일
						</th>
						<td class="col-input">
							<input type="file" id="file_name" name="file_name" class="col-data" />
						</td>
					</tr>
				</table>
				<div class="button-group">
					<div id="insertIssueLink" class="center-buttons">
						<input type="submit" value="저장"/>
						<a href="/issue/list-issue.do" class="button">목록</a>
					</div>
				</div> --%>
				
			</div>
		</div>
					
	</div>
	
	<!-- footer -->
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
    <!-- footer -->
</div>
<!-- Right Panel -->

<script src="/externlib/jquery/jquery.js"></script>
<script src="/externlib/sufee-template/js/plugins.js"></script>
<script src="/externlib/sufee-template/js/main.js"></script>

<script type="text/javascript">
	Dropzone.options.myDropzone = {
		// Prevents Dropzone from uploading dropped files immediately
		autoProcessQueue: false,
		init: function() {
	    	var submitButton = document.querySelector("#submit-all")
			myDropzone = this; // closure
			submitButton.addEventListener("click", function() {
				myDropzone.processQueue(); // Tell Dropzone to process all queued files.
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
