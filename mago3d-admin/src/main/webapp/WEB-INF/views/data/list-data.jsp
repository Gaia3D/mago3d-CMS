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
	<link rel="stylesheet" href="/externlib/${lang}/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/${lang}/jquery-ui/jquery-ui.css" />
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
									<label for="project_id">프로젝트명</label>
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
										<option value=""><spring:message code='search.word'/></option>
					                	<option value="data_id"><spring:message code='select'/></option>
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
					                	<option value="data_id"> <spring:message code='id'/> </option>
										<option value="data_name"> <spring:message code='name'/> </option>
										<option value="register_date"> <spring:message code='search.insert.date'/> </option>
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
										<a href="#" onclick="insertDataFile(); return false;" class="button"><spring:message code='data.all.insert'/></a>
<c:if test="${txtDownloadFlag ne 'true' }">
										<a href="/data/download-excel-data.do" class="button"><spring:message code='data.download'/></a>
</c:if>
<c:if test="${txtDownloadFlag eq 'true' }">
										<a href="/data/download-txt-data.do" class="button"><spring:message code='data.download.txt'/></a>
</c:if>
										<a href="/data/download-excel-data-sample.do" class="image-button button-area button-batch-download" title="<spring:message code='data.all.example.file'/>"><span><spring:message code='data.all.example.file'/></span></a>
									</div>
								</div>
							</div>
							<table class="list-table scope-col">
									<col class="col-checkbox" />
									<col class="col-number" />
									<col class="col-name" />
									<col class="col-name" />
									<col class="col-number" />
									<col class="col-id" />
									<col class="col-name" />
									<col class="col-toggle" />
									<col class="col-toggle" />
									<col class="col-toggle" />
									<col class="col-toggle" />
									<col class="col-toggle" />
									<col class="col-name" />
									<col class="col-date" />
									<col class="col-functions" />
									<thead>
										<tr>
											<th scope="col" class="col-checkbox"><input type="checkbox" id="chk_all" name="chk_all" /></th>
											<th scope="col" class="col-number"><spring:message code='number'/></th>
											<th scope="col" class="col-name">프로젝트명</th>
											<th scope="col" class="col-name">상위 Node</th>
											<th scope="col" class="col-number">Depth</th>
											<th scope="col" class="col-id"><spring:message code='key'/></th>
											<th scope="col" class="col-name"><spring:message code='name'/></th>
											<th scope="col" class="col-toggle"><spring:message code='lat'/></th>
											<th scope="col" class="col-toggle"><spring:message code='lon'/></th>
											<th scope="col" class="col-toggle"><spring:message code='height'/></th>
											<th scope="col" class="col-toggle"><spring:message code='status'/></th>
											<th scope="col" class="col-toggle"><spring:message code='use.not'/></th>
											<th scope="col" class="col-name">속성</th>
											<th scope="col" class="col-date">등록일</th>
											<th scope="col" class="col-functions"><spring:message code='modified.and.inser'/></th>
										</tr>
									</thead>
									<tbody>
<c:if test="${empty dataList }">
										<tr>
											<td colspan="15" class="col-none"><spring:message code='data.no.data'/></td>
										</tr>
</c:if>
<c:if test="${!empty dataList }">
	<c:forEach var="dataInfo" items="${dataList}" varStatus="status">
										<tr>
											<td class="col-checkbox">
												<input type="checkbox" id="data_id_${dataInfo.data_id}" name="data_id" value="${dataInfo.data_id}" />
											</td>
											<td class="col-number">${pagination.rowNumber - status.index }</td>
											<td class="col-name"><a href="#" class="view-group-detail" onclick="detailProject('${dataInfo.project_id }'); return false;">${dataInfo.project_name }</a></td>
											<td class="col-id">${dataInfo.parent }</td>
											<td class="col-id">${dataInfo.depth }</td>
											<td class="col-id">${dataInfo.data_key }</td>
											<td class="col-name"><a href="/data/detail-data.do?data_id=${dataInfo.data_id }&amp;pageNo=${pagination.pageNo }${pagination.searchParameters}">${dataInfo.data_name }</a></td>
											<td class="col-toggle">${dataInfo.latitude}</td>
											<td class="col-toggle">${dataInfo.longitude}</td>
											<td class="col-toggle">${dataInfo.height}</td>
											<td class="col-toggle">
		<c:if test="${dataInfo.status eq '0'}">
												<span class="icon-glyph glyph-on on"></span>
		</c:if>
		<c:if test="${dataInfo.status ne '0'}">
												<span class="icon-glyph glyph-off off"></span>
		</c:if>
												<span class="icon-text">${dataInfo.viewStatus }</span>
											</td>
											<td class="col-toggle">${dataInfo.public_yn }</td>
											<td class="col-name"><a href="#" onclick="viewAttributes('${dataInfo.data_id }'); return false;">속성</a></td>
											<td class="col-date">${dataInfo.viewInsertDate }</td>
											<td class="col-functions">
												<span class="button-group">
													<a href="/data/modify-data.do?data_id=${dataInfo.data_id }&amp;pageNo=${pagination.pageNo }${pagination.searchParameters}" class="image-button button-edit"><spring:message code='modified'/></a>
													<a href="/data/delete-data.do?data_id=${dataInfo.data_id }" onclick="return deleteWarning();" class="image-button button-delete"><spring:message code='delete'/></a>
												</span>
											</td>
										</tr>
	</c:forEach>
</c:if>
									</tbody>
							</table>
							</form:form>
							
							<%-- 엑셀 다운로드 --%>
							<form:form id="excelDataInfo" modelAttribute="excelDataInfo" method="post" action="/data/download-excel-data.do">
								<form:hidden path="project_id" />
								<form:hidden path="search_word" />
								<form:hidden path="search_option" />
								<form:hidden path="search_value" />
								<form:hidden path="status" />
								<form:hidden path="data_insert_type" />
								<form:hidden path="start_date" />
								<form:hidden path="end_date" />
								<form:hidden path="order_word" />
								<form:hidden path="order_value" />
							</form:form>
							<%-- 엑셀 다운로드 --%>
						</div>
						<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
	<div class="projectDialog" title="프로젝트 정보">
		<table class="inner-table scope-row">
			<col class="col-label" />
			<col class="col-data" />
			<tr>
				<th class="col-label" scope="row">프로젝트명</th>
				<td id="project_name_info" class="col-data"></td>
			</tr>
			<tr>
				<th class="col-label" scope="row">프로젝트 Key</th>
				<td id="project_key_info" class="col-data"></td>
			</tr>
			<tr>
				<th class="col-label" scope="row"><spring:message code='data.use.not'/></th>
				<td id="use_yn_info" class="col-data"></td>
			</tr>
			<tr>
				<th class="col-label" scope="row"><spring:message code='description'/></th>
				<td id="description_info" class="col-data"></td>
			</tr>
		</table>
	</div>
	<%-- 일괄등록(File) --%>
	<div class="dataFileDialog" title="<spring:message code='data.all.insert.data'/>">
		<form id="fileInfo" name="fileInfo" action="/data/ajax-insert-data-file.do" method="post" enctype="multipart/form-data">
			<table id="dataFileUpload" class="inner-table scope-row">
				<col class="col-sub-label xl" />
				<col class="col-data" />
				<tbody>
					<tr>
						<th class="col-sub-label">
							<label for="project_id">프로젝트명</label>
						</th>
						<td>
							<select id="project_id" name="project_id" class="select">
								<option value="0"><spring:message code='all'/></option>
<c:forEach var="project" items="${projectList}">
								<option value="${project.project_id}">${project.project_name}</option>
</c:forEach>
							</select>
						</td>
					</tr>
					
					<tr>
						<th class="col-sub-label"><spring:message code='data.upload.file'/></th>
						<td>
							<div class="inner-data">
								<input type="file" id="file_name" name="file_name" class="col-data" />
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="button-group">
				<input type="button" onclick="fileUpload();" class="button" value="<spring:message code='data.file.save'/>"/>
			</div>
		</form>
	</div>
	<%-- 일괄등록(Excel) --%>
	
<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/${lang}/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.form.js"></script>	
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/${lang}/navigation.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initJqueryCalendar();
		
		initSelect(	new Array("project_id", "status", "data_insert_type", "search_word", "search_option", "search_value", "order_word", "order_value", "list_counter"), 
					new Array("${dataInfo.project_id}", "${dataInfo.status}", "${dataInfo.data_insert_type}", "${dataInfo.search_word}", 
							"${dataInfo.search_option}", "${dataInfo.search_value}", "${dataInfo.order_word}", "${dataInfo.order_value}", "${pagination.pageRows }"));
		initCalendar(new Array("start_date", "end_date"), new Array("${dataInfo.start_date}", "${dataInfo.end_date}"));
		$( ".select" ).selectmenu();
	});
	
	var projectDialog = $( ".projectDialog" ).dialog({
		autoOpen: false,
		height: 300,
		width: 400,
		modal: true,
		resizable: false
	});
	
	var dataFileDialog = $( ".dataFileDialog" ).dialog({
		autoOpen: false,
		height: 445,
		width: 600,
		modal: true,
		resizable: false,
		close: function() { location.reload(); }
	});
	
	// 전체 선택 
	$("#chk_all").click(function() {
		$(":checkbox[name=data_id]").prop("checked", this.checked);
	});
	
	// Data 일괄 등록 Layer 생성
	function insertDataFile() {
		dataFileDialog.dialog( "open" );
	}
	// Data 등록 Layer 닫기
	function popClose() {
		dataFileDialog.dialog( "close" );
		location.reload();
	}
	
	var updateDataStatusFlag = true;
	function updateDataStatus(business_type, status_value) {
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
		var info = $("#listForm").serialize() + "&business_type=" + business_type + "&status_value=" + status_value;		
		if(updateDataStatusFlag) {
			updateDataStatusFlag = false;
			$.ajax({
				url: "/data/ajax-update-data-status.do",
				type: "POST",
				data: info,
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						if(msg.result_message != null && msg.result_message != "" && business_type == "OTP") {
							var updateMessage = JS_MESSAGE["data.data_otp.update.warning"];
							var patternCount = /{update_count}/ig; // notice "g" here now!
							var pattern = /{data_ids}/ig; // notice "g" here now!
							updateMessage = updateMessage.replace( patternCount, msg.update_count );
							updateMessage = updateMessage.replace( pattern, msg.result_message );
							alert(updateMessage);
						} else {
							alert(JS_MESSAGE["update"]);	
						}
						location.reload();
						$(":checkbox[name=data_id]").prop("checked", false);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateDataStatusFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateDataStatusFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		} 
	}

	var fileUploadFlag = true;
	function fileUpload() {
		var fileName = $("#file_name").val();
		if(fileName === "") {
			alert(JS_MESSAGE["data.file.name"]);
			$("#file_name").focus();
			return false;
		}
		
		if( fileName.lastIndexOf("xlsx") <=0 
				&& fileName.lastIndexOf("xls") <=0
				&& fileName.lastIndexOf("json") <=0 
				&& fileName.lastIndexOf("txt") <=0 ) {
			alert(JS_MESSAGE["data.file.invalid"]);
			$("#file_name").focus();
			return false;
		}
		
		if(fileUploadFlag) {
			fileUploadFlag = false;
			$("#fileInfo").ajaxSubmit({
				type: "POST",
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						if(msg.parse_error_count != 0 || msg.insert_error_count != 0) {
							$("#file_name").val("");
							alert(JS_MESSAGE["fail.count.retry.select"]);
						} else {
							alert(JS_MESSAGE["update"]);
						}
						var content = ""
						+ "<tr>"
						+ 	"<td colspan=\"2\">&nbsp;</td>"
						+ "</tr>"
						+ "<tr>"
						+ 	"<td> 총건수</td>"
						+ 	"<td> " + msg.total_count + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ 	"<td> 파싱 성공 건수</td>"
						+ 	"<td> " + msg.parse_success_count + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ 	"<td> 파싱 실패 건수</td>"
						+ 	"<td> " + msg.parse_error_count + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ 	"<td> DB 등록 성공 건수</td>"
						+ 	"<td> " + msg.insert_success_count + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ 	"<td> DB 등록 실패 건수</td>"
						+ 	"<td> " + msg.insert_error_count + "</td>"
						+ "</tr>";
						$("#dataFileUpload > tbody:last").append(content);
					}
					fileUploadFlag = true;
				},
				error:function(request,status,error){
					alert(JS_MESSAGE["ajax.error.message"]);
			        fileUploadFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// project 정보
    function detailProject(projectId) {
    	projectDialog.dialog( "open" );
    	ajaxProject(projectId);
	}
	
	// project 정보
    function ajaxProject(projectId) {
    	$.ajax({
    		url: "/data/ajax-project.do",
    		data: { projectId : projectId },
    		type: "GET",
    		dataType: "json",
    		success: function(msg){
    			if (msg.result == "success") {
    				drawProject(msg.project);
				} else {
    				alert(JS_MESSAGE[msg.result]);
    			}
    		},
    		error:function(request,status,error){
    			alert(JS_MESSAGE["ajax.error.message"]);
    		}
    	});
    }
	
	// 프로젝트 정보
	function drawProject(project) {
		$("#project_name_info").html(project.project_name);
		$("#project_key_info").html(project.project_key);
		$("#use_yn_info").html(project.use_yn);
		$("#description_info").html(project.description);
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
					async:false,
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
</script>
</body>
</html>