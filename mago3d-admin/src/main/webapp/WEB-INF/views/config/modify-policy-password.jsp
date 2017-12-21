<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="password_tab">
	<form:form id="policyPassword" modelAttribute="policy" method="post" onsubmit="return false;">
	<table class="input-table scope-row">
		<col class="col-label l" />
		<col class="col-input" />
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="password_change_term"><spring:message code='config.change.cycle'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="password_change_term" maxlength="5" cssClass="m" />
				<span class="table-desc"><spring:message code='config.date.unit'/></span>
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="password_min_length"><spring:message code='config.minmum.length'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="password_min_length" maxlength="2" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="password_max_length"><spring:message code='config.maximum.length'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="password_max_length" maxlength="2" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="password_eng_upper_count"><spring:message code='config.uppercase.count'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="password_eng_upper_count" maxlength="5" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="password_eng_lower_count"><spring:message code='config.lowercase.count'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="password_eng_lower_count" maxlength="5" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="password_number_count"><spring:message code='config.number.count'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="password_number_count" maxlength="5" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="password_special_char_count"><spring:message code='config.spacial.count'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="password_special_char_count" maxlength="5" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="password_continuous_char_count"><spring:message code='config.continuity.count'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="password_continuous_char_count" maxlength="5" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="password_create_type"><spring:message code='config.init.password.way'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<spring:message code='config.id.plus.init' var='idPlusInit'/>
			<spring:message code='config.init' var='init'/>
			<td class="col-input">
				<select id="password_create_type" name="password_create_type" class="select">
	  				<option value="0">${idPlusInit}</option>
	  				<option value="1">${init}</option>
				</select>
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="password_create_char"><spring:message code='config.init.password.string'/></form:label>
			</th>
			<td class="col-input"><form:input path="password_create_char" maxlength="32" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="password_exception_char"><spring:message code='config.password.xss'/></form:label>
			</th>
			<td class="col-input"><form:input path="password_exception_char" maxlength="10" cssClass="m" /></td>
		</tr>
	</table>
	<div class="button-group">
		<div class="center-buttons">
					<a href="#" onclick="updatePolicyPassword();" class="button"><spring:message code='save'/></a>
		</div>
	</div>
	</form:form>
</div>