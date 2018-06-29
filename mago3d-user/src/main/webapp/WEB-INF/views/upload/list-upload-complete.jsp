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
	
	<script src="/externlib/dropzone/dropzone.js"></script>
</head>
<body>
	
<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>

<div id="right-panel" class="right-panel">

	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<%@ include file="/WEB-INF/views/layouts/page_header.jsp" %>
			
	<div class="content mt-3" style="min-height: 750px;">
	
		<div class="page-content">
			<div class="filters">
   				<form:form id="searchForm" modelAttribute="uploadLog" method="post" action="/data/list-data.do" onsubmit="return searchCheck();">
				<div class="input-group row">
					<div class="input-set">
						<label for="search_word"><spring:message code='search.word'/></label>
						<select id="search_word" name="search_word" class="select">
							<option value=""><spring:message code='select'/></option>
		          			<option value="file_name">파일 이름</option>
						</select>
						<select id="search_option" name="search_option" class="select">
							<option value="0"><spring:message code='search.same'/></option>
							<option value="1"><spring:message code='search.include'/></option>
						</select>
						<form:input path="search_value" type="search" cssClass="m" />
					</div>
					<div class="input-set">
						<label for="start_date"><spring:message code='search.date'/></label>
						<input type="text" class="s date" id="start_date" name="start_date" />
						<span class="delimeter tilde">~</span>
						<input type="text" class="s date" id="end_date" name="end_date" />
					</div>
					<div class="input-set">
						<label for="order_word"><spring:message code='search.order'/></label>
						<select id="order_word" name="order_word" class="select">
							<option value=""> <spring:message code='search.basic'/> </option>
							<option value="file_name"> 파일 이름 </option>
							<option value="insert_date"> <spring:message code='search.insert.date'/> </option>
						</select>
						<select id="order_value" name="order_value" class="select">
	                		<option value=""> <spring:message code='search.basic'/> </option>
		                	<option value="ASC"> <spring:message code='search.ascending'/> </option>
							<option value="DESC"> <spring:message code='search.descending.order'/> </option>
						</select>
						<select id="list_counter" name="list_counter" class="select">
	                		<option value="10"> <spring:message code='search.ten.count'/> </option>
		                	<option value="50"> <spring:message code='search.fifty.count'/> </option>
							<option value="100"> <spring:message code='search.hundred.count'/> </option>
						</select>
					</div>
					<div class="input-set">
						<input type="submit" value="<spring:message code='search'/>" />
					</div>
				</div>
				</form:form>
			</div>
			<div class="list">
				<form:form id="listForm" modelAttribute="uploadLog" method="post">
					<input type="hidden" id="check_ids" name="check_ids" value="" />
				<div class="list-header row" style="padding-left: 20px;">
					<div class="list-desc u-pull-left">
						<spring:message code='all.d'/> <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em><spring:message code='search.what.count'/> 
						<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
					</div>
				</div>
				<table class="list-table scope-col">
						<col class="col-checkbox" />
						<col class="col-number" />
						<col class="col-name" />
						<col class="col-functions" />
						<col class="col-functions" />
						<col class="col-date" />
						<col class="col-functions" />
						<thead>
							<tr>
								<th scope="col" class="col-checkbox"><input type="checkbox" id="chk_all" name="chk_all" /></th>
								<th scope="col" class="col-number"><spring:message code='number'/></th>
								<th scope="col" class="col-name">파일명</th>
								<th scope="col" class="col-id">파일 경로</th>
								<th scope="col" class="col-name">사이즈</th>
								<th scope="col" class="col-date"><spring:message code='insert.date'/></th>
								<th scope="col" class="col-functions">수정 / 삭제</th>
							</tr>
						</thead>
						<tbody>
<c:if test="${empty uploadCompleteList }">
							<tr>
								<td colspan="7" class="col-none">파일 업로딩 이력이 존재하지 않습니다.</td>
							</tr>
</c:if>
<c:if test="${!empty uploadCompleteList }">
<c:forEach var="uploadLog" items="${uploadCompleteList}" varStatus="status">
							<tr>
								<td class="col-checkbox">
									<input type="checkbox" id="upload_log_id_${uploadLog.upload_log_id}" name="upload_log_id" value="${uploadLog.upload_log_id}" />
								</td>
								<td class="col-number">${pagination.rowNumber - status.index }</td>
								<td class="col-name">${uploadLog.file_name }</td>
								<td class="col-name">${uploadLog.file_path}</td>
								<td class="col-name">${uploadLog.file_size}</td>
								<td class="col-name">${uploadLog.viewInsertDate }</td>
								<td class="col-functions">
									<span class="button-group">
										<a href="/data/modify-data.do?data_id=${uploadLog.upload_log_id }&amp;pageNo=${pagination.pageNo }${pagination.searchParameters}" 
											class="image-button button-edit"><spring:message code='modified'/></a>
										<a href="/data/delete-data.do?data_id=${uploadLog.upload_log_id }" onclick="return deleteWarning();" 
											class="image-button button-delete"><spring:message code='delete'/></a>
									</span>
								</td>
							</tr>
</c:forEach>
</c:if>
						</tbody>
				</table>
				</form:form>
				
			</div>
			<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
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
		url: "/userupload/insert-fileupload.do",	
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
			
			// maxFiles 카운터를 초과하면 경고창
			this.on("maxfilesexceeded", function (data) {
				alert("최대 업로드 파일 수는 20개 입니다.");
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
