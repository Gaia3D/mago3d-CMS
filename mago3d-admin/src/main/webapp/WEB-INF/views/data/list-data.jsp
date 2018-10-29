<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>${sessionSiteName }</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/css/${lang}/style.css" />
</head>
<body>
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	<div class="site-body">
		<div class="container">
			<div class="site-content">
				<%@ include file="/WEB-INF/views/layouts/sub_menu.jsp" %>
				<div class="page-area">
					<%@ include file="/WEB-INF/views/layouts/page_header.jsp" %>
					<div class="page-content">
						<div class="filters">
		    				<form:form id="searchForm" modelAttribute="dataInfo" method="post" action="/data/list-data.do" onsubmit="return searchCheck();">
							<div class="input-group row">
								<div class="input-set">
									<label for="project_id"><spring:message code='data.project.name'/></label>
									<form:select path="project_id" cssClass="select">
										<option value="0"><spring:message code='all'/></option>
<c:forEach var="project" items="${projectList}">
										<option value="${project.project_id}">${project.project_name}</option>
</c:forEach>
									</form:select>
								</div>
								<div class="input-set">
									<label for="search_word"><spring:message code='search.word'/></label>
									<select id="search_word" name="search_word" class="select">
										<option value=""><spring:message code='select'/></option>
					         			<option value="data_name"><spring:message code='name'/></option>
									</select>
									<select id="search_option" name="search_option" class="select">
										<option value="0"><spring:message code='search.same'/></option>
										<option value="1"><spring:message code='search.include'/></option>
									</select>
									<form:input path="search_value" type="search" cssClass="m" />
								</div>
								<div class="input-set">
									<label for="status"><spring:message code='search.status'/></label>
									<select id="status" name="status" class="select">
										<option value=""> <spring:message code='all'/> </option>
										<option value="0"> <spring:message code='search.in.use'/>  </option>
										<option value="1"> <spring:message code='search.stop.use'/> </option>
										<option value="2"> <spring:message code='search.etc'/> </option>
									</select>
								</div>
								<div class="input-set">
									<label for="data_insert_type"><spring:message code='search.insert.type'/></label>
									<select id="data_insert_type" name="data_insert_type" class="select">
										<option value=""><spring:message code='all'/></option>
<c:forEach var="commonCode" items="${dataRegisterTypeList}" varStatus="status">
										<option value="${commonCode.code_value }"> ${commonCode.code_name } </option>
</c:forEach>
									</select>
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
					                	<option value="data_name"> <spring:message code='data.name'/> </option>
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
							<form:form id="listForm" modelAttribute="dataInfo" method="post">
								<input type="hidden" id="check_ids" name="check_ids" value="" />
							<div class="list-header row">
								<div class="list-desc u-pull-left">
									<spring:message code='all.d'/> <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em><spring:message code='search.what.count'/> 
									<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
								</div>
								<div class="list-functions u-pull-right">
									<div class="button-group">
										<a href="#" onclick="updateDataStatus('DATA', 'LOCK'); return false;" class="button"><spring:message code='data.lock'/></a>
										<a href="#" onclick="updateDataStatus('DATA', 'UNLOCK'); return false;" class="button"><spring:message code='data.lock.release'/></a>
										<a href="#" onclick="deleteDatas(); return false;" class="button"><spring:message code='data.all.delete'/></a>
										<a href="#" onclick="uploadDataFile(); return false;" class="button"><spring:message code='data.all.insert'/></a>
										<a href="#" onclick="uploadProjectDataAttribute(); return false;" class="button"><spring:message code='data.attribute.insert'/></a>
										<a href="#" onclick="uploadProjectDataObjectAttribute(); return false;" class="button"><spring:message code='data.object.attribute.insert'/></a>
									</div>
								</div>
							</div>
							<table class="list-table scope-col">
									<col class="col-checkbox" />
									<col class="col-number" />
									<col class="col-name" />
									<col class="col-id" />
									<col class="col-name" />
									<col class="col-toggle" />
									<col class="col-toggle" />
									<col class="col-toggle" />
									<col class="col-toggle" />
									<col class="col-functions" />
									<col class="col-functions" />
									<col class="col-functions" />
									<col class="col-date" />
									<col class="col-functions" />
									<thead>
										<tr>
											<th scope="col" class="col-checkbox"><input type="checkbox" id="chk_all" name="chk_all" /></th>
											<th scope="col" class="col-number"><spring:message code='number'/></th>
											<th scope="col" class="col-name"><spring:message code='data.project.name'/></th>
											<th scope="col" class="col-id"><spring:message code='data.key'/></th>
											<th scope="col" class="col-name"><spring:message code='data.name'/></th>
											<th scope="col" class="col-toggle"><spring:message code='latitude'/></th>
											<th scope="col" class="col-toggle"><spring:message code='longitude'/></th>
											<th scope="col" class="col-toggle"><spring:message code='height'/></th>
											<th scope="col" class="col-toggle"><spring:message code='status'/></th>
											<th scope="col" class="col-name"><spring:message code='data.control.properties'/></th>
											<th scope="col" class="col-name"><spring:message code='data.origin.properties'/></th>
											<th scope="col" class="col-name"><spring:message code='data.object.properties'/></th>
											<th scope="col" class="col-date"><spring:message code='data.insert.date'/></th>
											<th scope="col" class="col-functions"><spring:message code='modified.and.insert'/></th>
										</tr>
									</thead>
									<tbody>
<c:if test="${empty dataList }">
										<tr>
											<td colspan="14" class="col-none"><spring:message code='data.does.not.exist'/></td>
										</tr>
</c:if>
<c:if test="${!empty dataList }">
	<c:forEach var="dataInfo" items="${dataList}" varStatus="status">
										<tr>
											<td class="col-checkbox">
												<input type="checkbox" id="data_id_${dataInfo.data_id}" name="data_id" value="${dataInfo.data_id}" />
											</td>
											<td class="col-number">${pagination.rowNumber - status.index }</td>
											<td class="col-name">
												<a href="#" class="view-group-detail" onclick="detailProject('${dataInfo.project_id }'); return false;">${dataInfo.project_name }</a></td>
											<td class="col-id">${dataInfo.data_key }</td>
											<td class="col-name"><a href="/data/detail-data.do?data_id=${dataInfo.data_id }&amp;pageNo=${pagination.pageNo }${pagination.searchParameters}">${dataInfo.data_name }</a></td>
											<td class="col-toggle">${dataInfo.latitude}</td>
											<td class="col-toggle">${dataInfo.longitude}</td>
											<td class="col-toggle">${dataInfo.height}</td>
											<td class="col-toggle">
		<c:if test="${dataInfo.status eq '0'}">
												<span class="icon-glyph glyph-on on"></span>
												<span class="icon-text"><spring:message code='data.status.use'/></span>
		</c:if>
		<c:if test="${dataInfo.status ne '0'}">
												<span class="icon-glyph glyph-off off"></span>
												<span class="icon-text"><spring:message code='data.status.unused'/></span>
		</c:if>
												
											</td>
											<td class="col-name" style="text-align: center;">
												<a href="#" onclick="detailDataControlAttribute('${dataInfo.data_id }'); return false;"><spring:message code='view'/></a>
											</td>
											<td class="col-functions">
												<span class="button-group">
													<a href="#" onclick="detailDataAttribute('${dataInfo.data_id }', '${dataInfo.data_name }'); return false;"><spring:message code='view'/></a>
													<a href="#" class="image-button button-edit" 
														onclick="uploadDataAttribute('${dataInfo.data_id }', '${dataInfo.data_name }'); return false;">
														<spring:message code='modified'/></a>
												</span>
											</td>
											<td class="col-functions">
												<span class="button-group">
													<a href="#" class="image-button button-edit" 
														onclick="uploadDataObjectAttribute('${dataInfo.data_id }', '${dataInfo.data_name }'); return false;">
														<spring:message code='modified'/></a>
												</span>
											</td>
											<td class="col-date">${dataInfo.viewInsertDate }</td>
											<td class="col-functions">
												<span class="button-group">
													<a href="/data/modify-data.do?data_id=${dataInfo.data_id }&amp;pageNo=${pagination.pageNo }${pagination.searchParameters}" 
														class="image-button button-edit"><spring:message code='modified'/></a>
													<a href="/data/delete-data.do?data_id=${dataInfo.data_id }" onclick="return deleteWarning();" 
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
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
	<%@ include file="/WEB-INF/views/data/project-dialog.jsp" %>
	<%@ include file="/WEB-INF/views/data/data-file-dialog.jsp" %>
	<%@ include file="/WEB-INF/views/data/data-control-attribute-dialog.jsp" %>
	<%@ include file="/WEB-INF/views/data/data-attribute-dialog.jsp" %>
	<%@ include file="/WEB-INF/views/data/data-attribute-file-dialog.jsp" %>
	<%@ include file="/WEB-INF/views/data/data-object-attribute-file-dialog.jsp" %>
	<%@ include file="/WEB-INF/views/data/project-data-attribute-file-dialog.jsp" %>
	<%@ include file="/WEB-INF/views/data/project-data-object-attribute-file-dialog.jsp" %>
	
<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript" src="/externlib/jquery/jquery.form.js"></script>	
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initJqueryCalendar();
		
		initSelect(	new Array("project_id", "status", "data_insert_type", "search_word", "search_option", "search_value", "order_word", "order_value", "list_counter"), 
					new Array("${dataInfo.project_id}", "${dataInfo.status}", "${dataInfo.data_insert_type}", "${dataInfo.search_word}", 
							"${dataInfo.search_option}", "${dataInfo.search_value}", "${dataInfo.order_word}", "${dataInfo.order_value}", "${pagination.pageRows }"));
		initCalendar(new Array("start_date", "end_date"), new Array("${dataInfo.start_date}", "${dataInfo.end_date}"));
		$( ".select" ).selectmenu();
	});
	
	// 전체 선택 
	$("#chk_all").click(function() {
		$(":checkbox[name=data_id]").prop("checked", this.checked);
	});
	
	// project 정보
    function detailProject(projectId) {
    	projectDialog.dialog( "open" );
    	
    	$.ajax({
    		url: "/data/ajax-project.do",
    		data: { projectId : projectId },
    		type: "GET",
    		dataType: "json",
    		success: function(msg){
    			if (msg.result == "success") {
    				$("#project_name_info").html(msg.project.project_name);
    				$("#project_key_info").html(msg.project.project_key);
    				$("#use_yn_info").html(msg.project.use_yn);
    				$("#description_info").html(msg.project.description);
				} else {
    				alert(JS_MESSAGE[msg.result]);
    			}
    		},
    		error:function(request,status,error){
    			alert(JS_MESSAGE["ajax.error.message"]);
    		}
    	});
	}
	
 	// 제어 속성
    function detailDataControlAttribute(dataId) {
    	dataControlAttributeDialog.dialog( "open" );
    	
    	$.ajax({
    		url: "/data/ajax-detail-data.do",
    		data: { data_id : dataId },
    		type: "GET",
    		dataType: "json",
    		success: function(msg){
    			if (msg.result == "success") {
    				$("#data_control_attribute").html(msg.dataInfo.attributes);
				} else {
    				alert(JS_MESSAGE[msg.result]);
    			}
    		},
    		error:function(request,status,error){
    			alert(JS_MESSAGE["ajax.error.message"]);
    		}
    	});
	}
	
	// Origin 속성
    function detailDataAttribute(dataId, dataName) {
    	dataAttributeDialog.dialog( "open" );
    	$("#data_name_for_origin").html(dataName);
    	
    	$.ajax({
    		url: "/data/ajax-detail-data-attribute.do",
    		data: { data_id : dataId },
    		type: "GET",
    		dataType: "json",
    		success: function(msg){
    			if (msg.result == "success") {
    				if(msg.dataInfoAttribute !== null) {
						$("#data_attribute_for_origin").html(msg.dataInfoAttribute.attributes);
    				}
				} else {
    				alert(JS_MESSAGE[msg.result]);
    			}
    		},
    		error:function(request,status,error){
    			alert(JS_MESSAGE["ajax.error.message"]);
    		}
    	});
	}
 	
    // origin 속성 수정
 	function uploadDataAttribute(dataId, dataName) {
 		uploadDataAttributeDialog.dialog( "open" );
 		$("#attribute_file_name").val("");
 		$("#dataAttributeUploadLog > tbody:last").html("");
		$("#attribute_file_data_id").val(dataId);
		$("#attributeDataName").html(dataName);
	}
	
    // origin 속성 파일 upload
	var dataAttributeFileUploadFlag = true;
	function dataAttributeFileUpload() {
		var fileName = $("#attribute_file_name").val();
		if(fileName === "") {
			alert(JS_MESSAGE["file.name.empty"]);
			$("#attribute_file_name").focus();
			return false;
		}
		if( fileName.lastIndexOf("json") <=0 && fileName.lastIndexOf("txt") <=0 ) {
			alert(JS_MESSAGE["file.ext.invalid"]);
			$("#file_name").focus();
			return false;
		}
		
		if(dataAttributeFileUploadFlag) {
			dataAttributeFileUploadFlag = false;
			var totalNumber = "<spring:message code='data.total.number'/>";
			var successParsing = "<spring:message code='data.success.parsing'/>";
			var failedParsing = "<spring:message code='data.fail.parsing'/>";
			var insertSuccessCount = "<spring:message code='data.insert.success.db'/>";
			var updateSuccessCount = "<spring:message code='data.update.success.db'/>";
			var failCount = "<spring:message code='data.insert.fail.db'/>";
			$("#dataAttributeInfo").ajaxSubmit({
				type: "POST",
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						if(msg.parse_error_count != 0 || msg.insert_error_count != 0) {
							$("#data_file_name").val("");
							alert(JS_MESSAGE["error.exist.in.processing"]);
						} else {
							alert(JS_MESSAGE["update"]);
						}
						var content = ""
							+ "<tr>"
							+ 	"<td colspan=\"2\" style=\"text-align: center;\">Result of parsing</td>"
							+ "</tr>"
							+ "<tr>"
							+ 	"<td> " + totalNumber + "</td>"
							+ 	"<td> " + msg.total_count + "</td>"
							+ "</tr>"
							+ "<tr>"
							+ 	"<td> " + successParsing + "</td>"
							+ 	"<td> " + msg.parse_success_count + "</td>"
							+ "</tr>"
							+ "<tr>"
							+ 	"<td> " + failedParsing + "</td>"
							+ 	"<td> " + msg.parse_error_count + "</td>"
							+ "</tr>"
							+ "<tr>"
							+ 	"<td> " + insertSuccessCount + "</td>"
							+ 	"<td> " + msg.insert_success_count + "</td>"
							+ "</tr>"
							/* + "<tr>"
							+ 	"<td> " + updateSuccessCount + "</td>"
							+ 	"<td> " + msg.update_success_count + "</td>"
							+ "</tr>" */
							+ "<tr>"
							+ 	"<td> " + failCount + "</td>"
							+ 	"<td> " + msg.insert_error_count + "</td>"
							+ "</tr>";
							$("#dataAttributeUploadLog > tbody:last").html("");
							$("#dataAttributeUploadLog > tbody:last").append(content);
					} else {
	    				alert(JS_MESSAGE[msg.result]);
	    			}
					dataAttributeFileUploadFlag = true;
				},
				error:function(request,status,error){
					alert(JS_MESSAGE["ajax.error.message"]);
					dataAttributeFileUploadFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// Data Object Attribute 파일 수정
	function uploadDataObjectAttribute(dataId, dataName) {
		uploadDataObjectAttributeDialog.dialog( "open" );
		$("#object_attribute_file_name").val("");
 		$("#dataObjectAttributeUploadLog > tbody:last").html("");
		$("#object_attribute_file_data_id").val(dataId);
		$("#objectAttributeDataName").html(dataName);
	}
	
	// Data Object 속성 파일 upload
	var dataObjectAttributeFileUploadFlag = true;
	function dataObjectAttributeFileUpload() {
		var fileName = $("#object_attribute_file_name").val();
		if(fileName === "") {
			alert(JS_MESSAGE["file.name.empty"]);
			$("#object_attribute_file_name").focus();
			return false;
		}
		
		if( fileName.lastIndexOf("json") <=0 && fileName.lastIndexOf("txt") <=0 ) {
			alert(JS_MESSAGE["file.ext.invalid"]);
			$("#file_name").focus();
			return false;
		}
		
		if(dataObjectAttributeFileUploadFlag) {
			dataObjectAttributeFileUploadFlag = false;
			var totalNumber = "<spring:message code='data.total.number'/>";
			var successParsing = "<spring:message code='data.success.parsing'/>";
			var failedParsing = "<spring:message code='data.fail.parsing'/>";
			var insertSuccessCount = "<spring:message code='data.insert.success.db'/>";
			var updateSuccessCount = "<spring:message code='data.update.success.db'/>";
			var failCount = "<spring:message code='data.insert.fail.db'/>";
			$("#dataObjectAttributeInfo").ajaxSubmit({
				type: "POST",
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						if(msg.parse_error_count != 0 || msg.insert_error_count != 0) {
							$("#data_file_name").val("");
							alert(JS_MESSAGE["error.exist.in.processing"]);
						} else {
							alert(JS_MESSAGE["update"]);
						}
						var content = ""
							+ "<tr>"
							+ 	"<td colspan=\"2\" style=\"text-align: center;\">Result of parsing</td>"
							+ "</tr>"
							+ "<tr>"
							+ 	"<td> " + totalNumber + "</td>"
							+ 	"<td> " + msg.total_count + "</td>"
							+ "</tr>"
							+ "<tr>"
							+ 	"<td> " + successParsing + "</td>"
							+ 	"<td> " + msg.parse_success_count + "</td>"
							+ "</tr>"
							+ "<tr>"
							+ 	"<td> " + failedParsing + "</td>"
							+ 	"<td> " + msg.parse_error_count + "</td>"
							+ "</tr>"
							+ "<tr>"
							+ 	"<td> " + insertSuccessCount + "</td>"
							+ 	"<td> " + msg.insert_success_count + "</td>"
							+ "</tr>"
							/* + "<tr>"
							+ 	"<td> " + updateSuccessCount + "</td>"
							+ 	"<td> " + msg.update_success_count + "</td>"
							+ "</tr>" */
							+ "<tr>"
							+ 	"<td> " + failCount + "</td>"
							+ 	"<td> " + msg.insert_error_count + "</td>"
							+ "</tr>";
							$("#dataObjectAttributeUploadLog > tbody:last").html("");
							$("#dataObjectAttributeUploadLog > tbody:last").append(content);
					} else {
	    				alert(JS_MESSAGE[msg.result]);
	    			}
					dataObjectAttributeFileUploadFlag = true;
				},
				error:function(request,status,error){
					alert(JS_MESSAGE["ajax.error.message"]);
					dataObjectAttributeFileUploadFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// Data 일괄 삭제
	var deleteDatasFlag = true;
	function deleteDatas() {
		if($("input:checkbox[name=data_id]:checked").length == 0) {
			alert(JS_MESSAGE["check.value.required"]);
			return false;
		} else {
			var checkedValue = "";
			$("input:checkbox[name=data_id]:checked").each(function(index){
				checkedValue += $(this).val() + ",";
			});
			$("#check_ids").val(checkedValue);
		}
		
		if(confirm(JS_MESSAGE["delete.confirm"])) {
			if(deleteDatasFlag) {
				deleteDatasFlag = false;
				var info = $("#listForm").serialize();
				$.ajax({
					url: "/data/ajax-delete-datas.do",
					type: "POST",
					data: info,
					cache: false,
					dataType: "json",
					success: function(msg){
						if(msg.result == "success") {
							alert(JS_MESSAGE["delete"]);	
							location.reload();
							$(":checkbox[name=data_id]").prop("checked", false);
						} else {
							alert(JS_MESSAGE[msg.result]);
						}
						deleteDatasFlag = true;
					},
					error:function(request,status,error){
				        alert(JS_MESSAGE["ajax.error.message"]);
				        deleteDatasFlag = true;
					}
				});
			} else {
				alert(JS_MESSAGE["button.dobule.click"]);
				return;
			}
		}
	}
	
	function searchCheck() {
		if($("#search_option").val() == "1") {
			if(confirm(JS_MESSAGE["search.option.warning"])) {
				// go
			} else {
				return false;
			}
		} 
		
		var start_date = $("#start_date").val();
		var end_date = $("#end_date").val();
		if(start_date != null && start_date != "" && end_date != null && end_date != "") {
			if(parseInt(start_date) > parseInt(end_date)) {
				alert(JS_MESSAGE["search.date.warning"]);
				$("#start_date").focus();
				return false;
			}
		}
		return true;
	}
	
	// Data 일괄 등록 Layer 생성
	function uploadDataFile() {
		uploadDataFileDialog.dialog( "open" );
		$("#data_file_name").val("");
 		$("#dataFileUploadLog > tbody:last").html("");
	}
	// Data 일괄 등록 Layer 닫기
	function popClose() {
		uploadDataFileDialog.dialog( "close" );
		location.reload();
	}
	
	// 일괄등록(파일)
	var dataFileUploadFlag = true;
	function dataFileUpload() {
		var fileName = $("#data_file_name").val();
		if(fileName === "") {
			alert(JS_MESSAGE["file.name.empty"]);
			$("#data_file_name").focus();
			return false;
		}
		
		if( fileName.lastIndexOf("xlsx") <=0 
				&& fileName.lastIndexOf("xls") <=0
				&& fileName.lastIndexOf("json") <=0 
				&& fileName.lastIndexOf("txt") <=0 ) {
			alert(JS_MESSAGE["file.ext.invalid"]);
			$("#data_file_name").focus();
			return false;
		}
		
		if(dataFileUploadFlag) {
			dataFileUploadFlag = false;
			var totalNumber = "<spring:message code='data.total.number'/>";
			var successParsing = "<spring:message code='data.success.parsing'/>";
			var failedParsing = "<spring:message code='data.fail.parsing'/>";
			var insertSuccessCount = "<spring:message code='data.insert.success.db'/>";
			var updateSuccessCount = "<spring:message code='data.update.success.db'/>";
			var failCount = "<spring:message code='data.insert.fail.db'/>";
			$("#dataFileInfo").ajaxSubmit({
				type: "POST",
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						if(msg.parse_error_count != 0 || msg.insert_error_count != 0) {
							$("#data_file_name").val("");
							alert(JS_MESSAGE["error.exist.in.processing"]);
						} else {
							alert(JS_MESSAGE["update"]);
						}
						var content = ""
						+ "<tr>"
						+ 	"<td colspan=\"2\" style=\"text-align: center;\">Result of parsing</td>"
						+ "</tr>"
						+ "<tr>"
						+ 	"<td> " + totalNumber + "</td>"
						+ 	"<td> " + msg.total_count + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ 	"<td> " + successParsing + "</td>"
						+ 	"<td> " + msg.parse_success_count + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ 	"<td> " + failedParsing + "</td>"
						+ 	"<td> " + msg.parse_error_count + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ 	"<td> " + insertSuccessCount + "</td>"
						+ 	"<td> " + msg.insert_success_count + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ 	"<td> " + updateSuccessCount + "</td>"
						+ 	"<td> " + msg.update_success_count + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ 	"<td> " + failCount + "</td>"
						+ 	"<td> " + msg.insert_error_count + "</td>"
						+ "</tr>";
						$("#dataFileUploadLog > tbody:last").html("");
						$("#dataFileUploadLog > tbody:last").append(content);
					} else {
	    				alert(JS_MESSAGE[msg.result]);
	    			}
					dataFileUploadFlag = true;
				},
				error:function(request,status,error){
					alert(JS_MESSAGE["ajax.error.message"]);
					dataFileUploadFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// Data Attribute 일괄 등록
	function uploadProjectDataAttribute() {
		uploadProjectDataAttributeDialog.dialog( "open" );
		$("#project_data_attribute_path").val("");
 		$("#projectDataAttributeUploadLog > tbody:last").html("");
	}
	
	// data attribute 일괄 등록
	var projectDataAttributeFileUploadFlag = true;
	function projectDataAttributeFileUpload() {
		if(projectDataAttributeFileUploadFlag) {
			projectDataAttributeFileUploadFlag = false;
			var totalNumber = "<spring:message code='data.total.number'/>";
			var successParsing = "<spring:message code='data.success.parsing'/>";
			var failedParsing = "<spring:message code='data.fail.parsing'/>";
			var insertSuccessCount = "<spring:message code='data.insert.success.db'/>";
			var updateSuccessCount = "<spring:message code='data.update.success.db'/>";
			var failCount = "<spring:message code='data.insert.fail.db'/>";
			var info = $("#projectDataAttributeInfo").serialize();
			$.ajax({
				url: "/data/ajax-insert-project-data-attribute.do",
				type: "POST",
				data: info,
				dataType: "json",
				success: function(msg){
					if(msg.insert_error_count != 0) {
						$("#project_data_attribute_path").val("");
						alert(JS_MESSAGE["error.exist.in.processing"]);
					} else {
						alert(JS_MESSAGE["update"]);
					}
					var content = ""
					+ "<tr>"
					+ 	"<td colspan=\"2\" style=\"text-align: center;\">Result of parsing</td>"
					+ "</tr>"
					+ "<tr>"
					+ 	"<td> " + totalNumber + "</td>"
					+ 	"<td> " + msg.total_count + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ 	"<td> " + insertSuccessCount + "</td>"
					+ 	"<td> " + msg.insert_success_count + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ 	"<td> " + updateSuccessCount + "</td>"
					+ 	"<td> " + msg.update_success_count + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ 	"<td> " + failCount + "</td>"
					+ 	"<td> " + msg.insert_error_count + "</td>"
					+ "</tr>";
					$("#projectDataAttributeUploadLog > tbody:last").html("");
					$("#projectDataAttributeUploadLog > tbody:last").append(content);
					projectDataAttributeFileUploadFlag = true;
				},
				error:function(request,status,error){
					alert(JS_MESSAGE["ajax.error.message"]);
					projectDataAttributeFileUploadFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// Data Object Attribute 일괄 등록
	function uploadProjectDataObjectAttribute() {
		uploadProjectDataObjectAttributeDialog.dialog( "open" );
		$("#project_data_object_attribute_path").val("");
 		$("#projectDataObjectAttributeUploadLog > tbody:last").html("");
	}
	
	// data object attribute 일괄 등록
	var projectDataObjectAttributeFileUploadFlag = true;
	function projectDataObjectAttributeFileUpload() {
		if(projectDataObjectAttributeFileUploadFlag) {
			projectDataObjectAttributeFileUploadFlag = false;
			var totalNumber = "<spring:message code='data.total.number'/>";
			var successParsing = "<spring:message code='data.success.parsing'/>";
			var failedParsing = "<spring:message code='data.fail.parsing'/>";
			var insertSuccessCount = "<spring:message code='data.insert.success.db'/>";
			var updateSuccessCount = "<spring:message code='data.update.success.db'/>";
			var failCount = "<spring:message code='data.insert.fail.db'/>";
			var info = $("#projectDataObjectAttributeInfo").serialize();
			$.ajax({
				url: "/data/ajax-insert-project-data-object-attribute.do",
				type: "POST",
				data: info,
				dataType: "json",
				success: function(msg){
					if(msg.insert_error_count != 0) {
						$("#project_data_object_attribute_path").val("");
						alert(JS_MESSAGE["error.exist.in.processing"]);
					} else {
						alert(JS_MESSAGE["update"]);
					}
					var content = ""
					+ "<tr>"
					+ 	"<td colspan=\"2\" style=\"text-align: center;\">Result of parsing</td>"
					+ "</tr>"
					+ "<tr>"
					+ 	"<td> " + totalNumber + "</td>"
					+ 	"<td> " + msg.total_count + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ 	"<td> " + insertSuccessCount + "</td>"
					+ 	"<td> " + msg.insert_success_count + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ 	"<td> " + updateSuccessCount + "</td>"
					+ 	"<td> " + msg.update_success_count + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ 	"<td> " + failCount + "</td>"
					+ 	"<td> " + msg.insert_error_count + "</td>"
					+ "</tr>";
					$("#projectDataObjectAttributeUploadLog > tbody:last").html("");
					$("#projectDataObjectAttributeUploadLog > tbody:last").append(content);
					projectDataObjectAttributeFileUploadFlag = true;
				},
				error:function(request,status,error){
					alert(JS_MESSAGE["ajax.error.message"]);
					projectDataObjectAttributeFileUploadFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 프로젝트 다이얼 로그
	var projectDialog = $( ".projectDialog" ).dialog({
		autoOpen: false,
		width: 400,
		height: 300,
		modal: true,
		resizable: false
	});
	// 데이터 일괄 등록 다이얼 로그
	var uploadDataFileDialog = $( ".uploadDataFileDialog" ).dialog({
		autoOpen: false,
		width: 600,
		height: 445,
		modal: true,
		resizable: false,
		close: function() { location.reload(); }
	});
	// 데이터 제어 속성 다이얼 로그
	var dataControlAttributeDialog = $( ".dataControlAttributeDialog" ).dialog({
		autoOpen: false,
		width: 500,
		height: 255,
		modal: true,
		resizable: false
	});
	// 데이터 속성 다이얼 로그
	var dataAttributeDialog = $( ".dataAttributeDialog" ).dialog({
		autoOpen: false,
		width: 600,
		height: 350,
		modal: true,
		resizable: false
	});
	// 데이터 속성 하나 등록 다이얼 로그
	var uploadDataAttributeDialog = $( ".uploadDataAttributeDialog" ).dialog({
		autoOpen: false,
		width: 600,
		height: 445,
		modal: true,
		resizable: false
	});
	// 데이터 Object 속성 하나 등록
	var uploadDataObjectAttributeDialog = $( ".uploadDataObjectAttributeDialog" ).dialog({
		autoOpen: false,
		width: 600,
		height: 445,
		modal: true,
		resizable: false
	});
	// 데이터 속성 프로젝트 전체 등록 다이얼 로그
	var uploadProjectDataAttributeDialog = $( ".uploadProjectDataAttributeDialog" ).dialog({
		autoOpen: false,
		width: 600,
		height: 445,
		modal: true,
		resizable: false
	});
	// 프로젝트 데이터 Object 속성 하나 등록
	var uploadProjectDataObjectAttributeDialog = $( ".uploadProjectDataObjectAttributeDialog" ).dialog({
		autoOpen: false,
		width: 600,
		height: 445,
		modal: true,
		resizable: false
	});
</script>
</body>
</html>