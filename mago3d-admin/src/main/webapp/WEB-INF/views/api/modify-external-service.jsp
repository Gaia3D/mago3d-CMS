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
						<div class="input-header row">
							<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span>체크표시는 필수입력 항목입니다.</div>
						</div>
						<form:form id="externalService" modelAttribute="externalService" method="post" onsubmit="return false;">			
							<form:hidden path="external_service_id"/>
							<table class="input-table scope-row">
								<col class="col-label m" />
								<col class="col-input" />
								<tr>
									<th class="col-label m" scope="row">
										<form:label path="service_code">서비스 코드</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">${externalService.service_code}</td>
								</tr>
								<tr>
									<th class="col-label m" scope="row">
										<form:label path="service_name">서비스명</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input"><form:input path="service_name" cssClass="m" /></td>
								</tr>
								<tr>
									<th class="col-label m" scope="row">
										<form:label path="service_type">서비스 유형</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<select id="service_type" name="service_type" class="select">
											<option value="0"> Cache(캐시 Reload) </option>
											<option value="1"> 고가용성(HA) </option>
											<option value="2"> 접속자 목록 </option>
										</select>
									</td>
								</tr>
								<tr>
									<th class="col-label m" scope="row">
										<form:label path="server_ip">서버 IP</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
				 						<form:hidden path="server_ip" />
										<form:input path="view_server_ip" cssClass="m" readonly="true" />
						 				<a href="#" onclick="displayListServer();" class="button">서버 선택</a>
									</td>
								</tr>
								<tr>
									<th class="col-label m" scope="row">
										<form:label path="url_scheme">Scheme (프로토콜)</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input"><form:input path="url_scheme" cssClass="m" /></td>
								</tr>
								<tr>
									<th class="col-label m" scope="row">
										<form:label path="url_host">호스트</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input"><form:input path="url_host" cssClass="m" /></td>
								</tr>
								<tr>
									<th class="col-label m" scope="row">
										<form:label path="url_port">포트</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input"><form:input path="url_port" cssClass="m" /></td>
								</tr>
								<tr>
									<th class="col-label m" scope="row">
										<form:label path="api_key">API KEY</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:input path="api_key" cssClass="l" readonly="true" />
									</td>
								</tr>
								<tr>
									<th class="col-label m" scope="row"><form:label path="url_path">경로</form:label></th>
									<td class="col-input"><form:input path="url_path" cssClass="l" /></td>
								</tr>
								<tr>
									<th class="col-label m" scope="row"><span>상태</span></th>
									<td class="col-input radio-set">
										<form:radiobutton path="status" value="0" />
										<label for="service-status-use">사용</label>
										<form:radiobutton path="status" value="1" />
										<label for="service-status-none">미사용</label>
									</td>
								</tr>
								<tr>
									<th class="col-label m" scope="row"><form:label path="description">설명</form:label></th>
									<td class="col-input"><form:input path="description" cssClass="l" /></td>
								</tr>
								<tr>
									<th class="col-label m" scope="row"><form:label path="extra_key1">여분 필드 1</form:label></th>
									<td class="col-input">
										<span class="table-desc">KEY&nbsp;:&nbsp;</span>
										<form:input path="extra_key1" type="text" class="m" />
										<span class="delimeter">&nbsp;</span>
										<span class="table-desc">VALUE&nbsp;:&nbsp;</span>
										<form:input path="extra_value1" type="text" class="m" />
									</td>
								</tr>
								<tr>
									<th class="col-label m" scope="row"><form:label path="extra_key2">여분 필드 2</form:label></th>
									<td class="col-input">
										<span class="table-desc">KEY&nbsp;:&nbsp;</span>
										<form:input path="extra_key2" type="text" class="m" />
										<span class="delimeter">&nbsp;</span>
										<span class="table-desc">VALUE&nbsp;:&nbsp;</span>
										<form:input path="extra_value2" type="text" class="m" />
									</td>
								</tr>
								<tr>
									<th class="col-label m" scope="row"><form:label path="extra_key3">여분 필드 3</form:label></th>
									<td class="col-input">
										<span class="table-desc">KEY&nbsp;:&nbsp;</span>
										<form:input path="extra_key3" type="text" class="m" />
										<span class="delimeter">&nbsp;</span>
										<span class="table-desc">VALUE&nbsp;:&nbsp;</span>
										<form:input path="extra_value3" type="text" class="m" />
									</td>
								</tr>																				
							</table>
							<div class="button-group">
								<div class="center-buttons">
									<input type="submit" value="저장" onclick="updateExternalService();" />
									<a href="/api/list-external-service.do" class="button">목록</a>
								</div>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
	<%-- <div class="dialog" title="서버 목록(검색 기능 추가)">
		<div class="dialog-user-group">
			<ul>
<c:if test="${!empty serverList }">
	<c:forEach var="server" items="${serverList}" varStatus="status">
				<li>
					<input type="radio" id="radio_group_${server.server_id}" name="radio_group" value="${server.server_id}_${server.server_ip}_${server.viewApiKey}" />	
					<label for="radio_group_${server.server_id}">${server.server_name} (IP : ${server.server_ip})</label>
				</li>
	</c:forEach>
</c:if>		
			</ul>
		</div>
		<div class="button-group">
			<input type="submit" id="button_groupSelect" name="button_groupSelect" value="선택" />
		</div>
	</div>	 --%>
	
<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/${lang}/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/${lang}/navigation.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("[name=status]").filter("[value='${externalService.status}']").prop("checked",true);
		
		var service_type = "${externalService.service_type}";
		if(service_type != null && service_type != "") {
			$("#service_type").val(service_type);
		}
		
		$("#view_server_ip").val("${externalService.server_ip}");
		
		$( ".select" ).selectmenu();
	});

	var dialog = $( ".dialog" ).dialog({
		autoOpen: false,
		height: 600,
		width: 600,
		modal: true,
		resizable: false
	});
	
	function displayListServer() {
		dialog.dialog( "open" );
	}
		
/* 	// 서버 선택
	$( "#button_groupSelect" ).on( "click", function() {
		var radioObj = $(":radio[name=radio_group]:checked").val();
		if (!radioObj) {
			alert('그룹이 선택되지 않았습니다.');
	        return false;
	    } else {
	    	var splitValues = radioObj.split("_");
			$("#server_ip").val(splitValues[1]);
			$("#view_server_ip").val(splitValues[1]);
			$("#api_key").val(splitValues[2]);
			dialog.dialog( "close" );
	    }
	}); */
	
	// Private API 수정
	var updateExternalServiceFlag = true;
	function updateExternalService() {
		if(updateExternalServiceFlag) {
			if (check() == false) {
				return false;
			}
			
			updateExternalServiceFlag = false;
			var info = $("#externalService").serialize();
			$.ajax({
				url: "/api/ajax-update-external-service.do",
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
					updateExternalServiceFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateExternalServiceFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	function check() {
		/* if ($("#service_code").val() == "") {
			alert("서비스 코드를 입력하여 주십시오.");
			$("#service_code").focus();
			return false;
		} */
		if ($("#service_name").val() == "") {
			alert("서비스명을 입력하여 주십시오.");
			$("#service_name").focus();
			return false;
		}
		if ($("#server_ip").val() == "") {
			alert("서버 IP를 입력하여 주십시오.");
			$("#server_ip").focus();
			return false;
		}
		if ($("#api_key").val() == "") {
			alert("API KEY를 입력하여 주십시오.");
			$("#api_key").focus();
			return false;
		}
	}
	
	/* // API KEY 생성
	var createApiKeyFlag = true;
	function createApiKey() {
		if(createApiKeyFlag) {
			createApiKeyFlag = false;
			$.ajax({
				url: "/server/ajax-create-api-key.do",
				type: "POST",
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						$("#api_key").val(msg.api_key);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					createApiKeyFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        createApiKeyFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}	
	} */
</script>
</body>
</html>