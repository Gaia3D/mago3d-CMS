<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="geoserver_tab">
	<form:form id="policyGeoServer" modelAttribute="policy" method="post" onsubmit="return false;">
		<form:hidden path="policy_id"/>
	<table class="input-table scope-row">
		<col class="col-label l" />
		<col class="col-input" />
		<tr>
  			<th>
		  		<span><spring:message code='config.use.not'/></span>
 			</th>
 			<spring:message code='use' var='use'/>
 			<spring:message code='no.use' var='noUse'/>
 			<td class="col-input radio-set">
 				<form:radiobutton path="geo_server_enable" value="true" label="${use}" />
				<form:radiobutton path="geo_server_enable" value="false" label="${noUse}" />
	  		</td>
  		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_server_url"><spring:message code='url'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_server_url" cssClass="l" />
				<form:errors path="geo_server_url" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_server_layers"><spring:message code='config.geoserver.layers'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_server_layers" cssClass="m" />
				<form:errors path="geo_server_layers" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_server_parameters_service"><spring:message code='config.geoserver.parameters_service'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_server_parameters_service" cssClass="m" />
				<form:errors path="geo_server_parameters_service" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_server_parameters_version"><spring:message code='config.geoserver.parameters_version'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_server_parameters_version" cssClass="m" />
				<form:errors path="geo_server_parameters_version" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_server_parameters_request"><spring:message code='config.geoserver.parameters_request'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_server_parameters_request" cssClass="m" />
				<form:errors path="geo_server_parameters_request" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_server_parameters_transparent"><spring:message code='config.geoserver.parameters_transparent'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_server_parameters_transparent" cssClass="m" />
				<form:errors path="geo_server_parameters_transparent" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_server_parameters_format"><spring:message code='config.geoserver.parameters_format'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_server_parameters_format" cssClass="m" />
				<form:errors path="geo_server_parameters_format" cssClass="error" />
			</td>
		</tr>
	</table>
	<div class="button-group">
		<div class="center-buttons">
			<a href="#" onclick="updatePolicyGeoServer();" class="button"><spring:message code='save'/></a>
		</div>
	</div>
	</form:form>
</div>