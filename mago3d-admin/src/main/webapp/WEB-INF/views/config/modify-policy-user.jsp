<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="user_tab">
	<form:form id="policyUser" modelAttribute="policy" method="post" onsubmit="return false;">
		<form:hidden path="policy_id" />
	<table class="input-table scope-row">
		<col class="col-label l" />
		<col class="col-input" />
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="user_id_min_length"><spring:message code='config.user.id.minimum.length'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="user_id_min_length" maxlength="2" cssClass="s" />
				<span class="table-desc"><spring:message code='config.four.or.more'/></span>
				<form:errors path="user_id_min_length" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="user_fail_login_count"><spring:message code='config.login.fail.count'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="user_fail_login_count" maxlength="2" cssClass="s" />
				<form:errors path="user_fail_login_count" cssClass="error" />
			</td>
		</tr>
		
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="user_fail_lock_release"><spring:message code='config.login.fail.lock'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="user_fail_lock_release" maxlength="5" cssClass="s" readonly="true" />
				<span class="table-desc"><spring:message code='config.minute.unit'/></span>
				<form:errors path="user_fail_lock_release" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="user_last_login_lock"><spring:message code='config.last.login.lock'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="user_last_login_lock" maxlength="3" cssClass="s" />
				<span class="table-desc"><spring:message code='config.date.unit'/></span>
				<form:errors path="user_last_login_lock" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<span><spring:message code='config.duplicate.login.availability'/></span>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			
			<spring:message code='use' var='use'/>
			<spring:message code='no.use' var='noUse'/>
			<td class="col-input radio-set">
				<form:radiobutton path="user_duplication_login_yn" value="Y" label="${use}"/>
				<form:radiobutton path="user_duplication_login_yn" value="N" label="${noUse}" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="user_delete_type"><spring:message code='config.information.delete'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">	
				<select id="user_delete_type" name="user_delete_type" class="select">
	  				<option value="0"><spring:message code='config.logical'/></option>
	  				<option value="1"><spring:message code='config.physical'/></option>
				</select>
			</td>
		</tr>
	</table>
	<div class="button-group">
		<div class="center-buttons">
					<a href="#" onclick="updatePolicyUser();" class="button"><spring:message code='save'/></a>
		</div>
	</div>
	</form:form>
</div>
							