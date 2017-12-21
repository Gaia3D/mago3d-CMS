<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="geoserver_tab">
	<form:form id="policyGeoServer" modelAttribute="policy" method="post" onsubmit="return false;">
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
				<form:label path="geo_server_url">Default Layers URL</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_server_url" cssClass="l" />
				<form:errors path="geo_server_url" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_server_layers">Default Layers</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_server_layers" cssClass="m" />
				<form:errors path="geo_server_layers" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_server_parameters_service">Default Layers Parameters Service</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_server_parameters_service" cssClass="m" />
				<form:errors path="geo_server_parameters_service" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_server_parameters_version">Default Layers Parameters Version</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_server_parameters_version" cssClass="m" />
				<form:errors path="geo_server_parameters_version" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_server_parameters_request">Default Layers Parameters Request</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_server_parameters_request" cssClass="m" />
				<form:errors path="geo_server_parameters_request" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_server_parameters_transparent">Default Layers Parameters Transparent</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_server_parameters_transparent" cssClass="m" />
				<form:errors path="geo_server_parameters_transparent" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_server_parameters_format">Default Layers Parameters Format</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_server_parameters_format" cssClass="m" />
				<form:errors path="geo_server_parameters_format" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_server_add_url">Add Layers URL</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_server_add_url" cssClass="l" />
				<form:errors path="geo_server_add_url" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_server_add_layers">Add Layers</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_server_add_layers" cssClass="m" />
				<form:errors path="geo_server_add_layers" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_server_add_parameters_service">Add Layers Parameters Service</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_server_add_parameters_service" cssClass="m" />
				<form:errors path="geo_server_add_parameters_service" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_server_add_parameters_version">Add Layers Parameters Version</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_server_add_parameters_version" cssClass="m" />
				<form:errors path="geo_server_add_parameters_version" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_server_add_parameters_request">Add Layers Parameters Request</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_server_add_parameters_request" cssClass="m" />
				<form:errors path="geo_server_add_parameters_request" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_server_add_parameters_transparent">Add Layers Parameters Transparent</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_server_add_parameters_transparent" cssClass="m" />
				<form:errors path="geo_server_add_parameters_transparent" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_server_add_parameters_format">Add Layers Parameters Format</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_server_add_parameters_format" cssClass="m" />
				<form:errors path="geo_server_add_parameters_format" cssClass="error" />
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