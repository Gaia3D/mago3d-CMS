<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="geocallback_tab">
	<form:form id="policyGeoCallBack" modelAttribute="policy" method="post" onsubmit="return false;">
		<form:hidden path="policy_id"/>
	<table class="input-table scope-row">
		<col class="col-label l" />
		<col class="col-input" />
		<tr>
  			<th>
		  		<span>사용유무</span>
 			</th>
 			<td class="col-input radio-set">
 				<form:radiobutton path="geo_callback_enable" value="true" label="사용" />
				<form:radiobutton path="geo_callback_enable" value="false" label="사용안함" />
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
				<form:label path="geo_callback_insertissue">Issue 등록 Callback</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_callback_insertissue" cssClass="l" />
				<form:errors path="geo_callback_insertissue" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_callback_listissue">Issue 목록 Callback</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_callback_listissue" cssClass="l" />
				<form:errors path="geo_callback_listissue" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_callback_clickposition">Mouse Click 위치  Callback</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_callback_clickposition" cssClass="l" />
				<form:errors path="geo_callback_clickposition" cssClass="error" />
			</td>
		</tr>
	</table>
	<div class="button-group">
		<div class="center-buttons">
			<a href="#" onclick="updatePolicyGeoCallBack();" class="button">저장</a>
		</div>
	</div>
	</form:form>
</div>