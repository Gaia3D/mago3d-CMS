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
		    				<form:form id="searchForm" modelAttribute="dataInfoLog" method="post" action="/data/list-data-log.do" onsubmit="return searchCheck();">
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
					                	<option value="user_id"><spring:message code='user.id'/></option>
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
										<option value="0"> <spring:message code='request'/>  </option>
										<option value="1"> <spring:message code='complete'/> </option>
										<option value="2"> <spring:message code='reject'/> </option>
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
							<form:form id="listForm" modelAttribute="dataInfoLog" method="post">
								<input type="hidden" id="check_ids" name="check_ids" value="" />
							<div class="list-header row">
								<div class="list-desc u-pull-left">
									<spring:message code='all.d'/> <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em><spring:message code='search.what.count'/> 
									<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
								</div>
								<%-- <div class="list-functions u-pull-right">
									<div class="button-group">
										<a href="#" onclick="updateDataStatus('DATA', 'LOCK'); return false;" class="button"><spring:message code='data.lock'/></a>
									</div>
								</div> --%>
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
									<col class="col-date" />
									<col class="col-functions" />
									<thead>
										<tr>
											<th scope="col" class="col-checkbox"><input type="checkbox" id="chk_all" name="chk_all" /></th>
											<th scope="col" class="col-number"><spring:message code='number'/></th>
											<th scope="col" class="col-name"><spring:message code='data.project.name'/></th>
											<th scope="col" class="col-id"><spring:message code='data.name'/></th>
											<th scope="col" class="col-name"><spring:message code='user.id'/></th>
											<th scope="col" class="col-toggle"><spring:message code='latitude'/></th>
											<th scope="col" class="col-toggle"><spring:message code='longitude'/></th>
											<th scope="col" class="col-toggle"><spring:message code='height'/></th>
											<th scope="col" class="col-toggle"><spring:message code='status'/></th>
											<th scope="col" class="col-date"><spring:message code='data.insert.date'/></th>
											<th scope="col" class="col-functions"><spring:message code='approval'/></th>
										</tr>
									</thead>
									<tbody>
<c:if test="${empty dataInfoLogList }">
										<tr>
											<td colspan="11" class="col-none"><spring:message code='data.log.does.not.exist'/></td>
										</tr>
</c:if>
<c:if test="${!empty dataInfoLogList }">
	<c:forEach var="dataInfoLog" items="${dataInfoLogList}" varStatus="status">
										<tr>
											<td class="col-checkbox">
												<input type="checkbox" id="data_info_log_id_${dataInfoLog.data_info_log_id}" name="data_info_log_id" value="${dataInfoLog.data_info_log_id}" />
											</td>
											<td class="col-number">${pagination.rowNumber - status.index }</td>
											<td class="col-name">
												<a href="#" class="view-group-detail" onclick="detailProject('${dataInfoLog.project_id }'); return false;">${dataInfoLog.project_name }</a></td>
											<td class="col-id">
												<a href="#" class="view-group-detail" onclick="detailDataInfoLog('${dataInfoLog.data_name}'
													, '${dataInfoLog.before_latitude}', '${dataInfoLog.latitude}', '${dataInfoLog.before_longitude}', '${dataInfoLog.longitude}'
													, '${dataInfoLog.before_height}', '${dataInfoLog.height}', '${dataInfoLog.before_heading}', '${dataInfoLog.heading}'
													, '${dataInfoLog.before_pitch}', '${dataInfoLog.pitch}', '${dataInfoLog.before_roll}', '${dataInfoLog.roll}'
													); return false;">${dataInfoLog.data_name }</a></td>
											<td class="col-name">${dataInfoLog.user_id }</td>
											<td class="col-toggle">${dataInfoLog.latitude}</td>
											<td class="col-toggle">${dataInfoLog.longitude}</td>
											<td class="col-toggle">${dataInfoLog.height}</td>
											<td class="col-toggle">
												<span class="icon-glyph glyph-on on"></span>
		<c:if test="${dataInfoLog.status eq '0'}">
												<span class="icon-text"><spring:message code='request'/></span>
		</c:if>
		<c:if test="${dataInfoLog.status eq '1'}">
												<span class="icon-text"><spring:message code='complete'/></span>
		</c:if>
		<c:if test="${dataInfoLog.status eq '2'}">
												<span class="icon-text"><spring:message code='reject'/></span>
		</c:if>
		<c:if test="${dataInfoLog.status eq '3'}">
												<span class="icon-text"><spring:message code='reset'/></span>
		</c:if>
												
											</td>
											<td class="col-date">${dataInfoLog.view_insert_date }</td>
											<td class="col-functions">
												<span class="button-group">
		<c:if test="${dataInfoLog.status eq '0'}">
													<a href="#" onclick="return warning('CONFIRM', '${dataInfoLog.project_id}', '${dataInfoLog.data_info_log_id}');" class="button" >
														<spring:message code='confirm'/>
													</a>
													<a href="#" onclick="return warning('REJECT', '${dataInfoLog.project_id}', '${dataInfoLog.data_info_log_id}');" class="button" >
														<spring:message code='reject'/>
													</a>
		</c:if>
		<c:if test="${dataInfoLog.status eq '1'}">
													<a href="#" onclick="return warning('RESET', '${dataInfoLog.project_id}', '${dataInfoLog.data_info_log_id}');" class="button" >
														<spring:message code='reset'/>
													</a>
		</c:if>
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
	<%@ include file="/WEB-INF/views/data/data-info-log-dialog.jsp" %>
	
<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/${lang}/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.form.js"></script>	
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/${lang}/navigation.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initJqueryCalendar();
		
		initSelect(	new Array("project_id", "status", "search_word", "search_option", "search_value", "order_word", "order_value", "list_counter"), 
					new Array("${dataInfoLog.project_id}", "${dataInfoLog.status}", "${dataInfoLog.search_word}", 
							"${dataInfoLog.search_option}", "${dataInfoLog.search_value}", "${dataInfoLog.order_word}", "${dataInfoLog.order_value}", "${pagination.pageRows }"));
		initCalendar(new Array("start_date", "end_date"), new Array("${dataInfoLog.start_date}", "${dataInfoLog.end_date}"));
		$( ".select" ).selectmenu();
	});
	
	// 전체 선택 
	$("#chk_all").click(function() {
		$(":checkbox[name=data_info_log_id]").prop("checked", this.checked);
	});
	
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
	
	var projectDialog = $( ".projectDialog" ).dialog({
		autoOpen: false,
		height: 300,
		width: 400,
		modal: true,
		resizable: false
	});
	
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
	
	// data info change request log
    var dataInfoLogDialog = $( ".dataInfoLogDialog" ).dialog({
        autoOpen: false,
        width: 400,
        height: 380,
        modal: true,
        resizable: false
    });
	function detailDataInfoLog(data_name, before_latitude, latitude, before_longitude, longitude, before_height, height, before_heading, heading, before_pitch, pitch, before_roll, roll) {
		$("#beforeLatitude").html(before_latitude);
		$("#afterLatitude").html(latitude);
		$("#beforeLongitude").html(before_longitude);
		$("#afterLongitude").html(longitude);
		$("#beforeHeight").html(before_height);
		$("#afterHeight").html(height);
		$("#beforeHeading").html(before_heading);
		$("#afterHeading").html(heading);
		$("#beforePitch").html(before_pitch);
		$("#afterPitch").html(pitch);
		$("#beforeRoll").html(before_roll);
		$("#afterRoll").html(roll);
		
		dataInfoLogDialog.dialog({title: data_name + " Change Request Log"}).dialog( "open" );
	}
	
	var warningFlag = true;
	function warning(statusLevel, projectId, dataInfoLogId) {
		if(confirm(JS_MESSAGE["proceed.confirm"])) {
			if(warningFlag) {
				warningFlag = false;
				$.ajax({
					url: "/data/ajax-update-data-log-status.do",
					type: "POST",
					data: { status_level : statusLevel, project_id : projectId, data_info_log_id : dataInfoLogId },
					dataType: "json",
					success: function(msg){
						if(msg.result == "success") {
							alert(JS_MESSAGE["update"]);	
							location.reload();
						} else {
							alert(JS_MESSAGE[msg.result]);
						}
						warningFlag = true;
					},
					error:function(request,status,error){
				        alert(JS_MESSAGE["ajax.error.message"]);
				        console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
				        warningFlag = true;
					}
				});
			} else {
				alert(JS_MESSAGE["button.dobule.click"]);
				return;
			} 
		}
	}
</script>
</body>
</html>