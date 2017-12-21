<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="geocallback_tab">
	<form:form id="policyGeoCallBack" modelAttribute="policy" method="post" onsubmit="return false;">
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
 				<form:radiobutton path="geo_callback_enable" value="true" label="${use}" />
				<form:radiobutton path="geo_callback_enable" value="false" label="${noUse}" />
	  		</td>
  		</tr>
  		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_callback_apiresult">api 처리 결과 Callback</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_callback_apiresult" cssClass="l" />
				<form:errors path="geo_callback_apiresult" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_callback_selectedobject">Object Select Callback</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_callback_selectedobject" cssClass="l" />
				<form:errors path="geo_callback_selectedobject" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_callback_insertissue"><spring:message code='config.issue.insert.callback'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_callback_insertissue" cssClass="l" />
				<form:errors path="geo_callback_insertissue" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_callback_listissue"><spring:message code='config.issue.list.callback'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_callback_listissue" cssClass="l" />
				<form:errors path="geo_callback_listissue" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_callback_clickposition"><spring:message code='config.mouse.click.position.callback'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_callback_clickposition" cssClass="l" />
				<form:errors path="geo_callback_clickposition" cssClass="error" />
			</td>
		</tr>
	</table>
	<div class="button-group">
		<div class="center-buttons">
			<a href="#" onclick="updatePolicyGeoCallBack();" class="button"><spring:message code='save'/></a>
		</div>
	</div>
	</form:form>
</div>