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
						<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='user.group.check.mark'/></div>
						<div class="tabs">
							<ul>
								<li><a href="#data_info_tab"><spring:message code='user.input.information'/></a></li>
							</ul>
							<div id="data_info_tab">
								<form:form id="dataInfo" modelAttribute="dataInfo" method="post" onsubmit="return false;">
								<form:hidden path="data_id"/>
								<form:hidden path="old_data_key"/>
								<table class="input-table scope-row">
									<col class="col-label" />
									<col class="col-input" />
									<tr>
										<th class="col-label" scope="row">
											<form:label path="data_key">Key</form:label>
											<span class="icon-glyph glyph-emark-dot color-warning"></span>
										</th>
										<spring:message code='overlap.check' var='overLap'/>
										<td class="col-input">
											<form:hidden path="duplication_value"/>
											<form:input path="data_key" cssClass="m" />
					  						<input type="button" id="data_duplication_buttion" value="${ overLap}" />
					  						<form:errors path="data_key" cssClass="error" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="data_group_name"><spring:message code='data.group'/></form:label>
											<span class="icon-glyph glyph-emark-dot color-warning"></span>
										</th>
										<td class="col-input">
											<form:hidden path="data_group_id" />
				 							<form:input path="data_group_name" cssClass="m" readonly="true" />
											<input type="button" id="data_group_buttion" value="<spring:message code='user.input.group.select'/>" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="data_name"><spring:message code='name'/></form:label>
										</th>
										<td class="col-input">
											<form:input path="data_name" class="m" />
					  						<form:errors path="data_name" cssClass="error" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="latitude"><spring:message code='lat'/></form:label>
											<span class="icon-glyph glyph-emark-dot color-warning"></span>
										</th>
										<td class="col-input">
											<form:input path="latitude" class="m" />
					  						<form:errors path="latitude" cssClass="error" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="longitude"><spring:message code='lon'/></form:label>
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
											<form:label path="heading">Heading</form:label>
											<span class="icon-glyph glyph-emark-dot color-warning"></span>
										</th>
										<td class="col-input">
											<form:input path="heading" class="m" />
					  						<form:errors path="heading" cssClass="error" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="pitch">Pitch</form:label>
											<span class="icon-glyph glyph-emark-dot color-warning"></span>
										</th>
										<td class="col-input">
											<form:input path="pitch" class="m" />
					  						<form:errors path="pitch" cssClass="error" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="roll">Roll</form:label>
											<span class="icon-glyph glyph-emark-dot color-warning"></span>
										</th>
										<td class="col-input">
											<form:input path="roll" class="m" />
					  						<form:errors path="roll" cssClass="error" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="public_yn"><spring:message code='use.not'/></form:label>
											<span class="icon-glyph glyph-emark-dot color-warning"></span>
										</th>
										<spring:message code='use' var='use'/>
										<spring:message code='no.use' var='noUse'/>
										<td class="col-input">
											<form:radiobutton path="public_yn" value="Y" label="${use}"/>
											<form:radiobutton path="public_yn" value="N" label="${noUse}" />
										</td>
									</tr>
								</table>
								
								<div class="button-group">
									<div id="insertDataLink" class="center-buttons">
										<input type="submit" value="<spring:message code='modified'/>" onclick="updateData();" />
										<a href="/data/list-data.do" class="button"><spring:message code='list'/></a>
									</div>
								</div>
								</form:form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
	<!-- Dialog -->
	<div class="dialog" title="<spring:message code='data.group'/>">
		<div class="dialog-data-group">
<c:if test="${!empty dataGroupList }">
			<ul>
	<c:set var="groupDepthValue" value="0" />
	<c:forEach var="dataGroup" items="${dataGroupList }" varStatus="status">
		<c:if test="${groupDepthValue eq '0' && dataGroup.depth eq 1 }">
				<li>
					<input type="radio" id="radio_group_${dataGroup.data_group_id }" name="radio_group" value="${dataGroup.data_group_id }_${dataGroup.data_group_name }" />
					<label for="radio_group_${dataGroup.data_group_id }">${dataGroup.data_group_name }</label>
		</c:if>
		<c:if test="${groupDepthValue eq '1' && dataGroup.depth eq 1 }">
				</li>
				<li>
					<input type="radio" id="radio_group_${dataGroup.data_group_id }" name="radio_group" value="${dataGroup.data_group_id }_${dataGroup.data_group_name }" />
					<label for="radio_group_${dataGroup.data_group_id }">${dataGroup.data_group_name }</label>
		</c:if>
		<c:if test="${groupDepthValue eq '1' && dataGroup.depth eq 2 }">
					<ul>
						<li>
							<input type="radio" id="radio_group_${dataGroup.data_group_id }" name="radio_group" value="${dataGroup.data_group_id }_${dataGroup.data_group_name }" />
							<label for="radio_group_${dataGroup.data_group_id }">${dataGroup.data_group_name }</label>
		</c:if>
		<c:if test="${groupDepthValue eq '2' && dataGroup.depth eq 1 }">
						</li>
					</ul>
				</li>
				<li>
					<input type="radio" id="radio_group_${dataGroup.data_group_id }" name="radio_group" value="${dataGroup.data_group_id }_${dataGroup.data_group_name }" />
					<label for="radio_group_${dataGroup.data_group_id }">${dataGroup.data_group_name }</label>
		</c:if>
		<c:if test="${groupDepthValue eq '2' && dataGroup.depth eq 2 }">
						</li>
						<li>
							<input type="radio" id="radio_group_${dataGroup.data_group_id }" name="radio_group" value="${dataGroup.data_group_id }_${dataGroup.data_group_name }" />
							<label for="radio_group_${dataGroup.data_group_id }">${dataGroup.data_group_name }</label>
		</c:if>
		<c:if test="${groupDepthValue eq '2' && dataGroup.depth eq 3 }">
							<ul style="padding-left: 30px;">
								<li>
									<input type="radio" id="radio_group_${dataGroup.data_group_id }" name="radio_group" value="${dataGroup.data_group_id }_${dataGroup.data_group_name }" />
									<label for="radio_group_${dataGroup.data_group_id }">${dataGroup.data_group_name }</label>
		</c:if>
		<c:if test="${groupDepthValue eq '3' && dataGroup.depth eq 1 }">
								</li>
							</ul>
						</li>
					</ul>
				</li>
				<li>
					<input type="radio" id="radio_group_${dataGroup.data_group_id }" name="radio_group" value="${dataGroup.data_group_id }_${dataGroup.data_group_name }" />
					<label for="radio_group_${dataGroup.data_group_id }">${dataGroup.data_group_name }</label>
		</c:if>		
		<c:if test="${groupDepthValue eq '3' && dataGroup.depth eq 2 }">
								</li>
							</ul>
						</li>
						<li>
							<input type="radio" id="radio_group_${dataGroup.data_group_id }" name="radio_group" value="${dataGroup.data_group_id }_${dataGroup.data_group_name }" />
							<label for="radio_group_${dataGroup.data_group_id }">${dataGroup.data_group_name }</label>
		</c:if>			
		<c:if test="${groupDepthValue eq '3' && dataGroup.depth eq 3 }">
								</li>
								<li>
									<input type="radio" id="radio_group_${dataGroup.data_group_id }" name="radio_group" value="${dataGroup.data_group_id }_${dataGroup.group_name }" />
									<label for="radio_group_${dataGroup.data_group_id }">${dataGroup.group_name }</label>
		</c:if>	
		<c:if test="${dataGroup.depth eq '3' && status.last }">
								</li>
							</ul>
						</li>
					</ul>
				</li>
		</c:if>
		<c:if test="${dataGroup.depth eq '2' && status.last }">
						</li>
					</ul>
				</li>
		</c:if>
		<c:if test="${dataGroup.depth eq '1' && status.last }">
				</li>
		</c:if>
		<c:set var="groupDepthValue" value="${dataGroup.depth }" />			
	</c:forEach>
			</ul>
</c:if>
		</div>
			
		<div class="button-group">
			<input type="submit" id="button_groupSelect" name="button_groupSelect" value="선택" />
		</div>
	</div>

<script src="/externlib/${lang}/jquery/jquery.js"></script>
<script src="/externlib/${lang}/jquery-ui/jquery-ui.js"></script>		
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$( ".tabs" ).tabs();
	});
	
	// 그룹 선택
	$( "#data_group_buttion" ).on( "click", function() {
		dialog.dialog( "open" );
	});
	var dialog = $( ".dialog" ).dialog({
		autoOpen: false,
		height: 600,
		width: 600,
		modal: true,
		resizable: false
	});
	
	// 아이디 중복 확인
	$( "#data_duplication_buttion" ).on( "click", function() {
		var oldDataKey = $("#old_data_key").val();
		var dataKey = $("#data_key").val();
		if (dataKey == "") {
			alert(JS_MESSAGE["data.key.empty"]);
			$("#data_key").focus();
			return false;
		} else if(oldDataKey === dataKey ) {
			alert(JS_MESSAGE["data.key.same"]);
			$("#data_key").focus();
			return false;
		}
			
		var info = "data_key=" + dataKey + "&old_data_key=";
		$.ajax({
			url: "/data/ajax-data-key-duplication-check.do",
			type: "POST",
			data: info,
			cache: false,
			//async:false,
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					if(msg.duplication_value != "0") {
						alert(JS_MESSAGE["data.key.duplication"]);
						$("#data_key").focus();
						return false;
					} else {
						alert(JS_MESSAGE["data.key.enable"]);
						$("#duplication_value").val(msg.duplication_value);
					}
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error:function(request,status,error) {
				//alert(JS_MESSAGE["ajax.error.message"]);
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    		}
		});
	});
	
	// 그룹 선택
	$( "#button_groupSelect" ).on( "click", function() {
		var radioObj = $(":radio[name=radio_group]:checked").val();
		if (!radioObj) {
			alert(JS_MESSAGE["check.group.required"]);
	        return false;
	    } else {
	    	var splitValues = radioObj.split("_");
	    	var dataGroupName = "";
	    	for(var i = 1; i < splitValues.length; i++) {
	    		dataGroupName = dataGroupName + splitValues[i];
	    		if(i != splitValues.length - 1) {
	    			dataGroupName = dataGroupName + "_";
	    		}
			}	    	
	    	$("#data_group_id").val(splitValues[0]);
			$("#data_group_name").val(dataGroupName);
			dialog.dialog( "close" );
	    }
	});
	
	// Data 정보 저장
	var updateDataFlag = true;
	function updateData() {
		if (checkData() == false) {
			return false;
		}
		if(updateDataFlag) {
			updateDataFlag = false;
			var info = $("#dataInfo").serialize();
			$.ajax({
				url: "/data/ajax-update-data-info.do",
				type: "POST",
				data: info,
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["data.update"]);
						$("#duplication_value").val("");
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					console.log("=========== " + msg.result);
					console.log("=========== " + msg);
					updateDataFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateDataFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	function checkData() {
		if ($("#data_key").val() == "") {
			alert(JS_MESSAGE["data.key.empty"]);
			$("#data_key").focus();
			return false;
		}
		if($("#duplication_value").val() == "1") {
			alert(JS_MESSAGE["data.key.duplication_value.already"]);
			return false;
		}
		if ($("#data_group_id").val() == "") {
			alert(JS_MESSAGE["data.group.id.empty"]);
			$("#data_group_id").focus();
			return false;
		}
		if ($("#latitude").val() == "") {
			alert(JS_MESSAGE["data.latitude.empty"]);
			$("#latitude").focus();
			return false;
		}
		if ($("#longitude").val() == "") {
			alert(JS_MESSAGE["data.longitude.empty"]);
			$("#longitude").focus();
			return false;
		}
		if ($("#height").val() == "") {
			alert(JS_MESSAGE["data.height.empty"]);
			$("#height").focus();
			return false;
		}
		if ($("#heading").val() == "") {
			alert(JS_MESSAGE["data.heading.empty"]);
			$("#heading").focus();
			return false;
		}
		if($("#pitch").val() == "") {
			alert(JS_MESSAGE["data.pitch.empty"]);
			$("#pitch").focus();
			return false;
		}
		if($("#roll").val() == "") {
			alert(JS_MESSAGE["data.roll.empty"]);
			$("#roll").focus();
			return false;
		}
	}
</script>
</body>
</html>