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
					<div class="filters">
		   				<form:form id="searchForm" modelAttribute="converterUploadLog" method="post" action="/converter/input-converterjob.do" onsubmit="return searchCheck();">
						<div class="input-group row">
							<div class="input-set">
								<label for="search_word"><spring:message code='search.word'/></label>
								<select id="search_word" name="search_word" class="select" style="height: 30px;">
									<option value=""><spring:message code='select'/></option>
				          			<option value="file_name">파일 이름</option>
								</select>
								<select id="search_option" name="search_option" class="select" style="height: 30px;">
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
								<select id="order_word" name="order_word" class="select" style="height: 30px;">
									<option value=""> <spring:message code='search.basic'/> </option>
									<option value="file_name"> 파일 이름 </option>
									<option value="insert_date"> <spring:message code='search.insert.date'/> </option>
								</select>
								<select id="order_value" name="order_value" class="select" style="height: 30px;">
			                		<option value=""> <spring:message code='search.basic'/> </option>
				                	<option value="ASC"> <spring:message code='search.ascending'/> </option>
									<option value="DESC"> <spring:message code='search.descending.order'/> </option>
								</select>
								<select id="list_counter" name="list_counter" class="select" style="height: 30px;">
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
						<div class="list-header">
							<div class="list-desc u-pull-left">
								<spring:message code='all.d'/> <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em><spring:message code='search.what.count'/> 
								<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
							</div>
							<div class="list-functions u-pull-right">
								<div style="padding-bottom: 3px;" class="button-group">
									<a href="#" onclick="converterFiles(); return false;" class="button">F4D 일괄 변환</a>	
								</div>
							</div>
						</div>
						<table class="list-table scope-col">
								<col class="col-checkbox" />
								<col class="col-number" />
								<col class="col-name" />
								<col class="col-functions" />
								<col class="col-functions" />
								<col class="col-number" />
								<col class="col-functions" />
								<col class="col-functions" />
								<col class="col-functions" />
								<thead>
									<tr>
										<th scope="col" class="col-checkbox"><input type="checkbox" id="chk_all" name="chk_all" /></th>
										<th scope="col" class="col-number"><spring:message code='number'/></th>
										<th scope="col" class="col-name">파일명</th>
										<th scope="col" class="col-id">파일 경로</th>
										<th scope="col" class="col-name">사이즈</th>
										<th scope="col" class="col-name">F4d 변환횟수</th>
										<th scope="col" class="col-date"><spring:message code='insert.date'/></th>
										<th scope="col" class="col-functions">변환</th>
										<th scope="col" class="col-functions">삭제</th>
									</tr>
								</thead>
								<tbody>
<c:if test="${empty converterUploadLogList }">
									<tr>
										<td colspan="9" class="col-none">파일 업로딩 이력이 존재하지 않습니다.</td>
									</tr>
</c:if>
<c:if test="${!empty converterUploadLogList }">
	<c:forEach var="converterUploadLog" items="${converterUploadLogList}" varStatus="status">
									<tr>
										<td class="col-checkbox">
											<input type="checkbox" id="converter_upload_log_id_${converterUploadLog.converter_upload_log_id}" name="converter_upload_log_id" value="${converterUploadLog.converter_upload_log_id}" />
										</td>
										<td class="col-number">${pagination.rowNumber - status.index }</td>
										<td class="col-name">${converterUploadLog.file_name }</td>
										<td class="col-name">${converterUploadLog.file_path}</td>
										<td class="col-name">${converterUploadLog.file_size}</td>
										<td class="col-name">${converterUploadLog.converter_count}</td>
										<td class="col-name">${converterUploadLog.viewInsertDate }</td>
										<td class="col-functions">
											<span class="button-group">
												<a href="#" onclick="converterFile('${converterUploadLog.converter_upload_log_id}'); return false;" class="button">F4D 변환</a>
											</span>
										</td>
										<td class="col-functions">
											<span class="button-group">
												<a href="/converter/delete-upload.do?converter_upload_log_id=${converterUploadLog.converter_upload_log_id }" onclick="return deleteWarning();" 
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
				<!-- End content by page -->
				
			</div>
			<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
		</div>
	</div>
	<!--  컨텐츠 -->
</div>

<%-- F4D Converter Job 등록 --%>
<div class=dialog_converter_job title="F4D Converter Job 등록">
	<form id="converterJobForm" name="converterJobForm" action="" method="post">
		<input type="hidden" id="check_ids" name="check_ids" value="" />
		<table class="inner-table scope-row">
			<col class="col-sub-label xl" />
			<col class="col-data" />
			<tbody>
				<tr>
					<th class="col-sub-label x">제목</th>
					<td>
						<div class="inner-data">
							<input type="text" id="title" name="title" class="l" />
						</div>
					</td>
				</tr>
				<tr>
					<th class="col-sub-label x">F4D 변환 타입</th>
					<td class="col-input">
						<input type="radio" id="converter_type_default" name="converter_type" value="0" />
						<label for="converter_type_default">기본</label>
						<input type="radio" id="converter_type_big" name="converter_type" value="1" />
						<label for="converter_type_big">Big Mesh One</label>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="button-group">
			<a href="#" onclick="saveConverterJob(); return false;" class="button">저장</a>
		</div>
	</form>
</div>
<%-- F4D Converter Job 등록 --%>

<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript">
	
	//전체 선택 
	$("#chk_all").click(function() {
		$(":checkbox[name=converter_upload_log_id]").prop("checked", this.checked);
	});
	
	var dialogConverterJob = $( ".dialog_converter_job" ).dialog({
		autoOpen: false,
		height: 280,
		width: 600,
		modal: true,
		resizable: false,
		close: function() { location.reload(); }
	});
	
	// F4D Converter Button Click
	function converterFile(converter_upload_log_id) {
		$("#check_ids").val(converter_upload_log_id + ",");
		
		dialogConverterJob.dialog( "open" );
	}
	
	// All F4D Converter Button Click
	function converterFiles() {
		var checkedValue = "";
		$("input:checkbox[name=converter_upload_log_id]:checked").each(function(index){
			checkedValue += $(this).val() + ",";
		});
		if(checkedValue === "") {
			alert("파일을 선택해 주십시오.");
			return;
		}
		$("#check_ids").val(checkedValue);
		
		dialogConverterJob.dialog( "open" );
	}
	
	// F4D Converter 일괄 변환
	var saveConverterJobFlag = true;
	function saveConverterJob() {
		if($("#title").val() == null || $("#title").val() == "") {
			alert("제목을 입력하여 주십시오.");
			return false;
		}
		
		if(saveConverterJobFlag) {
			saveConverterJobFlag = false;
			var info =$("#converterJobForm").serialize();
			$.ajax({
				url: "/converter/ajax-insert-converter-job.do",
				type: "POST",
				data: info,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["insert"]);	
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					
					$("#check_ids").val("");
					$("#title").val("");
					$(":checkbox[name=converter_upload_log_id]").prop("checked", false);
					dialogConverterJob.dialog( "close" );
					saveConverterJobFlag = true;
				},
				error:function(request,status,error){
					alert(JS_MESSAGE["ajax.error.message"]);
					dialogConverterJob.dialog( "close" );
					saveConverterJobFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
		
	}
</script>
</body>
</html>
